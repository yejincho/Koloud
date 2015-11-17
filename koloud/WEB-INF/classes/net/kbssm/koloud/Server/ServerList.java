package net.kbssm.koloud.Server;

import java.util.ArrayList;
import java.util.List;

public class ServerList {

	private List<Server> serverList;
	
	public ServerList(){
		serverList = new ArrayList<Server>();
	}
	
	public void add(Server server){
		serverList.add(server);
	}
	
	public int getSize(){
		return serverList.size();
	}
	
	public List<Server> getList(){
		return serverList;
	}
	
	public Server getElement(int index){
		return serverList.get(index);
	}

}
