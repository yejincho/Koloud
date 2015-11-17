package net.kbssm.koloud.Resource;

import java.sql.Timestamp;

public class Resource {

	private int index;
	private int id;
	private String s_name;
	private long disk;
	private int cpu;
	private long ram;
	private String reason;
	private String permission;
	private Timestamp time;
	
	public Resource() {
		super();
	}

	public Resource(int index, int id, String s_name, long disk, int cpu,
			long ram, String reason, String permission, Timestamp time) {
		super();
		this.index = index;
		this.id = id;
		this.s_name = s_name;
		this.disk = disk;
		this.cpu = cpu;
		this.ram = ram;
		this.reason = reason;
		this.permission = permission;
		this.time = time;
	}

	public int getIndex() {
		return index;
	}

	public void setIndex(int index) {
		this.index = index;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getS_name() {
		return s_name;
	}

	public void setS_name(String s_name) {
		this.s_name = s_name;
	}

	public long getDisk() {
		return disk;
	}

	public void setDisk(long disk) {
		this.disk = disk;
	}

	public int getCpu() {
		return cpu;
	}

	public void setCpu(int cpu) {
		this.cpu = cpu;
	}

	public long getRam() {
		return ram;
	}

	public void setRam(long ram) {
		this.ram = ram;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}

	public Timestamp getTime() {
		return time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	
}
