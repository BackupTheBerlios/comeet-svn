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

package com.kazak.comeet.client.control;

import java.io.IOException;
import java.nio.channels.SocketChannel;

import org.jdom.Document;
import org.jdom.Element;

import com.kazak.comeet.client.Run;
import com.kazak.comeet.client.network.QuerySender;
import com.kazak.comeet.client.network.SocketHandler;
import com.kazak.comeet.client.network.SocketWriter;

public class MessageConfirmer extends Thread {

	private String confirm;
	private String date;
	private String time;
	private String subject;
	private String from;
	
	public MessageConfirmer(int confirm,String date, String time,String subject,String from) {
		this.confirm = "" + confirm;
		this.date = date;
		this.time = time;
		this.subject = subject;
		this.from = from;
		run();
	}
	
	public void run() {
		Element transaction = new Element("Transaction");
		Document doc = new Document(transaction);
		
		Element id = new Element("id");
        id.setText(QuerySender.getId());
        transaction.addContent(id);
        
        Element driver = new Element("driver");
        driver.setText("TR011");
        transaction.addContent(driver);
        
		Element pack = new Element("package");
		pack.addContent(new Element("field").setText(confirm));
		pack.addContent(new Element("field").setText(date));
		pack.addContent(new Element("field").setText(time));
		pack.addContent(new Element("field").setText(Run.user));
		pack.addContent(new Element("field").setText(subject));
		pack.addContent(new Element("field").setText(from));
		
		transaction.addContent(pack);
		SocketChannel sock = SocketHandler.getSock();
		try {
			SocketWriter.writing(sock,doc);
		} catch (IOException ex) {
			System.out.println("Error de entrada y salida");
			System.out.println("mensaje: " + ex.getMessage());
			ex.printStackTrace();
		}
	}
}
