<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.io.*, net.kbssm.koloud.User.UserConvert, net.kbssm.koloud.User.User"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="javax.mail.*"%>
<%@ page import="java.util.Properties" %>
<%@ page import="net.kbssm.koloud.mail.*" %>
<%@page import="java.util.regex.Pattern" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String pw = request.getParameter("password");
	String pw_check = request.getParameter("password_check");
	Timestamp time = new Timestamp(System.currentTimeMillis());
	
	boolean flag = false;
	
	//email 유효성 검사
	boolean emailCheck = true;
	String serReg = "[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+";
	emailCheck = Pattern.matches(serReg,email);
	
	
	//username 유효성 검사
	int usernameCheck = 0;
	System.out.println(name.length());
	// too long
	if(name.length() > 56)
		usernameCheck = 1;
	// null
	if(name == "")
		usernameCheck = 2;
	
	//password 유효성 검사
	int passwordCheck = 0;
	if(pw.length() > 56)
		passwordCheck = 1; // too long
	if(pw == "")
		passwordCheck = 2;
	if(emailCheck){
		UserConvert cv = new UserConvert(name, email, pw, pw_check, time);
// 		if(usernameCheck == 1 || passwordCheck == 1){
			%>
<!-- 			<script type="text/javascript"> -->
<!-- 				alert("입력값이 너무 깁니다."); -->
<!-- 				location.href="/koloud/register"; -->
<!-- 			</script> -->
			<%
// 			return;
// 		}
		if(usernameCheck == 2 || passwordCheck == 2){
			%>
			<script type="text/javascript">
				alert("입력 창을 모두 채워 주세요.");
				location.href="/koloud/register";
			</script>
			<%
			return;
		}
		if(cv.SignUp() == 0){
		    %>
		    <%
	
		//send email - register                  
		SendEmail sendMail = new SendEmail();
		sendMail.defType(name,email,"register");
	
	%>
	
	    <script type = "text/javascript">
	        alert("request success!");
	        location.href = "/koloud";
	    </script>
	    <%
		}
		else if(cv.SignUp() == 1){
		    %>
		    <script type = "text/javascript">
		        alert("이미 가입되었습니다.");
		        location.href = "/koloud/register";
		    </script>
		    <%
		
		}
		else if(cv.SignUp() == 2){
		    %>
		    <script type = "text/javascript">
		        alert("Password does not match!");
		        location.href = "/koloud/register";
		    </script>
		    <%
		}
	}
	else{
	 	%>
	    <script type = "text/javascript">
	        alert("Password does not match!");
	        location.href = "/koloud/register";
	    </script>
	    <%
	}

%>

</body>
</html>