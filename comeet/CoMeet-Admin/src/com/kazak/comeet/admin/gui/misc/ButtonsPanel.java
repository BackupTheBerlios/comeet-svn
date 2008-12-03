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

package com.kazak.comeet.admin.gui.misc;

import java.awt.FlowLayout;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JPanel;

public class ButtonsPanel extends JPanel{
	
	private static final long serialVersionUID = 8682203073690265957L;
	private JButton addButton; 
	private JButton editButton;
	private JButton deleteButton;
	
	public ButtonsPanel() {
		super(new FlowLayout(FlowLayout.CENTER));
		GUIFactory guiFactory = new GUIFactory();
		addButton    = guiFactory.createButton("Adicionar",'A',"add");
		editButton   = guiFactory.createButton("Editar",'S',"edit");
		deleteButton = guiFactory.createButton("Eliminar",'R',"delete");
		add(addButton);
		add(editButton);
		add(deleteButton);
	}
	
	public void setActioListener(ActionListener action) {
		addButton.addActionListener(action);
		editButton.addActionListener(action);
		deleteButton.addActionListener(action);
	}
}