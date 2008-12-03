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

import com.kazak.comeet.admin.gui.table.models.LateUsersHeaderListener;
import com.kazak.comeet.admin.gui.table.models.LateUsersModel;
import com.kazak.comeet.admin.gui.table.models.SortButtonRenderer;

public class LateUsersTable extends JTable { 

	private static final long serialVersionUID = 1L;
	private static LateUsersModel model;
	private SortButtonRenderer renderer;
	private JTableHeader header = new JTableHeader();
	private LateUsersHeaderListener listener;
	
	public LateUsersTable(Document doc) {
		model = new LateUsersModel();
		model.setQuery(doc);
		this.setModel(model);
		
		this.setGridColor(Color.BLACK);
		this.setSurrendersFocusOnKeystroke(true);
		this.setAutoCreateColumnsFromModel(false);
				
		renderer = new SortButtonRenderer();
	    TableColumnModel columnModel = this.getColumnModel();
	    int n = model.getColumnCount(); 
		int columnWidth[] = {70,200,150,150};
	    for (int i=0;i<n;i++) {
	      columnModel.getColumn(i).setHeaderRenderer(renderer);
	      columnModel.getColumn(i).setPreferredWidth(columnWidth[i]);
	    }
	    
	    header = this.getTableHeader();
	    listener = new LateUsersHeaderListener(header,model,renderer);
		header.addMouseListener(listener);
	}
			
	public LateUsersModel getModel() {
		return model;
	}
	
	public int getRowCount() {
		return model.getRowCount();
	}
}