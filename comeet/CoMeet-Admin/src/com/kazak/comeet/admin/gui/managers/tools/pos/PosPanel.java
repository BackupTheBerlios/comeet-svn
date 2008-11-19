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

package com.kazak.comeet.admin.gui.managers.tools.pos;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.ArrayList;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.JOptionPane;

import com.kazak.comeet.admin.control.Cache;
import com.kazak.comeet.admin.control.Cache.WorkStation;
import com.kazak.comeet.admin.gui.managers.tools.Transactions.PosDocument;
import com.kazak.comeet.admin.gui.misc.AutoCompleteComboBox;
import com.kazak.comeet.admin.gui.misc.GUIFactory;
import com.kazak.comeet.admin.gui.managers.tools.MainForm;
import com.kazak.comeet.admin.gui.managers.tools.ButtonBar;
import com.kazak.comeet.admin.gui.managers.tools.ToolsConstants;
import com.kazak.comeet.admin.gui.managers.tools.Operation;
import com.kazak.comeet.admin.gui.table.UserPosTable;
import com.kazak.comeet.lib.misc.FixedSizePlainDocument;

public class PosPanel extends JPanel implements ActionListener, KeyListener { 
	
	private static final long serialVersionUID = 1L;
	private MainForm mainFrame;
	private int action;
	private String target;
	private ArrayList<Component> componentsList = new ArrayList<Component>();
	private AutoCompleteComboBox nameField;
	private JCheckBox enabledCheck;
	private JButton searchButton;
	private JTextField ipField;
	private JComboBox groupsCombo;
	private String[] labels = {"Nombre: ","Habilitado ","IP: ","Grupo: "};
	private UserPosTable table;

	public PosPanel(MainForm mainFrame, int action, String target, UserPosTable table) {
		this.mainFrame = mainFrame;
		this.action = action;
		this.target = target;
		this.table = table;
		initInterface();
		packPanels();
	}
	
	private void initInterface() {
		GUIFactory gui = new GUIFactory();
		searchButton = gui.createButton("search.png");
		searchButton.setActionCommand("search");
		searchButton.addActionListener(this);
		componentsList.add(nameField = new AutoCompleteComboBox(Cache.getWorkStationsList(),false,50,searchButton));
		componentsList.add(enabledCheck = new JCheckBox());
		componentsList.add(ipField   = new JTextField());
		ipField.setEditable(false);
		ipField.setName("IP");
		groupsCombo = new JComboBox(Cache.getAvailableGroupsList());
		groupsCombo.removeItem("COMEET");
		componentsList.add(groupsCombo);
		ipField.setDocument(new FixedSizePlainDocument(15));		
		setInitMode();
		this.setVisible(true);
	}
	
	private void setInitMode(){
		WorkStation ws;
		switch(action) {
			// To Add
		case ToolsConstants.ADD:
			mainFrame.setTitle("Nueva Ubicación");
			enabledCheck.setSelected(true);
			ipField.setEditable(true);
			ButtonBar.setEnabledAcceptButton(false);
			break;
			// To Edit
		case ToolsConstants.EDIT:
			mainFrame.setTitle("Editar Ubicación");
			reset();
			/*
			enabledCheck.setEnabled(false);
			ipField.setEditable(false);
			ipField.setFocusTraversalKeysEnabled(false);
			groupsCombo.setEnabled(false);
			*/
			break;
			// Edit pre-filled
		case ToolsConstants.EDIT_PREFILLED:
			mainFrame.setTitle("Editar Ubicación");
			nameField.setSelectedItem(target);
			ws = Cache.getWorkStation(target);
			enabledCheck.setSelected(ws.isEnabled());
			ipField.setEditable(true);
			ipField.setFocusTraversalKeysEnabled(false);
			groupsCombo.setEnabled(true);
			fillForm();
			break;
			// To Delete
		case ToolsConstants.DELETE:
			mainFrame.setTitle("Borrar Ubicación");
			ButtonBar.setEnabledAcceptButton(false);
			groupsCombo.setEnabled(false);
			break;
			// Delete pre-filled
		case ToolsConstants.DELETE_PREFILLED:
			nameField.setSelectedItem(target);
			mainFrame.setTitle("Borrar Ubicación");
			groupsCombo.setEnabled(false);
			fillForm();
			break;
			// To Search
		case ToolsConstants.SEARCH:
			mainFrame.setTitle("Buscar Ubicación");
			enableFields(false);
			break;
			// Search pre-filled
		case ToolsConstants.SEARCH_PREFILLED:
			mainFrame.setTitle("Buscar Ubicación");		
			ws = Cache.getWorkStation(target);
			enabledCheck.setSelected(ws.isEnabled());
			doFilledSearch();
			enableFields(false);
			break;
		case ToolsConstants.LINK:
			mainFrame.setTitle("Asignar Ubicación a Usuario");
			ButtonBar.setEnabledAcceptButton(false);
			enableFields(false);
			break;			
		}	
	}
	
	private void fillForm() {
		
		if (Cache.containsWs(target)) {
			WorkStation ws = Cache.getWorkStation(target);
			switch(action) {
			case ToolsConstants.ADD:
				if(!nameField.eventFromCombo()) {
					JOptionPane.showMessageDialog(mainFrame,"El grupo " + target + " ya existe. ");
					nameField.blankTextField();
					nameField.requestFocus();
				}
				break;
			case ToolsConstants.EDIT:
			case ToolsConstants.EDIT_PREFILLED:
				enabledCheck.setEnabled(true);
				enabledCheck.setSelected(ws.isEnabled());
				ipField.setEditable(true);
				groupsCombo.setEnabled(true);
				ipField.setText(ws.getIp());
				groupsCombo.setSelectedItem(ws.getGroupName());
				ipField.addKeyListener(this);
				ipField.requestFocus();
				ButtonBar.setEnabledAcceptButton(true);
				break;
			case ToolsConstants.DELETE:
			case ToolsConstants.DELETE_PREFILLED:
				ButtonBar.setEnabledAcceptButton(true);
			case ToolsConstants.SEARCH:
			case ToolsConstants.SEARCH_PREFILLED:
			case ToolsConstants.LINK:
				enabledCheck.setSelected(ws.isEnabled());
				ipField.setText(ws.getIp());
				groupsCombo.setSelectedItem(ws.getGroupName());
				nameField.requestFocus();
				if(!ButtonBar.isAcceptButtonActive()) {
					ButtonBar.setEnabledAcceptButton(true);
				}
				break;
			}
		} else {
			if ((action != ToolsConstants.ADD)) {
				JOptionPane.showMessageDialog(mainFrame,"La ubicación no existe. ");
				reset();
			} else {
				enabledCheck.setSelected(true);
				ipField.setEditable(true);
				groupsCombo.setEnabled(true);
				ipField.requestFocus();
				ipField.addKeyListener(this);
				ButtonBar.setEnabledAcceptButton(true);
			}
		}			
	}
	
	public String[] getFormData(){
		String[] data = new String[6];	
		WorkStation ws = Cache.getWorkStation(target);
		data[0] = target;
		if (ws != null) {
			data[1] = ws.getCode();
		} else {
			data[1] = null;
		}
		data[2] = ipField.getText();
		data[3] = (String) groupsCombo.getSelectedItem();
		data[4] = enabledCheck.isSelected() ? "1" : "0";
		data[5] = nameField.getText();
	
		return data;
	}
		
	public void executeOperation() {
		PosData pos = new PosData(mainFrame,getFormData(),ipField,action);
		if (!pos.verifyData()) {
			return;
		}
		PosDocument doc = new PosDocument(getFormData());
		
		if (Cache.containsWs(nameField.getText())) {
			switch(action) {
				// To Edit
			case ToolsConstants.EDIT:
				// To Edit (filled)
			case ToolsConstants.EDIT_PREFILLED:
				Operation.execute(doc.getDocumentToEdit());
				mainFrame.dispose();
				break;
				// To Delete
			case ToolsConstants.DELETE:
				Operation.execute(doc.getDocumentToDelete());
				mainFrame.dispose();
				break;
				// To Delete (filled)
			case ToolsConstants.DELETE_PREFILLED:
				Operation.execute(doc.getDocumentToDelete());
				mainFrame.dispose();
				break;
			case ToolsConstants.LINK:
				table.insertData(doc.getDocumentToLink());
				mainFrame.dispose();
				break;
			}	   
		} else {
			if (action != ToolsConstants.ADD) {
				JOptionPane.showMessageDialog(mainFrame,"El grupo " + target + " no existe. ");
				resetPanel();
			} else {
				// ADD operation
				Operation.execute(doc.getDocumentToAdd());
				mainFrame.dispose();
			}
		}			
	}
	
	private void packPanels() {
		JPanel labelsPanel = new JPanel(new GridLayout(labels.length,0));
		JPanel fieldsPanel = new JPanel(new GridLayout(labels.length,0));
		
		for (int i=0 ; i< labels.length ; i++) {
			labelsPanel.add(new JLabel(labels[i]));
			fieldsPanel.add(componentsList.get(i));
		}
		
		JPanel searchPanel = new JPanel();		
		searchPanel.setLayout(new BoxLayout(searchPanel,BoxLayout.Y_AXIS));
		searchPanel.setPreferredSize(new Dimension(40,90));
		searchPanel.add(searchButton);
		
		JPanel centerPanel = new JPanel(new BorderLayout());
		centerPanel.add(labelsPanel,BorderLayout.WEST);
		centerPanel.add(fieldsPanel,BorderLayout.CENTER);

		this.add(centerPanel,BorderLayout.CENTER);
		this.add(searchPanel,BorderLayout.EAST);
	}
		
	public void clean() {
		switch(action) {
			// To Add
		case ToolsConstants.ADD:
			enabledCheck.setSelected(false);
			nameField.blankTextField();
			ipField.setText("");
			ipField.setEditable(true);
			break;
			// To Edit, to Delete (unfilled,filled)
		case ToolsConstants.LINK:
		case ToolsConstants.EDIT:
		case ToolsConstants.EDIT_PREFILLED:
		case ToolsConstants.DELETE:
		case ToolsConstants.DELETE_PREFILLED:
			resetPanel();
			break;
			// To Search
		case ToolsConstants.SEARCH:
		case ToolsConstants.SEARCH_PREFILLED:
			reset();
			break;
		}	
	}
		
	private void reset() {
		nameField.setEditable(true);
		nameField.blankTextField();
		enabledCheck.setEnabled(false);
		ipField.setText("");
		ipField.setEditable(false);
		groupsCombo.setSelectedIndex(0);
		groupsCombo.setEnabled(false);	
	}
	
	private void resetPanel() {
		reset();
		ButtonBar.setEnabledAcceptButton(false);
	}
	
	private void enableFields(Boolean flag) {
		enabledCheck.setEnabled(flag);
		ipField.setEditable(flag);
		groupsCombo.setEnabled(flag);
	}
	
	private void doFilledSearch() {
		nameField.setSelectedItem(target);
		doSearch();
	}
	
	private void doSearch() {
		target = nameField.getText();
		if(target.length() > 0) {
			fillForm();		
		} else {
			resetPanel();
		}
	}
	
	public void actionPerformed(ActionEvent e) {
		String command = e.getActionCommand();
		if (command.equals("search")) {
			doSearch();
		}
	}

	public void keyPressed(KeyEvent e) {
	}

	public void keyReleased(KeyEvent e) {
		int keyCode = e.getKeyCode();
        if (keyCode==KeyEvent.VK_ENTER || keyCode==KeyEvent.VK_TAB){ 
        	JTextField ipText = (JTextField) e.getSource();
        	String name = ipText.getName();
        	if (name.equals("IP")) {
        		groupsCombo.requestFocus();
        	}
        }
	}

	public void keyTyped(KeyEvent e) {
	}
}
