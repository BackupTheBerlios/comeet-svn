package com.kazak.comeet.server.control;

import java.util.Date;

import com.kazak.comeet.server.comunications.MailHandler;

public class EmailSender extends Thread {
	private String from;
	private String to;
	private String subject;
	private String message;
	private Date date;
	private String toFullName = "Soporte Tecnico";
	private String workStation = "Centro de Datos";
	
	public void setFrom(String from) {
		this.from = from;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public void setDestination(String to) {
		this.to = to;
	}
	
	public void send() {
		start();
	}
	
	public void run() {
		String fulltext = 
			toFullName+" escribio desde "+workStation+":\n" +
			"--------------------------------------------\n"+
			message+ "\n"+
			"--------------------------------------------\n" +
			".";
		MailHandler.sendMessage(from, to, date, subject, fulltext);
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public void setSenderFullName(String toFullName) {
		this.toFullName = toFullName;
	}

	public void setWorkStation(String workStation) {
		this.workStation = workStation;
	}
}
