package net.kbssm.koloud.User;

import java.sql.Timestamp;

public class User {

	private int id;
	private String name;
	private String email;
	private String password;
	private String sysPassword;
	private int visitCnt;
	private int level; //1 = member , 3 = admin
	private Timestamp time;
	
	public User() {
		
	}

	public User(int id, String name, String email, String password, int level, Timestamp time) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.level = level;
		this.time = time;
	}
	
	public User(int id, String name, String email, String password,
			String sysPassword, int level, Timestamp time) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.sysPassword = sysPassword;
		this.level = level;
		this.time = time;
	}

	public int getVisitCnt() {
		return visitCnt;
	}

	public void setVisitCnt(int visitCnt) {
		this.visitCnt = visitCnt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSysPassword() {
		return sysPassword;
	}

	public void setSysPassword(String sysPassword) {
		this.sysPassword = sysPassword;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public Timestamp getTime() {
		return time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}
	
	
}
