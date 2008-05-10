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

import java.awt.Color;

import javax.swing.JTable;
import javax.swing.table.JTableHeader;
import javax.swing.table.TableColumnModel;

import org.jdom.Document;

import com.kazak.comeet.admin.gui.table.models.CellEditor;
import com.kazak.comeet.admin.gui.table.models.ControlHeaderListener;
import com.kazak.comeet.admin.gui.table.models.ControlModel;
import com.kazak.comeet.admin.gui.table.models.SortButtonRenderer;

public class ControlTable extends JTable { 

	private static final long serialVersionUID = 1L;
	private static ControlModel model;
	private SortButtonRenderer renderer;
	private JTableHeader header = new JTableHeader();
	private ControlHeaderListener listener;
	
	public ControlTable(Document doc) {
		model = new ControlModel();
		this.setModel(model);
		this.setGridColor(Color.BLACK);
		this.setDefaultEditor(String.class,new CellEditor());
		this.setSurrendersFocusOnKeystroke(true);
		this.setAutoCreateColumnsFromModel(false);
		
		model.setQuery(doc);
		renderer = new SortButtonRenderer();
	    TableColumnModel columnModel = this.getColumnModel();
	    int n = model.getColumnCount(); 
		int columnWidth[] = {80,60,150,90,200};
	    for (int i=0;i<n;i++) {
	      columnModel.getColumn(i).setHeaderRenderer(renderer);
	      columnModel.getColumn(i).setPreferredWidth(columnWidth[i]);
	    }
	    
	    header = this.getTableHeader();
	    listener = new ControlHeaderListener(header,model,renderer);
		header.addMouseListener(listener);
	}
			
	public ControlModel getModel() {
		return model;
	}
	
	public int getRowCount() {
		return model.getRowCount();
	}

}
