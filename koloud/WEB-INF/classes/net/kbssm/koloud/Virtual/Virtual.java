package net.kbssm.koloud.Virtual;

public class Virtual {
	
	private String os;
	private String name;
	private String ser_id;
	private String server;
	private long maxMemory;
	private long memory;
	private int status;
	private long alloc1;
	private long alloc2;
	private long available;
	private long capacity1;
	private long capacity2;
	private int vCpu;
	private int id;
	
	public Virtual() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Virtual(String os, String name, String ser_id, String server,
			long maxMemory, long memory, int status, long alloc1, long alloc2,
			long available, long capacity1, long capacity2, int vCpu, int id) {
		super();
		this.os = os;
		this.name = name;
		this.ser_id = ser_id;
		this.server = server;
		this.maxMemory = maxMemory;
		this.memory = memory;
		this.status = status;
		this.alloc1 = alloc1;
		this.alloc2 = alloc2;
		this.available = available;
		this.capacity1 = capacity1;
		this.capacity2 = capacity2;
		this.vCpu = vCpu;
		this.id = id;
	}

	public String getOs() {
		return os;
	}

	public void setOs(String os) {
		this.os = os;
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

	public String getServer() {
		return server;
	}

	public void setServer(String server) {
		this.server = server;
	}

	public long getMaxMemory() {
		return maxMemory;
	}

	public void setMaxMemory(long maxMemory) {
		this.maxMemory = maxMemory;
	}

	public long getMemory() {
		return memory;
	}

	public void setMemory(long memory) {
		this.memory = memory;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public long getAlloc1() {
		return alloc1;
	}

	public void setAlloc1(long alloc1) {
		this.alloc1 = alloc1;
	}

	public long getAlloc2() {
		return alloc2;
	}

	public void setAlloc2(long alloc2) {
		this.alloc2 = alloc2;
	}

	public long getAvailable() {
		return available;
	}

	public void setAvailable(long available) {
		this.available = available;
	}

	public long getCapacity1() {
		return capacity1;
	}

	public void setCapacity1(long capacity1) {
		this.capacity1 = capacity1;
	}

	public long getCapacity2() {
		return capacity2;
	}

	public void setCapacity2(long capacity2) {
		this.capacity2 = capacity2;
	}

	public int getvCpu() {
		return vCpu;
	}

	public void setvCpu(int vCpu) {
		this.vCpu = vCpu;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

		
}
