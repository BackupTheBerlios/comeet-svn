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
import java.util.List;

import javax.swing.JTable;
import javax.swing.table.JTableHeader;
import javax.swing.table.TableColumnModel;

import org.jdom.Document;

import com.kazak.comeet.admin.gui.table.models.MessagesHeaderListener;
import com.kazak.comeet.admin.gui.table.models.MessagesModel;
import com.kazak.comeet.admin.gui.table.models.SortButtonRenderer;
import com.kazak.comeet.admin.transactions.QuerySender;
import com.kazak.comeet.admin.transactions.QuerySenderException;

public class MessagesTable extends JTable { 

	private static final long serialVersionUID = 1L;
	private static MessagesModel model;
	private SortButtonRenderer renderer;
	private JTableHeader header = new JTableHeader();
	private MessagesHeaderListener listener;
	
	public MessagesTable(Document doc) {
		model = new MessagesModel();
		this.setModel(model);
		this.getModel().setQuery(doc);
		this.setGridColor(Color.BLACK);
		this.setSurrendersFocusOnKeystroke(true);
		this.setAutoCreateColumnsFromModel(false);
		
		renderer = new SortButtonRenderer();
	    TableColumnModel columnModel = this.getColumnModel();
	    int n = model.getColumnCount(); 
		int columnWidth[] = {80,70,150,200,70};
	    for (int i=0;i<n;i++) {
	      columnModel.getColumn(i).setHeaderRenderer(renderer);
	      columnModel.getColumn(i).setPreferredWidth(columnWidth[i]);
	    }
	    
	    header = this.getTableHeader();
	    listener = new MessagesHeaderListener(header,model,renderer);
		header.addMouseListener(listener);
		
		//getMessages(login);
	}
		
	/*
	// This method gets the inbox mail titles from a user
	public static void getMessages(final String user) {
		Thread t = new Thread() {
			public void run() {
				try {
					String[] args = {user};
					Document doc = QuerySender.getResultSetFromST("SEL0011",args);
					if (!queryIsEmpty(doc)) {
						model.setQuery(doc);
					}
				} catch (QuerySenderException e) {
					System.out.println("ERROR: No se pudieron consultar los mensajes del usuario: " + user);
					e.printStackTrace();
				}
			}
		};
		t.start();
	} */
	
	public MessagesModel getModel() {
		return model;
	}
	
	/*
	private static boolean queryIsEmpty(Document doc) {
        List messagesList = doc.getRootElement().getChildren("row");
        if (messagesList.size() == 0) {
        	return true;
        }
        return false;
	}*/
	
	public int getRowCount() {
		return model.getRowCount();
	}
}
