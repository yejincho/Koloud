<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.security.SecureRandom, java.util.Random"%>
<%@ page import="javax.mail.*"%>
<%@ page import="java.util.Properties" %>
<%@ page import="net.kbssm.koloud.mail.*, net.kbssm.koloud.User.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String user = request.getParameter("user");
	String email = request.getParameter("email");
	
	System.out.println(user + "   " + email);
	
	//send email - find password
	SendEmail sendMail = new SendEmail();
	sendMail.defType(user, email, "changePw");
	
	%>
	<script type="text/javascript">
		alert("Password Sended Email\n Check your Email now!");
	</script>
	<%
	response.sendRedirect("/koloud/");
%>
	
</body>
</html>