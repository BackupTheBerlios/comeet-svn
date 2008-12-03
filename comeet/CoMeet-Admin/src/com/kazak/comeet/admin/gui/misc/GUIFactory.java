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
import java.awt.Color;
import java.net.URL;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JTextField;

public class GUIFactory {
	
	public JButton createButton(
			String name, char mnemonic,	String command,	String icon , int alignment) {
		
		URL url = this.getClass().getResource("/icons/"+icon);
		JButton button = createButton(name, mnemonic, command);
		if (url!=null) {
			ImageIcon imageIcon = new ImageIcon(url);
			button.setIcon(imageIcon);
		}
		button.setHorizontalTextPosition(alignment);
		
		return button;
	}
	
	public JButton createButton(String icon) {
		URL url = this.getClass().getResource("/icons/"+icon);
		ImageIcon imageIcon = new ImageIcon(url);
		JButton button = new JButton(imageIcon);

		return button;
	}
	
	public JButton createButton(String name,char mnemonic, String command) {
		JButton button = new JButton(name);
		button.setActionCommand(command);
		button.setMnemonic(mnemonic);

		return button;
	}

	public JTextField createTextField(int columns) {
		JTextField textField = new JTextField(columns);
		Color color = Color.BLACK;
		textField.setEnabled(false);		
		textField.setDisabledTextColor(color);

		return textField;
	}
	
	public JTextField createTextField(int columns,boolean enabled) {
		JTextField textField = new JTextField(columns);
		Color color = Color.BLACK;
		textField.setEnabled(enabled);		
		textField.setDisabledTextColor(color);

		return textField;
	}
}
