package com.kazak.comeet.server.businessrules;

import java.nio.channels.SocketChannel;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.jdom.Element;

import com.kazak.comeet.server.comunications.SocketServer;
import com.kazak.comeet.server.database.sql.QueryClosingHandler;
import com.kazak.comeet.server.database.sql.QueryRunner;
import com.kazak.comeet.server.database.sql.SQLBadArgumentsException;
import com.kazak.comeet.server.database.sql.SQLNotFoundException;
import com.kazak.comeet.server.misc.LogWriter;

public class MassiveConfirmer {

	private Iterator iterator;
	private static SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
	private static SimpleDateFormat formatHour = new SimpleDateFormat("HH:mm:ss a");
	private String sentDate;  // 1
	private String sentHour;  // 2
	private String login;     // 3
	private String pdaServer; // 4
	private int isMassive;    // 5
	private String confirmationDate;
	private String confirmationHour;
	
	public MassiveConfirmer(SocketChannel sock, Element args, Element packet, String id) {

		this.iterator = packet.getChildren("package").iterator();
		Iterator argsIterator = args.getChildren("args").iterator();
		Element element = (Element) argsIterator.next();
		String sqlCode = element.getValue();
			
		Element nextElement = (Element)iterator.next();
		List list = nextElement.getChildren();
		Iterator listIterator = list.iterator();
		
		sentDate  = (((Element) listIterator.next()).getValue()); // sent date
		String hour = ((Element) listIterator.next()).getValue(); // sent hour
		sentHour  = formatHour(hour);
		login     = ((Element) listIterator.next()).getValue(); // destination
		pdaServer = ((Element) listIterator.next()).getValue(); // login server
		isMassive = Integer.parseInt(((Element) listIterator.next()).getValue());
		Date date  = Calendar.getInstance().getTime();
		confirmationDate = formatDate.format(date);
		confirmationHour = formatHour.format(date);
		int mid = -1;
		
		if (isMassive == 1) {
			QueryRunner queryRunner = null;
			ResultSet resultSet = null;
			try {
				queryRunner = new QueryRunner("SEL0012B",new String[]{sentDate,sentHour,pdaServer});
				resultSet = queryRunner.select();
			    if (resultSet.next()) {
			    	mid = resultSet.getInt(1);
			    }
			} catch (SQLNotFoundException e) {
				e.printStackTrace();
			} catch (SQLBadArgumentsException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				QueryClosingHandler.close(resultSet);
				queryRunner.closeStatement();
			}
			
			if (mid != -1) {
				try {
					queryRunner = new QueryRunner("INS0008A",new String[]{mid + "",login,confirmationDate,confirmationHour});
					queryRunner.setAutoCommit(false);
					queryRunner.executeSQL();
				} catch (SQLNotFoundException e) {
					e.printStackTrace();
				} catch (SQLBadArgumentsException e) {
					e.printStackTrace();
				} catch (SQLException e) {
					e.printStackTrace();
				} finally {
					QueryClosingHandler.close(resultSet);
					queryRunner.closeStatement();
				}		
				LogWriter.write("INFO: [" + confirmationDate + " " + confirmationHour + "] Confirmada lectura de mensaje con destino {" + login + "}");
			} else {
				LogWriter.write("ERROR: No se pudo confirmar mensaje de usuario PDA. El identificador del mensaje no existe");				
			}
			
		} else {
			QueryRunner queryRunner = null;
			String[] sqlArgs = new String[5];
			sqlArgs[0] = confirmationDate;
			sqlArgs[1] = confirmationHour;
			sqlArgs[2] = sentHour;
			sqlArgs[3] = sentDate;
			sqlArgs[4] = login;
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
	
    private String formatHour(String basic) {
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
