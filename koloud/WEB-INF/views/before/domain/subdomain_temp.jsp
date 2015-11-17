<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, net.kbssm.koloud.Server.*, net.kbssm.koloud.kDomain.*" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@page import="java.util.regex.Pattern" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	String domain = session.getAttribute("domain").toString();	
// 	String domain = null;
	String subdom = (String)request.getParameter("subdom");
	String ftpdom = request.getParameter("ftpdom");
	String sshdom = request.getParameter("sshdom");

	kDomainConvert d = new kDomainConvert();
	List<kDomain> ld = d.getDomainList();	
	
	kDomain kd = new kDomain();
// 	kDomainConvert dc;

	String compare = null;
	boolean reg = true;
	if(subdom.equals(""))
		reg = false;
	else if(subdom.charAt(0) == '0' || subdom.charAt(0) == '1' || subdom.charAt(0) == '2' || subdom.charAt(0) == '3' || subdom.charAt(0) == '4' || subdom.charAt(0) == '5' || 
			subdom.charAt(0) == '6' || subdom.charAt(0) == '7' || subdom.charAt(0) == '8' || subdom.charAt(0) == '9' || subdom.charAt(0) == ' '){
				reg = false;
	}
	if(reg){
		String serReg = "^[a-zA-Z_0-9]*$";
		reg = Pattern.matches(serReg,subdom);
	}


	int checkExist = 0;
	//서브 도메인 이름 유효성 검사
	int validCheck = 0;
	for(int i=0;i<subdom.length();i++){
		if(subdom.charAt(i) == '.'){
			validCheck = 1;
		}
	}
	//점이 오면 안된다!!
	if(reg == false){
		%>
		<script type="text/javascript">
			alert("Invalid sub domain name");
			location.href="/koloud/index_second";
		</script>
		<%
	}
	//점이 오면 안된다!!
	else if(validCheck == 1){
		%>
		<script type="text/javascript">
			alert("Only enter before dot");
			location.href="/koloud/index_second";
		</script>
		<%
	}
	//tool이나 console 올 수 X
	else if(subdom.equals("tool") || subdom.equals("console")){
		checkExist = 1;
		%>
		<script type="text/javascript">
			alert("Domain cannot be 'tool' or 'console'!");
			location.href="/koloud/index_second";
		</script>
		<%
	}
	//공백 올 수 X
	else if(subdom.equals(' ')){
		%>
		<script type="text/javascript">
			alert("You have to fill ALL tabs");
			location.href="/koloud/index_second";
 		</script>
		<%
		
	}
	//적절한 서브 도메인임 -> 등록 궈궈
	else{
		int flag = 0;
		for(int i=0;i<domain.length();i++){
			if(flag == 0 && domain.charAt(i) == '.'){
				flag = 1;
			}
			if(flag == 1){
				subdom += domain.charAt(i);
			} 
		}
		System.out.println(subdom);
		
		for(int i=1;i<ld.size();i++){
			if(ld.get(i).getSubDom().equals(subdom)){
				checkExist = 1;
				%>
				<script type="text/javascript">
					alert("Already Exist!");
					location.href="/koloud/index_second";
				</script>
				<%
			}
		}
		if(checkExist != 1){
			kDomainConvert dc = new kDomainConvert(domain, ftpdom, sshdom, subdom);
			if(dc.domainList() == 1){
				response.sendRedirect("/koloud/index_second");
			}
			else{
				%>
				<script type="text/javascript">
					alert("Create error");
					location.href="/koloud/index_second";
		 		</script>
				<%
			}
		}
	}
%>


</body>
</html>