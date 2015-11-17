package net.kbssm.koloud.Resource;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import net.kbssm.koloud.xstream.GetFile;

import com.thoughtworks.xstream.XStream;

public class ResourceConvert {

	
	public ResourceConvert() {
		super();
	}

	public void resourceList(int id, String s_name, long disk, int cpu, long ram, String reason, String permission, Timestamp time) throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("resource", Resource.class);
		xStream.alias("resourceList", ResourceList.class);
		xStream.addImplicitCollection(ResourceList.class, "resourceList");
		
		ResourceList r = new ResourceList();
		
		GetFile file = new GetFile("ResourceList.xml");
		
		r = (ResourceList)xStream.fromXML(file.reader());
		
		r.add(new Resource(r.getSize()+1,id,s_name,disk,cpu,ram,reason,permission,time));
		
		String xml = xStream.toXML(r);
		
		file.writer(xml);
		
	}
	
	public List<Resource> getResourceList() throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("resource", Resource.class);
		xStream.alias("resourceList", ResourceList.class);
		xStream.addImplicitCollection(ResourceList.class, "resourceList");
		
		ResourceList r = new ResourceList();
		
		GetFile file = new GetFile("ResourceList.xml");
		
		r = (ResourceList)xStream.fromXML(file.reader());
		
		List<Resource> lr = new ArrayList<Resource>();
		
		for(int i=0;i<r.getSize();i++){
			lr.add(r.getElement(i));				
		}
	
		return lr;
	}
	
	public void updateResourceList(int field, int index, String value) throws IOException{ //domain delete
		XStream xStream = new XStream();
		
		xStream.alias("resource", Resource.class);
		xStream.alias("resourceList", ResourceList.class);
		xStream.addImplicitCollection(ResourceList.class, "resourceList");
		
		ResourceList r = new ResourceList();
		
		GetFile file = new GetFile("ResourceList.xml");
		
		r = (ResourceList)xStream.fromXML(file.reader());
		
//		System.out.println(s_name);
		for(int i=0;i<r.getSize();i++){
			if(i == index){
				if(field == 1){ //change permission
					r.getList().get(i).setPermission(value);
				}
				else if(field == 2){ //change reason
					r.getList().get(i).setReason(value);
				}
			}
		}
		
		String xml = xStream.toXML(r);
		
		file.writer(xml);
		
	}
}
