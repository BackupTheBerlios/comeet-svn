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

import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.table.JTableHeader;

public class NoAnswerUsersHeaderListener extends MouseAdapter {
	
    JTableHeader   header;
    NoAnswerUsersModel    model;
    SortButtonRenderer renderer;
    
    public NoAnswerUsersHeaderListener(JTableHeader header, NoAnswerUsersModel model, SortButtonRenderer renderer) {
      this.header   = header;
      this.model    = model;
      this.renderer = renderer;
    }
      
    public void mousePressed(MouseEvent e) {
      int index = header.columnAtPoint(e.getPoint());
      boolean isAscent;
      renderer.setPressedColumn(index);
      renderer.setSelectedColumn(index);
      header.repaint();
      if (SortButtonRenderer.DOWN == renderer.getState(index)) {
        isAscent = false;
      } else {
        isAscent = true;
      }
      model.updateTable(index, isAscent);	      	
    }

    public void mouseReleased(MouseEvent e) {
        renderer.setPressedColumn(-1); // clear
        header.repaint();    	
    }
        
    public void initHeader() {
        renderer.setPressedColumn(0);
        renderer.setColumnForUpdate();
        header.repaint();
        model.updateTable(0, true);	      	
    }
}