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

public class HistoryDataModel extends AbstractTableModel {

	private static final long serialVersionUID = -6111771046854883088L;
	
	private String[] titles = {
			"No","Fecha","Hora","Remitente","Destinatario","Asunto","Mensaje","Leído"
	};
	
	private Class[] types = {
			Integer.class,String.class,String.class,String.class,
			String.class,String.class,String.class,Boolean.class};
	
	private int[] width = {40,80,60,80,80,194,0,40};
	private Vector<Vector<Object>> dataVector;
	
	public HistoryDataModel(Vector<Vector<Object>> data) {
		this.dataVector = data;
	}
	
	public String getColumnName(int index) {
		return titles[index];
	}
	
	public int getColumnCount() {
		return titles.length;
	}

	public int getRowCount() {
		return dataVector.size();
	}

	public Class<?> getColumnClass(int columnIndex) {
		return types[columnIndex];
	}
	
	public Object getValueAt(int rowIndex, int columnIndex) {
		Object value = dataVector.get(rowIndex).get(columnIndex);
		if (columnIndex==7) {
			return Boolean.parseBoolean(value.toString());
		}
		return value;
	}
	
	public int getWidth(int i) {
		return width[i];
	}
	
	public boolean isCellEditable(int rowIndex, int columnIndex) {
		return false;
	}
}