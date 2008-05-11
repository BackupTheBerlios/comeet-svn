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
    private static int serverPort;
    private static String host;
    private static int time = -1;
    
    public static void loadSettings() { 

    	String os = System.getProperty("os.name");
        String path = ClientConstants.unixConfigPath + "comeet.conf";
        if (os.startsWith("Windows")) {
            path = ClientConstants.winConfigPath + "conf" + ClientConstants.SEPARATOR + "comeet.conf";
        } 
        
        File configFile = new File(path);
        if (!configFile.exists()) {
			JOptionPane.showMessageDialog(
					null,
					"No se encontró el archivo de configuración.\n" +
					"Por favor, Contacte al administrador del sistema.",
					"Error del Sistema",
					JOptionPane.ERROR_MESSAGE);
			
			System.exit(0);
        }
    	
        try {
            saxBuilder = new SAXBuilder(false);
                        
            doc = saxBuilder.build(path);
            root = doc.getRootElement();
            List configList = root.getChildren();
            Iterator iterator = configList.iterator();
            while (iterator.hasNext()) {
                Element data = (Element) iterator.next();
                String name = data.getName();
                if (name.equals("host")) {
                    host = data.getValue();
                } else if (name.equals("serverport")) {
                    serverPort = Integer.parseInt(data.getValue());
                } else if (name.equals("time")) {
                    time = Integer.parseInt(data.getValue());
                }
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