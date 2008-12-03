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
import java.net.NoRouteToHostException;
import java.nio.channels.SocketChannel;
import java.util.Timer;
import java.util.TimerTask;

import com.kazak.comeet.client.gui.LoginWindow;
import com.kazak.comeet.lib.misc.ClientConfigFile;

public class Ping {

	private int port;
	private String host;
	private static MyTimer myTimer;
	
	public Ping(String host, int port) {
		this.host = host;
		this.port = port;
		myTimer = new MyTimer(ClientConfigFile.getTime());
		myTimer.start();
	}

	class MyTimer {
		
		private final Timer timer = new Timer();
		private final int minutes;

		public MyTimer(int minutes) {
			this.minutes = minutes * 1000 * 60;
			
		}

		public void start() {
			timer.schedule(new TimerTask() {
				public void run() {
					work();
					timer.cancel();
					myTimer = new MyTimer(ClientConfigFile.getTime());
					myTimer.start();
				}
			}, minutes);
		}

	}
	
	public static void cancel() {
		if (myTimer!=null) {
			System.out.println("Terminando el ping");
			myTimer.timer.cancel();	
		}
	}
	
	private void work() {
		try {
			SocketChannel socket = SocketChannel.open();
			socket.configureBlocking(false);
			InetSocketAddress address = new InetSocketAddress(host, port);
			socket.connect(address);
			
			while (!socket.finishConnect()) {
				try {
					Thread.sleep(100);
					System.out.println("@");
				} catch (InterruptedException IEe) {}
			}
			LoginWindow.onTop = true;
			System.out.println("INFO: Conexion re-establecida");
			socket.close();
		} catch (NoRouteToHostException e) {
			System.out.println("ERROR: No es posible crear la conexion");
			System.out.println("Causa: " + e.getMessage());
		} catch (ConnectException e) {
			System.out.println("ERROR: El servidor no responde");
			System.out.println("Causa: " + e.getMessage());
		} catch (IOException e) {
			System.out.println("ERROR: Falla de entrada/salida");
			System.out.println("Causa: " + e.getMessage());
		}
	}
}
