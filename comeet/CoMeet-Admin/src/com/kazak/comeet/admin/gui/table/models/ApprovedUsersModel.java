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

package com.kazak.comeet.admin.gui.table.models;

import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import javax.swing.table.AbstractTableModel;

import org.jdom.Document;
import org.jdom.Element;


public class ApprovedUsersModel extends AbstractTableModel {
	
	private static final long serialVersionUID = 1L;
	private String[] titles = {"Login","Nombres","Punto de Venta","Tiempo de Respuesta"};
	private Class[] types = {String.class,String.class,String.class,Integer.class};
	private Vector<Vector> tableData = new Vector<Vector>();
		
	@SuppressWarnings("unchecked")
	public void addRow() {
		Vector<Object> vector = new Vector<Object>();
		vector.add("");
		vector.add("");
		vector.add("");
		vector.add(null);
		tableData.add(vector);
		fireTableDataChanged();
	}
	
	@SuppressWarnings("unchecked")
	public void addRow(String login, String names, String pos, Integer time) {
		Vector<Object> vector = new Vector<Object>();
		vector.add(login);
		vector.add(names);
		vector.add(pos);
		vector.add(time);
		tableData.add(vector);
		fireTableDataChanged();
	}
	
	@SuppressWarnings("unchecked")
	public void clear() {
		tableData.clear();
		fireTableDataChanged();
   	}
		
	public Vector<Vector> getData() {
		return tableData;
	}
	
	public void remove(int index) {
		tableData.remove(index);
		fireTableDataChanged();
	}
	
	public String getColumnName(int index) {
		return titles[index];
	}
	
	public int getColumnCount() {
		return titles.length;
	}
	
	public int getRowCount() {
		return tableData.size();
	}

	public Object getValueAt(int rowIndex, int columnIndex) {
		return tableData.get(rowIndex).get(columnIndex);
	}
	
	public Class<?> getColumnClass(int columnIndex) {
		return types[columnIndex];
	}
	
	@SuppressWarnings("unchecked")
	public void setValueAt(Object element,int rowIndex, int columnIndex) {
		tableData.get(rowIndex).set(columnIndex,element);
	}

	public boolean isCellEditable(int rowIndex, int columnIndex) {
		return false;
	}
	
	public void updateTable(int index, boolean asc) {
        Collections.sort(tableData, new ColumnSorter(index,asc)); // TODO: Eliminar este warning
        fireTableStructureChanged();
	}
			
	// This method fills the table of users online
    public synchronized void setQuery(Document doc) {

    	class LoadData extends Thread {
    		private Document doc;

    		LoadData(Document doc) {
    			this.doc=doc;
    		}

    		public void run() {
    			// Cleaning the table
    			clear();
    			List messagesList = doc.getRootElement().getChildren("row");
    			Iterator messageIterator = messagesList.iterator();
    			// Loading new info 
    			for (;messageIterator.hasNext();) {  
    				Element oneMessage = (Element) messageIterator.next();
    				List messagesDetails = oneMessage.getChildren();
    				Vector<Object> tableRow = new Vector<Object>();
    				for (int k=0;k<4;k++) {
    					String data = ((Element)messagesDetails.get(k)).getText();
    					if (k==3) {
    						Integer integer = new Integer(data);
    						tableRow.add(integer);
    					} else {
       						tableRow.add(data);
    					}
       				}
    				// Adding a new row into the table 
    				tableData.add(tableRow);
    			}
    			fireTableDataChanged();
    			/* if(messagesList.size() > 0) {
    				updateTable(0, true);
    			}*/
    			doc = null;
    			System.gc();
    		}
    	}
    	new LoadData(doc).start();
    }
}