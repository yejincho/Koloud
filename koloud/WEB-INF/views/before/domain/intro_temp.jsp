<%@page import="net.kbssm.koloud.kDomain.*"%>
<%@page import="net.kbssm.koloud.User.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, net.kbssm.koloud.Server.*" %>
<%@page import="java.util.regex.Pattern" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	
	String step = request.getParameter("step");

	ServerList sl = new ServerList();
	ServerConvert sc = new ServerConvert();
	
	kDomainConvert dc = new kDomainConvert();
	
	if(step.equals("step1")){
		//todo domain check
 		String domain = request.getParameter("domain");
	
		// Check Domain Invalid
		boolean www = false;
		boolean dot = false;
		int dotCnt = 0;
		
		for(int i=0;i<domain.length();i++){
			if(domain.charAt(i) == '.'){
				dotCnt++;
			}
		}
		if(domain.startsWith("www."))
			www = true;
		if(dotCnt >= 2){
			dot = true;
		}
		
		if(www && dot){
			session.setAttribute("domain",domain);
			sc.updateServerList(0, 4, domain);
			dc.updateDomain(domain);
	 		response.sendRedirect("/koloud/index_second");
	 		return;
		}
		else{
			%>
			<script type="text/javascript">
				alert("Invalid Domain \nTry Again!");
				location.href="/koloud/index_first";
			</script>
			<%
		}
	}
	
	if(step.equals("step2")){
		response.sendRedirect("/koloud/index_third");
		return;
	}
	
	if(step.equals("step3")){
		String email = request.getParameter("email");
		
		String usrPw = request.getParameter("usrPw");
		String usrPwCheck = request.getParameter("usrPwCheck");
		
		boolean emailCheck = true;
		String serReg = "[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+";
		emailCheck = Pattern.matches(serReg,email);
		
		if(emailCheck){
			if(usrPw.equals("admin")){ //pw admin
				%>
				<script type="text/javascript">
					alert("password cannot be 'admin'");
					location.href="index_third";
				</script>
				<%
			}
			else if(usrPw.equals("")){ //null
				%>
				<script type="text/javascript">
					alert("Fill password!");
					location.href="index_third";
				</script>
				<%
			}
			else if(usrPw.equals(usrPwCheck)){
				UserConvert uc = new UserConvert(1, email, usrPw);
				uc.init_setting();
				response.sendRedirect("/koloud/");
			}
			
			else{ //etc
				%>
				<script type="text/javascript">
					alert("retry");
					location.href="index_third";
				</script>
				<%
			}
		}
		else{
			%>
			<script type="text/javascript">
				alert("Improper Email!");
				location.href="index_third";
			</script>
			<%
		}
		
	}
%>


</body>
</html>