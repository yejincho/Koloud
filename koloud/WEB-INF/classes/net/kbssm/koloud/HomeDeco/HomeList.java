package net.kbssm.koloud.HomeDeco;

import java.util.ArrayList;
import java.util.List;

public class HomeList {

	private List<Home> homeList;
	
	public HomeList(){
		homeList = new ArrayList<Home>();
	}
	
	public void add(Home home){
		homeList.add(home);
	}
	
	public int getSize(){
		return homeList.size();
	}
	
	public List<Home> getList(){
		return homeList;
	}
	
	public Home getElement(int index){
		return homeList.get(index);
	}
}
