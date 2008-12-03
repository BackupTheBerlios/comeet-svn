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

package com.kazak.comeet.client.gui;

import java.awt.Color;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.net.URL;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JToolTip;
import javax.swing.ToolTipManager;
import javax.swing.border.LineBorder;

import com.kazak.comeet.lib.misc.ClientConstants;

public class TrayManager implements ActionListener {

	private JFrame window;
	private static boolean logged = false;
	private JPanel menu;
	private static JButton sendButton;
	private static JButton viewButton;
	private static JButton changePasswdButton;
	private static JButton exit;
	
	public TrayManager() {
		window = new JFrame("Mensajería Interna");
		window.setSize(195,40);
		window.setUndecorated(true);
		window.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
		window.setResizable(false);
		window.setLocation(0,0);
		window.setAlwaysOnTop(true);
		window.addWindowListener(new WindowAdapter() {
			public void windowIconified(WindowEvent e) {
				window.setState(JFrame.NORMAL);
			}
			public void windowClosing(WindowEvent e) {
				window.setVisible(true);
			}
		});
		ToolTipManager.sharedInstance().setInitialDelay(0);
		
		menu = new JPanel(new GridLayout(1,3));
		menu.setBorder(new LineBorder(new Color(180,180,180),3));
		URL url = getClass().getResource(ClientConstants.iconsPath + "new_message.png");
		ImageIcon icon = new ImageIcon(url);

		sendButton = new JButton(icon);
		sendButton.addMouseMotionListener(new MouseMotionAdapter() {
			public void mouseMoved(MouseEvent e) {
				super.mouseMoved(e);
				window.requestFocus();
				if (!LoginWindow.isLogged()) {
					LoginWindow.getFrame().toBack();
					LoginWindow.getFrame().toFront();
				}
			}
		});
		sendButton.setToolTipText("<html><h3>Enviar Nuevo Mensaje</h3></html>");
		sendButton.setActionCommand("new");
		sendButton.addActionListener(this);
		sendButton.setEnabled(false);
		sendButton.setBorder(new LineBorder(new Color(150,150,150),1));

		menu.add(sendButton);
		
		url = getClass().getResource(ClientConstants.iconsPath + "view_message.png");
		icon = new ImageIcon(url);
		viewButton = new JButton(icon);
		viewButton.addMouseMotionListener(new MouseMotionAdapter() {
			public void mouseMoved(MouseEvent e) {
				super.mouseMoved(e);
				window.requestFocus();
				if (!LoginWindow.isLogged()) {
					LoginWindow.getFrame().toBack();
					LoginWindow.getFrame().toFront();
				}
			}
		});
		viewButton.setToolTipText("<html><h3>Ver Mensajes Recibidos</h3></html>");
		viewButton.addActionListener(this);
		viewButton.setActionCommand("view");
		viewButton.setEnabled(false);
		viewButton.setBorder(new LineBorder(new Color(150,150,150),1));
		menu.add(viewButton);
		
		url = getClass().getResource(ClientConstants.iconsPath + "password.png");
		icon = new ImageIcon(url);
		changePasswdButton = new JButton(icon);
		changePasswdButton.addMouseMotionListener(new MouseMotionAdapter() {
			public void mouseMoved(MouseEvent e) {
				super.mouseMoved(e);
				window.requestFocus();
				if (!LoginWindow.isLogged()) {
					LoginWindow.getFrame().toBack();
					LoginWindow.getFrame().toFront();
				}
			}
		});
		changePasswdButton.setToolTipText("<html><h3>Cambiar Clave de Mensajería<h3></html>");
		changePasswdButton.addActionListener(this);
		changePasswdButton.setActionCommand("change_password");
		changePasswdButton.setEnabled(false);
		changePasswdButton.setBorder(new LineBorder(new Color(150,150,150),1));
		menu.add(changePasswdButton);
		
		JToolTip toolTip = new JToolTip();
		toolTip.setFont(new Font("Sans",Font.BOLD,20));
		toolTip.setComponent(sendButton);

		url = getClass().getResource(ClientConstants.iconsPath + "close.png");
		icon = new ImageIcon(url);
		exit = new JButton(icon);
		exit.setToolTipText("<html><h3>Salir<h3></html>");
		exit.addActionListener(this);
		exit.setActionCommand("exit");
		exit.setEnabled(false);
		exit.setBorder(new LineBorder(new Color(150,150,150),1));
		if (!ClientConstants.LOTTERY_MODE) {
			menu.add(exit);
		}
		
		window.add(menu);	
		window.setVisible(true);
	}
	
	public void actionPerformed(ActionEvent e) {
		String command = e.getActionCommand();
		if ("new".equals(command)) {
			if (logged) {
				sendButton.setEnabled(false);
				new MessageWindow();
				sendButton.setEnabled(true);
			}
		}
		else if ("view".equals(command)) {
			viewButton.setEnabled(false);
			MessageViewer.show();
			viewButton.setEnabled(true);
		}
		else if ("change_password".equals(command)) {
			changePasswdButton.setEnabled(false);
			PasswordExchanger.show();
			changePasswdButton.setEnabled(true);
		} else if ("exit".equals(command)) {
			int option = JOptionPane.showConfirmDialog(
					new JFrame(),
					"Desea cerrar la aplicacion?",
					"CoMeet",
					JOptionPane.YES_NO_OPTION);
			if (option == JOptionPane.YES_OPTION) {
				System.exit(0);
			}
		}
	}

	public static boolean isLogged() {
		return logged;
	}

	public static void setLogged(boolean logged) {
		TrayManager.logged = logged;
		sendButton.setEnabled(logged);
		viewButton.setEnabled(logged);
		changePasswdButton.setEnabled(logged);
		exit.setEnabled(logged);
	}
}