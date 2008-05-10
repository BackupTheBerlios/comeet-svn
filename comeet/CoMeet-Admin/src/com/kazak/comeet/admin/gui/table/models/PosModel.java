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

import com.kazak.comeet.admin.control.Cache.WorkStation;

public class PosModel extends AbstractTableModel {
	private static final long serialVersionUID = 1L;
	private String[] titles = {"CODIGO","NOMBRE DEL PUNTO","IP"};
	private Class[] types   = {String.class,String.class,String.class};
	private Vector<WorkStation> wsVector;
	
	public PosModel(Vector<WorkStation> wsVector) {
		this.wsVector = wsVector;
	}
	
	public String getColumnName(int index) {
		return titles[index];
	}
	
	public int getColumnCount() {
		return titles.length;
	}

	public int getRowCount() {
		return wsVector.size();
	}

	public Class<?> getColumnClass(int columnIndex) {
		return types[columnIndex];
	}
	
	public Object getValueAt(int rowIndex, int columnIndex) {
		WorkStation ws = wsVector.get(rowIndex);
		switch (columnIndex) {
		case 0:
			return ws.getCode();
		case 1:
			return ws.getName();
		case 2:
			return ws.getIp();
		}
		return null;
	}
	
	public boolean isCellEditable(int rowIndex, int columnIndex) {
		return false;
	}
}