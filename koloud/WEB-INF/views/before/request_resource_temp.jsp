<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.kbssm.koloud.User.*, net.kbssm.koloud.Server.*, net.kbssm.koloud.Resource.*, net.kbssm.koloud.OS.*" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="net.kbssm.koloud.mail.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String permission = request.getParameter("btn-permission");
	String reason = request.getParameter("btn-reason");
	String real_reason = request.getParameter("reason");
	String email = request.getParameter("email");
	String name = request.getParameter("name");
	String s_disk = request.getParameter("disk");
	String s_cpu = request.getParameter("cpu");
	String s_ram = request.getParameter("ram");
	String servername = request.getParameter("servername");
	int index = Integer.parseInt(request.getParameter("index").toString());
	int index_resource = Integer.parseInt(request.getParameter("index_resource").toString());
	Timestamp time = new Timestamp(System.currentTimeMillis());
	
	ServerConvert sv = new ServerConvert();
	List<Server> ls = sv.getServerList();

	ResourceConvert rc = new ResourceConvert();
	List<Resource> lr = rc.getResourceList();
	
	UserConvert uc = new UserConvert();
	List<User> lu = uc.getUserList();
	
	String username = "";
	for(int i=0;i<lu.size();i++){
		if(lu.get(i).getEmail().equals(email)){
			username = lu.get(i).getName();
		}
	}
	
//	setting permission
	if(permission != null){
		if(permission.equals("accept") && reason == null){
			long disk = Long.parseLong(s_disk);
			long kbTogb = 1024*1024*1024;
			int cpu = Integer.parseInt(s_cpu);
			long ram = Long.parseLong(s_ram);
			String n_permission = "accepted";
			rc.updateResourceList(1,index_resource,n_permission);
			sv.updateResources(index,cpu,disk/kbTogb,(int)ram/1024);			
			%>
			<script type="text/javascript">
				alert("Accepted!");
			</script>
			<%
			//send email - accept request
			System.out.println("email : "+email);
			System.out.println("username : "+username);
			SendEmail sendMail = new SendEmail();
			sendMail.defType(username,email,"requestAccept");
			
			//make Virtual OS
			//new window
			
			//이따 처리
			CreateOS create = new CreateOS();
			create.setResources(servername,disk,cpu,ram);
			
			response.sendRedirect("/koloud/request_resources");
			return;
			
		}
		
		if(permission.equals("deny")){%>
			<script>
				location.href="/koloud/reason_resource?s_name=<%=servername%>&index_resource=<%=index_resource%>&permission=<%=permission%>"; 
			</script>
			<%
		}
			
	}
	if(reason != null){
		if(reason.equals("cancel")){ //accepted cancel
			rc.updateResourceList(1, index_resource, "waiting");
			response.sendRedirect("/koloud/request_resources");
		}
		else if(reason.equals("send-deny")){ //permission deny
			rc.updateResourceList(1, index_resource, "denied");
			rc.updateResourceList(2, index_resource, real_reason);
			
			//send email - accept deny
			SendEmail sendMail = new SendEmail();
			sendMail.defType(username,email,"requestDeny");
			
			response.sendRedirect("/koloud/request_resources");
		}
			
	}
%>
</body>
</html>