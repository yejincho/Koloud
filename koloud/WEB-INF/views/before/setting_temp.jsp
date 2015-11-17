<%@page import="net.kbssm.koloud.Virtual.*, net.kbssm.koloud.Resource.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@page import="java.sql.Timestamp"%>
<%@ page import="net.kbssm.koloud.User.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	//TODO UPDATE INSTANCE
	int cpu = Integer.parseInt(request.getParameter("cpu"));
	long allocDisk = Long.parseLong(request.getParameter("allocDisk"));
	long ram = Integer.parseInt(request.getParameter("ram"))*1024;
	String s_name = request.getParameter("s_name");
	int index = Integer.parseInt(request.getParameter("index"));
	int temp = Integer.parseInt(request.getParameter("disk"));
	long kbTogb = 1024*1024*1024;
	long disk = temp * kbTogb;
	Timestamp time = new Timestamp(System.currentTimeMillis());
	
	String s_id = request.getParameter("id");
	int id = Integer.parseInt(s_id);

	ResourceConvert resource = new ResourceConvert();
	String reason = "";
	String permission = "waiting";
	
	System.out.println("dd");
	System.out.println(allocDisk / kbTogb);
	System.out.println(disk / kbTogb);
	if(allocDisk / kbTogb <= disk / kbTogb)
		resource.resourceList(id, s_name, disk, cpu, ram, reason, permission,time);
	else{
		%>
		<script type="text/javascript">
			alert("디스크는 현재 할당량 보다 커야합니다.");
			location.href="/koloud/tables_Setting";
		</script>
		<%
	}
	
%>
<script type = "text/javascript">
	alert("Request Success!");
	location.href = "/koloud/tables_Setting";
</script>
</body>
</html>