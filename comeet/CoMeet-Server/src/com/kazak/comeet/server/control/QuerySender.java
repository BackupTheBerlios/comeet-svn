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

package com.kazak.comeet.server.control;

import java.io.IOException;
import java.nio.channels.SocketChannel;
import java.util.Hashtable;

import org.jdom.Document;
import org.jdom.Element;

import com.kazak.comeet.server.comunications.SocketWriter;
import com.kazak.comeet.server.control.QuerySenderException;

public class QuerySender {

	private static Hashtable <String,Document> verificationsHash = new Hashtable<String,Document>();
	private static long id = 0;

	/*  Este metodo se encarga de consultar si un usuario existe en un servidor
	 *  de usuarios pda
	 */
	
	public static boolean verifyPDAUser(SocketChannel socket, String code, String login) {		
		Document doc = new Document();
		doc.setRootElement(new Element("VERIFY"));
		Element id = new Element("id").setText(code);
		Element user = new Element("user").setText(login);
		doc.getRootElement().addContent(id);
		doc.getRootElement().addContent(user);
		try {	
			SocketWriter.write(socket,doc);
		} catch (IOException e) {
			System.out.println("ERROR: Falla de entrada/salida");
			System.out.println("Causa: " + e.getMessage());
			e.printStackTrace();
		}
		int i=0;
		while (!verificationsHash.containsKey(code)) {
			try {
				Thread.sleep(100);
				i++;
				if (i>20000) {
					throw new QuerySenderException();
				}
			}
			catch(InterruptedException e) {
				try {
					throw new QuerySenderException();
				} catch (QuerySenderException e1) {
					e1.printStackTrace();
				}
			} catch (QuerySenderException e) {
				e.printStackTrace();
			}
		}
		Document result = (Document)verificationsHash.get(code);
		Element root = result.getRootElement();
		String exist = root.getChildText("answer");
		boolean flag = Boolean.valueOf(exist);
		verificationsHash.remove(id);

		return flag;    
	}

	/**
	 * Este metodo adiciona retorno paquetes answer provenientes de la
	 * solicitud de una consulta a los servidores de pda's
	 * @param id identificador de solicitud de consulta.
	 * @param doc paquete answer,success o error retornado por el ST.
	 */
	public static synchronized void putResultOnPool(String id, Document doc) {
		verificationsHash.put(id,doc);
	}

	public static synchronized String getId() {
		return String.valueOf(++id);
	}
}
