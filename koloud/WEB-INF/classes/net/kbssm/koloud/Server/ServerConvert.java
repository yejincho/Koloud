package net.kbssm.koloud.Server;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.libvirt.Connect;
import org.libvirt.Domain;
import org.libvirt.LibvirtException;
import org.libvirt.StoragePool;
import org.libvirt.StorageVol;

import net.kbssm.koloud.OS.CreateOS;
import net.kbssm.koloud.Virtual.Virtual;
import net.kbssm.koloud.Virtual.VirtualList;
import net.kbssm.koloud.xstream.GetFile;

import com.thoughtworks.xstream.XStream;

public class ServerConvert{
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
	private int permission;
	private String reason;
	private Timestamp time;
	
	public ServerConvert(){
	}
	
	public ServerConvert(int id){
		this.id = id;
	}
	
	public ServerConvert(String ip, String name, int ram, int cpu, int disk, String os, int id, int permission){
		this.ip = ip;
		this.name = name;
		this.os = os;
		this.ram = ram;
		this.cpu = cpu;
		this.disk = disk;
		this.id = id;
		this.permission = permission;
	}
	
	public ServerConvert(String ip, String name, int ram, int cpu, int disk, String os, int id, int permission, Timestamp time){
		this.ip = ip;
		this.name = name;
		this.os = os;
		this.ram = ram;
		this.cpu = cpu;
		this.disk = disk;
		this.id = id;
		this.permission = permission;
		this.time = time;
	}
	
	public int serverList() throws IOException {
		XStream xStream = new XStream();
		
		xStream.alias("server", Server.class);
		xStream.alias("serverList", ServerList.class);
		xStream.addImplicitCollection(ServerList.class, "serverList");
			
		ServerList s = new ServerList();
		
		GetFile file = new GetFile("ServerList.xml");
				
		s = (ServerList)xStream.fromXML(file.reader());

		v_ip = "";
		ser_id = "";
		domain = "";
		password = "make-random-function";
		status = "stop";
		server = "";
		 
		s.add(new Server(ip,v_ip,name,ser_id,os,domain,
				ram,cpu,disk,server,password,status,id,permission,null,time));
		
		String xml = xStream.toXML(s);
		
		file.writer(xml);
		
		return 1;
	}
	
	public List<Server> getServerList(int id) throws IOException{
		XStream xStream = new XStream();
		xStream.alias("server",Server.class);
		xStream.alias("serverList",ServerList.class);
		xStream.addImplicitCollection(ServerList.class, "serverList");
		
		List<Server> ls = new ArrayList<Server>();
		
		ServerList sl = new ServerList();
		
		GetFile file = new GetFile("ServerList.xml");
		
		sl = (ServerList)xStream.fromXML(file.reader());

		for(int i=0;i<sl.getSize();i++){
			if(sl.getList().get(i).getId() == id){
				ls.add(sl.getElement(i));				
			}
		}
	
		return ls;
	}
	
	public List<Server> getServerList() throws IOException{
		XStream xStream = new XStream();
		xStream.alias("server",Server.class);
		xStream.alias("serverList",ServerList.class);
		xStream.addImplicitCollection(ServerList.class, "serverList");
		
		List<Server> ls = new ArrayList<Server>();
		
		ServerList sl = new ServerList();
		
		GetFile file = new GetFile("ServerList.xml");
		
		sl = (ServerList)xStream.fromXML(file.reader());

		for(int i=0;i<sl.getSize();i++){
			ls.add(sl.getElement(i));				
			
		}
	
		return ls;
	}
		
	public void updateServerList(int index, int field, String value) throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("server", Server.class);
		xStream.alias("serverList", ServerList.class);
		xStream.addImplicitCollection(ServerList.class, "serverList");
			
		ServerList s = new ServerList();
		
		GetFile file = new GetFile("ServerList.xml");
		
		s = (ServerList)xStream.fromXML(file.reader());
		
		for(int i=0;i<s.getSize();i++){
			if(i == index){
				if(field == 1){ //status change
					s.getList().get(i).setStatus(value);
				}
				else if(field == 2){ //permission change
					s.getList().get(i).setPermission(Integer.parseInt(value));
				}
				else if(field == 3){ //reason change
					s.getList().get(i).setReason(value);
				}
				else if(field == 4){ //domain change
					s.getList().get(i).setDomain(value);
				}
				else if(field == 5){ //server change
					s.getList().get(i).setServer(value);
				}
				else if(field == 6){ //domain change
					s.getList().get(i).setDomain(value);
				}
			}
		}
		
		String xml = xStream.toXML(s);
		
		file.writer(xml);
	}
	
	public void updateResources(int index, int cpu, long received_disk, int ram) throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("server", Server.class);
		xStream.alias("serverList", ServerList.class);
		xStream.addImplicitCollection(ServerList.class, "serverList");
			
		ServerList s = new ServerList();
		
		GetFile file = new GetFile("ServerList.xml");
		
		s = (ServerList)xStream.fromXML(file.reader());
		
		int disk = (int)received_disk;
		
		for(int i=0;i<s.getSize();i++){
			if(i == index){
				s.getList().get(i).setCpu(cpu);
				s.getList().get(i).setRam(ram);
				s.getList().get(i).setDisk(disk);
			}
		}
		
		String xml = xStream.toXML(s);
		
		file.writer(xml);
	}
	
	public void setTime(int index, Timestamp time) throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("server", Server.class);
		xStream.alias("serverList", ServerList.class);
		xStream.addImplicitCollection(ServerList.class, "serverList");
			
		ServerList s = new ServerList();
		
		GetFile file = new GetFile("ServerList.xml");
		
		s = (ServerList)xStream.fromXML(file.reader());
		
		for(int i=0;i<s.getSize();i++){
			if(i == index){
				s.getList().get(i).setTime(time);
			}
		}
		
		String xml = xStream.toXML(s);
		
		file.writer(xml);
	}

	public void remove(int index) throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("server", Server.class);
		xStream.alias("serverList", ServerList.class);
		xStream.addImplicitCollection(ServerList.class, "serverList");
			
		ServerList s = new ServerList();
		
		GetFile file = new GetFile("ServerList.xml");
		
		s = (ServerList)xStream.fromXML(file.reader());
		
		for(int i=0;i<s.getSize();i++){
			if(i == index){
				s.getList().remove(i);
			}
		}
		
		String xml = xStream.toXML(s);
		
		file.writer(xml);
	}
}
