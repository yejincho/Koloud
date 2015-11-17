<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="net.kbssm.koloud.kDomain.*"%>
<%@ page import="org.libvirt.*, java.sql.Timestamp"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
    UserConvert uv = new UserConvert(id);
	List<User> ls = uv.getUserList();
	String clickId =request.getParameter("clickId");
	String clickEmail = request.getParameter("clickEmail");
	
	NodeInfo node = null;

	Connect conn = null;
	try {
		conn = new Connect("qemu:///system", true);

	} catch (LibvirtException e) {
		System.out.println("exception caught:" + e);
		System.out.println(e.getError());
	}
	try {
		node = conn.nodeInfo();

	} catch (LibvirtException e) {
		System.out.println("exception caught:" + e);
		System.out.println(e.getError());
	}
	
	CreateOS os = new CreateOS();
	String ip = os.ip();
	
%> 
<script type="text/javascript">
	function popup(){
		window.open('about:blank','popwin','width=400,height=300');
		f1.submit();
		
	}
</script>
	<link href="../koloud/resources/css/serverlist.css" rel="stylesheet">

		<!-- start: Content -->
		<div id="content" class="span10">
			<ul class="breadcrumb">
				<li>
					<i class="fa fa-home"></i>
					<a href="/koloud/home">Home</a> 
					<i class="fa fa-angle-right"></i>
				</li>
				<li><a href="/koloud/users">users</a></li>
			</ul>
          
          <div class="col-lg-6">
				<h2>사용자 목록</h2><br>
				<table class="table table-bordered table-hover table-striped">
					<thead>
						<tr>
							<th>번호</th>
							<th>아이디</th>
							<th>이메일</th>
							<th>등급</th>
							<th>가입 날짜</th>
							<th>편집</th>
							<th>메일보내기</th>
						</tr>
					</thead>
					<tbody>
               	<%//guest
               	for(int i=0;i<ls.size();i++){
                   	%> 
                       <tr>
                           <td><%= ls.get(i).getId() %></td>
                           <td><%= ls.get(i).getName() %></td>
                           <td><%= ls.get(i).getEmail() %></td>
                           <td><%= ls.get(i).getLevel() %></td>
                           <td><%= ls.get(i).getTime() %></td>
                           <td><a href="/koloud/users?clickId=<%=ls.get(i).getName()%>">비밀번호 변경</a>
                           <td><a href="/koloud/users?clickEmail=<%=ls.get(i).getEmail() %>&clickName=<%=ls.get(i).getName()%>">
                           <button type="submit" class="btn btn-info"><i class="fa fa-envelope" style="color:white;"></i></button></a>
                           <font size="1px"><p>*호스트 PC에 대한 사용량이 전송됩니다.</p></font></td>
                       </tr>
                   	<% } %>
               </tbody>
		       </table>
		     </div>
              <%
              if(clickId != null){%>
			  	<form action="guest_account_temp" method="post">
              	<br><hr>
					<input type="hidden" name="id" value='<%=clickId %>'>
			       Enter new password : <input type="password" name="new_pw1"><br>
			       Retype new password : <input type="password" name="new_pw2"><br><br>  
			       <button type="submit" name="password" class="btn btn-success">save</button>
              </form>   
              <%}
				if(clickEmail != null){
					System.out.println("cc"+clickEmail);
					String receiver_email = clickEmail;
					String receiver_name = request.getParameter("clickName");
					String subject = "Notification";
					String content = "<h3>Host PC Resources</h3>"+
					                  "Hey! "+receiver_name+", you are using own free server on "+node.model+"!<br>"+
					                  "Here is Host PC's resources<br>"+
					                	"Disk Utilization : "+s_percent+"% ("+s_usingDisk+" GB / "+s_totalDisk+" GB)<br>"+
					                	"memory Utilization : "+s_memory+"%<br>"+
					                	"cpu Utilization : "+s_cpu+"%<br>"+
					                  "Enjoy the service!<br>"+
					                  "<h3>Disk IOs for /dev/sda(Day / Week)</h3>"+
										"<img src=\"http://"+ip+":81/munin/localdomain/localhost.localdomain/diskstats_iops/sda-day.png\"/>"+
										"<img src=\"http://"+ip+":81/munin/localdomain/localhost.localdomain/diskstats_iops/sda-week.png\"/><br>"+
										"<h3>Disk latency for /dev/sda(Day / Week)</h3>"+
										"<img src=\"http://"+ip+":81/munin/localdomain/localhost.localdomain/diskstats_latency/sda-day.png\"/>"+
										"<img src=\"http://"+ip+":81/munin/localdomain/localhost.localdomain/diskstats_latency/sda-week.png\"/><br>"+
										"<h3>CPU usage(Day / Week)</h3>"+
										"<img src=\"http://"+ip+":81/munin/localdomain/localhost.localdomain/cpu-day.png\"/>"+
										"<img src=\"http://"+ip+":81/munin/localdomain/localhost.localdomain/cpu-week.png\"/><br>"+
										"<h3>CPU frequency scaling(Day / Week)</h3>"+
										"<img src=\"http://"+ip+":81/munin/localdomain/localhost.localdomain/cpuspeed-day.png\"/>"+
										"<img src=\"http://"+ip+":81/munin/localdomain/localhost.localdomain/cpuspeed-week.png\"/><br>"+
										"<h3>Memory usage(Day / Week)</h3>"+
										"<img src=\"http://"+ip+":81/munin/localdomain/localhost.localdomain/memory-day.png\"/>"+
										"<img src=\"http://"+ip+":81/munin/localdomain/localhost.localdomain/memory-week.png\"/><br>";
					
					//send email - register                  
					SendEmail sendMail = new SendEmail();
					sendMail.SendEmailToClient(receiver_email, subject, content);
					//add xml
					Timestamp time = new Timestamp(System.currentTimeMillis());
					String sender = "koloudcloud@gmail.com";
					mc.mailList(sender, receiver_email, receiver_name, content, subject, "HostInfo", time);
					%>
					<script type="text/javascript">
						alert("메일이 전송되었습니다.");
						location.href="users";
					</script>
					<%
					
				}
				%>
      </div>
              
<!-- <script src="../../../koloud/resources/js/develop/table.js"></script> -->
<%@include file = "../layout/foot.jsp"%>
