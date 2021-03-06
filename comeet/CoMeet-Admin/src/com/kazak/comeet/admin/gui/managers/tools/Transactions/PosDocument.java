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
import com.kazak.comeet.admin.control.Cache;
import com.kazak.comeet.admin.transactions.QuerySender;

public class PosDocument {

	private String name;
	private String code;
	private String ip;
	private String group;
	private String enabled;
	
	public PosDocument(String[] data) {
		name = data[0];
		code = data[1];
		ip = data[2];
		group = data[3];
		enabled = data[4];
	}
	
	public Document getDocumentToAdd() {
		Element transaction = new Element("Transaction");
		Document doc = new Document(transaction);
		
		Element id = new Element("id");
        id.setText(QuerySender.getId());
        transaction.addContent(id);
        
        Element driver = new Element("driver");
        driver.setText("TR007");
        transaction.addContent(driver);
        
		Element pack = new Element("package");
		 
		Cache.Group g = Cache.getGroup(group);
		pack.addContent(createField(name));
		pack.addContent(createField(ip));
		pack.addContent(createField(g.getId()));
		pack.addContent(createField(enabled));
		
		transaction.addContent(pack);
		
		return doc;
	}
		
	public Document getDocumentToEdit() {
		Element transaction = new Element("Transaction");
		Document doc = new Document(transaction);
		
		Element id = new Element("id");
        id.setText(QuerySender.getId());
        transaction.addContent(id);
        
		Element driver = new Element("driver");
        driver.setText("TR008");
        transaction.addContent(driver);
        
		Element pack = new Element("package");

		Cache.Group groupObject = Cache.getGroup(group);
		pack.addContent(createField(ip));
		pack.addContent(createField(groupObject.getId()));
		pack.addContent(createField(enabled));
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
        driver.setText("TR009");
        transaction.addContent(driver);
        
		Element pack = new Element("package");
		pack.addContent(createField(code));
		transaction.addContent(pack);
		
		return doc;
	}
	
	public Document getDocumentToLink() {
		Element transaction = new Element("Transaction");
		Document doc = new Document(transaction);

		Element driver = new Element("driver");
        driver.setText("TR-OFF");
        transaction.addContent(driver);
        
		Element pack = new Element("package");
		pack.addContent(createField(code));
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
