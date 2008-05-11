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

package com.kazak.comeet.lib.network;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.ClosedChannelException;
import java.nio.channels.SocketChannel;
import java.util.Vector;

import org.jdom.Document;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;


public class PackageToXMLConverter {

    private static ByteArrayOutputStream bufferOutputStream;
    private static Document doc;
    private ByteBuffer buffer;
    private SAXBuilder saxBuilder;
    private Vector <PackageComingListener>arrivedPackageListener = new Vector<PackageComingListener>();
    
    public PackageToXMLConverter() {
        bufferOutputStream = new ByteArrayOutputStream();
    }

    public synchronized boolean work(SocketChannel socket) {

        buffer = ByteBuffer.allocateDirect(8192);
        try {

            int bytesNum = 1;
            while (bytesNum > 0) {

                buffer.rewind();                
                bytesNum = socket.read(buffer);
                buffer.rewind();

                for (int i = 0; i < bytesNum; i++) {
                    int character = buffer.get(i);
                    if (character != 12) {
                        if (character!=0) {
                        	bufferOutputStream.write(character);
                        }
                    }
                    else {
                        ByteArrayInputStream bufferInputStream = null;
                        saxBuilder = new SAXBuilder(false);
                        bufferInputStream = new ByteArrayInputStream(bufferOutputStream.toByteArray());
                        try {
							doc = saxBuilder.build(bufferInputStream);
						} catch (JDOMException e) {
							System.out.println("ERROR: Paquete recibido no posee una estructura xml correcta");
							e.printStackTrace();
						}
        	            ArrivedPackageEvent event = new ArrivedPackageEvent(this,doc);
        	            notifyArrivedPackage(event);
                    	bufferOutputStream.close();
                        bufferOutputStream = new ByteArrayOutputStream();
                    }

                }
                if (bytesNum == -1) {
                    socket.close();
                    socket = null;
                    return false;
                }
            }

        }
        catch (ClosedChannelException e) {
        	socket = null;
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        return true;
    }

    public synchronized void addPackageComingListener(PackageComingListener listener) {
        arrivedPackageListener.addElement(listener);
    }

    public synchronized void removeSuccessListener(PackageComingListener listener) {
        arrivedPackageListener.removeElement(listener);
    }

    private synchronized void notifyArrivedPackage(ArrivedPackageEvent packageEvent) {
        for (int i=0; i<arrivedPackageListener.size();i++) {
            PackageComingListener listener = (PackageComingListener)arrivedPackageListener.elementAt(i);
            listener.validPackage(packageEvent);
        }
    }
}