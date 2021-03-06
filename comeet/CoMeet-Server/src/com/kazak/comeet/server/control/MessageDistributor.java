package com.kazak.comeet.server.control;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.channels.ClosedChannelException;
import java.nio.channels.SocketChannel;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Vector;

import org.jdom.Document;
import org.jdom.Element;

import com.kazak.comeet.server.comunications.SocketServer;
import com.kazak.comeet.server.comunications.SocketWriter;
import com.kazak.comeet.server.comunications.SocketServer.SocketInfo;
import com.kazak.comeet.server.database.sql.QueryClosingHandler;
import com.kazak.comeet.server.database.sql.QueryRunner;
import com.kazak.comeet.server.database.sql.SQLBadArgumentsException;
import com.kazak.comeet.server.database.sql.SQLNotFoundException;
import com.kazak.comeet.server.misc.LogWriter;
import com.kazak.comeet.server.misc.settings.ConfigFileHandler;
import com.kazak.comeet.server.misc.ServerConstants;

//This class delivers all the messages received by the comeet account

public class MessageDistributor {
	
	private static final boolean LOTTERY_MODE = false;
	private static final boolean CONTROL_MODE = false;
	private static SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat formatHour = new SimpleDateFormat("HH:mm:ss a");
	private Date   date;
	private String groupIDString;
	private int    groupID;
	private String from;
	private String dateString;
	private String hourString;
	private String subject;
	private String body;
	private int rol;

	private int lifeTime = -1;
	private boolean control = false;

	public MessageDistributor(Element element, boolean senderIsMailUser) {

		// Captures the info from the message
		getMessageParams(element);
		// Gets the sender info
		SocketInfo sender = getSenderInfo(senderIsMailUser);
		rol = sender.getUserRol();

		// Getting the destination list for this message 
		Vector<SocketInfo> usersVector = getDestinationList(element,senderIsMailUser);
		int groupSize = usersVector.size();
		
		String many = "";
		if (groupSize > 1 || groupSize==0) {
			many = "s";
		}

		LogWriter.write("INFO: Enviando mensaje a "+ groupSize + " usuario" + many);
		
		// In this cycle, the message is sent to every user in the destination list 
		for (SocketInfo destination : usersVector) {
			SocketChannel sock = destination.getSock()!=null ? destination.getSock().getChannel() : null;

			// If the POS user is online
			if ((sock!=null) && (destination.getUserRol()==3)) {
				Element message = new Element("Message");
				Element root = new Element("root");

				message.addContent(root);
				root.addContent(addColumn(dateString));
				root.addContent(addColumn(hourString));
				root.addContent(addColumn(sender.getGroupName()));
				root.addContent(addColumn(subject));
				root.addContent(addColumn(body));
				root.addContent(addColumn("0"));

				Document doc = new Document((Element) message.clone());
				// Sending message to POS user online
				try {
					SocketWriter.write(sock,doc);
					LogWriter.write("INFO: [Envio a Punto de Venta] Remitente {" + sender.getLogin() 
							+ "} - Destino: " + destination.getLogin() 
							+ " - Asunto: " + subject);
				} catch (ClosedChannelException e) {
					LogWriter.write("INFO: El colocador " + destination.getLogin() + " no se encuentra en linea.");
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			// Sending message to pop users (admin users)
			if (!senderIsMailUser) {
				sendMail(destination,sender);
			}

			// if destination user is offline
			if (!control || (control && (sock!=null))) {			
				subject = subject.replaceAll("'","&39;");
				body = body.replaceAll("'","&39;");
				int rol = destination.getUserRol(); 
				System.out.println("ROL: " + rol + " - " + destination.getLogin());
				if ((rol == 1) || (rol == 2) || (rol == 5)) {
					sendMail(destination,sender);
				}
				String[] argsArray = {String.valueOf(destination.getUid()),
						dateString,hourString,subject.trim(),body.trim(),
						"0",String.valueOf(ConfigFileHandler.getMessageLifeTimeForClients()),
						String.valueOf(sender.getUid()),"0","0"};
						
				QueryRunner qRunner = null;
				try {
					LogWriter.write("INFO: Almacenando registro de mensaje en la base de datos [" + destination.getLogin() + "]");
					qRunner = new QueryRunner("INS0003",argsArray);
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
		}	
	}

	private void sendMail(SocketInfo destination, SocketInfo sender) {
		EmailSender mail = new EmailSender();
		mail.setFrom(Pop3Handler.getUser()+"@"+Pop3Handler.getHost());
		mail.setDestination(destination.getEmail());
		mail.setSubject(sender.getLogin() + ", " + subject);
		mail.setDate(date);
		mail.setMessage(body);
		if (rol == 4) {
			mail.setSenderFullName(sender.getLogin() + " [PDA]");
		} else {
			mail.setSenderFullName(sender.getNames());
		}
		mail.setWorkStation(sender.getWsName());
		mail.send();
		LogWriter.write("INFO: [Envio a Cuenta de Correo] Remitente {" + sender.getLogin() 
				+ "} - Destino: " + destination.getLogin() 
				+ " - Asunto: " + subject);					
	}
	
	private void getMessageParams(Element element) {
		groupIDString  = element.getChildText("idgroup");
		groupID        = Integer.parseInt(groupIDString);
		date           = Calendar.getInstance().getTime();
		from           = (element.getChildText("from")).trim();
		dateString     = formatDate.format(date);
		hourString     = formatHour.format(date);                 
		subject        = element.getChildText("subject");
		body           = element.getChildText("message");
		Element mailLifeTime = element.getChild("lifeTime");
		lifeTime = mailLifeTime != null ? Integer.parseInt(mailLifeTime.getValue()) : 0;

		if (CONTROL_MODE) {
			// This is a message control
			if (lifeTime > 0) {
				control = true;
				body += "\n====================================\n"
					+ "Este mensaje es de control\n";
			}
		} 
	}

	// This method returns the sender data structure
	private SocketInfo getSenderInfo(boolean senderIsMailUser) {
		SocketInfo sender=null;
		// Sender is a POS user
		if (!senderIsMailUser) {	
			// Querying the info of the sender (a pos user)
			sender = SocketServer.getSocketInfo(from);
			// If sender doesn't exist, this operation is aborted
			if (sender==null) {
				String msg = "ERROR: El Colocador {" + from + "} no esta registrado en el sistema.";
				LogWriter.write(msg);
				sendAlarm("Error procesando mensaje de colocador",msg);
				return null;
			}
		}
		// Sender is a POP user
		else {
			// Querying users from the pop server (admin user)
			sender = getUserData(from,senderIsMailUser);			

			if (LOTTERY_MODE) {
				if (sender == null) {
					sender = insertPopUser(from);
					if (sender == null) {
						return null;
					}
				}
			}
		}

		return sender;
	}

	private SocketInfo getUserData(String login, boolean senderIsMailUser) {
		SocketInfo user = null;
		QueryRunner qRunner = null;
		ResultSet resultSet = null;

		if(!senderIsMailUser) {
			// Check is POS user is online
			user = SocketServer.getSocketInfo(login);
			if(user!= null) {
				return user;
			}
		}	    

		// If user is POP or if is a POS user offline
		int i=0;
		try {
			if(senderIsMailUser) {
				qRunner = new QueryRunner("SEL0036",new String[]{login});
			} else {
				qRunner = new QueryRunner("SEL0026",new String[]{login});
			}
			resultSet = qRunner.select();
			if (resultSet.next()) {
				i++;
				user = SocketServer.getInstaceOfSocketInfo();
				user.setUid(resultSet.getInt(1));
				user.setLogin(resultSet.getString(2));
				user.setNames(resultSet.getString(3));
				user.setEmail(resultSet.getString(4));
				user.setGroupID(resultSet.getInt(5));
				user.setGroupName(resultSet.getString(6));
				user.setWsName(resultSet.getString(7));
				user.setUserRol(resultSet.getInt(8));
			}
		} catch (SQLNotFoundException e) {
			e.printStackTrace();
		} catch (SQLBadArgumentsException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			LogWriter.write("ERROR: Falla mientras se consultaba la informacion del usuario: " + login);
			e.printStackTrace();
		} finally {
			QueryClosingHandler.close(resultSet);
			qRunner.closeStatement();
		}

		return user;
	}


	// This method returns the destination list for a message
	private Vector<SocketInfo> getDestinationList(Element element, boolean senderIsMailUser) {
		Vector<SocketInfo> usersVector = new Vector<SocketInfo>();	

		String target = element.getChildText("toName");

		// If sender is a POS user
		if (!senderIsMailUser) {
			usersVector = SocketServer.getAllClients(groupID);
		}
		else {
			// If destination is one user
			if(target != null) {
				System.out.println("USER: " + target);
				SocketInfo destination = getUserData(target,false);
				if(destination!=null) {
					usersVector.add(destination);
					return usersVector;
				}
			}
			// If destination is a group
			usersVector = SocketServer.getAllClients(target);
		}

		return usersVector;
	}

	// This method sends an alarm message to the CoMeet group when the system fails
	public static void sendAlarm(String subject, String body) {
		Vector<SocketInfo> usersVector = SocketServer.getAllClients("COMEET");
		//int groupSize = usersVector.size();
		Date date = Calendar.getInstance().getTime();
		String dateString = formatDate.format(date);
		String hourString = formatHour.format(date);

		for (SocketInfo destination : usersVector) {
			EmailSender mail = new EmailSender();
			mail.setFrom(Pop3Handler.getUser()+"@"+Pop3Handler.getHost());
			mail.setDestination(destination.getEmail());
			mail.setSubject("[Error CoMeet]: " + subject);
			mail.setDate(date);
			mail.setMessage(body);
			mail.setSenderFullName("Sistema CoMeet");
			mail.setWorkStation("Servidor");
			mail.send();
			LogWriter.write("INFO: Enviando notificacion de alarma a {" + destination.getEmail() + "} / Asunto: [" + subject + "]");
			
			String[] argsArray = {String.valueOf(destination.getUid()),
					dateString,hourString,subject.trim(),body.trim(),
					"0",String.valueOf(ConfigFileHandler.getMessageLifeTimeForClients()),
					"1","0","0"};

			QueryRunner qRunner = null;
			try {
				LogWriter.write("INFO: Almacenando registro de alarma en la base de datos...");
				qRunner = new QueryRunner("INS0003",argsArray);
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
	}

	// This method insert a pop user into the CoMeet system
	private SocketInfo insertPopUser(String login) {
		SocketInfo socketInfo = null;
		String line = "";
		String names = "";
		boolean userExists = false;

		try {
			BufferedReader in = new BufferedReader(new FileReader("/etc/passwd"));

			while ((line = in.readLine()) != null)   {
				if(line.startsWith(login)) {
					userExists = true;
					String[] userData = line.split(":");
					names = userData[4];
					if (names.length() == 0) {
						names = "Usuario de Correo";
					}
					int index = names.indexOf(',');
					if (index > 0) {
						names = names.substring(0,index);
					}
					break;
				}
			}
			in.close();

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		// If the user doesn't exist in the file /etc/passwd, do not add him to the CoMeet server
		if(!userExists){
			LogWriter.write("ERROR: El usuario {" + login + "} no existe en el servidor de correo");
			return null;
		}

		String[] userInfoArray = {login,
				"d41d8cd98f00b204e9800998ecf8427e",
				names,
				login+"@"+Pop3Handler.getHost(),
				"true",
				"false",
				ServerConstants.ADMINGROUP + ""};

		QueryRunner qRunner = null;
		try {
			qRunner = new QueryRunner("INS0001",userInfoArray);
			qRunner.setAutoCommit(false);
			qRunner.executeSQL();
			qRunner.commit();
			LogWriter.write("INFO: Usuario {" + login + "} adicionado satisfactoriamente al sistema");
		} catch(SQLNotFoundException SNFE) {
			qRunner.rollback();
			SNFE.printStackTrace();
		} catch(SQLBadArgumentsException SBAE) {
			qRunner.rollback();
			SBAE.printStackTrace();
		} catch(SQLException SQLE){
			qRunner.rollback();
			String msg = "ERROR: Falla mientras se ingresaba un nuevo usuario de correo\n" +
			"que no estaba registrado en el sistema.\nLogin: " + login;
			LogWriter.write(msg);
			sendAlarm("Error adicionando usuario",msg);
			SQLE.printStackTrace();
			return null;
		} finally {
			qRunner.closeStatement();
			qRunner.setAutoCommit(true);
		}

		ResultSet resultSet = null;
		int uid = -1;
		String groupName = "";
		try {
			qRunner = new QueryRunner("SEL0008",new String[]{login});
			resultSet = qRunner.select();
			int i=0;
			if (resultSet.next()) {
				i++;
				uid = resultSet.getInt(1);
				groupName = resultSet.getString(2);
			}
		} catch (SQLNotFoundException e) {
			e.printStackTrace();
		} catch (SQLBadArgumentsException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			LogWriter.write("ERROR: Falla mientras se consultaba la informacion del usuario: " + login);
			e.printStackTrace();
			return null;
		} finally {
			QueryClosingHandler.close(resultSet);
			qRunner.closeStatement();
		}

		socketInfo = SocketServer.getInstaceOfSocketInfo();
		socketInfo.setUid(uid);
		socketInfo.setLogin(userInfoArray[0]);
		socketInfo.setNames(userInfoArray[2]);
		socketInfo.setEmail(userInfoArray[3]);
		socketInfo.setGroupID(Integer.parseInt(userInfoArray[6]));
		socketInfo.setWsName("");
		socketInfo.setGroupName(groupName);	

		return socketInfo;
	}

	private Element addColumn(String value) {
		Element element = new Element("col");
		element.setText(value);
		return element;
	}
}
