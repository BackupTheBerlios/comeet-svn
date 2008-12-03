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

package com.kazak.comeet.admin.gui.managers;

import com.kazak.comeet.admin.gui.managers.tools.user.UserDialog;
import com.kazak.comeet.admin.gui.managers.tools.ToolsConstants;
import com.kazak.comeet.admin.control.Cache;
import com.kazak.comeet.admin.control.Cache.User;

public class UserManager {
	UserDialog form;

	public UserManager() {
	}

	public void addUser() {
		form = new UserDialog(ToolsConstants.ADD,"",false);
	}
	public void editUser() {
		form = new UserDialog(ToolsConstants.EDIT,"",false);
	}
	public void editUser(String target) {
		form = new UserDialog(ToolsConstants.EDIT_PREFILLED,target,false);
	}
	public void deleteUser() {
		form = new UserDialog(ToolsConstants.DELETE,"",false);
	}
	public void deleteUser(String target) {
		User user = Cache.getUser(target);
		Boolean isAdmin = false;
		int type = user.getType();
		switch(type) {
		case 1:
		case 2:
		case 5:
			isAdmin = true;
			break;
		}
		form = new UserDialog(ToolsConstants.DELETE_PREFILLED,target,isAdmin);
	}
	public void searchUser() {
		form = new UserDialog(ToolsConstants.SEARCH,"",false);
	}
	public void searchUser(String target) {
		form = new UserDialog(ToolsConstants.SEARCH_PREFILLED,target,false);
	}
	
	public void addAdmin() {
		form = new UserDialog(ToolsConstants.ADD,"",true);
	}
	public void editAdmin() {
		form = new UserDialog(ToolsConstants.EDIT,"",true);
	}
	public void editAdmin(String target) {
		form = new UserDialog(ToolsConstants.EDIT_PREFILLED,target,true);
	}
	public void deleteAdmin() {
		form = new UserDialog(ToolsConstants.DELETE,"",true);
	}
	public void deleteAdmin(String target) {
		form = new UserDialog(ToolsConstants.DELETE_PREFILLED,target,true);
	}
	public void searchAdmin() {
		form = new UserDialog(ToolsConstants.SEARCH,"",true);
	}
	public void searchAdmin(String target) {
		form = new UserDialog(ToolsConstants.SEARCH_PREFILLED,target,true);
	}	
}
