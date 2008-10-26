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

	private String date;
	private String time;
	
	public MessageConfirmer(String date, String time) {
		this.date = date;
		this.time = time;
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
        
		time = formatDate(time);
        
		Element pack = new Element("package");	
		pack.addContent(new Element("field").setText(date));
		pack.addContent(new Element("field").setText(time));
		pack.addContent(new Element("field").setText(Run.user));
		
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
	
    private String formatDate(String basic) {
		int hour = Integer.parseInt(basic.substring(0,basic.indexOf(":")));
		String meridian = basic.substring(basic.indexOf(" "),basic.length());
		if (meridian.trim().equals("PM")) {
				hour = hour + 12;
				String tail = basic.substring(basic.indexOf(":"),basic.length());
				basic = hour + tail;
		}
        return basic;
    }
}
