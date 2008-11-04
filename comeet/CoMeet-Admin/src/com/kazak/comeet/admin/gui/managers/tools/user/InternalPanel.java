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

package com.kazak.comeet.admin.gui.managers.tools.user;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.Vector;

import javax.swing.BorderFactory;
import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.border.Border;

import com.kazak.comeet.admin.control.Cache;
import com.kazak.comeet.admin.control.Cache.User;
import com.kazak.comeet.admin.control.Cache.WorkStation;
import com.kazak.comeet.admin.gui.main.MainTreeManager;
import com.kazak.comeet.admin.gui.managers.tools.ButtonBar;
import com.kazak.comeet.admin.gui.managers.tools.ToolsConstants;
import com.kazak.comeet.admin.gui.table.UserPosTable;
import com.kazak.comeet.lib.misc.MD5Tool;

public class InternalPanel extends JPanel implements ActionListener {
	private static final long serialVersionUID = 1L;
	private ArrayList<Component> componentsList = new ArrayList<Component>();
	private String[] adminLabels = {"Clave: ","Nombres: ","E-Mail: ", "Tipo de Usuario: ","Grupo: ","Ubicación: "};
	private String[] posLabels = {"Clave: ","Nombres: ","Control de Acceso por IP "};
	private String[] userTypes = {"Administrador","Auditor","Usuario de Correo"};
	private JPasswordField passwdField;
	private JTextField nameField;
	private JTextField mailField;
	private JCheckBox ipControlCheck;
	private JComboBox typeCombo;
	private JComboBox groupsCombo;
	private JComboBox sitesCombo;
	private UserPosTable table;
	private JFrame dialog;
	private int action;
	private boolean isAdmin;
	private User user;
	private String username;

	public InternalPanel(JFrame dialog, String username, boolean isAdmin, int action) {
		super();
		this.username = username;
		user = Cache.getUser(username);
		this.dialog = dialog;
		this.action = action;
		this.isAdmin = isAdmin;
		this.setLayout(new BorderLayout());
		initComponents();
		addComponents();
	}

	private void initComponents() {
		componentsList.add(passwdField = new JPasswordField());
		passwdField.requestFocus();
		componentsList.add(nameField   = new JTextField());

		if(isAdmin) {
			initAdminComponents();
			groupsCombo.addActionListener(this);
		} else {
			initUserComponents();
		}
	}
	
	private void initAdminComponents() {
		componentsList.add(mailField   = new JTextField());
		componentsList.add(typeCombo   = new JComboBox(userTypes));
		componentsList.add(groupsCombo = new JComboBox(Cache.getAdminGroups()));
		String[] items = {"SIN REGISTROS"};
		componentsList.add(sitesCombo  = new JComboBox(items));
		setAdminContext();		
	}

	private void initUserComponents() {
		componentsList.add(ipControlCheck = new JCheckBox());
		setUserContext();
	}

	private void addComponents(){
		
		JPanel centerPanel = new JPanel(new BorderLayout());
		JPanel labelsPanel = null;
		JPanel fieldsPanel = null;
		Border border = BorderFactory.createEtchedBorder();

		if(isAdmin) {		
			labelsPanel = new JPanel(new GridLayout(6,0));
			fieldsPanel = new JPanel(new GridLayout(6,0));

			for (int i=0 ; i< adminLabels.length ; i++) {
				labelsPanel.add(new JLabel(adminLabels[i]));
				fieldsPanel.add(componentsList.get(i));
			}
		} else {
			labelsPanel = new JPanel(new GridLayout(3,0));
			fieldsPanel = new JPanel(new GridLayout(3,0));

			for (int i=0 ; i< posLabels.length ; i++) {
				labelsPanel.add(new JLabel(posLabels[i]));
				fieldsPanel.add(componentsList.get(i));
			}
			centerPanel.add(addPOSTable(),BorderLayout.SOUTH);
		}

		centerPanel.add(labelsPanel,BorderLayout.WEST);
		centerPanel.add(fieldsPanel,BorderLayout.CENTER);

		JPanel finalPanel = new JPanel(new BorderLayout());
		finalPanel.add(new JPanel(),BorderLayout.WEST);
		finalPanel.add(centerPanel,BorderLayout.CENTER);
		finalPanel.add(new JPanel(),BorderLayout.EAST);
		finalPanel.setBorder(border);
		this.add(finalPanel,BorderLayout.CENTER);

	}
	
	private JPanel addPOSTable() {
		JPanel southPanel = new JPanel(new BorderLayout());
		southPanel.add(new JLabel("Puntos de Trabajo",JLabel.CENTER),BorderLayout.NORTH);
		southPanel.add(new JPanel(),BorderLayout.WEST);
		southPanel.add(table.getPanel(),BorderLayout.CENTER);
		southPanel.add(new JPanel(),BorderLayout.EAST);
		
		return southPanel;
	}

	private void activeAdminPanel(boolean flag) {
		nameField.setEditable(flag);
		typeCombo.setEnabled(flag);
		groupsCombo.setEnabled(flag);
		sitesCombo.setEnabled(flag);
		mailField.setEditable(flag);
		passwdField.setEnabled(flag);
	}
	
	private void setAdminDataPanel() {
        switch(user.getType()) {
        case 1:
        	typeCombo.setSelectedItem("Administrador");
        	break;
        case 2:
        	typeCombo.setSelectedItem("Auditor");
        	break;
        case 5:
        	typeCombo.setSelectedItem("Usuario de Correo");
        	break;
        }
		groupsCombo.setSelectedItem(user.getGroupName());
		updateSitesCombo(Cache.getWorkStationsListByGroup(user.getGroupName()));
		Object[] leaf = MainTreeManager.getSelectedPath().getPath();
		sitesCombo.setSelectedItem(leaf[2].toString());
		mailField.setText(user.getEmail());
		nameField.setText(user.getName());		
	}
	
	public void setAdminContext() {	
		switch(action) {
		// To Add
		case ToolsConstants.ADD:
			break;
			// To Edit
			// To Edit (filled)
		case ToolsConstants.EDIT:
		case ToolsConstants.EDIT_PREFILLED:
			setAdminDataPanel();
			activeAdminPanel(true);
			break;
			// To Delete - To Delete (filled) - To Search - To Search (filled)
		case ToolsConstants.DELETE:
		case ToolsConstants.DELETE_PREFILLED:
			ButtonBar.setEnabledAcceptButton(true);
		case ToolsConstants.SEARCH:
		case ToolsConstants.SEARCH_PREFILLED:
			setAdminDataPanel();
			activeAdminPanel(false);
			break;
		}
	}
	
	private void activeUserPanel(boolean flag) {
		nameField.setEditable(flag);
		passwdField.setEnabled(flag);
		ipControlCheck.setEnabled(flag);
	}
	
	private void setUserPanel(boolean flag) {
		ipControlCheck.setSelected(user.getValidIp());
		nameField.setText(user.getName());
		activeUserPanel(flag);
		table = new UserPosTable(dialog,username,flag,action);
	}
	
	public void setUserContext() {	
		switch(action) {
		// To Add
		case ToolsConstants.ADD:
			table = new UserPosTable(dialog,username,true,action);
			break;
			// To Edit
			// To Edit (filled)
		case ToolsConstants.EDIT:
		case ToolsConstants.EDIT_PREFILLED:
			setUserPanel(true);
			break;
			// To Delete - To Delete (filled) - To Search - To Search (filled)
		case ToolsConstants.DELETE:
		case ToolsConstants.DELETE_PREFILLED:
			ButtonBar.setEnabledAcceptButton(true);
		case ToolsConstants.SEARCH:
		case ToolsConstants.SEARCH_PREFILLED:
			setUserPanel(false);
			break;
		}
	}
	
	public String getPasswd() {
		String passwd = new String(passwdField.getPassword()).trim();
		if(passwd.length() > 0) {
			MD5Tool md5 = new MD5Tool(passwd);
			passwd = md5.getDigest();
		} else {
				passwd = "";
		}
		return passwd;
	}
	
	public String getUserName() {
		return nameField.getText();
	}
	
	public String getUserMail() {
		if(isAdmin) {
			return mailField.getText();
		} else {
			return "";
		}
	}
	
	public String getUserGroup() {
		if(isAdmin) {
			String group = groupsCombo.getSelectedItem().toString();
			Cache.Group groupObject = Cache.getGroup(group);
			return groupObject.getId();
		} else {
			return "1";
		}
	}
	
	public String getUserLocation() {
		String location = sitesCombo.getSelectedItem().toString();
		if (location.equals("SIN REGISTROS")) {
			return location;	
		} else {
			WorkStation ws = Cache.getWorkStation(location);
			return ws.getCode();
		}
	}
	
	public String getUserRol() {
		String rol = typeCombo.getSelectedItem().toString();
		String type = "";

		if (rol.equals("Administrador")) {
			type = "1";
		} else if (rol.equals("Auditor")) {
			type = "2";
		} else {
			type = "5";
		}
		
		return type;
	}

	public String doIPCheck() {
		if(isAdmin) {
			return "0";
		} else {
			if (ipControlCheck.isSelected()) {
				return "1";
			} else {
				return "0";
			}
		}
	}
	
	public Vector<String> getPosCodes() {
		return table.getPosCodeVector();
	}

	public void actionPerformed(ActionEvent e) {
	    JComboBox cb = (JComboBox)e.getSource();
	    String group = (String)cb.getSelectedItem();
	    String[] places = Cache.getWorkStationsListByGroup(group);
	    updateSitesCombo(places);
	}
	
	private void updateSitesCombo(String[] items) {
		sitesCombo.removeAllItems();
	    if(items.length == 0) {
	    	sitesCombo.addItem("SIN REGISTROS");
	    } else {
	    	for (int i=0;i< items.length;i++) {
	    		sitesCombo.addItem(items[i]);
	    	}	    
	    }
	}
	

}
