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

import java.util.ArrayList;
import java.util.Iterator;

import org.jdom.Element;

public class MessageList {
	
	private ArrayList<Object> messageList = new ArrayList<Object>();
	
	public MessageList (Integer id,Element xml) {
		messageList.add(id); 
		Iterator it = xml.getChildren().iterator();
		messageList.add(((Element)it.next()).getValue());
		String date = formatDate(((Element)it.next()).getValue().toString());		
		messageList.add(date);
		messageList.add(((Element)it.next()).getValue());
		messageList.add(((Element)it.next()).getValue());
		messageList.add(((Element)it.next()).getValue());
		String value = ((Element)it.next()).getValue();
		Boolean flag = value.equals("1") ? true : false;
		messageList.add(flag);
	}
	
	public Object getAt(int index) {
		return messageList.get(index);
	}
	
	public void setAt(int index,Object element) {
		messageList.set(index, element);
	}
	
    private String formatDate(String date) {
		int hour = Integer.parseInt(date.substring(0,date.indexOf(":")));
		if (hour > 12) {
			hour = hour - 12;
			String tail = date.substring(date.indexOf(":"),date.length());
			if (hour < 10) {
				date = "0" + hour + tail;
			} else {
			    date = hour + tail;
			}
		}
        return date;
    }
}