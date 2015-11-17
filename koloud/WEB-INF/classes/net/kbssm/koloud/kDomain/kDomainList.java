package net.kbssm.koloud.kDomain;

import java.util.ArrayList;
import java.util.List;

public class kDomainList {
	

	private List<kDomain> domainList;
	
	public kDomainList(){
		domainList = new ArrayList<kDomain>();
		
	}
	
	public void add(kDomain domain){
		domainList.add(domain);
	}
	
	public int getSize(){
		return domainList.size();
	}
	
	public List<kDomain> getList(){
		return domainList;
	}
	
	public kDomain getElement(int index){
		return domainList.get(index);
	}
	
}
