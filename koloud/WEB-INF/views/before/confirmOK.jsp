<%@page
	import="net.kbssm.koloud.kDomain.*, net.kbssm.koloud.ssh.*, net.kbssm.koloud.network.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="net.kbssm.koloud.Server.*, net.kbssm.koloud.User.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader"%>
<%@ include file="server_status_temp.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	int ser_index = Integer.parseInt(request.getParameter("ser_index"));
	String s_name = ls.get(ser_index).getName();
	sv.remove(ser_index);
	
	
	//domain return setting
	for(int i=1;i<ld.size();i++){
		if(ld.get(i).getServer().equals(s_name))
			subdom = ld.get(i).getSubDom();
	}
	dc.updateDomainList(subdom, "");
	
	//proxy disconnect
	String cut_domain = "";
	for(int i=0;;i++){
		if(subdom.charAt(i) == '.')
			break;
		else
			cut_domain += subdom.charAt(i);
	}
	DomainController domControl = new DomainController();
	domControl.deleteDomainToHaproxy(cut_domain);
	
	try
	{
		Process p = null;
		  String[] cmd = {"/bin/bash","-c","echo "+password+" | sudo -S sh /netsh/virshDeleteOS.sh "+s_name}; //TODO restart
		  p = Runtime.getRuntime().exec(cmd);
		  p.waitFor();
		  p.destroy();			  
		  
		  
	} catch(Exception e) {
		System.out.println(e.toString());
	}
	
	%>
	<script type="text/javascript">
		location.href="/koloud/tables";		
	</script>
%>
</body>
</html>