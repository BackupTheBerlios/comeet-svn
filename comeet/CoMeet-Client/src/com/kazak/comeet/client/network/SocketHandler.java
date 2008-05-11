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

package com.kazak.comeet.client.network;

import java.io.IOException;
import java.net.ConnectException;
import java.net.InetSocketAddress;
import java.net.SocketException;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.SocketChannel;
import java.nio.channels.UnresolvedAddressException;
import java.util.Iterator;

import javax.swing.JOptionPane;

import com.kazak.comeet.client.gui.LoginWindow;
import com.kazak.comeet.client.gui.TrayManager;
import com.kazak.comeet.lib.network.PackageToXMLConverter;

public class SocketHandler extends Thread  {

	private static SocketChannel socket;
	private PackageToXMLConverter xmlPackage;
	private String host;
	private int port;
	
	public SocketHandler(String host,int port,PackageToXMLConverter packageXML) 
	throws UnresolvedAddressException, SocketException, IOException  {
		this.host = host;
		this.port = port;
		
		socket = SocketChannel.open();
        socket.configureBlocking(false);
        this.xmlPackage = packageXML;
        
        InetSocketAddress address = new InetSocketAddress(host,port);
        socket.connect(address);
        
        int times=0;
        while(!socket.finishConnect()){
    		try {
    			Thread.sleep(100);
    			times++;
    			if (times==50) {
    				throw new ConnectException();
				}
    		}
    		catch(InterruptedException IEe) {}
        }
        Ping.cancel();
	}
	
	public void run() {
        try {
            Selector selector = Selector.open();
            socket.register(selector, SelectionKey.OP_READ);
            boolean result = true;
            while (true) {
                int n = selector.select();
                if (n > 0) {
                    Iterator iterador = selector.selectedKeys().iterator();
                    while (iterador.hasNext()) {
                        SelectionKey key = (SelectionKey) iterador.next();
                        iterador.remove();
                        if (key.isReadable()) {
                        	result = xmlPackage.work(socket) ;
                        	if (!result) {
                        		JOptionPane.showMessageDialog(
                        				null,
                        				"Se ha perdido la conexión con el servidor.\n" +
                        				"Por favor, contacte a soporte técnico.");
                        	}
                        }
                        if (!result) {
                        	break;
                        }
                    }
                }
                if (!result) {
                	TrayManager.setLogged(false);
                	LoginWindow.show();
                	LoginWindow.onTop = false;
                	new Ping(host,port);
                	break;
                }
            }
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    public static SocketChannel getSock() {
        return socket;
    }
    
    public static boolean isConcected(){
        return socket.isConnected();
    }
}