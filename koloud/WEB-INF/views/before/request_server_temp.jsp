<%@page import="java.sql.Timestamp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="net.kbssm.koloud.Server.*"%>
<%@page import="net.kbssm.koloud.OS.*"%>
<%@page import="java.io.*"%>
<%@ page import="java.io.*, net.kbssm.koloud.User.UserConvert, net.kbssm.koloud.User.User" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="net.kbssm.koloud.mail.*" %>
<%@page import="java.util.regex.Pattern" %>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	UserConvert ul = new UserConvert();
	List<User> lu  = ul.getUserList();
	
	
	String s_id = request.getParameter("id");
	String s_ram = request.getParameter("ram");
	String os = request.getParameter("os");
	String s_cpu = request.getParameter("cpu");
	String s_disk = request.getParameter("disk");
// 	String server = request.getParameter("server");	
	String s_name = request.getParameter("s_name");
	
	int ram = Integer.parseInt(s_ram);
	int cpu = Integer.parseInt(s_cpu);
	int disk = Integer.parseInt(s_disk);
	int id= Integer.parseInt(s_id);
	
	CreateOS c = new CreateOS();
	String ip = c.ip();

	ServerConvert sc = new ServerConvert();
	List<Server> ls = sc.getServerList();
	
	//server name Check!!!
	boolean reg = true;
	//not permitted start with number
	if(s_name == ""){
		reg = false;
	}
	else if(s_name.charAt(0) == '0' || s_name.charAt(0) == '1' || s_name.charAt(0) == '2' || s_name.charAt(0) == '3' || s_name.charAt(0) == '4' || s_name.charAt(0) == '5' || 
	s_name.charAt(0) == '6' || s_name.charAt(0) == '7' || s_name.charAt(0) == '8' || s_name.charAt(0) == '9' || s_name.charAt(0) == ' ')
		reg = false;
	System.out.println("1 : "+reg);
	if(reg){
		String serReg = "^[a-zA-Z_0-9]*$";
		reg = Pattern.matches(serReg,s_name);
		System.out.println("2 : "+reg);
	}

	for(int i=0;i<ls.size();i++){
		if(ls.get(i).getName().equals(s_name))
			reg = false;
	}
	
	if(reg){
		if(id != 1){ //guest
			ServerConvert sv = new ServerConvert(ip, s_name, ram, cpu, disk, os, id, 1); //create with waiting
			sv.serverList();
			
			//send email - request server
			SendEmail sendMail = new SendEmail();
			sendMail.defType(ul.getName(id),ul.getEmail(id),"requestServer");
			
			%>
			<script type="text/javascript">
				alert("Request sended!");
				location.href = "/koloud/all_tables";
			</script>
			<%
					
		}
	}else{
		%>
		<script type="text/javascript">
			alert("Improper Server Name!");
			location.href = "/koloud/create_server_guest";
		</script>
		<%
	}
	
%>
</body>
</html>