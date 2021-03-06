package com.kazak.comeet.server.database.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Hashtable;

import com.kazak.comeet.lib.misc.Language;
import com.kazak.comeet.server.misc.LogWriter;
import com.kazak.comeet.server.misc.settings.ConfigFileHandler;


/**
 * PoolConexiones.java Creado el 25-jun-2004
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
 * Esta clase se encarga se cargar las bases de datos existentes en fichero de
 * configuracion.
 * <br>
 * @author <A href='mailto:felipe@qhatu.net'>Luis Felipe Hernandez</A>
 * @author <A href='mailto:cristian@qhatu.net'>Cristian David Cepeda</A>
 */
public class ConnectionsPool {
    
    private static Hashtable <String,Connection>Hpoolbds;
    private static boolean closed = false;
    /**
     * Este metodo carga todas las bases de datos existentes en el
     * fichero de configuracion
     */
    
    public static void loadDB() throws PoolNotLoadException {
        
        Hpoolbds = new Hashtable<String,Connection>();
        int max = ConfigFileHandler.getDBSize();
        for (int i=0;i<max;i++)
            try {
            	if (ConfigFileHandler.isConnectOnInit(i)) {
                LogWriter.write(
                		Language.getWord("LOADING_DB") +" "+
                		ConfigFileHandler.getDBName(i));
                
                Class.forName(ConfigFileHandler.getDriver(i));
                Hpoolbds.put(
                		ConfigFileHandler.getDBName(i),
						DriverManager.getConnection(
								ConfigFileHandler.getUrl(i),
								ConfigFileHandler.getUser(i),
								ConfigFileHandler.getPassword(i)));
            	} else {
                    LogWriter.write(Language.getWord("NO_LOADING_DB") +
                    		        ConfigFileHandler.getDBName(i));
            	}
            } 
            catch (ClassNotFoundException CNFEe) {
            	LogWriter.write(
                		Language.getWord("ERR_CLASS") + ", "+
                		CNFEe.getMessage());
                
                throw new PoolNotLoadException(ConfigFileHandler.getDBName(i));
            } 
            catch (SQLException SQLEe){
            	LogWriter.write(
                		Language.getWord("ERR_SQL") + " [" + ConfigFileHandler.getDBName(i) + "]\nCausa: " + 
                		SQLEe.getMessage());
                throw new PoolNotLoadException(ConfigFileHandler.getDBName(i));
            }
    }
    
    /**
     * Metodo encargado de retornar el objeto Connection de la base de datos
     * recibida como parametro
     * @param nombreBD recibe el nombre de la base de datos
     * @return retorna el objeto connection de la base de datos recibida como
     * parametro
     */
    public static synchronized Connection getConnection(String nombreBD) {
    	checkDataBasesConection();
        return Hpoolbds.get(nombreBD);
    }
    
    public static synchronized void  checkDataBasesConection() {
    	if (!ConnectionsPool.closed) return;
    	try {
        		loadDB();
        		ConnectionsPool.closed = false;
		} catch (PoolNotLoadException e) {
			e.printStackTrace();
		}
    }
    
    public static boolean checkDataBase(String DataBase) {
    	return Hpoolbds.containsKey(DataBase);
    }
    
    public static void CloseConnections() {
    	for (Connection cn: Hpoolbds.values()) {
    		if (cn!=null) try {
    				cn.close();
    				cn = null;
    		} catch (SQLException e) {
    				e.printStackTrace();
    		}
    	}
    	ConnectionsPool.closed = true;
    }
}
