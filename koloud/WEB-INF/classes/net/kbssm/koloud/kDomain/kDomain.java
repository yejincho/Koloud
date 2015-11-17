package net.kbssm.koloud.kDomain;

public class kDomain {

	private String domain;
	private int id;
	private String server;
	private String ftpDom;
	private String sshDom;
	private String subDom;
	
	public kDomain(){}

	public kDomain(String domain, int id, String ftpDom, String sshDom,
			String subDom) {
		super();
		this.domain = domain;
		this.id = id;
		this.ftpDom = ftpDom;
		this.sshDom = sshDom;
		this.subDom = subDom;
	}
	
	public kDomain(String domain, int id, String s_name, String ftpDom,
			String sshDom, String subDom) {
		super();
		this.domain = domain;
		this.id = id;
		this.server = s_name;
		this.ftpDom = ftpDom;
		this.sshDom = sshDom;
		this.subDom = subDom;
	}

	public String getDomain() {
		return domain;
	}

	public void setDomain(String domain) {
		this.domain = domain;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFtpDom() {
		return ftpDom;
	}

	public void setFtpDom(String ftpDom) {
		this.ftpDom = ftpDom;
	}

	public String getSshDom() {
		return sshDom;
	}

	public void setSshDom(String sshDom) {
		this.sshDom = sshDom;
	}

	public String getSubDom() {
		return subDom;
	}

	public void setSubDom(String subDom) {
		this.subDom = subDom;
	}

	public String getServer() {
		return server;
	}

	public void setServer(String s_name) {
		this.server = s_name;
	}
	
	
	
	
}
