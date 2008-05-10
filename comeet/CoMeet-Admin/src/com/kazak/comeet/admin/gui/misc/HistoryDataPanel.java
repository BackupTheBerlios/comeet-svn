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

package com.kazak.comeet.admin.gui.misc;

import java.awt.BorderLayout;
import java.util.Vector;

import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.ListSelectionModel;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;

import com.kazak.comeet.admin.gui.table.models.HistoryDataModel;
import com.kazak.comeet.admin.gui.table.models.TableSorter;

public class HistoryDataPanel extends JPanel {

	private static final long serialVersionUID = 1L;
	private JTable table;
	private HistoryDataModel historyDataModel;
	private HistoryMessagePanel messagePanel;
	
	public HistoryDataPanel(HistoryMessagePanel messagePanel, Vector<Vector<Object>> data) {
		setLayout(new BorderLayout());
		this.messagePanel = messagePanel;
		historyDataModel = new HistoryDataModel(data);
		TableSorter tableSorter =new TableSorter(historyDataModel);
		table = createTable();
		table.setModel(tableSorter);
		table.setSurrendersFocusOnKeystroke(true);
		tableSorter.setTableHeader(table.getTableHeader());
		table.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
		table.setEnabled(true);
		int columns = historyDataModel.getColumnCount();
		for (int i =0 ; i <  columns ; i++) {
			int width = historyDataModel.getWidth(i);
			table.getColumnModel().getColumn(i).setMinWidth(0);
			table.getColumnModel().getColumn(i).setPreferredWidth(width);	
		}
		
		JScrollPane jscroll = new JScrollPane(table);
		jscroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);
		this.add(new JPanel(),BorderLayout.NORTH);
		this.add(new JPanel(),BorderLayout.WEST);
		this.add(new JPanel(),BorderLayout.EAST);
		this.add(new JPanel(),BorderLayout.SOUTH);
		this.add(jscroll,BorderLayout.CENTER);
		addEvents();
	}
	
	private JTable createTable() {
		 JTable table = new JTable();
		 table.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		
		 return table;
	}
	
	private void addEvents() {
		table.getSelectionModel().addListSelectionListener(
				new ListSelectionListener() {
					public void valueChanged(ListSelectionEvent e) {
						int rowIndex = table.getSelectedRow();
						if (rowIndex < table.getRowCount()) {
							messagePanel.setData(getSelectedData());
						}
					}
				});
	}
	
	public String[] getSelectedData() {
		int rowIndex = table.getSelectedRow();
		String[] array = new String[7];
		for (int i =0 ; i < array.length ; i++) {
			array[i] = String.valueOf(table.getValueAt(rowIndex,(i+1)));
		}
		
		return array;
	}

	public JTable getTable() {
		return table;
	}
	
	public int getMessagesTotal() {
		return table.getRowCount();
	}
}