package net.kbssm.koloud.User;

import java.util.ArrayList;
import java.util.List;

import net.kbssm.koloud.Server.Server;

public class UserList {

	private List<User> userList;
	
	public UserList(){
		userList = new ArrayList<User>();
	}
	
	public void add(User user){
		userList.add(user);
	}
	
	public int getSize(){
		return userList.size();
	}
	
	public List<User> getList(){
		return userList;		
	}
	
	public User getElement(int index){
		return userList.get(index);
	}
}
