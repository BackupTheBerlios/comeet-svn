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

package com.kazak.comeet.admin.gui.managers.tools.group;

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
import javax.swing.JOptionPane;
import javax.swing.JPanel;

import com.kazak.comeet.admin.control.Cache;
import com.kazak.comeet.admin.control.Cache.Group;
import com.kazak.comeet.admin.gui.managers.tools.Transactions.GroupDocument;
import com.kazak.comeet.admin.gui.managers.tools.Operation;
import com.kazak.comeet.admin.gui.managers.tools.MainForm;
import com.kazak.comeet.admin.gui.managers.tools.ButtonBar;
import com.kazak.comeet.admin.gui.managers.tools.ToolsConstants;
import com.kazak.comeet.admin.gui.misc.AutoCompleteComboBox;
import com.kazak.comeet.admin.gui.misc.GUIFactory;

public class GroupPanel extends JPanel implements ActionListener, KeyListener {

	private static final long serialVersionUID = 1L;
	private MainForm mainFrame;
	private int action;
	private String target;
	private JButton searchButton;
	private ArrayList<Component> componentsList = new ArrayList<Component>();
	private AutoCompleteComboBox nameField;
	private JCheckBox enabledCheck;
	private JCheckBox visibleCheck;
	private JComboBox groupType;
	private String[] labels = {"Nombre: ","Habilitado ","Tipo de Grupo: ","Visible para clientes"};

	public GroupPanel(MainForm mainFrame, int action, String target) {
		this.mainFrame = mainFrame;
		this.action = action;
		this.target = target;
		initInterface();
		packPanels();		
	}
	
	private void initInterface() {
		GUIFactory gui = new GUIFactory();
		searchButton = gui.createButton("search.png");
		searchButton.setActionCommand("search");
		searchButton.addActionListener(this);		

		componentsList.add(nameField    = new AutoCompleteComboBox(Cache.getGroupsList(),false,50,searchButton));
		componentsList.add(enabledCheck = new JCheckBox());
		componentsList.add(groupType    = new JComboBox(Cache.getGroupTypesVector()));
		componentsList.add(visibleCheck = new JCheckBox());
		
		setInitMode();
		this.setVisible(true);
	}
	
	private void setInitMode(){
		Group group;
		switch(action) {
			// To Add
		case ToolsConstants.ADD:
			mainFrame.setTitle("Nuevo Grupo");
			enableFields(false);
			ButtonBar.setEnabledAcceptButton(false);
			break;
			// To Edit
		case ToolsConstants.EDIT:
			mainFrame.setTitle("Editar Grupo");
			enableFields(false);
			ButtonBar.setEnabledAcceptButton(false);
			break;
			// Edit pre-filled
		case ToolsConstants.EDIT_PREFILLED:
			mainFrame.setTitle("Editar Grupo");
			nameField.setSelectedItem(target);
			group = Cache.getGroupByName(target);
			enabledCheck.setSelected(group.isEnabled());		
			fillForm();
			break;
			// To Delete
		case ToolsConstants.DELETE:
			mainFrame.setTitle("Borrar Grupo");
			ButtonBar.setEnabledAcceptButton(false);
			enableFields(false);
			break;
			// Delete pre-filled
		case ToolsConstants.DELETE_PREFILLED:
			nameField.setSelectedItem(target);
			mainFrame.setTitle("Borrar Grupo");
			fillForm();
			break;
			// To Search
		case ToolsConstants.SEARCH:
			mainFrame.setTitle("Buscar Grupo");
			enableFields(false);
			break;
			// Search pre-filled
		case ToolsConstants.SEARCH_PREFILLED:
			mainFrame.setTitle("Buscar Grupo");			
			group = Cache.getGroupByName(target);
			enabledCheck.setSelected(group.isEnabled());		
			doFilledSearch();
			enableFields(false);
			break;
		}	
	}
	
	private void fillForm() {
		if (Cache.containsGroup(target)) {
			Group group = Cache.getGroup(target);
			String type;
			
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
				enabledCheck.setSelected(group.isEnabled());
				visibleCheck.setSelected(group.isVisible());
				type = Cache.getGroupTypeName(group.getType());
				groupType.setSelectedItem(type);
				enableFields(true);
				ButtonBar.setEnabledAcceptButton(true);			
				break;
			case ToolsConstants.DELETE:
			case ToolsConstants.DELETE_PREFILLED:
				enableFields(false);
				ButtonBar.setEnabledAcceptButton(true);
			case ToolsConstants.SEARCH:
			case ToolsConstants.SEARCH_PREFILLED:
				nameField.requestFocus();
				enabledCheck.setSelected(group.isEnabled());
				visibleCheck.setSelected(group.isVisible());
				type = Cache.getGroupTypeName(group.getType());
				groupType.setSelectedItem(type);
				break;
			}
		} else {
			if (action != ToolsConstants.ADD) {
				JOptionPane.showMessageDialog(mainFrame,"El grupo " + target + " no existe. ");
				resetPanel();
			} else {
				enabledCheck.setSelected(true);
				enableFields(true);
				ButtonBar.setEnabledAcceptButton(true);
			}
		}			
	}

	public String[] getFormData(){
		String[] data = new String[5];	
		data[0] = target;
		data[1] = visibleCheck.isSelected() ? "1" : "0";
		String type = groupType.getSelectedItem().toString();
		data[2] = Cache.getGroupTypeID(type).toString();
		data[3] = nameField.getText();
		data[4] = enabledCheck.isSelected() ? "1" : "0";
		
		return data;
	}	
	
	public void executeOperation() {
				
		GroupDocument doc = new GroupDocument(getFormData());
		switch(action) {
			// To Add
		case ToolsConstants.ADD:
			Operation.execute(doc.getDocumentToAdd());
			mainFrame.dispose();
			break;
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
		searchPanel.setPreferredSize(new Dimension(40,69));
		searchPanel.add(searchButton);
		
		JPanel centerPanel = new JPanel(new BorderLayout());
		centerPanel.add(labelsPanel,BorderLayout.WEST);
		centerPanel.add(fieldsPanel,BorderLayout.CENTER);

		this.add(centerPanel,BorderLayout.CENTER);
		this.add(searchPanel,BorderLayout.EAST);
	}
		
	public void clean() {
		switch(action) {
			// To Add, To Edit, To Delete, To Search
		case ToolsConstants.ADD:
		case ToolsConstants.EDIT:
		case ToolsConstants.EDIT_PREFILLED:
		case ToolsConstants.DELETE:
		case ToolsConstants.SEARCH:
		case ToolsConstants.SEARCH_PREFILLED:
			reset();
			break;
		}	
	}
	
	private void reset() {
		nameField.setEditable(true);
		nameField.blankTextField();
		enabledCheck.setSelected(false);
		visibleCheck.setSelected(false);
		groupType.setEnabled(false);
		ButtonBar.setEnabledAcceptButton(false);
	}
	
	private void resetPanel() {
		reset();
		ButtonBar.setEnabledAcceptButton(false);
	}
	
	private void enableFields(boolean flag) {
		enabledCheck.setEnabled(flag);
		visibleCheck.setEnabled(flag);
		groupType.setEnabled(flag);
	}

	private void doFilledSearch() {
		nameField.setSelectedItem(target);
		doSearch();
	}
	
	private void doSearch() {
		target = nameField.getText();
		if(target.length() == 0) {
			return;
		}
		fillForm();		
	}
	
	public void keyPressed(KeyEvent e) {	
	}

	public void keyReleased(KeyEvent e) {
	}

	public void keyTyped(KeyEvent e) {	
	}
	
	public void actionPerformed(ActionEvent e) {	
		String command = e.getActionCommand();
		if (command.equals("search")) {
			doSearch();
		}
	}
}
