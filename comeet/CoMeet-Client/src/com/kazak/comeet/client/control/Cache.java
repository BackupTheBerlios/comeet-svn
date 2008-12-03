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
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import org.jdom.Document;
import org.jdom.Element;

import com.kazak.comeet.client.Run;
import com.kazak.comeet.client.network.QuerySender;
import com.kazak.comeet.client.network.QuerySenderException;

public class Cache {

	private static final long serialVersionUID = -2796119857538194265L;
	private static HashMap<String, String> groupsCacheHash;
	private static ArrayList<MessageList> msgCacheList;
	
	public Cache () {
		groupsCacheHash = new HashMap<String, String>();
		msgCacheList = new ArrayList<MessageList>();
	}
	
	public static void loadGroupsCache() {
		groupsCacheHash.clear();
		Thread t = new Thread() {
			public void run() {
				try {
					Document doc = QuerySender.getResultSetFromST("SEL0001",null);
					Element root = doc.getRootElement();
					Iterator iterator = root.getChildren("row").iterator();
					while (iterator.hasNext()) {
						Element element = (Element)iterator.next();
						Iterator columnsIterator = element.getChildren().iterator();
						String id = ((Element)columnsIterator.next()).getValue();
						String name = ((Element)columnsIterator.next()).getValue();
						groupsCacheHash.put(name,id);  
					}
				} catch (QuerySenderException e) {
					e.printStackTrace();
				}
			}
		};
		t.start();
	}
	
	public static String getGroupID(String key) {
		return groupsCacheHash.get(key);
	}
	
	public static void addNewMessage (Element msg) {
		Iterator iterator = msg.getChildren().iterator();
		while (iterator.hasNext()) {
			Element columns = (Element)iterator.next();
			int index = msgCacheList.size() + 1;
			MessageList message = new MessageList(index,columns);
			//msgCacheList.add(0,message);
			msgCacheList.add(msgCacheList.size(),message);
		}
	}
	
	public static ArrayList<MessageList> getMessages() {
		return msgCacheList;
	}
	
	public static String[] getGroups() {
		Set <String>bag = groupsCacheHash.keySet();
		String[] sortedGroupList = (String[])bag.toArray(new String[bag.size()]);
		Arrays.sort(sortedGroupList);

		return sortedGroupList;	
	}
	
	public static void loadMessagesHistory() {
		msgCacheList.clear();
		Thread t = new Thread() {
			public void run() {
				try {
					String[] args = {Run.user,Run.user};
					Document doc = QuerySender.getResultSetFromST("SEL0012",args);
					Element root = doc.getRootElement();
					Iterator iterator = root.getChildren("row").iterator();
					while (iterator.hasNext()) {
						Element columns = (Element)iterator.next();
						int index = msgCacheList.size() + 1;
						MessageList message = new MessageList(index,columns);
						msgCacheList.add(message);  
					}
				} catch (QuerySenderException e) {
					e.printStackTrace();
				}
			}
		};
		t.start();
	}
}