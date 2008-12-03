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

import com.kazak.comeet.admin.gui.managers.tools.MainForm;
import com.kazak.comeet.admin.gui.managers.tools.ToolsConstants;

public class GroupManager {
	public MainForm form;
	
	public GroupManager() {
	}

	public void addGroup() {
		form = new MainForm(ToolsConstants.GROUP,ToolsConstants.ADD,"");
	}
	
	public void editGroup() {
		form = new MainForm(ToolsConstants.GROUP,ToolsConstants.EDIT,"");
	}

	public void editGroup(String target) {
		form = new MainForm(ToolsConstants.GROUP,ToolsConstants.EDIT_PREFILLED,target);
	}

	public void deleteGroup() {
		form = new MainForm(ToolsConstants.GROUP,ToolsConstants.DELETE,"");
	}

	public void deleteGroup(String target) {
		form = new MainForm(ToolsConstants.GROUP,ToolsConstants.DELETE_PREFILLED,target);
	}
	
	public void searchGroup() {
		form = new MainForm(ToolsConstants.GROUP,ToolsConstants.SEARCH,"");
	}
	
	public void searchGroup(String target) {
		form = new MainForm(ToolsConstants.GROUP,ToolsConstants.SEARCH_PREFILLED,target);
	}
}
