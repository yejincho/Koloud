<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="net.kbssm.koloud.OS.CreateOS"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	ServerConvert sv = new ServerConvert(id);
	List<Server> ls = sv.getServerList();
// 	System.out.println(sv.getServerList().size());
	String status = null;
	String clickCheck = request.getParameter("clickCheck");
	String clickId =request.getParameter("clickId");
	CreateOS os = new CreateOS();
	String ip = os.ip();
	
	int CntForServer = 0;
	
	for(int i=1;i<ls.size();i++){
		if(ls.get(i).getId() == id){
			CntForServer++;
		}
	}
%> 
<!-- new -->
<!-- start: Content -->
		<div id="content" class="span10">
			<ul class="breadcrumb">
				<li>
					<i class="fa fa-home"></i>
					<a href="/koloud/home">Home</a> 
					<i class="fa fa-angle-right"></i>
				</li>
				<li><a href="/koloud/create_server">신청 기록</a></li>
			</ul>
		

<!-- old -->
<div class="row-fluid">

                    <div class="col-lg-6">
                        <h2>All requested Server List</h2>
                        <form action="server_status_temp" METHOD="POST">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>서버 이름</th>
                                        <th>운영체제</th>
                                        <th>사양(CPU, RAM, DISK)</th>
                                        <th>상태</th>
                                        <th>허가 여부</th>
                                        <th>비고</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <% 
                                if(CntForServer == 0){
                                	%>
                                	<td colspan="6" align="center">No Request for Resource</td>
                                	<%
                                }
                               	for(int i=0;i<ls.size();i++){
                               		if(ls.get(i).getId() == id){ //id
                                   	%> 
                                       <tr>
                                           <td name="serverName"><a href="/koloud/all_tables?clickCheck=<%= ls.get(i).getName() %>&clickId=<%=String.valueOf(i)%>"><%=ls.get(i).getName() %></a></td>
                                           <td><%= ls.get(i).getOs() %></td>
                                           <td><%= ls.get(i).getCpu() %>  /  <%= ls.get(i).getRam() %>  /  <%= ls.get(i).getDisk() %></td>
                                           <td><%= ls.get(i).getStatus() %></td>
                                           <td><%if( ls.get(i).getPermission() == 4){%><font color="#B40404">force stopped</font>
                                           <%}else if(ls.get(i).getPermission() == 3) {%><font color="#B40404">denied</font>
                                           <%}else if(ls.get(i).getPermission() == 2) {%><font color="#088A29">accepted</font>
                                           <%}else {%><font color="#FF8000">waiting</font>
                                           <%} %>
                                           </td>
                                           <td><%if( ls.get(i).getPermission() == 4){%><%=ls.get(i).getReason() %>
                                           <%}else if(ls.get(i).getPermission() == 3) {%><%=ls.get(i).getReason() %>
                                           <%}else if(ls.get(i).getPermission() == 2) {%>accepted
                                           <%}else {%>waiting
                                           <%} %>
                                           </td>
                                       </tr>
                                   <% }
                               	}
                                %>
                                </tbody>
                             </table>
                             
                             <div class ="form-group">
                             	<p class="form-control-static">*To show in detail information, Click Server Name</p>
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
		                            	<td>Server Name</td>
		                            	<td><%= ls.get(index).getName() %></td>
		                            </tr>
		                            <tr>
		                            	<td>Public IP</td>
		                            	<td><%= ls.get(index).getIp() %></td>
		                            </tr>
		                            <tr>
		                            	<td>OS</td>
		                            	<td><%= ls.get(index).getOs() %></td>
		                            </tr>
		                            <tr>
		                            	<td>Cpu / Memory</td>
		                            	<td><%= ls.get(index).getCpu()%> vCore / <%=ls.get(index).getRam() %> GB</td>
		                            </tr>
		                            <tr>
		                            	<td>Disk</td>
		                            	<td><%= ls.get(index).getDisk()%> GB</td>
		                            </tr>
		                            <tr>
		                            	<td>Status</td>
		                            	<td><%= ls.get(index).getStatus()%></td>
		                            </tr>
		                            <%if(id == 1){ %>
		                            <tr>
		                            	<td><font color="#FF8000">*Request Username</font></td>
		                            	<td><font color="#FF8000"><%= ul.getName(ls.get(index).getId())%></font></td>
		                            </tr>
		                            <%} %>
	                            </tbody>
	                            <%}%>
                            </table>
                            
                            	<%if(clickCheck!=null && clickId!=null){ 	   
	                            	int index = Integer.parseInt(clickId);
	                            	if(ls.get(index).getPermission() ==2){
	                            %>
	                         <div class ="form-group">
                             	<p class="form-control-static">Connet to FTP, <a href ="http://<%=ip%>:81">http://localhost:81</a></p>
                             	<p class="form-control-static">Connet to SSH, <a href ="http://<%=ip%>:82">http://localhost:82</a></p>
                             </div>
                             <div class ="form-group">
                             	<p class="form-control-static">*If you want change instance setting, Click Network Setting Tab</p>
                             </div>
                             	 <%}
                             	 }%>
                             
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->
<!-- <script src="../../../koloud/resources/js/develop/table.js"></script> -->
<%@include file = "../layout/foot.jsp"%>
