package net.kbssm.koloud.Server;

import java.sql.Timestamp;

public class Server {
	
	private String ip;
	private String v_ip;
	private String name;
	private String ser_id;
	private String os;
	private String domain;
	private int ram;
	private int cpu;
	private int disk;
	private String server;
	private String password;
	private String status;
	private int id;
	private int permission; // 1 = waiting, 2 = accepted, 3 = denied, 4 = canceled
	private String reason;
	private Timestamp time;

	public Server(String ip, String v_ip, String name, String ser_id,
			String os, String domain, int ram, int cpu, int disk,
			String server, String password, String status, int id,
			int permission, String reason, Timestamp time) {
		super();
		this.ip = ip;
		this.v_ip = v_ip;
		this.name = name;
		this.ser_id = ser_id;
		this.os = os;
		this.domain = domain;
		this.ram = ram;
		this.cpu = cpu;
		this.disk = disk;
		this.server = server;
		this.password = password;
		this.status = status;
		this.id = id;
		this.permission = permission;
		this.reason = reason;
		this.time = time;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getV_ip() {
		return v_ip;
	}

	public void setV_ip(String v_ip) {
		this.v_ip = v_ip;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSer_id() {
		return ser_id;
	}

	public void setSer_id(String ser_id) {
		this.ser_id = ser_id;
	}

	public String getOs() {
		return os;
	}

	public void setOs(String os) {
		this.os = os;
	}

	public String getDomain() {
		return domain;
	}

	public void setDomain(String domain) {
		this.domain = domain;
	}

	public int getRam() {
		return ram;
	}

	public void setRam(int ram) {
		this.ram = ram;
	}

	public int getCpu() {
		return cpu;
	}

	public void setCpu(int cpu) {
		this.cpu = cpu;
	}

	public int getDisk() {
		return disk;
	}

	public void setDisk(int disk) {
		this.disk = disk;
	}

	public String getServer() {
		return server;
	}

	public void setServer(String server) {
		this.server = server;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getPermission() {
		return permission;
	}

	public void setPermission(int permission) {
		this.permission = permission;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Timestamp getTime() {
		return time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}
	
}
