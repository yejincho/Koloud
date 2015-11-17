<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="net.kbssm.koloud.kDomain.*"%>
<%@ page import="net.kbssm.koloud.Virtual.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="org.libvirt.*, net.kbssm.koloud.OS.*"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	ServerConvert sv = new ServerConvert(id);
	List<Server> ls = sv.getServerList();
	String status = null;
	String clickCheck = request.getParameter("clickCheck");
	String clickId =request.getParameter("clickId");
	CreateOS os = new CreateOS();
	String ip = os.ip();
	
	int vCpu = 0;
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
	
	int CntforServer = 0;
	for(int i=1;i<ls.size();i++){
		if(ls.get(i).getId() == id && ls.get(i).getPermission() == 2){
			CntforServer++;
		}
	}
%> 
<script type="text/javascript">
	function valuesend(){
		var win = window.open("","value","width=450, height=50");
		document.frm.target = "value";
		document.frm.action="http://<%=ip%>:8080/koloud/request_temp?btn-permission=accept";
		document.frm.submit();
	}
	function alert(){
		location.href="/koloud/OSCreateInfo";
	}
</script>
		<!-- start: Content -->
		<div id="content" class="span10">
			<ul class="breadcrumb">
				<li>
					<i class="fa fa-home"></i>
					<a href="/koloud/home">Home</a> 
					<i class="fa fa-angle-right"></i>
				</li>
				<li><a href="/koloud/request">OS 요청</a></li>
			</ul>
          
          <!-- Page Heading -->
		<i class="fa fa-bar-chart-o"></i> 호스트 정보<br>
		
			<div class="col-lg-6">
				<table class="table table-bordered table-hover table-striped">
					<thead>
						<tr align="center">
							<th>CPU Model</th>
							<th>CPUS</th>
							<th>Hz</th>
							<th>RAM</th>
							<th>CPU Utilization</th>
							<th>Memory Utilization</th>
						</tr>
					</thead>
					<tbody>
						<tr align="center">
							<td><%=node.model%></td>
							<td><%=node.cpus%></td>
							<td><%=node.mhz%> MHz</td>
							<td><%=node.memory%> KB</td>
							<td>
								<%
									try {
										String msg = "", emsg = "";
										Process p = null;
										String[] cmd = {
												"/bin/bash",
												"-c",
												"echo "
														+ password
														+ " | sudo -S mpstat | tail -1 | awk '{print 100-$11}'" };
	
										p = Runtime.getRuntime().exec(cmd);
										p.waitFor();
										BufferedReader inOut = new BufferedReader(
												new InputStreamReader(p.getInputStream()));
										BufferedReader inErr = new BufferedReader(
												new InputStreamReader(p.getErrorStream()));
										while ((msg = inOut.readLine()) != null) {
											out.print(msg);
										}
										while ((emsg = inErr.readLine()) != null) {
											System.out.println("Error = "+ emsg);
										}
										p.destroy();
									} catch (Exception e) {
										System.out.println(e.toString());
									}
								%> %
							</td>
							<td>
								<%
									try {
										String msg = "", emsg = "";
										Process p = null;
										String[] cmd = {
												"/bin/bash",
												"-c",
												"echo "
														+ password
														+ " | sudo -S free | grep Mem | tail -1 | awk '{print $3/$2*100}'" };
										p = Runtime.getRuntime().exec(cmd);
										p.waitFor();
										BufferedReader inOut = new BufferedReader(
												new InputStreamReader(p.getInputStream()));
										BufferedReader inErr = new BufferedReader(
												new InputStreamReader(p.getErrorStream()));
										while ((msg = inOut.readLine()) != null) {
											out.print(msg);
										}
										while ((emsg = inErr.readLine()) != null) {
											System.out.println("Error = " + emsg);
										}
										p.destroy();
									} catch (Exception e) {
										System.out.println(e.toString());
									}
								%> %
							</td>
						</tr>
					</tbody>
				</table>
			</div>
          
          
          
		<div class="col-lg-6">
           <h2>OS 요청 목록</h2><br>
				<table class="table table-bordered table-hover table-striped">
					<thead>
						<tr>
							<th>신청인</th>
			               <th>서버 이름</th>
			               <th>운영체제</th>
			               <th>스펙(cpu, ram, disk)</th>
			               <th>허용</th>
			           </tr>
					</thead>
					<tbody>
						<tbody>
                                <% 
                                if(id != 1 && CntforServer == 0){
                            	%>
                            	<td colspan="4" align="center">No Request for OS</td>
                            	<%
                            	}else if(id == 1 && ls.size() == 1){
                           		%>
                               	<td colspan="4" align="center">No Request for OS</td>
                               	<%
                            	}
                                for(int i=1;i<ls.size();i++){ 
                                	String permission = null;
                                %>
                                    <tr>
                                    <td><%= ul.getName(ls.get(i).getId()) %>
                                        <td><a href="/koloud/request?clickCheck=<%= ls.get(i).getName() %>&clickId=<%=String.valueOf(i)%>"><%=ls.get(i).getName() %></a></td>
                                        <td><%= ls.get(i).getOs() %> Server</td>
                                        <td><%= ls.get(i).getCpu() %> vCores /  <%= ls.get(i).getRam() %> MB /  <%=ls.get(i).getDisk() %> GB</td>
                                        <td><% if(ls.get(i).getPermission() == 1){ %><font color="#FF8000">waiting</font>
                                        <%}else if(ls.get(i).getPermission() == 2){ %><font color="#088A29">accepted</font>
                                        <%}else if(ls.get(i).getPermission() == 3){ %><font color="#B40404">denied</font>
                                        <%}else { %><font color="#B40404">Service Stopped</font><%} %>	
                                        </td>
                                    </tr>
                                <% } 
                                %>
                                </tbody>
                             </table>
                             
                             <div class ="form-group">
                             	<p class="form-control-static">*To permit requested server, Click Server Name</p>
                             </div>
                             
                             <%if(clickCheck!=null && clickId!=null){ 	   
	                            	int index = Integer.parseInt(clickId);
	                         %>
                             <table class="table table-bordered table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>Detail</th>
                                        <th>Instance information</th>
                                    </tr>
	                            </thead>
	                            
	                            <tbody>
	                            	<tr>
		                            	<td><font color="#FF8000">*사용자 이름</font></td>
		                            	<td><font color="#FF8000"><%= ul.getName(ls.get(index).getId()) %></font></td>
		                            </tr>
	                            	<tr>
		                            	<td>서버 이름</td>
		                            	<td><%= ls.get(index).getName() %></td>
		                            </tr>
		                            <tr>
		                            	<td>운영체제</td>
		                            	<td><%= ls.get(index).getOs() %></td>
		                            </tr>
		                            <tr>
		                            	<td>Cpu / Memory</td>
		                            	<td><%= ls.get(index).getCpu()%> vCore / <%=ls.get(index).getRam() %> MB</td>
		                            </tr>
		                            <tr>
		                            	<td>Disk</td>
		                            	<td>
		                            	<input type="hidden" name="id" value="<%=ls.get(index).getId()%>">
		                            	<input type="hidden" name="index" value="<%=index%>">
			                            <input type="hidden" name="email" value="<%=ul.getEmail(ls.get(index).getId())%>">
			                            <input type="hidden" name="name" value="<%=ul.getName(ls.get(index).getId())%>">
		                            	<%= ls.get(index).getDisk()%> GB</td>
		                            </tr>		                          
	                            </tbody>
                            </table>
                            <div align="right">
                            <%
                            if(ls.get(index).getPermission() == 1){%>
                            	<form name="frm" method="post"><!--action="request_temp" -->
                            	<input type="hidden" name="id" value="<%=ls.get(index).getId()%>">
                            	<input type="hidden" name="index" value="<%=index%>">
	                            <input type="hidden" name="email" value="<%=ul.getEmail(ls.get(index).getId())%>">
	                            <input type="hidden" name="name" value="<%=ul.getName(ls.get(index).getId())%>">
                            		*승인을 허용 합니다.
                            	<button type="button" class="btn btn-success" name="btn-permission" value="accept" onclick="valuesend(); alert()">승인</button> 
                            	</form>
                            	<form action="request_temp" method="post">
                            	<input type="hidden" name="id" value="<%=ls.get(index).getId()%>">
                            	<input type="hidden" name="index" value="<%=index%>">
	                            <input type="hidden" name="email" value="<%=ul.getEmail(ls.get(index).getId())%>">
	                            <input type="hidden" name="name" value="<%=ul.getName(ls.get(index).getId())%>">
                            		*승인을 거절 합니다.
                            	<button type="submit" class="btn btn-danger" name="btn-permission" value="deny">거절</button> 
                            	</form>
                            <%}else if(ls.get(index).getPermission() == 2){ %>
                            	<form action="request_temp" method="post">
                            	<input type="hidden" name="id" value="<%=ls.get(index).getId()%>">
                            	<input type="hidden" name="index" value="<%=index%>">
	                            <input type="hidden" name="email" value="<%=ul.getEmail(ls.get(index).getId())%>">
	                            <input type="hidden" name="name" value="<%=ul.getName(ls.get(index).getId())%>">
                            		*누를 시 서버가 삭제됩니다.
                            	<button type="submit" class="btn btn-danger" name="btn-permission" value="cancel">허가 취소</button>
                            	</form>
                            <%}else if(ls.get(index).getPermission() == 3){%>
                           		<div class ="form-group">
                               		<p class="form-control-static">*거절된 서버</p>
                               	</div>
                            <%}else{%>
                           		<div class ="form-group">
                               		<p class="form-control-static">*서비스 정지된 서버</p>
                               	</div>
                            <%}
                            }%>
                            
    						</div>
    				</div>
    		</div>
    						

<!-- <script src="../../../koloud/resources/js/develop/table.js"></script> -->
<%@include file = "../layout/foot.jsp"%>
