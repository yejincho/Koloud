<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="net.kbssm.koloud.kDomain.*, net.kbssm.koloud.network.*"%>
<%@page import="java.security.DomainCombiner"%>
<%@page import="java.sql.Timestamp"%>
<%@ page import="net.kbssm.koloud.User.*, net.kbssm.koloud.Server.*, net.kbssm.koloud.OS.*" %>
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
	request.setCharacterEncoding("utf-8");
	String permission = request.getParameter("btn-permission");
	String reason = request.getParameter("btn-reason");
	String real_reason = request.getParameter("reason");
	String email = request.getParameter("email");
	String name = request.getParameter("name");
	String s_id = request.getParameter("id");
	
	int id = Integer.parseInt(s_id);
	int index = Integer.parseInt(request.getParameter("index").toString());
	Timestamp time = new Timestamp(System.currentTimeMillis());
	
	CreateOS c = new CreateOS();
	String ip = c.ip();
	
	ServerConvert sv = new ServerConvert();
	List<Server> ls = sv.getServerList();

	UserConvert uc = new UserConvert();
	List<User> lu = uc.getUserList();
	
	kDomainConvert dc = new kDomainConvert();
	List<kDomain> ld = dc.getDomainList();
	String username = "";
	for(int i=0;i<lu.size();i++){
		if(lu.get(i).getEmail().equals(email)){
			username = lu.get(i).getName();
		}
	}

	if(permission != null){
		if(permission.equals("accept") && reason == null){
			%>
			<script type="text/javascript">
				alert("Accepted!");
				var win = window.open("/koloud/create_server","smallwin","width=400, height=350, status=yes,resizable=yes");
			</script>
			<%
			
			int ram = sv.getServerList().get(index).getRam();
			String os = sv.getServerList().get(index).getOs();
			int cpu = sv.getServerList().get(index).getCpu();
			String s_name = sv.getServerList().get(index).getName();
			int disk = sv.getServerList().get(index).getDisk();

			
			//send email - request accept
			SendEmail sendMail = new SendEmail();
			sendMail.defType(username,email,"requestAccept");
			
			//in New Window
			CreateOS create = new CreateOS();
			int error = create.creste_os(ram, os, cpu, s_name,disk);
			if(error == 1){
				sv.updateServerList(index, 2, "2"); //permission change
				sv.setTime(index, time); // setting server created time
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
		
		if(permission.equals("cancel")){
			%>
			<script>
				location.href="/koloud/reason?email=<%=email%>&id=<%=id %>&index=<%=index%>&permission=<%=permission%>";
			</script>
			<%
		}
		
		if(permission.equals("deny")){
			%>
			<script>
				location.href="/koloud/reason?email=<%=email%>&id=<%=id %>&index=<%=index%>&permission=<%=permission%>";
			</script>
			<%
		}
			
	}
	if(reason != null){
		if(reason.equals("send-cancel")){ //accepted cancel
			String password = lu.get(0).getSysPassword();
			
			sv.updateServerList(index, 2, "4");
			sv.updateServerList(index, 3, real_reason);
			sv.remove(index);
			
			String subdom = "";
			String s_name = ls.get(index).getName();
			
			//search sub domain
			for(int i=1;i<ld.size();i++){
				if(ld.get(i).getServer().equals(s_name))
					subdom = ld.get(i).getSubDom();
			}

			System.out.println("servername : "+s_name);
			System.out.println("subdomain : "+subdom);
			
			//proxy disconnect
			if(subdom != ""){
				String cut_domain = "";
				for(int i=0;;i++){
					if(subdom.charAt(i) == '.')
						break;
					else
						cut_domain += subdom.charAt(i);
				}
				System.out.println("servername : "+s_name);
				System.out.println("subdomain : "+subdom);
				System.out.println("cutdomain : "+cut_domain);
				DomainController domControl = new DomainController();
				domControl.deleteDomainToHaproxy(cut_domain);
				//domain return setting					
				dc.updateDomainList(subdom, "");
				
				sv.updateServerList(index, 6, "");
			}
			
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
			
			SendEmail sendMail = new SendEmail();
			sendMail.defType(username,email,"requestCancled");
			
			%>
			<script type="text/javascript">
				alert("서버가 삭제됩니다!");
				location.href = "/koloud/tables";
			</script>
			<%
			
		}
		else if(reason.equals("send-deny")){ //permission deny
			sv.updateServerList(index, 2, "3");
			sv.updateServerList(index, 3, real_reason);

			//send email - request deny
			SendEmail sendMail = new SendEmail();
			sendMail.defType(username,email,"requestDeny");
			
			response.sendRedirect("/koloud/request");
			
		}
		else{ //back
			response.sendRedirect("/koloud/request");
			sv.updateServerList(index, 3, reason);
		}
	}
%>
</body>
</html>