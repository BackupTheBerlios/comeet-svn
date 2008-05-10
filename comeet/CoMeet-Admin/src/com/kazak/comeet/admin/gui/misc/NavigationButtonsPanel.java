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
import javax.swing.SwingConstants;

public class NavigationButtonsPanel extends JPanel{
	
	private static final long serialVersionUID = 8682203073690265957L;
	private JButton nextButton; 
	private JButton previousButton;
	private JButton closeButton;
	private JButton saveButton;
	
	public NavigationButtonsPanel() {
		super(new FlowLayout(FlowLayout.RIGHT));
		GUIFactory guiFactory = new GUIFactory();
		previousButton = guiFactory.createButton("Ver Anterior", 'A',"previous","previous.png",SwingConstants.RIGHT);
		nextButton     = guiFactory.createButton("Ver Siguiente",'S',"next","next.png",SwingConstants.LEFT);
		closeButton    = guiFactory.createButton("Cerrar",'C',"close","close.png",SwingConstants.LEFT);
		saveButton     = guiFactory.createButton("Guardar",'G',"save","save.png",SwingConstants.LEFT);
		add(previousButton);
		add(nextButton);
		add(saveButton);
		add(closeButton);
	}
	
	public void setActioListener(ActionListener action) {
		previousButton.addActionListener(action);
		nextButton.addActionListener(action);
		closeButton.addActionListener(action);
		saveButton.addActionListener(action);
	}
}