package com.kazak.comeet.server.businessrules;

import java.nio.channels.SocketChannel;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.jdom.Element;

import com.kazak.comeet.server.database.sql.QueryRunner;
import com.kazak.comeet.server.database.sql.SQLBadArgumentsException;
import com.kazak.comeet.server.database.sql.SQLNotFoundException;
import com.kazak.comeet.server.misc.LogWriter;

public class MessageConfirmer {

	private Iterator iterator;
	private static SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat formatHour = new SimpleDateFormat("hh:mm:ss a");
	
	public MessageConfirmer(SocketChannel sock, Element args, Element packet, String id) {
		this.iterator = packet.getChildren("package").iterator();
		Iterator argsIterator = args.getChildren("args").iterator();
		QueryRunner queryRunner = null;
		
		while(argsIterator.hasNext()) {
			Element element = (Element) argsIterator.next();
			String sqlCode = element.getValue();
			
			Element nextElement = (Element)iterator.next();
			List list = nextElement.getChildren();
			String[] sqlArgs = new String[6];
			Iterator listIterator = list.iterator();

			sqlArgs[0] = ((Element) listIterator.next()).getValue();
			Date date  = Calendar.getInstance().getTime();
			sqlArgs[1] = formatDate.format(date); 
			sqlArgs[2] = formatHour.format(date);
			sqlArgs[3] = ((Element) listIterator.next()).getValue();
			sqlArgs[4] = ((Element) listIterator.next()).getValue();
			sqlArgs[5] = ((Element) listIterator.next()).getValue();
			
			try {
				queryRunner = new QueryRunner(sqlCode,sqlArgs);
				queryRunner.setAutoCommit(false);
				queryRunner.executeSQL();
				queryRunner.commit();
				LogWriter.write(
						"INFO: Confirmada lectura del mensaje con destino {" + 
						((Element)list.get(3)).getValue() + "} / Asunto: [" + 
						((Element)list.get(4)).getValue() + "] / Remitido por: {" + 
						((Element)list.get(5)).getValue() + "}");
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
}
