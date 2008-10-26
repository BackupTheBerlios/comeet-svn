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

package com.kazak.comeet.client.gui;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Point;

import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.ListSelectionModel;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.TableCellRenderer;

import com.kazak.comeet.client.control.MessageConfirmer;
import com.kazak.comeet.client.control.HeadersValidator;
import com.kazak.comeet.client.control.MessageEvent;
import com.kazak.comeet.client.control.MessageListener;

public class HistoryDataPanel extends JPanel implements MessageListener {

	private static final long serialVersionUID = 1L;
	private JTable table;
	private HistoryDataModel historyDataModel;
	private HistoryMessagePanel messagePanel;
	private JScrollPane jscroll;
	
	public HistoryDataPanel(HistoryMessagePanel messagePanel) {
		setLayout(new BorderLayout());

		HeadersValidator.addMessageListener(this);
		this.messagePanel = messagePanel;
		historyDataModel = new HistoryDataModel();
		
		table = createTable();
		table.setModel(historyDataModel);
		table.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
		table.setEnabled(true);
		int columns = historyDataModel.getColumnCount();
		for (int i =0 ; i <  columns ; i++) {
			int width = historyDataModel.getWidth(i);
			table.getColumnModel().getColumn(i).setMinWidth(0);
			table.getColumnModel().getColumn(i).setPreferredWidth(width);	
		}
		
		jscroll = new JScrollPane(table);
		jscroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
		this.add(new JPanel(),BorderLayout.NORTH);
		this.add(new JPanel(),BorderLayout.WEST);
		this.add(new JPanel(),BorderLayout.EAST);
		this.add(new JPanel(),BorderLayout.SOUTH);
		this.add(jscroll,BorderLayout.CENTER);
		addEvents();
	}
	
	private JTable createTable() {
		 JTable table = new JTable() {
			private static final long serialVersionUID = 358108449178930008L;
			public Component prepareRenderer(TableCellRenderer r, int row, int col) {
				Component c =  super.prepareRenderer(r, row, col);
				Boolean marked = (Boolean)getValueAt(row,6);
				if (marked && isCellSelected(row, col)) {
					c.setBackground(Color.LIGHT_GRAY);
				}
				else if (marked){
					c.setBackground(Color.WHITE);
				}
				else if (!marked && !isCellSelected(row, col)){
					c.setBackground(new Color(255,255,155));
				}
				return c;
			}
		
		};
		 table.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		 return table;
	}
	
	private void addEvents() {
		table.getSelectionModel().addListSelectionListener(
				new ListSelectionListener() {
					public void valueChanged(ListSelectionEvent e) {
						int rowIndex = table.getSelectedRow(); 
						if (rowIndex>=0) {
							if (rowIndex < table.getRowCount()) {							
								messagePanel.setData(getSelectedData(rowIndex));
							}
							if (((Boolean)table.getValueAt(rowIndex, 6))==false) {
								table.setValueAt(true,rowIndex,6);
								new MessageConfirmer(
										(String )table.getValueAt(rowIndex,1),
										(String )table.getValueAt(rowIndex,2));
							}
						}
					}
				});
	}
	
	public String[] getSelectedData(int row) {
		int rowIndex =  row; 
		String[] data = new String[5];
		for (int col =0 ; col < data.length ; col++) {
			data[col] = String.valueOf(table.getValueAt(rowIndex,col+1));
		}
		return data;
	}

	public JTable getTable() {
		return table;
	}
	
	
	public void setScroll() {
	 jscroll.getViewport().setViewPosition(new Point(0, jscroll.getViewport().getViewPosition().y + (table.getRowCount()*10)));
	}

	public void getANewMessage(MessageEvent event) {
		table.updateUI();
		table.clearSelection();
	}
	
}