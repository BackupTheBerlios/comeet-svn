package com.kazak.comeet.server.comunications;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.channels.CancelledKeyException;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Vector;
import java.util.Enumeration;

//import javax.swing.JOptionPane;

import org.jdom.Document;
import org.jdom.Element;

import com.kazak.comeet.lib.misc.Language;
import com.kazak.comeet.server.control.Pop3Handler;
import com.kazak.comeet.server.database.sql.QueryClosingHandler;
import com.kazak.comeet.server.database.sql.QueryRunner;
import com.kazak.comeet.server.database.sql.SQLBadArgumentsException;
import com.kazak.comeet.server.database.sql.SQLNotFoundException;
import com.kazak.comeet.server.misc.LogWriter;
import com.kazak.comeet.server.misc.settings.ConfigFileHandler;
/**
 * SocketServer.java Creado el 21-jul-2004
 * 
 * Este archivo es parte de E-Maku <A
 * href="http://comunidad.qhatu.net">(http://comunidad.qhatu.net) </A>
 * 
 * E-Maku es Software Libre; usted puede redistribuirlo y/o realizar
 * modificaciones bajo los terminos de la Licencia Publica General GNU GPL como
 * esta publicada por la Fundacion del Software Libre (FSF); tanto en la version
 * 2 de la licencia, o cualquier version posterior.
 * 
 * E-Maku es distribuido con la expectativa de ser util, pero SIN NINGUNA
 * GARANTIA; sin ninguna garantia aun por COMERCIALIZACION o por un PROPOSITO
 * PARTICULAR. Consulte la Licencia Publica General GNU GPL para mas detalles.
 * <br>
 * Esta clase es la encargada de abrir los sockets servidores para atender las
 * peticiones de un cliente. 
 * <br>
 * 
 * @author <A href='mailto:felipe@qhatu.net'>Luis Felipe Hernandez </A>
 * @author <A href='mailto:cristian@qhatu.net'>Cristian David
 *         Cepeda </A>
 */

public class SocketServer {

    /**
     * Este vector almacena todos los canales de las conexiones activas de los
     * clientes, es necesario en caso de que se quiera mandar un paquete a todas
     * las conexiones activas.
     */

    private static Hashtable <SocketChannel,SocketInfo>generalSocketsHash = new Hashtable<SocketChannel,SocketInfo>();
    private static PDASocketsHash pdaHash = new PDASocketsHash();
    private static ServerSocketChannel serverSocketChannel = null;
    private static int SocketsCounter = 0;

    /**
     * Desde el constructor de esta clase se trabaja la administracion de
     * conexiones cliente
     */

    public SocketServer() throws IOException{
        try {
            serverSocketChannel = ServerSocketChannel.open();
            serverSocketChannel.configureBlocking(false);
            ServerSocket socketForClient = serverSocketChannel.socket();

            socketForClient.bind(new InetSocketAddress(ConfigFileHandler.getPort()));

            Selector selector = Selector.open();
            serverSocketChannel.register(selector, SelectionKey.OP_ACCEPT);
            LogWriter.write(Language.getWord("SOCKET_SERVER_OPEN") + " "+ ConfigFileHandler.getPort());
            
            while (true) {
                int n = selector.select();
                if (n > 0) {
                    Iterator iterador = selector.selectedKeys().iterator();
                    while (iterador.hasNext()) {
                        SelectionKey password = (SelectionKey) iterador.next();
                        try {
                            if (password.isAcceptable()) {
                                ServerSocketChannel server = (ServerSocketChannel) password.channel();

                                SocketChannel socketChannel = server.accept();
                                socketChannel.configureBlocking(false);
                                socketChannel.register(selector,SelectionKey.OP_READ);
                                generalSocketsHash.put(socketChannel, new SocketInfo(socketChannel.socket()));
                                LogWriter.write(Language.getWord("NEW_SOCKET_CLIENT")
                                            + " "
                                            + socketChannel.socket());
                                Thread.sleep(50);

                            } else if (password.isReadable()) {
                                SocketChannel socketChannel = (SocketChannel) password.channel();
                                PackageToXMLConverter packageXML2 = new PackageToXMLConverter(socketChannel);
                                packageXML2.start();
                                Thread.sleep(70);
                            }
                            iterador.remove();
                        }
                        catch (CancelledKeyException e) {
                            Thread.sleep(50);
                        }
                    }
                }
            }
        }
        catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    /**
     * Este metodo sirve para saber si una conexion ha sido autenticada
     * @param sock
     *            Socket al que se valida
     * @return Retorna true si el socket a sido autenticado, de lo contrario
     *         retorna false
     */
    public static boolean isLogged(SocketChannel sock) {
        return generalSocketsHash.get(sock).isLogged();
    }
    
    /**
     * Este metodo retorna el login asociado a una conexion
     * @param sock
     * @return algo
     */
    public static String getLogin(SocketChannel sock) {
        return generalSocketsHash.get(sock).getLogin();
    }
    
    public static String getConnectionTime(SocketChannel sock) {
        return generalSocketsHash.get(sock).getConnectionTime();
    }

    public static String getCurrentIp(SocketChannel sock) {
        return generalSocketsHash.get(sock).getCurrentIp();
    }
    
    /**
     * Este metodo retorna el login asociado a una conexion
     * @param sock
     * @return user's login
     */
    public static String getName(SocketChannel sock) {
        return generalSocketsHash.get(sock).getNames();
    }
    
    /**
     * Este metodo retorna el nombre del POS asociado a una conexion
     * @param sock
     * @return user's pos name
     */
    public static String getPosName(SocketChannel sock) {
        return generalSocketsHash.get(sock).getWsName();
    }
    
    public static Document getUsersOnLine(String pattern,String areaID) {
    	int area = Integer.parseInt(areaID);
    	Document doc = new Document();
    	Element root = new Element("SEARCHRESULT");
    	Element id = new Element("id").setText("RESULT");
    	doc.setRootElement(root);
    	root.addContent(id);
    	
    	for ( Enumeration e = generalSocketsHash.keys() ; e.hasMoreElements() ; ) {
    		SocketChannel connection = (SocketChannel) e.nextElement();

    		if (isLogged(connection)) {
    			switch(area) {
                // Search by code    			
    			case 0:
    				String login = generalSocketsHash.get(connection).getLogin();
    				login = login.toLowerCase();
    				pattern = pattern.toLowerCase();
    				if (login.contains(pattern) || pattern.equals("*")) {
    					root.addContent(addElement(connection));
    				}
    				break;
    			// Search by names
    			case 1:
    				String name = generalSocketsHash.get(connection).getNames();
    				name = name.toLowerCase();
    				pattern = pattern.toLowerCase();
    				if (name.contains(pattern) || pattern.equals("*")) {
    					root.addContent(addElement(connection));
    				}
    				break;
       			// Search by pos name
    			case 2:
    				String posName = generalSocketsHash.get(connection).getWsName();
    				posName = posName.toLowerCase();
    				pattern = pattern.toLowerCase();
    	    		if (posName.contains(pattern) || pattern.equals("*")) {
    					root.addContent(addElement(connection));
    	    		}
    	    		break;    	    		

    			// Search by ip
    			case 3:
    				String ip = generalSocketsHash.get(connection).getCurrentIp();
    				if (ip.contains(pattern) || pattern.equals("*")) {
    					root.addContent(addElement(connection));
    				}
    				break;
    			// Search by group id
    			case 4:
    				String group = Integer.toString(generalSocketsHash.get(connection).getGroupID());
    	    		if (group.equals(pattern) || pattern.equals("*")) {
    					root.addContent(addElement(connection));
    	    		}
    	    		break;
    			}
    		}
    	}

    	return doc;
    }

    // Captures the info of the connection's user
    public static Element addElement(SocketChannel connection) {
    	Element rows, user, name, posName, ip, time;
		rows = new Element("row");
		user = new Element("cols").setText(getLogin(connection));
		name = new Element("cols").setText(getName(connection));
		String pos = getPosName(connection);
		if (pos == null) {
			pos = "POS NO asignado";
		}
		posName = new Element("cols").setText(pos);
		ip = new Element("cols").setText(getCurrentIp(connection));
		time = new Element("cols").setText(getConnectionTime(connection));
		rows.addContent(user);
		rows.addContent(name);
		rows.addContent(posName);
		rows.addContent(ip);
		rows.addContent(time);
    	
    	return rows;
    }
    
    public static Document getUsersTotal() {
		Document doc = new Document();
		Element root = new Element("USERLIST");
		doc.setRootElement(root);
		Element id = new Element("id").setText("TOTAL");
		root.addContent(id);
		Element rows = new Element("row");
		Element total = new Element("cols").setText(Integer.toString(generalSocketsHash.size()));
		rows.addContent(total);
 		root.addContent(rows);
 		
 		return doc;
    }
    
    public static Document getMailInfo(SocketChannel sock) {
    	Document doc = new Document();
		Element root = new Element("MAILINFO");
		doc.setRootElement(root);
		Element id = new Element("id").setText("MAILPARAMS");
		root.addContent(id);
		Element mailServer = new Element("mailServer").setText(ConfigFileHandler.getMailServer());
		root.addContent(mailServer);
		Element to = new Element("to").setText(getSocketInfo(sock).getEmail());
		root.addContent(to);		
    	Element from = new Element("from").setText(Pop3Handler.getUser()+"@"+Pop3Handler.getHost());
		root.addContent(from);
		
    	return doc;
    }
    
    /**
     * Este metodo remueve una coneccion (socket) de la
     * hash de conecciones.
     * @param sock Socket que se quiere remover.
     * @throws IOException
     */
    public static void removeSock(SocketChannel sock) throws IOException {
    	LogWriter.write("INFO: Cerrando conexion con cliente [OK]");
        setDecrementSocketsCount();
        generalSocketsHash.remove(sock);
        pdaHash.removeSocket(sock);
        sock.close();
    }
    
    public static ByteArrayOutputStream getTemporalBuffer(SocketChannel sock) {
        return generalSocketsHash.get(sock).getTemporalBuffer();
    }

    public static void setTemporalBuffer(SocketChannel sock,ByteArrayOutputStream temporalBuffer) {
        generalSocketsHash.get(sock).setTemporalBuffer(temporalBuffer);
    }
    
    /**
     * Este metodo retorna la base de datos un socket
     * @param sock Socket del cual se quiere obtener la informacion
     * @return El nombre de la base de datos
     */
    public static String getDataBase(SocketChannel sock){
    	return generalSocketsHash.get(sock).getDBName();    	
    }

    /**
     * Este metodo actualiza el valor de las conexiones logeadas
     * @param sock
     * @param db
     */

    public static void setLogin(SocketChannel sock, String db, String login) {
        generalSocketsHash.get(sock).setLogged();
        generalSocketsHash.get(sock).setDB(db);
        generalSocketsHash.get(sock).setLogin(login);
    }

    /**
     * Este metodo Incrementa el contador de socket's
     * conectados 
     * @return El numero de socket's conectados.
     */
    public static int setIncrementSocketsCount() {
        return ++SocketsCounter;
    }

    /**
     * Este metodo decrementa el contador de socket's
     * conectados 
     * @return El numero de socket's conectados.
     */
    public static int setDecrementSocketsCount() {
        return --SocketsCounter;
    }
    
    public static Hashtable getClientChannelsHash() {
        return generalSocketsHash;
    }
    
    public static PDASocketsHash getPDdaHash() {
        return pdaHash;
    }
    
    public static int getPDdaHashSize() {
        return pdaHash.size();
    } 
    
    public static SocketInfo getDataSocket(SocketChannel socket) {
    	return (SocketInfo) pdaHash.getHash().get(socket);
    }
    
    public static String getCompanyNameKey(SocketChannel sock) {
        return "K-"+ getDataBase(sock) + "-company";
    }
    
    public static String getCompanyIDKey(SocketChannel sock) {
        return "K-"+ getDataBase(sock) + "-companyID";    
    }
    
    public static SocketInfo getSocketInfo(SocketChannel sock) {
    	return generalSocketsHash.get(sock);
    }
    
    public static SocketInfo getSocketInfo(String login) {	
    	if (login == null) {
    		LogWriter.write("ERROR: Llamado a getInfoSocket con parametro nulo (login).");
    		return null;
    	}
    	
    	for (SocketInfo socketInfo : generalSocketsHash.values()) {
    		String username = socketInfo.getLogin();
    		if (username != null) {
    			if (username.equals(login)) {
    				return socketInfo;
    			}
    		}
    	}
    	return null;
    }
    
    public static SocketInfo getInstaceOfSocketInfo() {
    	return new SocketInfo();
    }
    /**
     * Esta clase sirve como valor para guardar
     * la conexiones en la hash de sockets
     */
    public static class SocketInfo extends Thread {

        private boolean logged = false;
        private String db;
        private String login;
        private Socket sock;
        private String names;
        private int uid;
        private String email;
        private int gid;
        private String groupName;
        private String currentIP;
        private String password;
        private String wsName;
        private String connectionTime;
        private ByteArrayOutputStream temporalBuffer;
        private int rol;
        
    	public SocketInfo() {}
    	
        private String getFormattedDate() {
        	SimpleDateFormat now = new SimpleDateFormat("dd MMM yyyy - HH:mm a");
        	Date date = new Date();
        	
        	return now.format(date);
        }
    	
    	public void setConnectionTime() {
    		connectionTime = getFormattedDate();
    	}
    	
    	public String getConnectionTime() {
    		return connectionTime;
    	}
        
    	public String getCurrentIp() {
    		return currentIP;
    	}

    	public void setCurrentIP(String currentIP) {
    		this.currentIP = currentIP;
    	}

    	public int getGroupID() {
    		return gid;
    	}

    	public void setGroupID(int gid) {
    		this.gid = gid;
    	}

    	public String getNames() {
    		return names;
    	}

    	public void setNames(String names) {
    		this.names = names;
    	}
    	
        public int getUid() {
    		return uid;
    	}

    	public void setUid(int userID) {
    		this.uid = userID;
    	}

    	public String getEmail() {
    		return email;
    	}

    	public void setEmail(String email) {
    		this.email = email;
    	}
    	
    	public int getUserRol() {
    		return rol;
    	}
    	    	
    	public void setUserRol(int rol) {
    		this.rol = rol;
    	}
    	        
        /**
         * @param sock
         */
        public SocketInfo(Socket sock) {
            this.sock = sock;
            temporalBuffer = new ByteArrayOutputStream();
            start();
        }

        /**
         * 
         */
        public void run() {
            try {
                Thread.sleep(10000);
                if (!isLogged()) {
                    SocketServer.removeSock(sock.getChannel());
                }
            }
            catch (InterruptedException e) {
                e.printStackTrace();
            }
            catch (IOException e) {
                e.printStackTrace();
            }
        }

        /**
         * Este metodo se utiliza para verificar si una
         * coneccion ha sido autenticada.
         * @return <code><b>true</b></code> si la conexion esta autenticada,
         * de lo contrario <code><b>false</b></code> 
         */
        public boolean isLogged() {
            return logged;
        }

        /**
         * Este metodo se encarga de pasar el estado
         * de no autenticado a autenticado.
         */
        public void setLogged() {
            this.logged = true;
        }

        /**
         * Este metodo se encarga de retornar la
         * base de datos a la que la coneccion(socket) hace
         * referencia.
         * @return Nombre de la base de datos
         */
        public String getDBName() {
            return db;
        }

        /**
         * Este metodo establece la base de datos
         * para la coneccion(socket).
         * @param db Nombre de la base de datos.
         */
        public void setDB(String db) {
            this.db = db;
        }

        /**
         * Este metodo se encarga de retornar
         * el nombre del usuario referente a la coneccion(socket).
         * @return Nombre de usuario
         */
        public String getLogin() {
            return login;
        }

        /**
         * Este metodo se encarga de retornar el nombre
         * de usuario de una coneccion(socket).
         * @param login Nombre de usuario.
         */
        public void setLogin(String login) {
            this.login = login;
        }
        
        public ByteArrayOutputStream getTemporalBuffer() {
            return temporalBuffer;
        }
        
        public void setTemporalBuffer(ByteArrayOutputStream temporalBuffer) {
            this.temporalBuffer = temporalBuffer;
        }
        
		public String getPassword() {
			return password;
		}
		
		public void setPassword(String password) {
			this.password = password;
		}
		
		public Socket getSock() {
			return sock;
		}
		
		public String getWsName() {
			return wsName;
		}
		
		public void setWsName(String wsName) {
			this.wsName = wsName;
		}
		
		public String getGroupName() {
			return groupName;
		}
		
		public void setGroupName(String groupName) {
			this.groupName = groupName;
		}
    }
 
    // Retorna todos los usuarios conectados al sistema y pertenecientes al grupo groupID
    
	public static Vector<SocketInfo> getAllClients(int groupID) {
		Vector<SocketInfo> usersVector = new Vector<SocketInfo>();
		QueryRunner qRunner = null;
	    ResultSet resultSet = null;
	    
	    for (SocketInfo socketInfo : generalSocketsHash.values()) {    
            if (socketInfo.getGroupID()==groupID) {
                usersVector.add(socketInfo);
            }
        }
	    
		try {
			qRunner = new QueryRunner("SEL0035",new String[]{String.valueOf(groupID)});
			resultSet = qRunner.select();
			while(resultSet.next()) {
				SocketInfo user = SocketServer.getInstaceOfSocketInfo();
				user.setUid(resultSet.getInt(1));
				user.setLogin(resultSet.getString(2));
				user.setNames(resultSet.getString(3));
				user.setEmail(resultSet.getString(4));
				user.setGroupID(resultSet.getInt(5));
				user.setUserRol(resultSet.getInt(6));
				user.setWsName(resultSet.getString(7));
				user.setGroupName(resultSet.getString(8));	
				
				if (!containsSocketInfo(usersVector, user)) {
					if (user.getGroupID()==groupID) {
						usersVector.add(user);
					}
				}
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
		return usersVector;
	}
	
	private static boolean containsSocketInfo(Vector<SocketInfo> usersVector,SocketInfo socketInfo) {
		for (SocketInfo user : usersVector) {
			if (socketInfo.getLogin().equals(user.getLogin())) {
				return true;
			}
		}
		return false;
	}
	
	private static Vector<String> getUserGroups(String uid) {
		Vector<String> groups = new Vector<String>(); 
		QueryRunner qRunner = null;
		ResultSet resultSet = null;
		try {
			qRunner = new QueryRunner("SEL0037",new String[]{uid});
			resultSet = qRunner.select();
			while(resultSet.next()) {
				String group = resultSet.getString(1);
				if(group != null) {
					groups.add(group);
				}
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
		
		return groups;
	}
	
	public static Vector<SocketInfo> getAllClients(String groupName) {
		Vector<SocketInfo> groupVector = new Vector<SocketInfo>();
		QueryRunner qRunner = null;
	    ResultSet resultSet = null;
	    
        for (SocketInfo socketInfo : generalSocketsHash.values()) { 
        	Vector groups = getUserGroups(String.valueOf(socketInfo.getUid()));
            if (groups.contains(groupName)) {
                groupVector.add(socketInfo);
            }
        }
        
		try {
			qRunner = new QueryRunner("SEL0027",new String[]{groupName,groupName});
			resultSet = qRunner.select();
			
			while(resultSet.next()) {
				SocketInfo user = SocketServer.getInstaceOfSocketInfo();
				user.setUid(resultSet.getInt(1));
				user.setLogin(resultSet.getString(2));
				user.setNames(resultSet.getString(3));
				user.setEmail(resultSet.getString(4));
				user.setUserRol(resultSet.getInt(5));
				user.setGroupID(resultSet.getInt(6));
				user.setWsName(resultSet.getString(7));
				user.setGroupName(resultSet.getString(8));		
				
				if (!containsSocketInfo(groupVector, user)) {
					groupVector.add(user);
				}
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
		return groupVector;
	}
}