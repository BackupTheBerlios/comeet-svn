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

import javax.swing.table.AbstractTableModel;

import com.kazak.comeet.client.control.Cache;

public class HistoryDataModel extends AbstractTableModel {

	private static final long serialVersionUID = -6111771046854883088L;
	
	private String[] titles = {
			"No","Fecha","Hora","Remitente","Asunto","Mensaje","Leído"
	};
	private Class[] types = {
			Integer.class,String.class,String.class,
			String.class,String.class,String.class,Boolean.class};
	
	private int[] width = {30,90,90,100,230,0,34};
	
	public String getColumnName(int index) {
		return titles[index];
	}
	
	public int getColumnCount() {
		return titles.length;
	}

	public int getRowCount() {
		return Cache.getMessages().size();
	}

	public Class<?> getColumnClass(int columnIndex) {
		return types[columnIndex];
	}
	
	public Object getValueAt(int rowIndex, int columnIndex) {
		return Cache.getMessages().get(rowIndex).getAt(columnIndex);
	}
	
	public void setValueAt(Object element,int rowIndex, int columnIndex) {
		Cache.getMessages().get(rowIndex).setAt(columnIndex, element);
	}
	
	public int getWidth(int i) {
		return width[i];
	}
	
	public boolean isCellEditable(int rowIndex, int columnIndex) {
		return false;
	}
}