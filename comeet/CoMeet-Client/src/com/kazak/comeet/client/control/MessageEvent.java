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

package com.kazak.comeet.client.control;

import java.util.EventObject;
import org.jdom.Element;


public class MessageEvent extends EventObject {

	private static final long serialVersionUID = -63911540053380830L;
	private Element element;
	
	public MessageEvent(Object source,Element element) {
		super(source);
		this.element = element;
	}
	
	/**
	 * @return    the element
	 * @uml.property  name="element"
	 */
	public Element getElement() {
		return element;
	}
}
