package net.kbssm.koloud.mail;

import java.sql.Timestamp;

public class Mail {
	private String sender;
	private String receiver_email;
	private String receiver_name;
	private String contents;
	private String subject;
	private String type;
	private Timestamp time;
	
	public Mail() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Mail(String sender, String receiver_email, String receiver_name,
			String contents, String subject, String type, Timestamp time) {
		super();
		this.sender = sender;
		this.receiver_email = receiver_email;
		this.receiver_name = receiver_name;
		this.contents = contents;
		this.subject = subject;
		this.type = type;
		this.time = time;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver_email() {
		return receiver_email;
	}

	public void setReceiver_email(String receiver_email) {
		this.receiver_email = receiver_email;
	}

	public String getReceiver_name() {
		return receiver_name;
	}

	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Timestamp getTime() {
		return time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	
}
