package com.kazak.comeet.server.control;

import java.io.IOException;
import java.nio.channels.SocketChannel;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.Enumeration;

import javax.mail.AuthenticationFailedException;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.InternetAddress;
import javax.mail.Part;
import org.jdom.Element;

import com.kazak.comeet.server.control.QuerySender;
import com.kazak.comeet.server.comunications.SocketServer;
import com.kazak.comeet.server.comunications.SocketServer.SocketInfo;
import com.kazak.comeet.server.Run;
import com.kazak.comeet.server.database.sql.QueryClosingHandler;
import com.kazak.comeet.server.database.sql.QueryRunner;
import com.kazak.comeet.server.database.sql.SQLBadArgumentsException;
import com.kazak.comeet.server.database.sql.SQLNotFoundException;
import com.kazak.comeet.server.misc.LogWriter;
import com.kazak.comeet.server.misc.settings.ConfigFileHandler;

public class Pop3Handler extends Thread {
	
	private static String user;
	private static String password;
	private static String host;
	
	public Pop3Handler() {
		LogWriter.write("INFO: Iniciando demonio pop3");
		LogWriter.write("INFO: Servidor de correo {" + ConfigFileHandler.getMailServer() + "}");
		Pop3Handler.host = ConfigFileHandler.getMailServer();
		Pop3Handler.user = ConfigFileHandler.getMailUser();
		Pop3Handler.password = ConfigFileHandler.getMailPasswd();
		start();
	}
	
	private static String processMimeMail(Part mail) {
		String result = "";
		try {
			if (mail.isMimeType("multipart/*")) {
				Multipart multi;
				multi = (Multipart) mail.getContent();
				for (int j = 0; j < multi.getCount(); j++) {
					mail = multi.getBodyPart(j);
					if (mail.isMimeType("text/plain")) {
						result = mail.getContent().toString();
					} 
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		if (result.length() == 0) {
			return "Mensaje con formato enriquecido (No legible)\n";
		}		
		return result;
	}	
	
	
	public void run() {
		Session session = Session.getInstance(new Properties());
		Store store = null;
		try {
			store = session.getStore("pop3");
		} catch (MessagingException e) {
			e.printStackTrace();
		} 
		while(true) {
			try {	
				store.connect(host,user,password);
				Folder folder = store.getFolder("INBOX");
				folder.open(Folder.READ_WRITE);
				Message messages[] = folder.getMessages();

				for (Message message : messages) {
					InternetAddress address = (InternetAddress) message.getFrom()[0];
					String fullSubject =  message.getSubject();
					fullSubject = fullSubject!=null ? fullSubject.trim() : null;

					String lowercase = fullSubject.toLowerCase();
					if(lowercase.startsWith("re:")) {
						fullSubject = fullSubject.substring(3,fullSubject.length()).trim();
					}

					int index1  = address.getAddress().indexOf('@');
					String from = address.getAddress().substring(0,index1);
					int index2  = fullSubject!=null ? fullSubject.indexOf(',') : -1;

					String to = "";
					String subject = "";
					String msgType = "";
					String content = "";

					if (message.isMimeType("multipart/*")) {
						msgType = "multipart/*";
						content = processMimeMail(message);
					} else {
						msgType = "text/*";
						content = message.getContent().toString();
					}

					LogWriter.write("INFO: Leyendo correo del buzon de mensajes");
					LogWriter.write("INFO: Formato de mensaje -> " + msgType);
					LogWriter.write("INFO: Nuevo mensaje desde {" + address.getAddress() + "} con asunto [ " +  fullSubject + " ]");

					if (index2==-1 && !fullSubject.startsWith("[Error CoMeet]")) {
						if (!"Mailer-Daemon".equals(from)){
							LogWriter.write("ERROR: Inconsistencia en el asunto del mensaje escrito por {" + address.getAddress() + "}");
							LogWriter.write("ERROR: Asunto escrito [" + fullSubject + "]");
							LogWriter.write("Contenido del mensaje:");
							LogWriter.write(content);
							EmailSender mail = new EmailSender();
							mail.setFrom(user+"@"+host);
							mail.setDestination(address.getAddress());
							mail.setSubject("Error enviando mensaje");
							mail.setDate(new Date());
							mail.setMessage (
									"El correo no tiene el formato apropiado.\n" +
									"Por favor verifique el asunto del mensaje\n" +
									"Contenido Original\n" +
									"-------------------------------------\n" +
									"Asunto: "   + fullSubject+"\n" +
									"Mensage:\n"+ content    +"\n" +
									"-------------------------------------\n" +
							"Este mensaje fue generado automaticamente por el Sistema de Mensajeria Instantanea." );
							mail.send();
						}
					}
					else {
						String[] strings = fullSubject.split(":");
						String lifeTime = "-1";
						if (strings.length > 0 ) {
							lifeTime = strings[strings.length-1];
							int lifeTimeInteger = -1;
							try {
								lifeTimeInteger= Integer.valueOf(lifeTime);
							} catch (NumberFormatException NFEe) {
								lifeTimeInteger = -1;
							}
							if (lifeTimeInteger < 1 || lifeTimeInteger>99) {
								lifeTime = "-1";
							}
						}

						if (index2 == -1) {
							to = "COMEET";
						} else {
							to = fullSubject.substring(0,index2).trim();
						}

						subject = fullSubject.substring(index2+1,fullSubject.length()).trim();			

						QueryRunner qRunner = null;
						ResultSet resultSet = null;
						String groupID = null;
						boolean toAllUsers = false;

						if ("TODOS".equals(to)) { 
							toAllUsers=true; 
						}

						try {
							boolean inside = false;
							qRunner = toAllUsers ? new QueryRunner("SEL0028") :	new QueryRunner("SEL0024",new String[]{to,to});
							resultSet = qRunner.select();
							while (resultSet.next()) {
								groupID =  resultSet.getString(1);
								if (groupID!=null) {
									inside = true;
									Element xml = new Element("Message");
									xml.addContent(createXMLElement("idgroup",groupID));
									xml.addContent(createXMLElement("toName",toAllUsers ? resultSet.getString(2): to ));
									xml.addContent(createXMLElement("from",from));
									xml.addContent(createXMLElement("subject",subject));
									xml.addContent(createXMLElement("message",content));
									xml.addContent(createXMLElement("timeAlife",lifeTime));
									new MessageDistributor(xml,true);
								}
								else {
									LogWriter.write("ERROR: El usuario {" + to + "} no existe en el sistema.");
									LogWriter.write("ERROR: Verificar posible inconsistencia en base de datos.");
								}
							}
						
							if (!inside && ConfigFileHandler.getMovilSupport()) {
								LogWriter.write("INFO: Consultando si usuario {" + to + "} existe en LOTES");
								Enumeration keys = SocketServer.getPDdaHash().getKeys();
								if (SocketServer.getPDdaHashSize() > 0) {
									while (keys.hasMoreElements()) {
										SocketChannel socket = (SocketChannel)keys.nextElement();
										String code = "Q" + QuerySender.getId();
										if (QuerySender.verifyPDAUser(socket,code,to)) {
											SocketInfo userData = (SocketInfo) SocketServer.getDataSocket(socket);
											String slot = userData.getLogin();
											LogWriter.write("INFO: El usuario {" + to + "} fue validado por el lote {" + slot + "}");
											qRunner = new QueryRunner("SEL0038",new String[]{address.getAddress()});
											resultSet = qRunner.select();
											String group = "-1";
											while (resultSet.next()) {
												Integer gid =  resultSet.getInt(1);
												group = gid.toString();
											}
											// Guardando mensaje en base de datos
											Date date = Calendar.getInstance().getTime();
											SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
											SimpleDateFormat formatHour = new SimpleDateFormat("hh:mm aaa");
											String dateString     = formatDate.format(date);
											String hourString     = formatHour.format(date);
											subject.replaceAll("\'","[ToKeN]");
											content.replaceAll("\'","[ToKeN]");
											String[] argsArray = {to,group,dateString,hourString,subject,content};
											savePDAMessage(to,argsArray);
											inside = true;
											break;
										}
									}
								}
							}					    								    	

							if (!inside) {
								LogWriter.write("ERROR: El usuario {" + to + "} no existe en el sistema.");
								LogWriter.write("ERROR: Notificando al remitente -> {" + from + "}");
								notifyBadDestination(address.getAddress(),to,fullSubject,content);
							} 
							
						} catch (SQLNotFoundException e) {
							e.printStackTrace();
						} catch (SQLBadArgumentsException e) {
							e.printStackTrace();
						} catch (SQLException e) {
							e.printStackTrace();
						} finally {
							QueryClosingHandler.close(resultSet);
							qRunner.closeStatement();
						}
					}
					message.setFlag(Flags.Flag.DELETED, true);
				}
				folder.close(true);
				store.close();
			} catch (AuthenticationFailedException e) {
				LogWriter.write("ERROR: Falla en la autenticacion del demonio pop3. No se podran obtener los correos.");
				LogWriter.write("ERROR: Por favor, revise el archivo de configuracion y vuelva a iniciar el CoMeet.");
				LogWriter.write("Causa: " + e.getMessage());
				Run.shutDownServer();
			} catch (NoSuchProviderException e) {
				e.printStackTrace();
			} catch (MessagingException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				Thread.sleep(ConfigFileHandler.getTimeIntervalConnect());
			} catch (InterruptedException e1) {
				e1.printStackTrace();
			}
		}
	}	
	
	private void savePDAMessage(String login, String[] argsArray) {
		QueryRunner qRunner = null;
		try {
			LogWriter.write("INFO: Almacenando mensaje para usuario {" + login + "/pda} en la base de datos");
			qRunner = new QueryRunner("INS0004",argsArray);
			qRunner.setAutoCommit(false);
			qRunner.executeSQL();
			qRunner.commit();
		} catch (SQLNotFoundException e) {
			qRunner.rollback();
			LogWriter.write("ERROR: No se pudo almacenar mensaje en la base de datos. Instruccion SQL no encontrada");
			e.printStackTrace();
		} catch (SQLBadArgumentsException e) {
			qRunner.rollback();
			LogWriter.write("ERROR: No se pudo almacenar mensaje en la base de datos. Argumentos Invalidos");
			e.printStackTrace();
		} catch (SQLException e) {
			qRunner.rollback();
			LogWriter.write("ERROR: No se pudo almacenar mensaje en la base de datos. Excepcion SQL");
			e.printStackTrace();
		} finally {
			qRunner.closeStatement();
			qRunner.setAutoCommit(true);
		}
	}
		
	private void notifyBadDestination(String sender,String target,String fullSubject,String content) {
		EmailSender mail = new EmailSender();
		mail.setFrom(user+"@"+host);
		mail.setDestination(sender);
		mail.setSubject("[CoMeet] Error enviando mensaje");
		mail.setDate(new Date());
		mail.setMessage (
				"El mensaje que usted envió al usuario o grupo {" + target + "} \n" +
				"no pudo ser entregado.\n" +
				"Motivo: \n" + 
				"El usuario o grupo {" + target + "} no existe en el sistema.\n" +
				"Por favor verifique el nombre del destino o consulte\n" +
				"con soporte tecnico.\n\n" +
				"Contenido Original\n" +
				"-------------------------------------\n" +
				"Asunto: "   + fullSubject+"\n" +
				"Mensage:\n"+ content    +"\n" +
				"-------------------------------------\n" +
		"Este mensaje fue generado automaticamente por CoMeet." );
		mail.send();		
	}
	
	private Element createXMLElement(String name,String value) {
		Element element = new Element(name);
		element.setText(value);
		return element;
	}

	public static String getHost() {
		return host;
	}

	public static void setHost(String host) {
		Pop3Handler.host = host;
	}

	public static String getUser() {
		return user;
	}

	public static void setUser(String user) {
		Pop3Handler.user = user;
	}
}
