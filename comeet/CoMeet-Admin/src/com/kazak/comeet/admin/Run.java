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

package com.kazak.comeet.admin;

import java.text.ParseException;

import javax.swing.JOptionPane;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

import com.kazak.comeet.admin.gui.main.LoginWindow;
import com.kazak.comeet.admin.gui.main.MainWindow;

import de.javasoft.plaf.synthetica.SyntheticaBlueIceLookAndFeel;

public class Run {
	
	public static String login = "";
	
	public static void main(String[] args) {
		try {
			String envMode = System.getenv("METAL");
			if (envMode==null) {
				UIManager.setLookAndFeel(new SyntheticaBlueIceLookAndFeel());
			}
		} catch (UnsupportedLookAndFeelException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		new LoginWindow();
	}
	
	public static void exit() {
		int option = JOptionPane.showConfirmDialog(
				MainWindow.getFrame(),
				"Realmente desea Salir?",
				"Salir",
				JOptionPane.YES_NO_OPTION);
		
		if (option==JOptionPane.YES_OPTION) {
			System.exit(0);			
		}
	}
}
