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

import java.awt.Cursor;
import java.io.IOException;
import java.util.ArrayList;

import javax.swing.JOptionPane;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;

import com.kazak.comeet.client.gui.LoginWindow;
import com.kazak.comeet.client.gui.MessageViewer;
import com.kazak.comeet.client.gui.TrayManager;
import com.kazak.comeet.client.network.QuerySender;
import com.kazak.comeet.client.network.SocketHandler;
import com.kazak.comeet.lib.network.ArrivedPackageEvent;
import com.kazak.comeet.lib.network.PackageComingListener;

// Solo para pruebas con pda's
import com.kazak.comeet.client.network.SocketWriter;

public class HeadersValidator implements PackageComingListener {

    private static Element root;
    private static ArrayList<MessageListener> msgListenersList = new ArrayList<MessageListener>();
    
    public void validPackage(ArrivedPackageEvent APe) {	
   		Document doc = APe.getDoc();
        root = doc.getRootElement();
        String name = root.getName();
        
        // Temporal code for degugging
    	XMLOutputter out2 = new XMLOutputter();
    	out2.setFormat(Format.getPrettyFormat());
    	try {
			out2.output(doc,System.out);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
    	if(name.equals("ACPBegin")) {
    		LoginWindow.quit();
    		LoginWindow.setLogged(true);
            Cache.loadGroupsCache();
            Cache.loadMessagesHistory();
            Element element = new Element("root");
            element.addContent(new Element("type").setText("connection"));
            TrayManager.setLogged(true);
        }
    	else if(name.equals("Message")) {
    		Cache.addMessages(root);
    		root.addContent(new Element("type").setText("message"));
            MessageEvent msgEvent = new MessageEvent(root,root);
            notifyMessage(msgEvent);
            MessageViewer.show();
        }
        else if(name.equals("ACPFAILURE")) {
            String message = root.getChildText("message");
            JOptionPane.showMessageDialog(LoginWindow.getFrame(),message);
            LoginWindow.setEnabled();
            LoginWindow.setCursorState(Cursor.DEFAULT_CURSOR);
            try {
				SocketHandler.getSock().close();
			} catch (IOException e) {
				e.printStackTrace();
			}
        }
        else if(name.equals("ANSWER")) {
            String id = root.getChildText("id");
            QuerySender.putResultOnPool(id,doc);
        }
        else if(name.equals("SUCCESS")) {
            String id = root.getChildText("id");
            QuerySender.putResultOnPool(id,doc);
            String message = root.getChildText("successMessage");
            JOptionPane.showMessageDialog(null, message);
        }
        else if(name.equals("ERROR")) {
			displayError();
        }
    	// Codigo experimental para probar con PDA's
        else if(name.equals("VERIFY")) {
        	String id = root.getChildText("id");
    		Element root = new Element("VERIFY");
    		Document xml = new Document();
            xml.setRootElement(root);
            root.addContent(new Element("id").setText(id));
            root.addContent(new Element("answer").setText(String.valueOf("true")));
            try {
    			SocketWriter.writing(SocketHandler.getSock(),xml);
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
        }
        else {
        	System.out.println("Error en el formato del protocolo");
        	XMLOutputter out = new XMLOutputter();
        	out.setFormat(Format.getPrettyFormat());;
        	try {
    			out.output(doc,System.out);
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
        }
    }
    
    private static void displayError() {
        JOptionPane.showMessageDialog(
        						null,
        						root.getChild("errorMsg").getText(),
        						"",
        						JOptionPane.ERROR_MESSAGE);
    }
    
    private static void notifyMessage(MessageEvent event) {
		for (int i = 0; i < msgListenersList.size(); i++) {
			MessageListener listener = msgListenersList.get(i);
			listener.getANewMessage(event);
		}
	}

	public static synchronized void addMessageListener(MessageListener l) {
		msgListenersList.add(l);
	}

	public static synchronized void removeACPFormListener(MessageListener l) {
		msgListenersList.remove(l);
	}
}