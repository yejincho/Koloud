package net.kbssm.koloud.Virtual;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.libvirt.Connect;
import org.libvirt.Domain;
import org.libvirt.LibvirtException;
import org.libvirt.Network;
import org.libvirt.StoragePool;
import org.libvirt.StorageVol;

import net.kbssm.koloud.Server.Server;
import net.kbssm.koloud.Server.ServerList;
import net.kbssm.koloud.xstream.GetFile;

import com.thoughtworks.xstream.XStream;

public class VirtualConvert {
	
	private String os;
	private String name;
	private String ser_id;
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

	public VirtualConvert() {
		super();
		// TODO Auto-generated constructor stub
	}

	public VirtualConvert(int id){
		this.id = id;
	}

	public VirtualConvert(String name){
		this.name = name;
	}
	
	public VirtualConvert(int ram, String os, int cpu, String name){
		this.alloc1 = ram;
		this.os = os;
		this.vCpu = cpu;
		this.name = name;
	}
	public VirtualConvert(String name, String ser_id, long maxMemory,
			long memory, int status, long alloc1, long alloc2, long available,
			long capacity1, long capacity2, int vCpu, int id) {
		this.name = name;
		this.ser_id = ser_id;
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

	public void saveInfo(String s_name) throws IOException {
		Connect conn = null;        
		try{
            conn = new Connect("qemu:///system", true);

		}catch (LibvirtException e) {
            System.out.println("exception caught:"+e);
            System.out.println(e.getError());
        }
		try{
			Domain domain = conn.domainLookupByName(s_name);
			StoragePool strPool = conn.storagePoolLookupByName("default");
			StorageVol testStVol = conn.storageVolLookupByPath("/var/lib/libvirt/images/" + s_name + ".img");
			
			Network network = conn.networkLookupByName("default");
			System.out.println(strPool.getInfo().state);
			System.out.println(domain.getInfo().state);
			System.out.println(network.getConnect().isConnected());		
			System.out.println(domain.getInfo().state);		
			
			
//			name = domain.getName();
			maxMemory = domain.getMaxMemory();
			memory = domain.getInfo().memory;
//			vCpu = domain.getInfo().nrVirtCpu; 
			ser_id = domain.getUUIDString();
			status = domain.isActive();
			
//			alloc1 = strPool.getInfo().allocation;
			available = strPool.getInfo().available;
			capacity1 = strPool.getInfo().capacity;
			
			alloc2 = testStVol.getInfo().allocation;
			capacity2 = testStVol.getInfo().capacity;
			
		}catch (LibvirtException e) {
            System.out.println("exception caught:"+e);
            System.out.println(e.getError());
        }
//		virtualList();
	}
	
	public void virtualList() throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("virtual", Virtual.class);
		xStream.alias("virtualList", VirtualList.class);
		xStream.addImplicitCollection(VirtualList.class, "virtualList");
		
		VirtualList v = new VirtualList();
		
		GetFile file = new GetFile("VirtualList.xml");
		
		v = (VirtualList) xStream.fromXML(file.reader());
		
		String server = null;
	
		v.add(new Virtual(os,name,ser_id,server,maxMemory,memory,status,
					alloc1,alloc2,available,capacity1,capacity2,vCpu,id));
		
		for(int i=0;i<v.getSize();i++){
			if(v.getList().get(i).getName().equals(name)){
				v.getList().get(i).setAvailable(available);
				v.getList().get(i).setCapacity1(capacity1);
				v.getList().get(i).setCapacity2(capacity2);
				v.getList().get(i).setMemory(memory);
			}
		}
		
		String xml = xStream.toXML(v);
		
		file.writer(xml);
		
	}
	 
	public List<Virtual> getVirtualList(int id) throws IOException{
		XStream xStream = new XStream();
		xStream.alias("virtual",Virtual.class);
		xStream.alias("virtualList",VirtualList.class);
		xStream.addImplicitCollection(VirtualList.class, "virtualList");
		
		List<Virtual> ls = new ArrayList<Virtual>();
		
		VirtualList sl = new VirtualList();
		
		GetFile file = new GetFile("VirtualList.xml");
		
		sl = (VirtualList)xStream.fromXML(file.reader());

		for(int i=0;i<sl.getSize();i++){
			if(sl.getList().get(i).getId() == id){
				ls.add(sl.getElement(i));				
			}
		}
	
		return ls;
	}
	
	public List<Virtual> getVirtualList() throws IOException{
		XStream xStream = new XStream();
		xStream.alias("virtual",Virtual.class);
		xStream.alias("virtualList",VirtualList.class);
		xStream.addImplicitCollection(VirtualList.class, "virtualList");
		
		List<Virtual> ls = new ArrayList<Virtual>();
		
		VirtualList sl = new VirtualList();
		
		GetFile file = new GetFile("VirtualList.xml");
		
		sl = (VirtualList)xStream.fromXML(file.reader());

		for(int i=0;i<sl.getSize();i++){
			ls.add(sl.getElement(i));				
		}
	
		return ls;
	}
	
	public void updateVirtualList(int index, int field, String data) throws IOException{
		XStream xStream = new XStream();
		xStream.alias("virtual",Virtual.class);
		xStream.alias("virtualList",VirtualList.class);
		xStream.addImplicitCollection(VirtualList.class, "virtualList");
		
		VirtualList sl = new VirtualList();
		
		GetFile file = new GetFile("VirtualList.xml");
		
		sl = (VirtualList)xStream.fromXML(file.reader());

		for(int i=0;i<sl.getSize();i++){
			if(i==index){
				if(field == 1) //server change
					sl.getList().get(i).setServer(data);
			}
		}
	
		String xml = xStream.toXML(sl);
		
		file.writer(xml);
	}
}
