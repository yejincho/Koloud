<%@page import="net.kbssm.koloud.kDomain.*, net.kbssm.koloud.ssh.*, net.kbssm.koloud.network.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="net.kbssm.koloud.Server.*, net.kbssm.koloud.User.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String status = request.getParameter("status_btn");
	
	ServerConvert sv = new ServerConvert();
	List<Server> ls = sv.getServerList();
	kDomainConvert dc = new kDomainConvert();
	List<kDomain> ld = dc.getDomainList();

	String subdom = "";	
	
	UserConvert uc = new UserConvert();
	List<User> lu = uc.getUserList();
	String password = lu.get(0).getSysPassword();
	
	//status
	if(status.equals("stop")){
		int ser_index = Integer.parseInt(request.getParameter("ser_index"));
		String s_name = ls.get(ser_index).getName();
		status = "stop";
		sv.updateServerList(ser_index, 1 , status);		
		%>
			<script type="text/javascript">
				alert("������ ����ϴ�!");
				location.href = "/koloud/tables";
			</script>
	<%
		try
		{
		  Process p = null;
		  String emsg ="";
		  String msg ="";
		  String[] cmd = {"/bin/bash","-c","echo "+password+" | sudo -S sh /netsh/virshDestroy.sh "+s_name};
		  p = Runtime.getRuntime().exec(cmd);
		  p.waitFor();
		  p.destroy();
		  BufferedReader inOut =
				    new BufferedReader(new InputStreamReader(p.getInputStream()));
				  BufferedReader inErr =
				    new BufferedReader(new InputStreamReader (p.getErrorStream()));
				  while ((msg = inOut.readLine()) != null)
				  {
				    System.out.println("Out = " + msg);
				  }
				  while ((emsg = inErr.readLine()) != null)
				  {
					  if(emsg.charAt(0) == 'E' && emsg.charAt(1) == 'R' && emsg.charAt(2) == 'R' && emsg.charAt(3) == 'O' && emsg.charAt(4) == 'R'){
						  p.destroy();
					  }
//					  errormsg += emsg;
					  System.out.println("Error = "+ emsg);
				  }
				  p.destroy();
		} catch(Exception e) {
			System.out.println(e.toString());
		}
	
	}
	else if(status.equals("start")){
		int ser_index = Integer.parseInt(request.getParameter("ser_index"));
		String s_name = ls.get(ser_index).getName();
	
		status = "running";
		sv.updateServerList(ser_index, 1 , status);	
		%>
		<script type="text/javascript">
			alert("������ ���۵˴ϴ�!");
			location.href = "/koloud/tables";
		</script>
		<%
		try
		{
		  Process p = null;
		  String[] cmd = {"/bin/bash","-c","echo "+password+" | sudo -S sh /netsh/virshStart.sh "+s_name};
		  p = Runtime.getRuntime().exec(cmd);
		  p.waitFor();
		  p.destroy();
		} catch(Exception e) {
			System.out.println(e.toString());
		}
	}
	else if(status.equals("restart")){
		int ser_index = Integer.parseInt(request.getParameter("ser_index"));
		String s_name = ls.get(ser_index).getName();
		try
		{
		  Process p = null;
		  String[] cmd = {"/bin/bash","-c","echo "+password+" | sudo -S sh /netsh/virshDestroy.sh "+s_name};
		  p = Runtime.getRuntime().exec(cmd);
		  p.waitFor();
		  p.destroy();
		  Process p2 = null;
		  String[] cmd2 = {"/bin/bash","-c","echo "+password+" | sudo -S sh /netsh/virshStart.sh "+s_name};
		  p2 = Runtime.getRuntime().exec(cmd2);
		  p2.waitFor();
		  p2.destroy();
		} catch(Exception e) {
			System.out.println(e.toString());
		}
		response.sendRedirect("/koloud/tables");
	}
	else{ //DELETE
		//1. ���� �ε����� �޾ƿͼ� ���� �̸��� ã�´�.
		//2. ���� �ε����� ���� ��Ͽ��� �����Ѵ�.
		//3. �ش� �����̸��� ���굵������ �����´�.
		//4. �ش� �������� ������ null�� ����� �ش�.
		// -------> �������� ���� �� �� �ִ�.(���ܿ��ܿ��ܿ���) �ƴϾ�!! ���� ���� ����!!
		//5. ���Ͻ� ������ ���� ���굵������ �պκ��� �ڸ���.
		//6. ���� ������ �պκ��� deleteDomainProxy�� ���ڷ� �Ѱ��ش�.
		//7. kvm���� ������ �����Ѵ�.
		
		int ser_index = Integer.parseInt(request.getParameter("ser_index"));
		String s_name = ls.get(ser_index).getName();
		
		//domain return setting
		for(int i=1;i<ld.size();i++){
			if(ld.get(i).getServer().equals(s_name))
				subdom = ld.get(i).getSubDom();
		}
		
		//proxy disconnect
		if(subdom !=  ""){
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

// 	 		sv.remove(ser_index);
			dc.updateDomainList(subdom, "");
			
			sv.updateServerList(ser_index, 2, "4");
			sv.updateServerList(ser_index, 6, "");
		
			try
			{
				Process p = null;
				  String[] cmd = {"/bin/bash","-c","echo "+password+" | sudo -S sh /netsh/virshDeleteOS.sh "+s_name}; 
				  p = Runtime.getRuntime().exec(cmd);
				  p.waitFor();
				  p.destroy();			  
				  
				  
			} catch(Exception e) {
				System.out.println(e.toString());
			}			
			%>
			<script type="text/javascript">
				alert("������ �����˴ϴ�!");
				location.href = "/koloud/tables";
			</script>
			<%
		}
	}
%>
</body>
</html>