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

package com.kazak.comeet.admin.control;

import java.awt.Cursor;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Set;
import java.util.Vector;
import java.util.Arrays;
import javax.swing.JFrame;
import org.jdom.Document;
import org.jdom.Element;

import com.kazak.comeet.admin.gui.main.MainTreeManager;
import com.kazak.comeet.admin.transactions.QuerySender;
import com.kazak.comeet.admin.transactions.QuerySenderException;

public class Cache {
	
	private static Hashtable<String, Group> groupsList;
	private static Hashtable<Integer, String> roles;
	private static Hashtable<String, Integer> groupTypes;
	private static Vector<String> groupTypesVector;
	private static JFrame frame;
	private static int VISUAL = 1;
	private static Vector<String> adminUsers = new Vector<String>();
	private static Vector<String> operativeUsers = new Vector<String>();
	private static Iterator rows1,rows2,rows3,rows4,rows5,rows6,rows7;
	
	// This method updates the main jtree 
	
	public static void loadInfoTree(final int mode) {
		groupsList = new Hashtable<String, Group>();
		Thread t = new  Thread() {

			public void run() {
				int typeCursor;
				if(mode == VISUAL) {
					typeCursor = Cursor.WAIT_CURSOR;
					Cursor cursor = Cursor.getPredefinedCursor(typeCursor);
					frame.setCursor(cursor);
					MainTreeManager.clearAll();
				}
				getDataBaseData();

				//Loading jtree with groups
				while (rows1.hasNext()) {
					String[] data = addGroupItem(rows1);
					if(mode == VISUAL && (data[1].equals("true"))) {
						MainTreeManager.addGroup(data[0]);
					}
				}
				
				//Loading jtree with workstations
				while (rows2.hasNext()) {
					String[] data = addWsItem(rows2); // Group name and ws name		
					if(mode == VISUAL && groupsList.get(data[0]).isEnabled() && data[2].equals("1")) {
						MainTreeManager.addChild(data[0],data[1]);
					}
				}
				
				//Loading jtree with users (admin)
				while (rows3.hasNext()) {						
					String[] data = addAdminUserItem(rows3); // Workstation name and user name
					if(mode == VISUAL && (data[2].equals("true"))) {
						Group group = getGroupByWorkStation(data[0].toString());
						MainTreeManager.addChild(group.getName(),data[0],data[1]);
					}
				}
				
				//Loading jtree with users (pos)
				while (rows4.hasNext()) {
					Object[] data = addPOSUserItem(rows4); // Workstation name and User object 		
					if(mode == VISUAL && (data[2].equals("true"))) {
						Group group = getGroupByWorkStation(data[0].toString());
						String login = ((User)data[1]).getLogin();
						MainTreeManager.addChild(group.getName(),data[0].toString(),login);
					}
				}
				
				//Loading jtree with users (slots)
				while (rows5.hasNext()) {
					Object[] data = addPOSUserItem(rows5); // Workstation name and User object 		
					if(mode == VISUAL) {
						Group group = getGroupByWorkStation(data[0].toString());
						String login = ((User)data[1]).getLogin();
						MainTreeManager.addChild(group.getName(),data[0].toString(),login);
					}
				}
				
				//Loading roles
				roles = new Hashtable<Integer, String>();
				while (rows6.hasNext()) {
					addRol(rows6);  		
				}
				
				//Loading group types
				groupTypes = new Hashtable<String, Integer>();
				groupTypesVector = new Vector<String>();
				while (rows7.hasNext()) {
					addGroupType(rows7);   		
				}
				
				if(mode == VISUAL) {
					MainTreeManager.updateUI();
					System.gc();
					MainTreeManager.expand();
					frame.setCursor(Cursor.getDefaultCursor());
				}
			}
		};
		t.start();
	}
	
	public static void getDataBaseData() {
		try {
			//Group Types
			Document doc = QuerySender.getResultSetFromST("SEL0040",null);
			Element root = doc.getRootElement();
			rows7 = root.getChildren("row").iterator();
			
			//Roles
			doc = QuerySender.getResultSetFromST("SEL0039",null);
			root = doc.getRootElement();
			rows6 = root.getChildren("row").iterator();

			//Groups
			doc = QuerySender.getResultSetFromST("SEL0004",null);
			root = doc.getRootElement();
			rows1 = root.getChildren("row").iterator();

			//POS
			doc = QuerySender.getResultSetFromST("SEL0005",null);
			root = doc.getRootElement();
			rows2 = root.getChildren("row").iterator();
			
			//Users - Admin 
			doc = QuerySender.getResultSetFromST("SEL0006",null);
			root = doc.getRootElement();
			rows3 = root.getChildren("row").iterator();
			
			//Users - POS
			doc = QuerySender.getResultSetFromST("SEL0007",null);
			root = doc.getRootElement();
			rows4 = root.getChildren("row").iterator();
			
			//Users - SLOT
			doc = QuerySender.getResultSetFromST("SEL0006A",null);
			root = doc.getRootElement();
			rows5 = root.getChildren("row").iterator();
			
		} catch (QuerySenderException e) {
			e.printStackTrace();
		}
	}

	public static void addRol(Iterator rolesIterator) {
		Element row = (Element) rolesIterator.next();
		Iterator columns = row.getChildren().iterator();

		String rolId = ((Element)columns.next()).getValue();
		String name = ((Element)columns.next()).getValue();
	
		roles.put(new Integer(rolId),name);
	}
	
	public static void addGroupType(Iterator groupTypeIterator) {
		Element row = (Element) groupTypeIterator.next();
		Iterator columns = row.getChildren().iterator();

		String typeId = ((Element)columns.next()).getValue();
		String name = ((Element)columns.next()).getValue();
	
		groupTypes.put(name, new Integer(typeId));
		groupTypesVector.add(name);
	}
	
	public static String getRol(int i) {
		String rol = roles.get(new Integer(i));
		return rol;
	}

	public static Integer getGroupTypeID(String type) {
		Integer id = groupTypes.get(type);
		return id;
	}

	public static String getGroupTypeName(int id) {
		String result = "";
		Enumeration<String> e = groupTypes.keys();
		while(e.hasMoreElements())
		{ 
			String key = (String)(e.nextElement());
			Integer value = (Integer)groupTypes.get(key);
			if (value.intValue() == id) {
				result =  key;
				break;
			}
		}
		return result;
	}
	
	public static Vector<String> getGroupTypesVector() {
		return groupTypesVector;
	}
	
	public static String[] addGroupItem(Iterator groupIterator) {
		String[] result = new String[2];
		Element row = (Element) groupIterator.next();
		Iterator columns = row.getChildren().iterator();

		String gid = ((Element)columns.next()).getValue();
		String name = ((Element)columns.next()).getValue();
		String visible = ((Element)columns.next()).getValue();
		String type = ((Element)columns.next()).getValue();
		String enabled = ((Element)columns.next()).getValue();

		Group group = new Group();
		group.setId(gid);
		group.setName(name);
		group.setVisible(visible.equals("1") ? true : false);
		group.setType(Integer.parseInt(type));
		group.setEnabled(Integer.parseInt(enabled));

		groupsList.put(name,group);
		
		result[0] = name;
		result[1] = group.isEnabled() + "";
		
		return result;
	}
	
	public static String[] addWsItem(Iterator wsIterator) {
		String[] result = new String[3];
		Element row = (Element) wsIterator.next();
		Iterator columns = row.getChildren().iterator();

		String code = ((Element)columns.next()).getValue();		
		String name = ((Element)columns.next()).getValue();						
		String ip = ((Element)columns.next()).getValue();
		String gid = ((Element)columns.next()).getValue();
		String groupName = ((Element)columns.next()).getValue();
		String enabled = ((Element)columns.next()).getValue();
		
		WorkStation ws = new WorkStation();
		ws.setGid(gid);
		ws.setName(name);
		ws.setIp(ip);
		ws.setCode(code);
		ws.setGroupName(groupName);
		ws.setEnabled(Integer.parseInt(enabled));
		groupsList.get(groupName).add(ws);
		
		result[0] = groupName;
		result[1] = name;
		result[2] = enabled;
		
		return result;
	}
	
	//u.codigo,u.login,u.clave,u.nombres,u.correo,u.gid,g.nombre,u.rol

	public static String[] addAdminUserItem(Iterator userIterator) {
		String[] result = new String[3];
		Element row = (Element) userIterator.next();
		Iterator columns = row.getChildren().iterator();
		User user = new User();
		user.setId(((Element)columns.next()).getValue());
		String login = ((Element)columns.next()).getValue();
		if (!adminUsers.contains(login)) {
			adminUsers.add(login);
		}
		user.setLogin(login);
		user.setPasswd(((Element)columns.next()).getValue());
		user.setName(((Element)columns.next()).getValue());
		user.setEmail(((Element)columns.next()).getValue());
		user.setGid(((Element)columns.next()).getValue());
		user.setGroupName(((Element)columns.next()).getValue());
		String wsName = ((Element)columns.next()).getValue();
		user.setType(Integer.parseInt(((Element)columns.next()).getValue()));
		user.setEnabled(Integer.parseInt(((Element)columns.next()).getValue()));
		user.setSeller(false);
		groupsList.get(user.groupName).add(user);
			
		result[0] = wsName;
		result[1] = user.getLogin();
		result[2] = user.isEnabled() + "";
		
		return result;
	}
	
	// u.codigo,u.login,u.clave,u.nombres,u.gid,ub.nombre,usb.validar_ip,g.nombre,u.rol
	
	public static Object[] addPOSUserItem(Iterator rows) {
		Object[] result = new Object[3];
		Element row = (Element) rows.next();
		Iterator columns = row.getChildren().iterator();
		User user = new User();
		user.setId(((Element)columns.next()).getValue());
		String login = ((Element)columns.next()).getValue();
		user.setLogin(login);
		if (!operativeUsers.contains(login)) {
			operativeUsers.add(login);
		}
		user.setPasswd(((Element)columns.next()).getValue());
		user.setName(((Element)columns.next()).getValue());
		user.setGid(((Element)columns.next()).getValue());
		String wsName = ((Element)columns.next()).getValue();
		user.setValidIp(((Element)columns.next()).getValue().equals("1") ? true : false);
		user.setGroupName(((Element)columns.next()).getValue());
		user.setType(Integer.parseInt(((Element)columns.next()).getValue()));
		user.setEnabled(Integer.parseInt(((Element)columns.next()).getValue()));
		user.setSeller(true);
		groupsList.get(user.groupName).add(user);
		groupsList.get(user.groupName).getWs(wsName).add(user);
		
		result[0] = wsName;
		result[1] = user;
		result[2] = user.isEnabled() + "";
		
		return result;
	}
	
	public static boolean containsGroup(String groupName) {
		return groupsList.containsKey(groupName);
	}
	
	public static Group getGroupByName(String groupName) {
		Collection<Group> list = groupsList.values();
		for (Group group: list) {
			if (group.getName().equals(groupName)) {
				return group;
			}
		}
		return null;
	}
	
	private static Group getGroupByWorkStation(String wsCode) {
		Collection<Group> list = groupsList.values();
		for (Group group: list) {
			if (group.containsWS(wsCode)) {
				return group;
			}
		}
		return null;
	}
	
	public static boolean containsWs(String wsName) {
		Collection<Group> list = groupsList.values();
		for (Group group: list) {
			for (WorkStation ws : group.getWorkStations()) {
				if (ws.name.equals(wsName)) {
					return true;	
				}
			}
		}
		return false;
	}
	
	public static boolean containsWsByCode(String wsCode) {
		Collection<Group> list = groupsList.values();
		for (Group group: list) {
			for (WorkStation ws : group.getWorkStations()) {
				if (ws.code.equals(wsCode)) {
					return true;	
				}
			}
		}
		return false;
	}
	
	public static WorkStation getWorkStation(String wsName) {
		Collection<Group> list = groupsList.values();
		for (Group group: list) {
			if (group.containsWS(wsName)) {
				return group.getWs(wsName);
			}
		}
		return null;
	}
	
	public static Group getGroup(String groupID) {
		return groupsList.get(groupID);
	}
	
	public static void setFrame(JFrame mainFrame) {
		frame = mainFrame;
	}	
	
	public static Collection<Group> getList() {
		return groupsList.values();
	}
	
	public static String[] getGroupsList() {
		Set <String>bag = groupsList.keySet();
		String[] sortedGroupList = (String[])bag.toArray(new String[bag.size()]);
		Arrays.sort(sortedGroupList);
		
		return sortedGroupList;
	}	

	public static String[] getAvailableGroupsList() {
		Object[] objectArray = Cache.getList().toArray();
		Vector<String> names = new Vector<String>();
		for (Object infoGroup:objectArray) {
			Group group = (Group)infoGroup;
			if (group.isEnabled()){
				names.add(group.getName());
			}
		}
        String[] groups = new String[names.size()];
		for (int i=0;i<names.size();i++) {
			groups[i] = names.elementAt(i);
		}
		Arrays.sort(groups);
		
		return groups;
	}	
	
	public static HashMap<String,String> getGroupsHash() {
		Object[] objectArray = Cache.getList().toArray();
		HashMap <String,String>groupsHash = new HashMap<String,String>();
		for (Object infoGroup:objectArray) {
			Group group = (Group)infoGroup;
			groupsHash.put(group.getName(), group.getId());
		}

		return groupsHash;
	}
	
	public static Vector<String> getAdminGroups() {
		Vector<String> groups = new Vector<String>();
		for (Group group : groupsList.values()) {
	         if (group.getType() == 2) {
	        	 groups.add(group.getName());
	         }
		}				
		Collections.sort(groups);
		return groups;
	}
	
	public static String[] getWorkStationsList() {
		String[] wsNames = {};
		Vector<String> workstations = new Vector<String>();
		for (Group group : groupsList.values()) {
			for (WorkStation ws : group.getWorkStations()) {
				workstations.add(ws.getName());
			}
		}		
		wsNames = new String[workstations.size()];
		for(int i=0;i<workstations.size();i++)  {
			wsNames[i] = workstations.get(i);
		}		
		Arrays.sort(wsNames);
		
		return wsNames;
	}
	
	public static String[] getWorkStationsListByGroup(String groupName) {
		String[] wsNames = {};
		Vector<String> workstations = new Vector<String>();
		Group group = groupsList.get(groupName);
        for (WorkStation ws : group.getWorkStations()) {
             workstations.add(ws.getName());
        }
		wsNames = new String[workstations.size()];
		for(int i=0;i<workstations.size();i++)  {
			wsNames[i] = workstations.get(i);
		}		
		Arrays.sort(wsNames);
		
		return wsNames;
	}

	public static User getUser (String login) {
		Cache.User user = null;
		boolean withGroup = false;
		boolean withWs = false;
		for (Cache.Group group : Cache.getList()) {
			withGroup = group.containsUser(login);
			if (withGroup) {
				user = group.getUser(login);
				break;
			}
			for (Cache.WorkStation ws : group.getWorkStations()) {
				withWs = ws.containsUser(login);
				if (withWs) {
					user = ws.getUser(login);
					break;
				}
			}
			if (withWs) {
				break;
			}
		}
		return user;
	}
		
	public static ArrayList<POS> getWorkStationsListByUser(String userCode) {
		ArrayList<POS> list = new ArrayList<POS>();
		for (Cache.Group group : Cache.getList()) {
			for (Cache.WorkStation ws : group.getWorkStations()) {
				if (ws.containsUser(userCode)) {
					POS upos = new POS();
					upos.posCode = ws.getCode();
					upos.name    = ws.getName();
					upos.validIP = ws.getUser(userCode).getValidIp();
					list.add(upos);
				}
			}
		}
		return list;
	}

	public static boolean containsUser(String login) {
		User user = getUser(login);
		return user!=null && user.login.equals(login) ? true :false;
	}
	
	public static boolean isOperatorUser(String login) {
		return operativeUsers.contains(login);
	}

	public static boolean isAdminUser(String login) {
		return adminUsers.contains(login);
	}
	
	public static void removeWs(String wsName) {
		Collection<Group> list = groupsList.values();
		for (Group group: list) {
			for (WorkStation ws : group.getWorkStations()) {
				if (ws.name.equals(wsName)) {
					group.workStationsHash.remove(wsName);
				}
			}
		}
	}
	
	public static void removeUser(String login) {
		Collection<Group> list = groupsList.values();
		for (Group group: list) {
			for (User user : group.getUsers() ) {
				if (user.login.equals(login)) {
					group.usersHash.remove(login);
				}
			}
		}
	}

	public static String[] getUsersList() {
		Vector<String> users = new Vector<String>();
		String[] usersArray = {};
		for (Group group : groupsList.values()) {
			for (String code : group.getUsersSet()) {
				users.add(code);
			}
		}		
		usersArray = new String[users.size()];
		for(int i=0;i<users.size();i++)  {
			usersArray[i] = users.get(i);
		}		
		Arrays.sort(usersArray);
		
		return usersArray;
	}
	
	public static String[] getAdminUsersList() {
		String[] usersArray = {};
		usersArray = new String[adminUsers.size()];
		for(int i=0;i<adminUsers.size();i++)  {
			usersArray[i] = adminUsers.get(i);
		}		
		Arrays.sort(usersArray);
		
		return usersArray;
	}
	
	public static String[] getOperativeUsersList() {
		String[] usersArray = {};
		usersArray = new String[operativeUsers.size()];
		for(int i=0;i<operativeUsers.size();i++)  {
			usersArray[i] = operativeUsers.get(i);
		}		
		Arrays.sort(usersArray);
		
		return usersArray;
	}
		
	public static class POS {
		
		private String posCode;
		private String name;
		private Boolean validIP;
		
		public String getPOSCode() {
			return posCode;
		}
		public Boolean getValidIP() {
			return validIP;
		}
		public String getName() {
			return name;
		}
		
	}
	
	public static class User {
		
		private String id;
		private String login;
		private String name;
		private String gid;
		private String email;
		private String passwd;
		private Boolean validIp = false;
		private String groupName;
		private Boolean seller=false;
		private int type;
		private int enabled;
		
		public Boolean isEnabled() {
			return (enabled == 1) ? true : false;
		}
		
		public void setEnabled(int enabled) {
			this.enabled = enabled;
		}
		
		public Boolean isSeller() {
			return seller;
		}
		
		public void setSeller(Boolean seller) {
			this.seller = seller;
		}
		
		public String getEmail() {
			return email;
		}
		
		public void setEmail(String email) {
			this.email = email;
		}
		
		public String getPasswd() {
			return passwd;
		}
		
		public void setPasswd(String passwd) {
			this.passwd = passwd;
		}
		
		public String getGid() {
			return gid;
		}
		
		public void setGid(String gid) {
			this.gid = gid;
		}
		
		public String getId() {
			return id;
		}
		
		public void setId(String id) {
			this.id = id;
		}
		
		public String getLogin() {
			return login;
		}
		
		public void setLogin(String login) {
			this.login = login;
		}
		
		public String getName() {
			return name;
		}
		
		public void setName(String name) {
			this.name = name;
		}
		
		public Boolean getValidIp() {
			return validIp;
		}
		
		public void setValidIp(Boolean validIp) {
			this.validIp = validIp;
		}

		public String getGroupName() {
			return groupName;
		}

		public void setGroupName(String groupName) {
			this.groupName = groupName;
		}
		
		public int getType() {
			return type;
		}
		
		public void setType(int type) {
			this.type = type;
		}	
	}
	
	public static class WorkStation {

		private String ip;
		private String code;
		private String gid;
		private String groupName;
		private String name;
		private int isEnabled;
		private Hashtable<String, User> userHash;
		
		public WorkStation() {
			userHash = new Hashtable<String, User>();
		}
		
		public void add(User user) {
			userHash.put(user.login,user);
		}
		
		public User getUser(String code) {
			return userHash.get(code);
		}
		
		public String getCode() {
			return code;
		}
		
		public void setCode(String code) {
			this.code = code;
		}
		
		public String getGid() {
			return gid;
		}
		
		public void setGid(String gid) {
			this.gid = gid;
		}
		
		public String getIp() {
			return ip;
		}
		
		public void setIp(String ip) {
			this.ip = ip;
		}
		
		public String getName() {
			return name;
		}
		
		public void setName(String name) {
			this.name = name;
		}
		
		public boolean containsUser(String code) {
			return userHash.containsKey(code);
		}
		
		public Collection<User> getUsers() {
			return userHash.values();
		}
		
		public void setGroupName(String groupName) {
			this.groupName = groupName;
		}

		public String getGroupName() {
			return groupName;
		}
		
		public void setEnabled(int i) {
			isEnabled = i;
		}
		
		public Boolean isEnabled(){
			return isEnabled == 1 ? true : false;
		}
	}	

	public static class Group {
		
		private String name;
		private String id;
		private int type;
		private Boolean isVisible;
		private Boolean isEnabled;
		private Hashtable<String, WorkStation> workStationsHash;
		private Hashtable<String, User> usersHash;
		
		public Group() {
			workStationsHash = new Hashtable<String, WorkStation>();
			usersHash = new Hashtable<String, User>();
		}
		
		public void add(WorkStation ws) {
			workStationsHash.put(ws.name,ws);
		}
		
		public void add(User user) {
			usersHash.put(user.login,user);
		}
		
		public WorkStation getWs(String name) {
			return workStationsHash.get(name);
		}
		
		public boolean containsWS(String name) {
			return workStationsHash.containsKey(name);
		}
		
		public boolean containsUser(String code) {
			return usersHash.containsKey(code);
		}
		
		public User getUser(String code) {
			return usersHash.get(code);
		}
		
		public Set<String> getUsersSet() {
			return usersHash.keySet();
		}
		
		public String getId() {
			return id;
		}
		
		public void setId(String id) {
			this.id = id;
		}
		
		public String getName() {
			return name;
		}
		
		public void setName(String name) {
			this.name = name;
		}
		
		public int getType() {
			return type;
		}
		
		public void setType(int type) {
			this.type = type;
		}
		
		public Boolean isVisible() {
			return isVisible;
		}
		
		public void setVisible(Boolean visible) {
			this.isVisible = visible;
		}

		public Collection<WorkStation> getWorkStations() {
			return workStationsHash.values();
		}
		
		public String[] getWorkStationsKeys() {
			Set <String>bag = workStationsHash.keySet();
			String[] array = (String[])bag.toArray(new String[bag.size()]);
			Arrays.sort(array);
			return array;
		}
		
		public Collection<User> getUsers() {
			return usersHash.values();
		}
		
		public void setEnabled(int i) {
			if (i == 1) {
				isEnabled = true;
			} else {
				isEnabled = false;
			}
		}
		
		public Boolean isEnabled() {
			return isEnabled;
		}		
		
	}

}