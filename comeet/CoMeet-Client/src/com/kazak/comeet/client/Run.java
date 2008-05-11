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

package com.kazak.comeet.client;

import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

import com.kazak.comeet.client.control.Cache;
import com.kazak.comeet.client.gui.LoginWindow;
import com.kazak.comeet.client.gui.TrayManager;
import com.kazak.comeet.lib.misc.ClientConfigFile;
import com.nilo.plaf.nimrod.NimRODLookAndFeel;

public class Run {
	public static boolean newConfigFile;
	public static String user;
	
	public Run() {
			ClientConfigFile.loadSettings();
			Run.instanceGUI();
	}

	public static void instanceGUI() {
		new Cache();
		new TrayManager();
		LoginWindow.show();
	}
	
	public static void main(String[] args) {
		try {
			UIManager.setLookAndFeel(new NimRODLookAndFeel());
			new Run();
		}catch (UnsupportedLookAndFeelException e) {
			e.printStackTrace();
		}
	}
}
