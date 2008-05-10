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

import java.awt.BorderLayout;
import java.awt.Color;

import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

public class MessageArea extends JPanel {

	private static final long serialVersionUID = -4602441410611695614L;
	private JTextArea textArea;
	
	public MessageArea(boolean enabled) {
		super(new BorderLayout());
		textArea = new JTextArea();
		textArea.setLineWrap(true);
		textArea.setWrapStyleWord(true);
		textArea.setEnabled(enabled);
		textArea.setDisabledTextColor(Color.BLACK);
		
		JScrollPane jscroll = new JScrollPane(textArea);
		this.add(jscroll,	  BorderLayout.CENTER);
		this.add(new JPanel(),BorderLayout.NORTH);
		this.add(new JPanel(),BorderLayout.WEST);
		this.add(new JPanel(),BorderLayout.EAST);
		this.add(new JPanel(),BorderLayout.SOUTH);
		this.setVisible(true);
	}
	
	public void requestFocus() {
		textArea.requestFocus();
	}
	
	public String getText() {
		return textArea.getText();
	}
	
	public void setText(String text) {
		textArea.setText(text);
	}
}
