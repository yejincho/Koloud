<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%@page import="net.kbssm.koloud.Resource.*" %>
<%@page import="net.kbssm.koloud.kDomain.*"%>
<%@ page import="net.kbssm.koloud.Virtual.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="org.libvirt.*, net.kbssm.koloud.OS.*"%>
<%
	request.setCharacterEncoding("utf-8");
	ResourceConvert rc = new ResourceConvert();
	List<Resource> lr = rc.getResourceList();

	UserConvert uc = new UserConvert();
	//List<User> lu = uc.getUserList();
	
	ServerConvert sc = new ServerConvert();
	List<Server> ls = sc.getServerList();
	
	String status = null;
	String userId = request.getParameter("userId");
	String index_res = request.getParameter("index_resource");
	String s_name = request.getParameter("s_name");
	
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
 	long kbTogb = 1024*1024*1024;
%> 

	<link href="../koloud/resources/css/serverlist.css" rel="stylesheet">

		<!-- start: Content -->
		<div id="content" class="span10">
			<ul class="breadcrumb">
				<li>
					<i class="fa fa-home"></i>
					<a href="/koloud/home">Home</a> 
					<i class="fa fa-angle-right"></i>
				</li>
				<li><a href="/koloud/request_resources">자원 변경 요청</a></li>
			</ul>
          
          <!-- Page Heading -->
		<i class="fa fa-bar-chart-o"></i> 호스트 정보<br>
		<div class="row-fluid hideInIE8 circleStats">
				
				<a class="quick-button metro blue span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-desktop "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.model %></font>
					</div>
				</a>
			
				<a class="quick-button metro pink span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-cogs "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.cpus %> </font><font color="white" size="3"> vCores</font>
					</div>
				</a>
			
				<a class="quick-button metro red span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-line-chart "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.mhz %> </font><font color="white" size="3"> Hz</font>
					</div>
				</a>
				
				<div class="span2" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox green">
						<div class="header">Disk</div>
						<span class="percent">percent</span>
						<div class="circleStat">
                    		<input type="text" value="<%= s_percent %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">20</span>
								<span class="unit">GB</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number"><%= s_totalDisk %></span>
								<span class="unit">GB</span>
							</span>	
						</div>
                	</div>
				</div>

				<div class="span2" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox greenDark">
						<div class="header">Memory 이용률</div>
						<span class="percent">percent</span>
                    	<div class="circleStat">
                    		<input type="text" value="<%=s_memory %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">64</span>
								<span class="unit">MB</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number"><%=node.memory / 1024 %></span>
								<span class="unit">MB</span>
							</span>	
						</div>
                	</div>
				</div>

				<div class="span2 noMargin" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox pink">
						<div class="header">CPU 점유율</div>
						<span class="percent">percent</span>
                    	<div class="circleStat">
                    		<input type="text" value="<%=s_cpu %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">64</span>
								<span class="unit">GHz</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number">100</span>
								<span class="unit">%</span>
							</span>	
						</div>
                	</div>
				</div>

			</div>	
			<br>
		<div class="col-lg-6">
           <h2>자원 변경 요청 목록</h2>
				<div class="box-content">
				<table class="table table-striped table-bordered bootstrap-datatable datatable">
						<thead>
                        <tr>
                        		<th>사용자</th>
                            <th>서버 이름</th>
                            <th>Cpu</th>
                            <th>Ram</th>
                            <th>Disk</th>
                            <th>허가 여부</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% 
                    for(int i=1;i<lr.size();i++){                                 	
                    %>
                        <tr>
                            <td><a href="/koloud/request_resources?s_name=<%=lr.get(i).getS_name() %>&userId=<%= String.valueOf(lr.get(i).getId()) %>&index_resource=<%=String.valueOf(i)%>"><%=uc.getName(lr.get(i).getId()) %></a></td>
                            <td><%= lr.get(i).getS_name() %></td>
                            <td><%= lr.get(i).getCpu()%> vCore</td>
                            <td><%= lr.get(i).getRam() / 1024 %> MB</td>
                            <td><%= lr.get(i).getDisk() / kbTogb%> GB</td>
                            <td><% if(lr.get(i).getPermission().equals("waiting")){ %><font color="#FF8000">waiting</font>
                            <%}else if(lr.get(i).getPermission().equals("accepted")){ %><font color="#088A29">accepted</font>
                            <%}else { %><font color="#B40404">denied</font>
                            <%}%>	
                            </td>
                        </tr>
                    <% } 
                    %>
                    </tbody>
                 </table>
                 
                  <%if(userId!=null && index_res!=null){ 
                		int request_id = Integer.parseInt(userId);
                     	int index_resource = Integer.parseInt(index_res);
                     	int index = 0;
                     	for(int i=1;i<ls.size();i++){
                     		if(ls.get(i).getName().equals(s_name))
                     				index= i;
                     		}
                     	if(ls.get(index).getPermission() == 2){
                	 
			                 %>
			                 <div class ="form-group">
			                 	<p class="form-control-static">*허가를 위하여, 사용자 이름을 클릭해주세요.</p>
			                 </div>
			                 
			                 <br><br>
			                 <table class="table table-bordered table-hover table-striped">
			                    <thead>
			                        <tr>
			                            <th>세부 정보</th>
			                            <th>현재 할당량</th>
			                            <th>요청 할당량</th>
			                        </tr>
			                 </thead>
			                 <tbody>
			                  <tr>
			                  	<td>Cpu</td>
			                  	<td><%= ls.get(index).getCpu()%> vCore</td>
			                  		<!-- 글씨 색깔 다르게 하기 -->
			                  	<% if(ls.get(index).getCpu() != lr.get(index_resource).getCpu()){ %>
			                  	<td><font color="#FF8000">*<%= lr.get(index_resource).getCpu()%> vCore</font></td>
			                  	<%}else{ %>
			                  	<td><%= lr.get(index_resource).getCpu()%> vCore</td>
			                  	<%} %>
			                  </tr>
			                  <tr>
			                  	<td>Memory</td>
			                  	<td><%=ls.get(index).getRam() %> MB</td>
			                  	<% if(ls.get(index).getRam() != (lr.get(index_resource).getRam() / 1024)){ %>
			                  	<td><font color="#FF8000">*<%= lr.get(index_resource).getRam() / 1024%> MB</font></td>
			                  	<%}else{ %>
			                  	<td><%= lr.get(index_resource).getRam() / 1024%> MB</td>
			                  	<%} %>
			                  </tr>
			                  <tr>
			                  	<td>Disk</td>
			                  	<td><%= ls.get(index).getDisk()%> GB</td>
			                  	<% if(ls.get(index).getDisk() != (lr.get(index_resource).getDisk() / kbTogb)){ %>
			                  	<td><font color="#FF8000">*<%= lr.get(index_resource).getDisk() / kbTogb%> GB</font></td>
			                  	<%}else{ %>
			                  	<td><%= lr.get(index_resource).getDisk() / kbTogb%> GB</td>
			                  	<%} %>
			                  </tr>
			                 </tbody>
			                </table>
			                <form action="request_resource_temp" method="post">
			                <input type="hidden" name="id" value="<%=ls.get(index).getId()%>">
			                <input type="hidden" name="index" value="<%=index%>">
			                <input type="hidden" name="index_resource" value="<%=index_resource%>">
			                <input type="hidden" name="disk" value="<%=String.valueOf(lr.get(index_resource).getDisk()) %>">
			                <input type="hidden" name="cpu" value="<%=String.valueOf(lr.get(index_resource).getCpu()) %>">
			                <input type="hidden" name="ram" value="<%=String.valueOf(lr.get(index_resource).getRam()) %>">
			                <input type="hidden" name="servername" value="<%=String.valueOf(lr.get(index_resource).getS_name()) %>">
			                <input type="hidden" name="email" value="<%=email %>">
			                <div align="right">
			                <%                            	
			                	if(lr.get(index_resource).getPermission().equals("waiting")){%>
			                 	<button type="submit" class="btn btn-success" name="btn-permission" value="accept">accept</button> 
			                 	<button type="submit" class="btn btn-danger" name="btn-permission" value="deny">deny</button> 
			                	<%}else if(lr.get(index_resource).getPermission().equals("denied")){ %>
			                		<div class ="form-group">
			                     		<p class="form-control-static">*Denied Request</p>
			                    	</div>
			                	<%}else if(lr.get(index_resource).getPermission().equals("accepted")){%>
			                		<div class ="form-group">
			                     		<p class="form-control-static">*Accepted Server</p>
			                    	</div>
			                	<%}
			                }else{%>
	               				 <script type="text/javascript">
	               				 	alert("해당 서버가 존재하지 않습니다.");
	               				 	location.href="request_resources";
	               				 </script>
                			<%}
                		}%>
                </div>
                
             </form>
            </div>
        </div>
        <%conn.close(); %>
<%@include file = "../layout/foot.jsp"%>
