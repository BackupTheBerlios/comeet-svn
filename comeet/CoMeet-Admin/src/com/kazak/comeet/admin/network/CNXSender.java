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

package com.kazak.comeet.admin.network;

import java.io.IOException;
import java.nio.channels.SocketChannel;

import org.jdom.Document;
import org.jdom.Element;

public class CNXSender {
    
    public CNXSender(SocketChannel socket,String login,String password) {
        Document doc = new Document();
        doc.setRootElement(new Element("CNX"));
        String ipAddress = socket.socket().getLocalAddress().getHostAddress();
        Element ip       = new Element("ip").setText(ipAddress);
        Element user     = new Element("login").setText(login);
        Element passwd   = new Element("password").setText(password);
        Element validate = new Element("validate").setText("true");
        
        doc.getRootElement().addContent(ip);
        doc.getRootElement().addContent(user);
        doc.getRootElement().addContent(passwd);
        doc.getRootElement().addContent(validate);
        
        try {	
        	SocketWriter.write(socket,doc);
	    } catch (IOException e) {
			System.out.println("ERROR: Falla de entrada/salida");
			System.out.println("Causa: " + e.getMessage());
			e.printStackTrace();
		}
    }
}