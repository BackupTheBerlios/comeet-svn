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

package com.kazak.comeet.admin.gui.managers.tools.user;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.util.Vector;

import javax.swing.JFrame;
import javax.swing.JOptionPane;

import com.kazak.comeet.admin.gui.main.MainWindow;
import com.kazak.comeet.admin.gui.managers.tools.ButtonBar;
import com.kazak.comeet.admin.gui.managers.tools.Operation;
import com.kazak.comeet.admin.gui.managers.tools.ToolsConstants;
import com.kazak.comeet.admin.gui.managers.tools.Transactions.UserDocument;
import com.kazak.comeet.admin.gui.managers.tools.user.InternalPanel;

public class UserDialog extends JFrame {
	
	private static final long serialVersionUID = 1L;
	private int action;
	private String target;
	private ButtonBar buttonBar;
	private InternalPanel dynamicPanel;
	private boolean dynamicPanelIsVisible = false;
	private UserPanel userPanel;
	String[] data = new String[9];
	boolean isAdmin = true;
	
	public UserDialog(int action, String target, boolean isAdmin) {
		super();
		this.action = action;
		this.target = target;
		this.isAdmin = isAdmin;
		this.setLayout(new BorderLayout());		
		setPanels();		
		this.pack();
		this.setResizable(false);
	
		if(action == ToolsConstants.EDIT_PREFILLED || action == ToolsConstants.SEARCH_PREFILLED 
				|| action == ToolsConstants.DELETE_PREFILLED) {
			Dimension dimension = new Dimension(330,250);
			if(!isAdmin) {
				dimension = new Dimension(330,280);
			}
			userPanel.enablePanel(false);
			expandInternalPanel(target);
			setSize(dimension);
		} else {
			setSize(330,100);
		}
		
		setLocationRelativeTo(MainWindow.getFrame());
		setVisible(true);	
	}
	
	private void setPanels() {
	    buttonBar = new ButtonBar(this, action);	
		userPanel = new UserPanel(this,action,target,isAdmin);
		add(userPanel,BorderLayout.NORTH);
		add(buttonBar,BorderLayout.SOUTH);
	}   
	
	public void clean() {
		if (dynamicPanelIsVisible) {
			userPanel.clean();
			buttonBar.setEnabledClearButton(false);
			ButtonBar.setEnabledAcceptButton(false);
		}
		else {
			userPanel.clean();
		}
	}

	private boolean isUserDataOk(){
		
		data[0] = userPanel.getLogin();
		data[1] = dynamicPanel.getPasswd();
				
		if((action == ToolsConstants.ADD) && (data[1].length() == 0 || data[1].length() < 5)) {
			JOptionPane.showMessageDialog(this,"Error: Clave inválida. Debe asignar una contraseña\n" +
			"de al menos 5 caracteres.");
			return false;
		}
		data[2] = dynamicPanel.getUserName();
		if(data[2].length() == 0) {
			JOptionPane.showMessageDialog(this,"Error: Debe asignar un nombre al usuario");
			return false;
		}
		data[3] = dynamicPanel.getUserMail();
		
		if(isAdmin) {
			if(data[3].length() == 0) {
				JOptionPane.showMessageDialog(this,"Error: Debe asignar una dirección de correo al usuario");
				return false;				
			} else {
				if(data[3].indexOf("@") == -1) {
					JOptionPane.showMessageDialog(this,"Error: Verifique la dirección de correo del usuario");
					return false;									
				}
			}
			data[4] = dynamicPanel.getUserRol();
			data[6] = dynamicPanel.getUserLocation();
			if (data[6].equals("SIN REGISTROS")) {
				JOptionPane.showMessageDialog(this,"Error: Ubicación Inválida. Seleccione un grupo que contenga al menos una ubicación");
				return false;
			}
		} else {
			data[4] = "3";
			data[6] = "NULL";			
		}
		data[5] = dynamicPanel.getUserGroup();
		data[7] = dynamicPanel.doIPCheck(); // ip control enabled? 
			
		return true;
	}
	
	public void executeOperation() {
		UserDocument doc = null;

		switch(action) {
		// To Add
		case ToolsConstants.ADD:
			// To Edit
		case ToolsConstants.EDIT:
			// To Edit (filled)
		case ToolsConstants.EDIT_PREFILLED:
			if (!dynamicPanelIsVisible) {
				JOptionPane.showMessageDialog(this,"Por favor, modifique los datos del usuario antes de salvar los cambios");
				return;
			}
			if(!isUserDataOk()) {
				return;
			}
			if(isAdmin) {
				Vector<String> posCodes = new Vector<String>();
				posCodes.add(dynamicPanel.getUserLocation());
				doc = new UserDocument(data,posCodes);
			}
			else  {
				Vector<String> posCodes = dynamicPanel.getPosCodes();
				doc = new UserDocument(data,posCodes);	
				if(posCodes.size() == 0) {
					JOptionPane.showMessageDialog(this,"Error: El usuario " + target + " debe tener asociado\n" +
					"al menos un punto de trabajo");
					return;	
				}
			}
			if(ToolsConstants.ADD == action) {
				Operation.execute(doc.getDocumentToAdd());
			} else {
				Operation.execute(doc.getDocumentToEdit());
			}
			dispose();
			break;
			// To Delete - To Delete (filled)
		case ToolsConstants.DELETE:
		case ToolsConstants.DELETE_PREFILLED:
			doc = new UserDocument();
			Operation.execute(doc.getDocumentToDelete(userPanel.getLogin()));
			dispose();
			break;
		case ToolsConstants.LINK:
			break;
		}	   
	}
	
	public void collapseInternalPanel()  {
		//  Remove the details panel from the dialog
		getContentPane().remove (dynamicPanel);

		//  Shrink the dialog the height of the removed panel
		Dimension detailsPanelSize = dynamicPanel.getSize ();
		Dimension dialogSize = getSize ();
		dialogSize.height -= detailsPanelSize.height;
		setSize (dialogSize);

		//  Cause the new layout to take effect
		invalidate ();
		validate ();
		
		if (dynamicPanelIsVisible) {
			dynamicPanelIsVisible = false;
		}
		centerDialog();
	}
	
	public void expandInternalPanel(String login)  {
		if(!ButtonBar.isAcceptButtonActive()) {
			ButtonBar.setEnabledAcceptButton(true);
		}
		buttonBar.setEnabledClearButton(true);
		dynamicPanel = new InternalPanel(this,login,isAdmin,action);

		//  Add the details panel to the dialog
		getContentPane().add (dynamicPanel, BorderLayout.CENTER);
		//  Resize the dialog to accomidate the added size
		Dimension dialogSize = getSize ();
		Dimension detailSize = null;
		
		if (dynamicPanelIsVisible)  {
			//  The details area already has a size from the last time it was displayed
			detailSize = dynamicPanel.getSize ();
		}  else  {
			//  The details area has yet to be made visible
			detailSize = dynamicPanel.getPreferredSize ();
		}
		//  Increase the height of the dialog to fit the added details area
		dialogSize.height += detailSize.height;
		setSize(dialogSize);
		//  Cause the new layout to take effect
		invalidate ();
		validate ();
		
		if (!dynamicPanelIsVisible) {
			dynamicPanelIsVisible = true;
		}
		
		centerDialog();
	}
	
	private void centerDialog()  {
		JFrame owner = MainWindow.getFrame();
		setLocationRelativeTo(owner);
	}
	
	public boolean isPanelVisible() {
		return dynamicPanelIsVisible;
	}
	
	public void setAdminFlag(boolean flag) {
		isAdmin = flag;
	}	
}
