package net.kbssm.koloud.kDomain;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import net.kbssm.koloud.xstream.GetFile;

import com.thoughtworks.xstream.XStream;

public class kDomainConvert {
	private String domain;
	private int id;
	private String ftpDom;
	private String sshDom;
	private String subDom;
	
	public kDomainConvert() {
		
	}
	
	public kDomainConvert(String domain, String ftpDom, String sshDom,
			String subDom) {
		this.domain = domain;
		this.ftpDom = ftpDom;
		this.sshDom = sshDom;
		this.subDom = subDom;
	}
	
	public kDomainConvert(String domain, int id, String ftpDom, String sshDom,
			String subDom) {
		this.domain = domain;
		this.id = id;
		this.ftpDom = ftpDom;
		this.sshDom = sshDom;
		this.subDom = subDom;
	}

	public int domainList() throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("domain", kDomain.class);
		xStream.alias("domainList", kDomainList.class);
		xStream.addImplicitCollection(kDomainList.class, "domainList");
		
		kDomainList d = new kDomainList();
		
		GetFile file = new GetFile("DomainList.xml");
		
		d = (kDomainList)xStream.fromXML(file.reader());
		
		id = 1;
		String s_name = "";
		d.add(new kDomain(domain,id,s_name,ftpDom,sshDom,subDom));
		
		String xml = xStream.toXML(d);
		
		file.writer(xml);
		
		return 1;
	}
		
	public List<kDomain> getDomainList() throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("domain", kDomain.class);
		xStream.alias("domainList", kDomainList.class);
		xStream.addImplicitCollection(kDomainList.class, "domainList");
		
		List<kDomain> ld = new ArrayList<kDomain>();
		
		kDomainList d = new kDomainList();
		
		GetFile file = new GetFile("DomainList.xml");
		
		d = (kDomainList)xStream.fromXML(file.reader());

		for(int i=0;i<d.getSize();i++){
			ld.add(d.getElement(i));				
		}
	
		return ld;
	}
	
	public void updateDomainList(String subdom) throws IOException{ //domain delete
		XStream xStream = new XStream();
		
		xStream.alias("domain", kDomain.class);
		xStream.alias("domainList", kDomainList.class);
		xStream.addImplicitCollection(kDomainList.class, "domainList");
		
		kDomainList d = new kDomainList();
		
		GetFile file = new GetFile("DomainList.xml");
		
		d = (kDomainList)xStream.fromXML(file.reader());
		
		for(int i=1;i<d.getSize();i++){
			if(d.getList().get(i).getSubDom().equals(subdom)){
				d.getList().remove(i);
			}
		}
		
		String xml = xStream.toXML(d);
		
		file.writer(xml);
		
	}
	
	public void updateDomain(String domain) throws IOException{ //domain delete
		XStream xStream = new XStream();
		
		xStream.alias("domain", kDomain.class);
		xStream.alias("domainList", kDomainList.class);
		xStream.addImplicitCollection(kDomainList.class, "domainList");
		
		kDomainList d = new kDomainList();
		
		GetFile file = new GetFile("DomainList.xml");
		
		d = (kDomainList)xStream.fromXML(file.reader());
		
		
		String ftpDomain = "tool.";
		String sshDomain = "console.";
		int flag = 0;
		for(int i=0;i<domain.length();i++){
			if(flag == 1){
				ftpDomain += domain.charAt(i);
				sshDomain += domain.charAt(i);
			}
			if(flag == 0 && domain.charAt(i) == '.'){ //.이 처음 나오면 flag = 1 해주고 넘어가기
				flag = 1;
			}
		}
		
		d.getList().get(0).setDomain(domain);
		d.getList().get(0).setFtpDom(ftpDomain);
		d.getList().get(0).setSshDom(sshDomain);
		
		String xml = xStream.toXML(d);
		
		file.writer(xml);
		
	}
	
	public void updateDomainList(String subdom, String s_name) throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("domain", kDomain.class);
		xStream.alias("domainList", kDomainList.class);
		xStream.addImplicitCollection(kDomainList.class, "domainList");
		
		kDomainList d = new kDomainList();
		
		GetFile file = new GetFile("DomainList.xml");
		
		d = (kDomainList)xStream.fromXML(file.reader());
				
		for(int i=1;i<d.getSize();i++){
			if(d.getList().get(i).getSubDom().equals(subdom)){
				d.getList().get(i).setServer(s_name);
			}
		}
		
		String xml = xStream.toXML(d);
		
		file.writer(xml);
		
	}
}
