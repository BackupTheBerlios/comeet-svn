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

package com.kazak.comeet.admin.gui.managers.tools.Transactions;

import org.jdom.Document;
import org.jdom.Element;

import com.kazak.comeet.admin.transactions.QuerySender;

public class GroupDocument {
	private String name;
	private String isVisible;
	private String isZone;
	private String newName;
	
	public GroupDocument(String[] data) {
		name = data[0];
		isVisible = data[1];
		isZone = data[2];
		newName = data[3];
	}
	
	public Document getDocumentToAdd() {
		Element transaction = new Element("Transaction");
		Document doc = new Document(transaction);
		
		Element id = new Element("id");
        id.setText(QuerySender.getId());
        transaction.addContent(id);
        
        Element driver = new Element("driver");
        driver.setText("TR004");
        transaction.addContent(driver);
        
		Element pack = new Element("package");

		pack.addContent(createField(name));
		pack.addContent(createField(isVisible));
		pack.addContent(createField(isZone));

		transaction.addContent(pack);
		
		return doc;
	}
		
	public Document getDocumentToEdit() {
		Element transaction = new Element("Transaction");
		Document doc = new Document(transaction);
		Element driver = new Element("driver");
        driver.setText("TR005");
        transaction.addContent(driver);
        
		Element pack = new Element("package");

		pack.addContent(createField(newName));
		pack.addContent(createField(isVisible));
		pack.addContent(createField(isZone));
		pack.addContent(createField(name));
		
		transaction.addContent(pack);
		
		return doc;
	}
	
	public Document getDocumentToDelete() {
		Element transaction = new Element("Transaction");
		Document doc = new Document(transaction);
		
		Element id = new Element("id");
        id.setText(QuerySender.getId());
        transaction.addContent(id);
        
        Element driver = new Element("driver");
        driver.setText("TR006");
        transaction.addContent(driver);
        
		Element pack = new Element("package");
		pack.addContent(createField(name));
		transaction.addContent(pack);
		
		return doc;
	}
	
	private Element createField(String text) {
		Element element = new Element("field");
		element.setText(text);
		return element;
	}
}
