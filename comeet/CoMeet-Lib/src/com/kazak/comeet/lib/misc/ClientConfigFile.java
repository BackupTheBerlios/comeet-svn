/**
 *  This file is part of CoMeet: Tiny IM.
 *
 *  CoMeet is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  CoMeet is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with CoMeet.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * @author Luis Felipe Hernandez
 * @author Cristian David Cepeda
 * 
 * Contact: comeet@kazak.com.co
 */

package com.kazak.comeet.lib.misc;

import java.io.File;
//import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.swing.JOptionPane;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import com.kazak.comeet.lib.misc.ClientConstants;

public class ClientConfigFile {

    private static SAXBuilder saxBuilder;
    private static Document doc;
    private static Element root;
    private static String host; 
    private static int serverPort = -1;
    private static int time = -1;
    
    public static void loadSettings() { 

    	String os = System.getProperty("os.name");
        String path = ClientConstants.unixConfigPath + "comeet.conf";
        if (os.startsWith("Windows")) {
            path = ClientConstants.winConfigPath + ClientConstants.SEPARATOR + 
			"conf" + ClientConstants.SEPARATOR + "comeet.conf";
        } 
        
        File configFile = new File(path);
        if (!configFile.exists()) {
        	criticalError("No se encontró el archivo de configuración.\n" +
							"(" + path + ")\n" + "Por favor, Contacte al administrador del sistema.");
        }
        
        System.out.println("Cargando Archivo de Configuracion: " + path);
    	
        try {
            saxBuilder = new SAXBuilder(false);   
            doc = saxBuilder.build(path);
            root = doc.getRootElement();
            List configList = root.getChildren();
            Iterator iterator = configList.iterator();
            int counter = 0;
            while (iterator.hasNext()) {
            	counter++;
                Element data = (Element) iterator.next();
                String name = data.getName();
                if (name.equals("host")) {
                	String serverString = data.getValue();
                	if (serverString.length() > 0) {
                		host = serverString;
                	} else {
                		criticalError("El campo <server> no tiene ningún valor en el archivo de configuración.\n" +
                				"Por favor, asignele una dirección IP o un nombre válido.");              		
                	}
                } else if (name.equals("serverPort")) {
                	String portString = data.getValue();
                	if (portString.length() > 0) {
                		if (hasNumberFormat(portString)) { 
                			serverPort = Integer.parseInt(portString);
                		} else {
                			criticalError("El campo <serverPort> debe poseer un valor númerico.\n" +
                					"Por favor, corrija el valor del campo.");
                		}
                	} else {
                		criticalError("El campo <serverPort> no tiene ningún valor en el archivo de configuración.\n" +
                					"Por favor, asignele un valor numerico.");
                	}
                } else if (name.equals("time")) {
                	String timeString = data.getValue();
                	if (timeString.length() > 0) {
                		if (hasNumberFormat(timeString)) { 
                			time = Integer.parseInt(timeString);
                		} else {
                			criticalError("El campo <time> debe poseer un valor númerico.\n" +
                					"Por favor, corrija el valor del campo.");
                		}
                	} else {
                		criticalError("El campo <time> no tiene ningún valor en el archivo de configuración.\n" +
                					"Por favor, asignele un valor numerico.");
                	}
                }
            }
            
            System.out.println("Counter: " + counter);
            
            if((host.length() == 0) || (serverPort == -1) || (time == -1)) {
            	criticalError("El archivo de configuración " + path 
            			+ " se encuentra corrupto.\nPor favor, verfiquelo.");
            }
            
        }
        // TODO: Corregir el manejo de excepciones aqui / Precisar mensaje de error
        /* catch (FileNotFoundException FNFEe) {
            throw new ConfigFileNotLoadException();
        } */
        catch (JDOMException JDOMEe) {
            JDOMEe.printStackTrace();
            //throw new ConfigFileNotLoadException();
        }
        catch (IOException IOEe) {
            //throw new ConfigFileNotLoadException();
        }
    }
    
    private static void criticalError(String msg) {
    	JOptionPane.showMessageDialog(
    			null,
    			msg,
    			"Error del Sistema",
    			JOptionPane.ERROR_MESSAGE);

    	System.exit(0);
    }
    
    private static boolean hasNumberFormat(String s) {
        for(int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (!Character.isDigit(c)) {
                return false;
            }
          }
        return true;
    }
    
    public static String getHost() {
        return host;
    }
   
    public static int getServerPort() {
        return serverPort;
    }
    
    public static int getTime() {
    	return time;
    }
}
