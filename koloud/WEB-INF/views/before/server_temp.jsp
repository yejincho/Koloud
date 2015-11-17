<%@page import="java.sql.Timestamp"%>
<%@page import="java.net.InetAddress"%>
<%@page import="net.kbssm.koloud.Server.*"%>
<%@page import="net.kbssm.koloud.OS.*"%>
<%@page import="java.io.*"%>
<%@page import="net.kbssm.koloud.User.*"%>
<%@page import="java.util.regex.Pattern" %>
<%@ page import="java.util.List, java.util.ArrayList" %>

<%
	request.setCharacterEncoding("UTF-8");
	String s_ram = request.getParameter("ram");
	String os = request.getParameter("os");
	String s_cpu = request.getParameter("cpu");
	String s_disk = request.getParameter("disk");
	String s_name = request.getParameter("s_name");
	String s_id = request.getParameter("id");
	
	int ram = Integer.parseInt(s_ram);
	int cpu = Integer.parseInt(s_cpu);
	int disk = Integer.parseInt(s_disk);
	int id = Integer.parseInt(s_id);
	
	ServerConvert sc = new ServerConvert();
	List<Server> ls = sc.getServerList();
	
	CreateOS c = new CreateOS();
	String ip = c.ip();
	
	Timestamp time = new Timestamp(System.currentTimeMillis());
	// mailing
	%>
	making server .... Please wait ...
	<%
	
	//server name Check!!!
	boolean reg = true;
	//not permitted start with number
	if(s_name.equals(""))
		reg = false;
	else if(s_name.charAt(0) == '0' || s_name.charAt(0) == '1' || s_name.charAt(0) == '2' || s_name.charAt(0) == '3' || s_name.charAt(0) == '4' || s_name.charAt(0) == '5' || 
	s_name.charAt(0) == '6' || s_name.charAt(0) == '7' || s_name.charAt(0) == '8' || s_name.charAt(0) == '9' || s_name.charAt(0) == ' ')
		reg = false;
	if(reg){
		String serReg = "^[a-zA-Z_0-9]*$";
		reg = Pattern.matches(serReg,s_name);
	}
	
	for(int i=0;i<ls.size();i++){
		if(ls.get(i).getName().equals(s_name))
			reg = false;
	}
	
	if(reg){
	
	 	//create virtual server
	 	CreateOS create = new CreateOS();
	 	int error = create.creste_os(ram, os, cpu, s_name,disk); //create directly(admin)
	 	
	 	
	 	if(error == 1){
	 	 	ServerConvert scd = new ServerConvert(ip,s_name,ram,cpu,disk,os,id,2,time);
	 	 	scd.serverList();
	 		%>
	 		<script type="text/javascript">
 	 			alert("Build Success!");
 	 			window.close();
 	 		</script> 
	 		<%
	 	}else{
	 		%>
	 		<script type="text/javascript">
				alert("Build Error!");
				window.close();
			</script>
			<%
	 	}

	}
	else{
		%>
 		<script type="text/javascript">
			alert("Improper Server Name!");
			window.close();
		</script>
		<%
	}
	
%>
</body>
</html>