<%@page import="net.kbssm.koloud.OS.*,net.kbssm.koloud.User.*"%>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="java.io.BufferedReader, java.io.InputStreamReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.kbssm.koloud.ssh.*, net.kbssm.koloud.network.*, net.kbssm.koloud.Server.*, net.kbssm.koloud.kDomain.*" %>
<%@ page import="net.kbssm.koloud.mail.*" %>
<%@page import="java.sql.Timestamp"%>
<%
	String domain = request.getParameter("domain");
	String server = request.getParameter("server");
	String os = request.getParameter("os");
	String serverType = request.getParameter("serverType");
	String server_name = request.getParameter("server_name");
	int index = Integer.parseInt(request.getParameter("index"));
	
	UserConvert uc = new UserConvert();
	List<User> lu = uc.getUserList();
	
	kDomainConvert dc = new kDomainConvert();
	List<kDomain> ld = dc.getDomainList();
	
	String syspassword = lu.get(0).getSysPassword();
	String virtIp = "";
	
	ServerConvert sc = new ServerConvert();
	List<Server> ls = sc.getServerList();
	
	sc.updateServerList(index, 5, "temp_server");
	
	Timestamp time = new Timestamp(System.currentTimeMillis());
	sc.setTime(0, time); //ssh 중복 등록 방지
	
	//id,username 찾기
	int id = 0;
	for(int i=0;i<ls.size();i++){
		if(ls.get(i).getName().equals(server_name)){
			id = ls.get(i).getId();
		}
	}
	String username = "";
	String email = "";
	for(int i=0;i<lu.size();i++){
		if(lu.get(i).getId() == id){
			username = lu.get(i).getName();
			email = lu.get(i).getEmail();
		}
	}
	System.out.println(domain);
	
	try {
		String msg = "", emsg = "";
		Process p = null;
			String[] cmd = {"/bin/bash","-c","echo " + syspassword
							+ " | sudo -S sh /netsh/virt-addr.sh "+ server_name };
			p = Runtime.getRuntime().exec(cmd);
			p.waitFor();
			BufferedReader inOut = new BufferedReader(
					new InputStreamReader(p.getInputStream()));
			BufferedReader inErr = new BufferedReader(
					new InputStreamReader(p.getErrorStream()));
			while ((msg = inOut.readLine()) != null) {
				String a = msg;
				if (a.charAt(0) == '1'){
					virtIp = a;
				}
			}
			while ((emsg = inErr.readLine()) != null) {
				System.out.println("Error = " + emsg);
			}
			p.destroy();
	} catch (Exception e) {
		System.out.println(e.toString());
	}
	
	if(virtIp.equals("")){ 
		%>
		<script type="javascript">
			history.back();
		</script>
		<%
		return;
	}


	// subdomain null check
	int domainCheck = 1;
	for(int i=1;i<ld.size();i++){
		if(ld.get(i).getSubDom().equals(domain)){
			if(ld.get(i).getServer() != ""){
				domainCheck = 0; //server already exist
				
			}else{
				kDomainConvert dom = new kDomainConvert();
				dom.updateDomainList(domain, server_name);
			}
		}
	}
	
	//server null -> build
	if(domainCheck == 1){
		/* ssh */
		connectSSH ssh = new connectSSH();
		DomainController domControl = new DomainController();
	
	
		if(os.equals("Ubuntu")){
			String user="root";
			String password="ubuntu";
		
		    if(serverType.equals("own")){
		        ssh.connect_U_FTP_Frist(virtIp, user, password);
		        Thread.sleep(30000); // sleep 30 seconds
		         ssh.connect_U_FTP_Second(virtIp, user, password) ;
		
		    }
		    else{
		        if(server.equals("Apache")){
		            ssh.connect_U_FTP_Frist(virtIp, user, password);
		            Thread.sleep(30000); // sleep 30 seconds
		            ssh.connect_U_FTP_Second_Nodiscon(virtIp, user, password);
		            Thread.sleep(10000); // sleep 30 seconds
		            ssh.connect_U_apm_First(virtIp, user, password);
		            Thread.sleep(30000); // sleep 30 seconds
		            ssh.connect_U_apm_Second(virtIp, user, password);
		            Thread.sleep(60000); // sleep 30 seconds
		            ssh.connect_U_apm_Third(virtIp, user, password);
		            Thread.sleep(60000); // sleep 30 seconds
		            ssh.connect_U_apm_Fourth(virtIp, user, password);
		            //Thread.sleep(90000); // sleep 30 seconds
		            //ssh.connect_U_apm(virtIp, user, password);
		         }else if(server.equals("Tomcat6")){
		            ssh.connect_U_FTP_Frist(virtIp, user, password);
		            Thread.sleep(30000); // sleep 30 seconds
		             ssh.connect_U_FTP_Second_Nodiscon(virtIp, user, password) ;
		             Thread.sleep(30000); // sleep 30 seconds
		            ssh.connect_U_tomcat6(virtIp, user, password);
		         }else if(server.equals("Tomcat7")){
		            ssh.connect_U_FTP_Frist(virtIp, user, password);
		            Thread.sleep(30000); // sleep 30 seconds
		             ssh.connect_U_FTP_Second_Nodiscon(virtIp, user, password) ;
		             Thread.sleep(30000); // sleep 30 seconds
		            ssh.connect_U_tomcat7(virtIp, user, password);
		        }
		    }
		}
		else{
			String user = "root";
			String password = "centos";
			
			if(serverType.equals("own")){
				ssh.connect_C_FTP(virtIp, user, password);
			}
			else{
				if(server.equals("APM+Phpmyadmin")) 
					ssh.connect_C_apm(virtIp, user, password);
				else if(server.equals("Tomcat6"))
					ssh.connect_C_tomcat6(virtIp, user, password);
				else if(server.equals("Tomcat7"))
					ssh.connect_C_tomcat7(virtIp, user, password);
				
			}
		}
		
		
		/* proxy */
		//cut domain
		String cut_domain = "";
		for(int i=0;;i++){
			if(domain.charAt(i) == '.')
				break;
			else
				cut_domain += domain.charAt(i);
		}
		
		//port
		String port = "";
		boolean success = false;
		if(server.equals("Tomcat6") || server.equals("Tomcat7")){
			port = "8080";
			success = true;
		}
		else if(server.equals("Apache") || server.equals("APM+Phpmyadmin")){
			port = "80";
			success = true;
		}
		else if(server.equals("undefined")){
			port = request.getParameter("port");
			success = true;
		}	
	
		if(success){
			domControl.addDomainToHaproxy(cut_domain, virtIp, port);	
		
			sc.updateServerList(index, 5, server);
			sc.updateServerList(index, 6, domain);
			
			kDomainConvert dom = new kDomainConvert();
			dom.updateDomainList(domain, server_name);
			
			SendEmail sendMail = new SendEmail();
			sendMail.defType(username,email,"makeServer");
			
			%>
	 		<script type="text/javascript">
 	 			alert("서버 생성 완료!");
 	 			window.close();
 	 		</script> 
 	 		
	 		<%
		}
		else{
			sc.updateServerList(index, 5, "waiting");		

			kDomainConvert dom = new kDomainConvert();
			dom.updateDomainList(domain, "");
			%>
	 		<script type="text/javascript">
 	 			alert("Build Error!\nPlease try again");
 	 			window.close();
 	 		</script> 
	 		<%
		}
	}
	else{
		%>
		<script type="text/javascript">
			alert("해당 도메인이 사용중 입니다.\n다른 도메인을 선택해 주세요.");
			location.href="/koloud/tables";
		</script>
		<%
	}
%>    
