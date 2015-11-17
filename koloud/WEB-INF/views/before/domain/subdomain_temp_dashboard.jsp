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
	kDomainConvert dc = new kDomainConvert();	
	List<kDomain> ld = dc.getDomainList();
	
	String subdom = (String)request.getParameter("subdom");
	String domain = ld.get(0).getDomain();
	String ftpdom = ld.get(0).getFtpDom();
	String sshdom = ld.get(0).getSshDom();
	
	System.out.println("subdom " + subdom);
	int checkExist = 0;
	
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
			location.href="/koloud/DNS_setting";
		</script>
		<%
	}
	else if(validCheck == 1){
		%>
		<script type="text/javascript">
			alert("Only enter before dot");
			location.href="/koloud/DNS_setting";
		</script>
		<%
	}
	//tool이나 console 올 수 X
	else if(subdom.equals("tool") || subdom.equals("console")){
		checkExist = 1;
		%>
		<script type="text/javascript">
			alert("Domain cannot be 'tool' or 'console'!");
			location.href="/koloud/DNS_setting";
		</script>
		<%
	}
	else{
		String fullSub = subdom;
		int flag = 0;
		for(int i=0;i<domain.length();i++){
			if(domain.charAt(i) == '.'){
				flag = 1;
			}			
			if(flag == 1){
				fullSub += domain.charAt(i);
			}
		}
		for(int i=1;i<ld.size();i++){
			if(ld.get(i).getSubDom().equals(fullSub)){
				checkExist = 1;
				%>
				<script type="text/javascript">
					alert("Already Exist!");
					location.href="/koloud/DNS_setting";
				</script>
				<%
			}
		}
		if(checkExist != 1){

			
			kDomainConvert newDC = new kDomainConvert(domain, ftpdom, sshdom, fullSub);
			if(newDC.domainList() == 1){ 
				response.sendRedirect("/koloud/DNS_setting");
			}
			else{
				%>
				<script type="text/javascript">
		 			alert("Create error"); 
		 			location.href="/koloud/DNS_setting"; 
		  		</script> 
				<%
			}
		}
	}
%>


</body>
</html>