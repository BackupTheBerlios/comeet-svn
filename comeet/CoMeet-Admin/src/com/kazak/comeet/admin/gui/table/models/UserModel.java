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

import java.util.Vector;

import javax.swing.table.AbstractTableModel;

public class UserModel extends AbstractTableModel {

	private static final long serialVersionUID = 1L;
	private String[] titles = { "Código Punto","Nombre"};
	private Class[] types = {String.class,String.class};
	private Vector<Vector> data = new Vector<Vector>();
	
	@SuppressWarnings("unchecked")
	public void addRow() {
		Vector v = new Vector();
		v.add("");
		v.add("");
		data.add(v);
		fireTableDataChanged();
	}
	
	@SuppressWarnings("unchecked")
	public void addRow(String code,String name) {
		Vector v = new Vector();
		v.add(code);
		v.add(name);
		data.add(v);
		fireTableDataChanged();
	}
	
	@SuppressWarnings("unchecked")
	public void clear() {
		data.clear();
		fireTableDataChanged();
	}
	
	public Vector<Vector> getData() {
		return data;
	}
	public void remove(int index) {
		data.remove(index);
		fireTableDataChanged();
	}
	
	public String getColumnName(int index) {
		return titles[index];
	}
	
	public int getColumnCount() {
		return titles.length;
	}
	
	public int getRowCount() {
		return data.size();
	}
	
	public boolean isAlreadyIn(String code) {
		for(int i=0;i<data.size();i++){
			Vector<Object> records = (Vector<Object>)data.get(i);
			String posCode = (String) records.get(0);
			if(posCode.equals(code)) {
				return true;
			}
		}
		return false;
	}

	public Object getValueAt(int rowIndex, int columnIndex) {
		return data.get(rowIndex).get(columnIndex);
	}
	
	public Class<?> getColumnClass(int columnIndex) {
		return types[columnIndex];
	}
	
	@SuppressWarnings("unchecked")
	public void setValueAt(Object element,int rowIndex, int columnIndex) {
		data.get(rowIndex).set(columnIndex,element);
	}

	public boolean isCellEditable(int rowIndex, int columnIndex) {
		//if (columnIndex==2) {
			//return true;
		//}
		return false;
	}
}
