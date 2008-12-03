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

package com.kazak.comeet.client.network;

import java.io.IOException;
import java.nio.channels.SocketChannel;

import org.jdom.Document;
import org.jdom.Element;

import com.kazak.comeet.client.control.Cache;
import com.kazak.comeet.client.gui.LoginWindow;

public class MessageSender {
	
	public MessageSender(String to,String subject, String message) {
		Element xml = new Element("Message");
		String groupID = Cache.getGroupID(to);
		xml.addContent(new Element("idgroup").setText(groupID));
		xml.addContent(new Element("from").setText(LoginWindow.getLoginUser()));
		xml.addContent(new Element("subject").setText(subject));
		xml.addContent(new Element("message").setText(message));
		SocketChannel sock = SocketHandler.getSock();
		try {
			SocketWriter.writing(sock,new Document(xml));
		} catch (IOException e) {
			System.out.println("ERROR: Falla de entrada / salida");
			System.out.println("Causa: " + e.getMessage());
			e.printStackTrace();
		}
	}
}