package net.kbssm.koloud.User;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import net.kbssm.koloud.xstream.GetFile;

import com.thoughtworks.xstream.XStream;


public class UserConvert{
	private int id;
	private String name;
	private String email;
	private String password;
	private String password_check;
	private String sysPassword;
	private Timestamp time;
	
	public UserConvert(){
	}
	
	public UserConvert(int id){
		this.id = id;
	}

	public UserConvert(int id, String email, String password){
		this.id = id;
		this.email = email;
		this.password = password;
	}
	
	public UserConvert(String name, String password){
		this.name = name;
		this.password = password;
	}
	
	public UserConvert(String name, String email, String password,
			String password_check, Timestamp time) {
		super();
		this.name = name;
		this.email = email;
		this.password = password;
		this.password_check = password_check;
		this.time = time;
	}

	public void init_setting() throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("user",User.class);
		xStream.alias("userList",UserList.class);
		xStream.addImplicitCollection(UserList.class, "userList");
		
		UserList u = new UserList();
		
		GetFile file = new GetFile("UserList.xml");
		
		Timestamp time = new Timestamp(System.currentTimeMillis());
		
		u = (UserList)xStream.fromXML(file.reader());
			
		u.getList().get(0).setEmail(email);
		u.getList().get(0).setPassword(password);
		u.getList().get(0).setTime(time);
		
		String xml = xStream.toXML(u);
		
		file.writer(xml);
		
	}
	
	public int SignUp() throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("user",User.class);
		xStream.alias("userList",UserList.class);
		xStream.addImplicitCollection(UserList.class, "userList");
		
		UserList u = new UserList();
		
		GetFile file = new GetFile("UserList.xml");
		
		u = (UserList)xStream.fromXML(file.reader());
				
		//password check
		if(password.equals(password_check) == false)
			return 2;
		
		//email check
		boolean exist = emailCheck(u,email);
		
		if(exist){
			u.add(new User(u.getSize()+1,name, email, password,1,time));			
		
			String xml = xStream.toXML(u);
			
			file.writer(xml);
			
			return 0;
		}
		else{
			return 1;

		}
	}
	
	public boolean emailCheck(UserList u, String email){
		for(int i=0;i<u.getSize();i++){
			if(u.getList().get(i).getEmail().equals(email))
				return false;
		}
		return true;
	}
	
	public int Login() throws IOException {
		XStream xStream = new XStream();
		xStream.alias("user",User.class);
		xStream.alias("userList",UserList.class);
		xStream.addImplicitCollection(UserList.class, "userList");
		
		UserList u = new UserList();
		
		GetFile file = new GetFile("UserList.xml");
		
		u = (UserList)xStream.fromXML(file.reader());
		
		for(int i=0;i<u.getSize();i++){
			if(u.getList().get(i).getName().equals(name)){
				if(u.getList().get(i).getPassword().equals(password))
					return 1; //success
				else
					return 2; //password not correct
			}
		}
		return 0; //invalid user
	}
	
	public String getName(int id) throws IOException{
		XStream xStream = new XStream();
		xStream.alias("user",User.class);
		xStream.alias("userList",UserList.class);
		xStream.addImplicitCollection(UserList.class, "userList");
		
		UserList u = new UserList();
		
		GetFile file = new GetFile("UserList.xml");
		
		u = (UserList)xStream.fromXML(file.reader());
		
		String name = new String();
		
		for(int i=0;i<u.getSize();i++){
			if(u.getList().get(i).getId() == id){
				name = u.getList().get(i).getName();
			}
		}

		return name;
	}
	
	public String getPassword(int id) throws IOException{
		XStream xStream = new XStream();
		xStream.alias("user",User.class);
		xStream.alias("userList",UserList.class);
		xStream.addImplicitCollection(UserList.class, "userList");
		
		UserList u = new UserList();
		
		GetFile file = new GetFile("UserList.xml");
		
		u = (UserList)xStream.fromXML(file.reader());
		
		String pw = new String();
		
		for(int i=0;i<u.getSize();i++){
			if(u.getList().get(i).getId() == id){
				pw = u.getList().get(i).getPassword();
			}
		}

		return pw;
	}
	
	public int getId(String name) throws IOException{
		XStream xStream = new XStream();
		xStream.alias("user",User.class);
		xStream.alias("userList",UserList.class);
		xStream.addImplicitCollection(UserList.class, "userList");
		
		UserList u = new UserList();
		
		GetFile file = new GetFile("UserList.xml");
		
		u = (UserList)xStream.fromXML(file.reader());
		
		int id = 0;
		
		for(int i=0;i<u.getSize();i++){
			if(u.getList().get(i).getName().equals(name)){
				id = u.getList().get(i).getId();
				
			}
		}

		return id;
	}
	
	public String getEmail(int id) throws IOException{
		XStream xStream = new XStream();
		xStream.alias("user",User.class);
		xStream.alias("userList",UserList.class);
		xStream.addImplicitCollection(UserList.class, "userList");
		
		UserList u = new UserList();
		
		GetFile file = new GetFile("UserList.xml");
		
		u = (UserList)xStream.fromXML(file.reader());
		
		String email = null;
		
		for(int i=0;i<u.getSize();i++){
			if(u.getList().get(i).getId() == id){
				email = u.getList().get(i).getEmail();
				
			}
		}

		return email;
	}
		
	public int getIndex(int id) throws IOException{
		XStream xStream = new XStream();
		xStream.alias("user",User.class);
		xStream.alias("userList",UserList.class);
		xStream.addImplicitCollection(UserList.class, "userList");
		
		UserList u = new UserList();
		
		GetFile file = new GetFile("UserList.xml");
		
		u = (UserList)xStream.fromXML(file.reader());
		
		int index =0 ;
		
		for(int i=0;i<u.getSize();i++){
			if(u.getList().get(i).getId() == id){
				index = i;
				
			}
		}

		return index;
	}
	
	public int getLevel(int id) throws IOException{
		XStream xStream = new XStream();
		xStream.alias("user",User.class);
		xStream.alias("userList",UserList.class);
		xStream.addImplicitCollection(UserList.class, "userList");
		
		UserList u = new UserList();
		
		GetFile file = new GetFile("UserList.xml");
		
		u = (UserList)xStream.fromXML(file.reader());
		
		int level =0 ;
		
		for(int i=0;i<u.getSize();i++){
			if(u.getList().get(i).getId() == id){
				level = u.getList().get(i).getLevel();
				
			}
		}

		return level;
	}
	
	public List<User> getUserList(int id) throws IOException{
		XStream xStream = new XStream();
		xStream.alias("user",User.class);
		xStream.alias("userList",UserList.class);
		xStream.addImplicitCollection(UserList.class, "userList");
		
		List<User> ls = new ArrayList<User>();
		
		UserList sl = new UserList();
		
		GetFile file = new GetFile("UserList.xml");
		
		sl = (UserList)xStream.fromXML(file.reader());

		for(int i=0;i<sl.getSize();i++){
			if(sl.getList().get(i).getId() == id){
				ls.add(sl.getElement(i));				
			}
		}
	
		return ls;
	}
	
	public List<User> getUserList() throws IOException{
		XStream xStream = new XStream();
		xStream.alias("user",User.class);
		xStream.alias("userList",UserList.class);
		xStream.addImplicitCollection(UserList.class, "userList");
		
		List<User> ls = new ArrayList<User>();
		
		UserList sl = new UserList();
		
		GetFile file = new GetFile("UserList.xml");
		
		sl = (UserList)xStream.fromXML(file.reader());

		for(int i=0;i<sl.getSize();i++){
			ls.add(sl.getElement(i));				
		}
	
		return ls;
	}
		
	public void updateUserList(int id, String name, String password) throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("user", User.class);
		xStream.alias("userList", UserList.class);
		xStream.addImplicitCollection(UserList.class, "userList");
			
		UserList s = new UserList();
		
		GetFile file = new GetFile("UserList.xml");
		
		s = (UserList)xStream.fromXML(file.reader());
		
		for(int i=0;i<s.getSize();i++){
			if(s.getList().get(i).getId() == id){
				s.getList().get(i).setName(name);
				s.getList().get(i).setPassword(password);
			}
		}
		String xml = xStream.toXML(s);
		
		file.writer(xml);
	}
	
	public void updateUserList(String name, String password) throws IOException{ //koloud password change
		XStream xStream = new XStream();
		
		xStream.alias("user", User.class);
		xStream.alias("userList", UserList.class);
		xStream.addImplicitCollection(UserList.class, "userList");
			
		UserList s = new UserList();
		
		GetFile file = new GetFile("UserList.xml");
		
		s = (UserList)xStream.fromXML(file.reader());
		
		for(int i=0;i<s.getSize();i++){
			if(s.getList().get(i).getName().equals(name)){
					s.getList().get(i).setPassword(password);
			}
		}
		String xml = xStream.toXML(s);
		
		file.writer(xml);
	}
	
	public void updateVisitCnt() throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("user", User.class);
		xStream.alias("userList", UserList.class);
		xStream.addImplicitCollection(UserList.class, "userList");
			
		UserList s = new UserList();
		
		GetFile file = new GetFile("UserList.xml");
		
		s = (UserList)xStream.fromXML(file.reader());
		
		s.getList().get(0).setVisitCnt(s.getList().get(0).getVisitCnt()+1);
		
		String xml = xStream.toXML(s);
		
		file.writer(xml);
	}
}