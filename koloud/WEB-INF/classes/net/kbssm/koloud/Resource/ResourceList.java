package net.kbssm.koloud.Resource;

import java.util.ArrayList;
import java.util.List;

public class ResourceList {

	private List<Resource> resourceList;
	
	public ResourceList(){
		resourceList = new ArrayList<Resource>();
		
	}
	
	public void add(Resource resource){
		resourceList.add(resource);
	}
	
	public int getSize(){
		return resourceList.size();
	}
	
	public List<Resource> getList(){
		return resourceList;
	}
	
	public Resource getElement(int index){
		return resourceList.get(index);
	}
	
}
