package com.kazak.comeet.server.control;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import org.jdom.Element;

import com.kazak.comeet.server.database.sql.QueryClosingHandler;
import com.kazak.comeet.server.database.sql.QueryRunner;
import com.kazak.comeet.server.database.sql.SQLBadArgumentsException;
import com.kazak.comeet.server.database.sql.SQLNotFoundException;
import com.kazak.comeet.server.misc.LogWriter;

/**
 * UserLogin.java Creado el 23-jul-2004
 * 
 * Este archivo es parte de E-Maku
 * <A href="http://comunidad.qhatu.net">(http://comunidad.qhatu.net)</A>
 *
 * E-Maku es Software Libre; usted puede redistribuirlo y/o realizar
 * modificaciones bajo los terminos de la Licencia Publica General
 * GNU GPL como esta publicada por la Fundacion del Software Libre (FSF);
 * tanto en la version 2 de la licencia, o cualquier version posterior.
 *
 * E-Maku es distribuido con la expectativa de ser util, pero
 * SIN NINGUNA GARANTIA; sin ninguna garantia aun por COMERCIALIZACION
 * o por un PROPOSITO PARTICULAR. Consulte la Licencia Publica General
 * GNU GPL para mas detalles.
 * <br>
 * Esta clase autentica el ingreso de un usuario al sistema
 * <br>
 * @author <A href='mailto:felipe@qhatu.net'>Luis Felipe Hernandez</A>
 * @author <A href='mailto:cristian@qhatu.net'>Cristian David Cepeda</A>
 */
public class UserLogin {
	
    //private Element data;
    private Integer	uid;
    private String login;
    private String password;
    private Boolean validate;
    private String names;
    private String email;
    private Integer gid;
    private String groupName;
    private String ip;
    private String wsName = "";
    private int rol;
    private final int ADMIN = 1;
    private final int AUDITOR = 2;
    private final int SALES = 3;
    
    public String getLogin() {
        return login;
    }
    
    public UserLogin(Element data){
    	//this.data = data;
    	login = data.getChild("login").getValue();
	    password = data.getChild("password").getValue();
	    ip = data.getChild("ip").getValue();
	    validate = data.getChild("validate")!=null ? true : false;
    }
    
    public boolean isValid() {	    
	    QueryRunner queryRunner = null;
	    ResultSet resultSet = null;
	    int count = 0;

	    LogWriter.write("INFO: Inicio de autenticacion para el usuario {" + login + "} con la clave {" + password + "}");
	 
	    // Check if login exists in the system
		try {
			queryRunner = new QueryRunner("SEL0022",new String[]{login});
			resultSet = queryRunner.select();
		    count = resultSet.next() ? resultSet.getInt(1) : 0;
		} catch (SQLNotFoundException e) {
			e.printStackTrace();
		} catch (SQLBadArgumentsException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			QueryClosingHandler.close(resultSet);
			queryRunner.closeStatement();
		}
		
		if(count==0) {
			LogWriter.write("ADVERTENCIA: El usuario {" + login + "} no aparece registrado en el servidor CoMeet");
			LogWriter.write("             Es posible que el login haya sido mal digitado o que no exista en la base de datos");
			
			return false;
		}
	    
		// Check if login and password are correct in the system
		try {
			queryRunner = new QueryRunner("SEL0023",new String[]{login,password});
			resultSet = queryRunner.select();
		    count = resultSet.next() ? resultSet.getInt(1) : 0;
		} catch (SQLNotFoundException e) {
			e.printStackTrace();
		} catch (SQLBadArgumentsException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			QueryClosingHandler.close(resultSet);
			queryRunner.closeStatement();
		}		
	
	    if (count==1) {	
	    	Vector<String> ips = new Vector<String>();
	    	Vector<String> posNameVector = new Vector<String>();
	    	boolean doControl = false;				
  			
  			try {
  				queryRunner = new QueryRunner("SEL0002",new String[]{login});
  				resultSet = queryRunner.select();
  				while (resultSet.next()) {
  					String posName = resultSet.getString(1);
  					if(posName.length()>0) {
  						posNameVector.add(posName);
  					}
  					String ipAddress = resultSet.getString(2);
  					if(ipAddress.length()>0) {
  						ips.add(ipAddress);
  					}
  					Boolean flag = resultSet.getBoolean(3);
  					if(flag) {
  						doControl = true;
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
  				queryRunner.closeStatement();
  			}

  			// Querying for pos name for a ip address given
  			try {	    		
  				queryRunner = new QueryRunner("SEL0003",new String[]{ip});
  				resultSet = queryRunner.select();
  				if (resultSet.next()) {
  					wsName = resultSet.getString(1);
  				}
  				if (wsName.length() == 0) {
  					wsName = "Ubicación No Registrada";
  				}
  			} catch (SQLNotFoundException e) {
  				e.printStackTrace();
  			} catch (SQLBadArgumentsException e) {
  				e.printStackTrace();
  			} catch (SQLException e) {
  				e.printStackTrace();
  			} finally {
  				QueryClosingHandler.close(resultSet);
  				queryRunner.closeStatement();
  			}

  			// Check if is "ip control access" enabled for user 
  			if (doControl) {
				LogWriter.write("INFO: Realizando control de acceso sobre direcciones ip...");
				if (!ips.contains(ip)) {
					LogWriter.write("ADVERTENCIA: La ip {" + ip + "} no esta autorizada para el usuario " + login);
					return false;
				}
			} else {
				LogWriter.write("INFO: Control de acceso sobre direcciones ip no habilitado para este usuario");
			}		
	    	
	    	try {	    	
	    		queryRunner = new QueryRunner("SEL0025",new String[]{login});
	    		resultSet = queryRunner.select();
	    		if (resultSet.next()) {
	    			uid 	   = resultSet.getInt(1);
	    			login	   = resultSet.getString(2);
	    			names	   = resultSet.getString(3);
	    			email	   = resultSet.getString(4);
	    			gid		   = resultSet.getInt(5);
	    			groupName  = resultSet.getString(6);
	    			rol        = resultSet.getInt(7);
                    //userDevice = resultSet.getInt(7);
	    			
	    			if (validate) {
	    				if (rol == ADMIN) {
	    					LogWriter.write("INFO: Usuario Administrador {" + login + "} autenticado desde " 
	    							+ wsName + " [" + ip + "]");
	    					//userLevel = 1;
	    					return true;
	    				} else if (rol == AUDITOR) {
	    					LogWriter.write("INFO: Auditor {" + login + "} autenticado desde " 
	    							+ wsName + " [" + ip + "]");
	    					//userLevel = 2;
	    					return true;
	    				}
	    			}
	    			else {
	    				if (rol == SALES ) {
	    					LogWriter.write("INFO: Colocador {" + login + "} autenticado desde " + wsName  + " [" + ip + "]");
	    				} else {					
	    					LogWriter.write("INFO: Lote {" + login + "} autenticado desde " + wsName  + " [" + ip + "]");
	    				}
    					//userLevel = 3;
	    				return true;
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
	    		queryRunner.closeStatement();
	    	}		
	    }
	    LogWriter.write(
	    		"INFO: Acceso denegado a {" + login + "} desde la ip " + ip + 
	    		" ingresando como " + (validate ? "Administrador/Auditor" :"Colocador") + " [Clave incorrecta]");
	    return false;
    }
    
	public int getUserLevel() {
		return rol;
	}
	public String getEmail() {
		return email;
	}
	public Integer getGid() {
		return gid;
	}
	public String getNames() {
		return names;
	}
	public Integer getUid() {
		return uid;
	}
	public String getIp() {
		return ip;
	}
	public Boolean getAdmin() {
		return rol == ADMIN;
	}
	public Boolean getAudit() {
		return rol == AUDITOR;
	}
	public String getWsName() {
		return wsName;
	}
	public String getGroupName() {
		return groupName;
	}	
	/*
	public int getUserDevice() {
		return userDevice;
	}*/
}
