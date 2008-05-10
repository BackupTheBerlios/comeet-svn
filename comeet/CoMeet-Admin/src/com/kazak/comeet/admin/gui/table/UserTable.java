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

package com.kazak.comeet.admin.gui.table;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Vector;

import javax.swing.BoxLayout;
import javax.swing.DefaultCellEditor;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;

import com.kazak.comeet.admin.control.Cache;
import com.kazak.comeet.admin.gui.table.models.UserModel;
import com.kazak.comeet.admin.gui.managers.WorkStationsManager;
import com.kazak.comeet.admin.gui.misc.GUIFactory;

public class UserTable extends JTable {

	private static final long serialVersionUID = 4182381331394270487L;
	private UserModel model;
	private JFrame frame;
	private JPanel panel;
	private JButton addButton;
	private JButton deleteButton;
	private WorkStationsManager ws;	
	
	public UserTable(JFrame parent) {
		frame = parent;
		panel =  new JPanel(new BorderLayout());
		model = new UserModel();
		this.setModel(model);
		GUIFactory factory = new GUIFactory();
		addButton = factory.createButton("add.png");
		deleteButton = factory.createButton("remove.png");
		this.setGridColor(Color.BLACK);
		this.setDefaultEditor(String.class,new CellEditor());
		this.setSurrendersFocusOnKeystroke(true);
		ws = new WorkStationsManager();
		deleteButton.setEnabled(false);
		addButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if (!ws.isVisible()) {
					ws.clean();
					ws.searchPOS(UserTable.this);
				}
			}
		});
			
		deleteButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				int rows = UserTable.this.getRowCount()-1;
				if (rows >= 0 ) {
					if (rows == 0){
						deleteButton.setEnabled(false);
					}
					int selected = UserTable.this.getSelectedRow();
					if (selected == -1) {
						model.remove(UserTable.this.getRowCount()-1);
					}
					else {
						model.remove(selected);	
					}
				}
			}
		});

		JPanel buttonsPanel = new JPanel();
		buttonsPanel.setLayout(new BoxLayout(buttonsPanel,BoxLayout.Y_AXIS));
		buttonsPanel.add(addButton);
		buttonsPanel.add(deleteButton);
		
		JScrollPane jscroll = new JScrollPane(UserTable.this);
		panel.add(jscroll,BorderLayout.CENTER);
		panel.add(buttonsPanel,BorderLayout.WEST);
	}
	
	public void disableButtons() {
		addButton.setEnabled(false);
		deleteButton.setEnabled(false);
	}
	
	public void enableDeleteButton() {
		deleteButton.setEnabled(true);
	}
	
	public void disableDeleteButton() {
		deleteButton.setEnabled(false);
	}
	
	public void addData(String code,String name) {
		model.addRow(code,name);
	}
	
	public boolean isAlreadyIn(String code) {
		return model.isAlreadyIn(code);
	}
	
	public void addRow() {
		model.addRow();
	}
	
	public UserModel getModel() {
		return model;
	}
	
	public void clean() {
		model.clear();
	}
	
	public JPanel getPanel() {
		return panel; 
	}
	
	public int getRowCount () {
		return model.getRowCount();
	}
	
	public void removeRow(int rows) {
		if (rows != -1) {
			model.remove(UserTable.this.getRowCount()-1);
			if (rows == 0){
				deleteButton.setEnabled(false);
			}
		}
	}
	
	public Vector<Vector> getData() {
		return model.getData();
	}
	
	class CellEditor extends DefaultCellEditor {

		private static final long serialVersionUID = -3511583773152512776L;

		public CellEditor() {
			super(new JTextField());
		}
		
	    public Object getCellEditorValue() {
	    	String value = ((JTextField)getComponent()).getText();
	        if (!Cache.containsWsByCode(value)) {
	        	JOptionPane.showMessageDialog(frame,"El código no existe. ");
	        	((JTextField)getComponent()).setText("");
	        	return "";
	        }
	        return value;
	    }
	}

	public void enableButtons() {
		addButton.setEnabled(true);
		deleteButton.setEnabled(true);
	}
}