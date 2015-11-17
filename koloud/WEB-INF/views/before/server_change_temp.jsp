<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="net.kbssm.koloud.kDomain.*"%>
<%@page import="net.kbssm.koloud.Server.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.List, java.util.ArrayList" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String server = request.getParameter("server");
	String domain = request.getParameter("domain");
	String s_name = request.getParameter("s_name");
	String port = request.getParameter("port");
	String password = request.getParameter("password");
	int index = Integer.parseInt(request.getParameter("index").toString());
	
	String cut_dom = "";
	
	for(int i=0;;i++){
		if(domain.charAt(i) == '.'){
			break;
		}
		else{
			cut_dom += domain.charAt(i);
		}
	}
// 	try{
// 		String msg = "", emsg = "";
// 		Process p = null;
		
// 		String[] cmd = {"/bin/bash","-c","echo \"dd\"| sudo -S ls"};
			
// 		p = Runtime.getRuntime().exec(cmd);
// 		p.waitFor();
		
// 		BufferedReader inOut = new BufferedReader(new InputStreamReader(p.getInputStream()));
// 	    BufferedReader inErr = new BufferedReader(new InputStreamReader (p.getErrorStream()));
	  
// 	    while ((msg = inOut.readLine()) != null)
// 	  {
// 	    System.out.println("Out = " + msg);
// 	  }
// 	    while ((emsg = inErr.readLine()) != null)
// 	  {
// 		  System.out.println("Error = "+ emsg);
// 	  }
// 	  p.destroy();
// 	}catch(Exception e) {
// 		System.out.println(e.toString());
// 	}
	
	ServerConvert sv = new ServerConvert();
	List<Server> ls = sv.getServerList();
	kDomainConvert dc = new kDomainConvert();
	List<kDomain> ld = dc.getDomainList();	
	
	sv.updateServerList(index, 5, server);
	sv.updateServerList(index, 6, domain);
	dc.updateDomainList(domain, s_name);
	
	
%>
	<script type="text/javascript">
 		alert("Server Setting is Done!");
 		window.close();
	</script>
<%-- <% response.sendRedirect("/koloud/tables");%> --%>
</body>
</html>