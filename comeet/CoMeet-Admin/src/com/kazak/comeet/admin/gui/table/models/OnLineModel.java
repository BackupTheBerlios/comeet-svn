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
import javax.swing.JLabel;

import org.jdom.Document;
import org.jdom.Element;


public class OnLineModel extends AbstractTableModel {
	
	private static final long serialVersionUID = 1L;
	private String[] titles = {"Usuario","Nombre","Punto de Venta","Dirección IP","Inicio Conexión"};
	private Class[] types = {String.class,String.class,String.class,String.class,String.class};
	private Vector<Vector> tableData = new Vector<Vector>();
	private int size;
	private JLabel groupSize;
	private int tab = 0;
	
	public void setLabel(JLabel gSize) {
		groupSize = gSize;
	}
	
	public void setTab(int tab){
		this.tab = tab;
	}
	
	@SuppressWarnings("unchecked")
	public void addRow() {
		Vector v = new Vector();
		v.add("");
		v.add("");
		v.add("");
		v.add("");
		v.add("");
		tableData.add(v);
		fireTableDataChanged();
	}
	
	@SuppressWarnings("unchecked")
	public void addRow(String code,String name,String pos,String ip,String time) {
		Vector v = new Vector();
		v.add(code);
		v.add(name);
		v.add(pos);
		v.add(ip);
		v.add(time);
		tableData.add(v);
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
        Collections.sort(tableData, new ColumnSorter(index,asc)); // TODO: Avoid this warning
        fireTableStructureChanged();
	}

	public int getResultSize() {
		return size;
	}
	
	// This method fills the table of users online
    public synchronized void setQuery(Document doc) {

    	class LoadData extends Thread {
    		private Document doc;

    		LoadData(Document doc) {
    			this.doc=doc;
    		}

    		public void run() {
    			List usersList = doc.getRootElement().getChildren("row");
    			Iterator userData = usersList.iterator();
    			int max = usersList.size();
    			if (max>0) {
    				// Cleaning the table
    				clear();
    				// Loading new info 
    				int i=0;
    				for (;userData.hasNext();i++) {
    					Element oneUser = (Element) userData.next();
    					List userDetails = oneUser.getChildren();
    					Vector<String> tableRow = new Vector<String>();
    					for (int k=0;k<5;k++) {
    						tableRow.add(((Element)userDetails.get(k)).getText());
    					}
    					// Adding a new row into the table 
    					tableData.add(tableRow);
    				}
    				fireTableDataChanged();

    				if (tab == 1) {
    					size = i;
    					String s = "s";
    					if (i==1) {
    						s = "";
    					}
    					groupSize.setText("( " + size + " usuario" + s + " )");
    				}
    			}
    			else {
    				clear();
    				if (tab == 1) {
    					groupSize.setText("");
    				}
    			}

    			updateTable(0, true);
    			doc = null;
    			System.gc();
    		}
    	}
    	new LoadData(doc).start();
    }
}
