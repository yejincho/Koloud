package net.kbssm.koloud.Virtual;

import java.util.ArrayList;
import java.util.List;

public class VirtualList {
	
	private List<Virtual> virtualList;
	
	public VirtualList(){
		virtualList = new ArrayList<Virtual>();
	}
	
	public void add(Virtual virtual){
		virtualList.add(virtual);
	}
	
	public int getSize(){
		return virtualList.size();
	}
	
	public List<Virtual> getList(){
		return virtualList;
	}
	
	public Virtual getElement(int index){
		return virtualList.get(index);
	}
}
