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

import java.util.Vector;
import org.jdom.Document;
import org.jdom.Element;

import com.kazak.comeet.admin.control.Cache;
import com.kazak.comeet.admin.transactions.QuerySender;

public class UserDocument {
	Document doc;
	private String login;
	private String passwd;
	private String name;
	private String mail;
	private String rol;
	private String groupId;
	private String ipControl;	
	Vector<String> posCodesVector = new Vector<String>();

	public UserDocument() {
	}

	public UserDocument(String[] data) {
		setData(data);
	}
	
	public UserDocument(String[] data, Vector<String> posCodesVector) {
		setData(data);
		this.posCodesVector = posCodesVector;
	}
	
	public void setData(String[] data) {
		login     = data[0];
		passwd    = data[1];
		if (passwd.length() == 0) {
			passwd = Cache.getUser(login).getPasswd();
		}
		name      = data[2];
		mail      = data[3];
		rol       = data[4];
		groupId   = data[5];
		ipControl = data[6];
	}
		
	public Document getDocumentToAdd() {
		Element transaction = new Element("Transaction");
		doc = new Document(transaction);
		Element id = new Element("id");
        id.setText(QuerySender.getId());
        transaction.addContent(id);
        Element driver = new Element("driver");
        driver.setText("TR001");
        transaction.addContent(driver);
        
		Element pack = new Element("package");
		pack.addContent(createField(login));
		pack.addContent(createField(passwd));
		pack.addContent(createField(name));
		pack.addContent(createField(mail));
		pack.addContent(createField(groupId));
		pack.addContent(createField(rol));		
		transaction.addContent(pack);
		
		// Saving pos data from table to package
		pack = new Element("package");
		int max = posCodesVector.size();
		for (int i=0 ; i < max ; i++) {
			Element subpackage = new Element("subpackage");
			subpackage.addContent(createField(login));
			subpackage.addContent(createField(posCodesVector.get(i).toString()));
			subpackage.addContent(createField(ipControl));
			pack.addContent(subpackage);
		}
		transaction.addContent(pack);
		
		return doc;
	}
		
	public Document getDocumentToEdit() {
		Element transaction = new Element("Transaction");
		doc = new Document(transaction);
		Element id = new Element("id");
        id.setText(QuerySender.getId());
        transaction.addContent(id);
        Element driver = new Element("driver");
        driver.setText("TR002");
        transaction.addContent(driver);
        
        String uid = Cache.getUser(login).getId();
		Element pack = new Element("package");
		pack.addContent(createField(login));
		pack.addContent(createField(passwd));
		pack.addContent(createField(name));
		pack.addContent(createField(mail));
		pack.addContent(createField(rol));
		pack.addContent(createField(groupId));
		pack.addContent(createField(uid));
		transaction.addContent(pack);
		
		pack = new Element("package");
		pack.addContent(createField(uid));
		transaction.addContent(pack);
		
		// Saving pos data from table to package
		pack = new Element("package");
		int max = posCodesVector.size();
		for (int i=0 ; i < max ; i++) {
			Element subpackage = new Element("subpackage");
			subpackage.addContent(createField(login));
			subpackage.addContent(createField(posCodesVector.get(i).toString()));
			subpackage.addContent(createField(ipControl));
			pack.addContent(subpackage);
		}
		transaction.addContent(pack);
		
        return doc;
	}
	
	public Document getDocumentToDelete(String login) {
		Element transaction = new Element("Transaction");
		Document doc = new Document(transaction);
		
		Element id = new Element("id");
        id.setText(QuerySender.getId());
        transaction.addContent(id);
        
        Element driver = new Element("driver");
        driver.setText("TR003");
        transaction.addContent(driver);
        
        Cache.User user = Cache.getUser(login);
        
		Element pack = new Element("package");
		pack.addContent(createField(user.getId()));
		transaction.addContent(pack);
		
		pack = new Element("package");
		pack.addContent(createField(user.getId()));
		transaction.addContent(pack);
		return doc;
	}
	
	private Element createField(String text) {
		Element element = new Element("field");
		element.setText(text);
		return element;
	}	
}
