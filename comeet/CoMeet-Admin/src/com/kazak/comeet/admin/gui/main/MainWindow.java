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

package com.kazak.comeet.admin.gui.main;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Toolkit;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.util.Collection;
import java.util.Vector;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JSplitPane;
import javax.swing.UIManager;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableColumnModel;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.TreePath;

import com.kazak.comeet.admin.Run;
import com.kazak.comeet.admin.control.Cache;
import com.kazak.comeet.admin.control.LogServerViewer;
import com.kazak.comeet.admin.control.Cache.Group;
import com.kazak.comeet.admin.control.Cache.User;
import com.kazak.comeet.admin.control.Cache.WorkStation;
import com.kazak.comeet.admin.gui.main.MainTreeManager.SortableTreeNode;
import com.kazak.comeet.admin.gui.table.models.PosModel;
import com.kazak.comeet.admin.gui.table.models.TableSorter;
import com.kazak.comeet.admin.gui.table.models.UsersModel;
import com.kazak.comeet.admin.gui.table.DataGrid;

public class MainWindow implements TreeSelectionListener {
	
	private static JFrame frame;
	private JSplitPane splitPane;
	private static DataGrid dataGrid;
	private JPanel rightPanel;
	private MainTreeManager mainTree;
	private static String appOwner;
    private static int MAX_WIN_SIZE_HEIGHT = (int) Toolkit.getDefaultToolkit().getScreenSize().getHeight();
    private static int MAX_WIN_SIZE_WIDTH = (int) Toolkit.getDefaultToolkit().getScreenSize().getWidth();

	public MainWindow(String appOwner,String userLevel) {
		MainWindow.appOwner = appOwner;
		frame = new JFrame("Administración CoMeet - " + appOwner + " - [Usuario: " + Run.login + "]");
		frame.setSize(800,600);
		frame.setJMenuBar(new MenuBar(userLevel));
		frame.setLayout(new BorderLayout());
		frame.setLocation(
                (MAX_WIN_SIZE_WIDTH / 2) - frame.getWidth() / 2,
                (MAX_WIN_SIZE_HEIGHT / 2) - frame.getHeight() / 2);
		frame.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
		frame.addWindowListener(new WindowAdapter() {
			@Override
			public void windowClosing(WindowEvent e) {
				Run.exit();
			}
		});
		
		Cache.setFrame(frame);

		if (userLevel.equals("1")) {
			splitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT);
			splitPane.setDividerLocation(250);
			
			mainTree = new MainTreeManager(frame);
			mainTree.addTreeSelectionListener(this);
			splitPane.setLeftComponent(mainTree.getContentPane());
			
			rightPanel = new JPanel(new BorderLayout());
			dataGrid = new DataGrid();
			rightPanel.add(dataGrid.getScrollPane(),BorderLayout.CENTER);

			splitPane.setRightComponent(rightPanel);
			frame.add(splitPane,BorderLayout.CENTER);	
		} else if (userLevel.equals("2")) {
			Cache.loadInfoTree(0);
			LogServerViewer.loadGUI();
			frame.add(LogServerViewer.getPanel(),BorderLayout.CENTER);
		}
		
		UIManager.put("ComboBox.disabledForeground",Color.BLACK);
		frame.setVisible(true);
	}
	
	public static JFrame getFrame() {
		return frame;
	}
	
	public void valueChanged(TreeSelectionEvent e) {		
		updateGrid(e.getPath());
	}
	
	public static void updateGrid(TreePath treePath) {		
		MainTreeManager.currentTreePath = treePath;		
		DefaultMutableTreeNode node;
		TableSorter tableSorter;
		boolean affect = false;

		switch (treePath.getPathCount()) {
		case 2:
			// Seleccionando grupo
			node = (SortableTreeNode) treePath.getPathComponent(1);
			Group group = Cache.getGroup(node.toString());			
			if(group != null) {				
				Collection<WorkStation> wsCollection = group.getWorkStations();
				Vector<WorkStation> wsVector = new Vector<WorkStation>(wsCollection);
				if (wsVector.size() > 0 ) {
					tableSorter = new TableSorter(new PosModel(wsVector));
					tableSorter.setSortingStatus(1,TableSorter.ASCENDING);
					dataGrid.setModel(tableSorter);
					tableSorter.setTableHeader(dataGrid.getTableHeader());
					TableColumnModel columnModel = dataGrid.getColumnModel();
					int n = tableSorter.getColumnCount(); 
					int columnWidth[] = {50,300,100};
					for (int i=0;i<n;i++) {
						columnModel.getColumn(i).setPreferredWidth(columnWidth[i]);
					}
					affect = true;
				}
				Collection<User> collectionus = group.getUsers();
				Vector<User> users = new Vector<User>(collectionus);
				if (users.size() > 0 ) {
					tableSorter = new TableSorter(new UsersModel(users));
					tableSorter.setSortingStatus(1,TableSorter.ASCENDING);
					dataGrid.setModel(tableSorter);
					tableSorter.setTableHeader(dataGrid.getTableHeader());
					TableColumnModel columnModel = dataGrid.getColumnModel();
					int n = tableSorter.getColumnCount(); 
					int columnWidth[] = {80,80,200,200,120};
					for (int i=0;i<n;i++) {
						columnModel.getColumn(i).setPreferredWidth(columnWidth[i]);
					}
					affect = true;
				}
			}
			break;
		case 3:
			// Seleccionando punto de venta
			node = (SortableTreeNode) treePath.getPathComponent(2);
			String name = node.toString();
			if (Cache.containsWs(name)){
				WorkStation ws = Cache.getWorkStation(name);
				Collection<User> collection = ws.getUsers();
				Vector<User> usersVector = new Vector<User>(collection);
				if (usersVector.size() > 0 ) {
					tableSorter = new TableSorter(new UsersModel(usersVector));
					tableSorter.setSortingStatus(1,TableSorter.ASCENDING);
					dataGrid.setModel(tableSorter);
					tableSorter.setTableHeader(dataGrid.getTableHeader());
					TableColumnModel columnModel = dataGrid.getColumnModel();
					int n = tableSorter.getColumnCount(); 
					int columnWidth[] = {80,80,200,200,120};
					for (int i=0;i<n;i++) {
						columnModel.getColumn(i).setPreferredWidth(columnWidth[i]);
					}
					affect = true;
				}
			}

			if (Cache.containsUser(name)){
				User user = Cache.getUser(name);
				if (user != null) {
					Vector<User> usersVector = new Vector<User>();
					usersVector.add(user);
					tableSorter = new TableSorter(new UsersModel(usersVector));
					tableSorter.setSortingStatus(1,TableSorter.ASCENDING);
					dataGrid.setModel(tableSorter);
					tableSorter.setTableHeader(dataGrid.getTableHeader());
					TableColumnModel columnModel = dataGrid.getColumnModel();
					int n = tableSorter.getColumnCount(); 
					int columnWidth[] = {80,80,200,200,120};
					for (int i=0;i<n;i++) {
						columnModel.getColumn(i).setPreferredWidth(columnWidth[i]);
					}
					affect = true;
				}
			}
			break;
		case 4:
			// Seleccionando usuario
			node = (SortableTreeNode) treePath.getPathComponent(3);
			String login = node.toString();
			User user = Cache.getUser(login);
			if (user!=null) {
				Vector<User> usersVector = new Vector<User>();
				usersVector.add(user);
				tableSorter = new TableSorter(new UsersModel(usersVector));
				tableSorter.setSortingStatus(1,TableSorter.ASCENDING);
				dataGrid.setModel(tableSorter);
				tableSorter.setTableHeader(dataGrid.getTableHeader());
				TableColumnModel columnModel = dataGrid.getColumnModel();
				int n = tableSorter.getColumnCount(); 
				int columnWidth[] = {80,80,200,200,120};
				for (int i=0;i<n;i++) {
					columnModel.getColumn(i).setPreferredWidth(columnWidth[i]);
				}
				affect = true;
			}
			break;
		}
		if (!affect) {
			dataGrid.setModel(new DefaultTableModel());
		}
		
	}

	public static String getAppOwner() {
		return appOwner;
	}
}
