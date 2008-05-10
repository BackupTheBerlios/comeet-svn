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

import java.io.File;
import java.util.Enumeration;
import java.util.Hashtable;

import javax.swing.filechooser.FileFilter;

public class ExtensionFilter extends FileFilter {

	private Hashtable<String,FileFilter> filters = null;
	private String description = null;
	private String fullDescription = null;
	private boolean useExtensionsInDescription = true;

	public ExtensionFilter() {
		this.filters = new Hashtable<String,FileFilter>();
	}

	public ExtensionFilter(String extension) {
		this(extension,null);
	}

	public ExtensionFilter(String extension, String description) {
		this();
		if(extension!=null) addExtension(extension);
		if(description!=null) setDescription(description);
	}

	public ExtensionFilter(String[] filters) {
		this(filters, null);
	}

	public ExtensionFilter(String[] filters, String description) {
		this();
		for (int i = 0; i < filters.length; i++) {
			// Add filters, one by one
			addExtension(filters[i]);
		}
		if(description!=null) setDescription(description);
	}

	public boolean accept(File f) {
		if(f != null) {
			if(f.isDirectory()) {
				return true;
			}
			String extension = getExtension(f);
			if(extension != null && filters.get(getExtension(f)) != null) {
				return true;
			};
		}
		return false;
	}

	public String getExtension(File f) {
		if(f != null) {
			String filename = f.getName();
			int i = filename.lastIndexOf('.');
			if(i>0 && i<filename.length()-1) {
				return filename.substring(i+1).toLowerCase();
			};
		}
		return null;
	}

	public void addExtension(String extension) {
		if(filters == null) {
			filters = new Hashtable<String,FileFilter>(5);
		}
		filters.put(extension.toLowerCase(), this);
		fullDescription = null;
	}

	public String getDescription() {
		if(fullDescription == null) {
			if(description == null || isExtensionListInDescription()) {
				fullDescription = description==null ? "(" : description + " (";
				// Build a description of the extensions list
				Enumeration extensions = filters.keys();
				if(extensions != null) {
					fullDescription += "." + (String) extensions.nextElement();
					while (extensions.hasMoreElements()) {
						fullDescription += ", " + (String) extensions.nextElement();
					}
				}
				fullDescription += ")";
			} else {
				fullDescription = description;
			}
		}
		return fullDescription;
	}

	public void setDescription(String description) {
		this.description = description;
		fullDescription = null;
	}

	public void setExtensionListInDescription(boolean b) {
		useExtensionsInDescription = b;
		fullDescription = null;
	}

	public boolean isExtensionListInDescription() {
		return useExtensionsInDescription;
	}
}
