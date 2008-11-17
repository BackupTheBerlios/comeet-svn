package com.kazak.comeet.server.businessrules;

import java.nio.channels.SocketChannel;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.jdom.Element;

import com.kazak.comeet.server.comunications.SocketServer;
import com.kazak.comeet.server.database.sql.QueryRunner;
import com.kazak.comeet.server.database.sql.SQLBadArgumentsException;
import com.kazak.comeet.server.database.sql.SQLNotFoundException;
import com.kazak.comeet.server.misc.LogWriter;

public class MessageConfirmer {

	private Iterator iterator;
	private static SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat formatHour = new SimpleDateFormat("HH:mm:ss a");
	
	public MessageConfirmer(SocketChannel sock, Element args, Element packet, String id) {
			
		this.iterator = packet.getChildren("package").iterator();
		Iterator argsIterator = args.getChildren("args").iterator();
		QueryRunner queryRunner = null;
		
		while(argsIterator.hasNext()) {
			Element element = (Element) argsIterator.next();
			String sqlCode = element.getValue();
			
			Element nextElement = (Element)iterator.next();
			List list = nextElement.getChildren();
			String[] sqlArgs = new String[5];
			Iterator listIterator = list.iterator();

			Date date  = Calendar.getInstance().getTime();
			sqlArgs[0] = formatDate.format(date); 
			sqlArgs[1] = formatHour.format(date);
			sqlArgs[2] = ((Element) listIterator.next()).getValue();
			sqlArgs[3] = formatDate(((Element) listIterator.next()).getValue()); // date
			sqlArgs[4] = ((Element) listIterator.next()).getValue();
			
			try {
				queryRunner = new QueryRunner(sqlCode,sqlArgs);
				queryRunner.setAutoCommit(false);
				queryRunner.executeSQL();
				queryRunner.commit();
				LogWriter.write("INFO: [" + sqlArgs[0] + " " + sqlArgs[1] + "] Confirmada lectura de mensaje con destino {" + sqlArgs[4] + "}");
				SocketServer.getSocketInfo(sqlArgs[4]);
			} catch (SQLException e) {
				queryRunner.rollback();
				LogWriter.write("ERROR: " + e.getErrorCode());
				e.printStackTrace();
				if (queryRunner!=null) {
					queryRunner.rollback();
				}
				TransactionRunner.notifyErrorMessage(
						 sock,
                    	 id,
                    	 "No se pudo procesar la operación:\n" +
 						 "Causa:\n" + e.getLocalizedMessage());
			} catch (SQLNotFoundException e) {
				e.printStackTrace();
				TransactionRunner.notifyErrorMessage(
						 sock,
						 id,
						 "La sentencia  " + sqlCode + " no existe.");
			} catch (SQLBadArgumentsException e) {
				e.printStackTrace();
				TransactionRunner.notifyErrorMessage(
						 sock,
						 id,
						 "Argumentos inválidos " +
						 "para la sentencia : " + sqlCode);
			}
		}
	}
	
    private String formatDate(String basic) {
    	int hour = Integer.parseInt(basic.substring(0,basic.indexOf(":")));
		String meridian = basic.substring(basic.indexOf(" "),basic.length());
		if (meridian.trim().equals("PM")) {
				hour = hour + 12;
				String tail = basic.substring(basic.indexOf(":"),basic.length());
				basic = hour + tail;
		}
	       return basic;
    }
}
