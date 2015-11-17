<%@page import="net.kbssm.koloud.Resource.*"%>
<%@page import="net.kbssm.koloud.kDomain.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="layout/Wrapper.jsp" %>
<%@ page import="net.kbssm.koloud.Virtual.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="org.libvirt.*, net.kbssm.koloud.OS.*"%>
<%
	request.setCharacterEncoding("utf-8");
	ServerConvert sv = new ServerConvert(id);
	List<Server> ls = sv.getServerList();
	String status = null;
	String clickCheck = request.getParameter("clickCheck");
	String clickId =request.getParameter("clickId");
	
	kDomainConvert dc = new kDomainConvert();
	List<kDomain> ld = dc.getDomainList();
	
	ResourceConvert rc = new ResourceConvert();
	List<Resource> lr = rc.getResourceList();
	
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
	
%> 
		<!-- start: Content -->
		<div id="content" class="span10">
		<h1 class="page-header" style="margin:0 0 30px 0;">Welcome to Koloud Service!</h1>
           <div class="row-fluid">	
				<div class="box blue span12">
					<div class="box-header">
						<h2><i class="fa fa-hand-o-down"></i><span class="break"></span>Quick Menu</h2>
					</div>
					<div class="box-content">
						<a class="quick-button span2" href="tables">
							<i class="fa fa-fw fa-list-ul"></i>
							<p>서버 리스트</p>
							<%if(id == 1){ 
								int cntServer = 0;
								for(int i=1;i<ls.size();i++){
									if(ls.get(i).getPermission() == 2){
										cntServer++;
									}
								}
							%>
							<span class="notification green"><%=cntServer %></span>
							<%}
							else{
								int cntServer = 0;
								for(int i=1;i<ls.size();i++){
									if(ls.get(i).getId() == id && ls.get(i).getPermission() == 2){
										cntServer++;
									}
								}
								%>
							<span class="notification green"><%=cntServer %></span>
							<%} %>
						</a>
						<a class="quick-button span2" href="charts">
							<i class="fa fa-fw fa-pie-chart"></i>
							<p>호스트 자원</p>
						</a>
						<a class="quick-button span2" href="tables_Setting">
							<i class="fa fa-fw fa-cog"></i>
							<p>자원 설정</p>
						</a>
						<a class="quick-button span2" href="mail">
							<i class="icon-envelope"></i>
							<%if(id == 1){ %>
							<span class="notification red"><%=lm.size()-1 %></span>
							<%}else{
								int cntMail = 0;
								for(int i=1;i<lm.size();i++){
									if(lm.get(i).getReceiver_email().equals(email)){
										cntMail++;
									}
								}
								%>
							<span class="notification red"><%=cntMail %></span>
							<%} %>
							<p>메일</p>
						</a>
						<% if(id == 1){ %>
						<a class="quick-button span2" href="create_server">
							<i class="fa fa-fw fa-plus-circle"></i>
							<p>OS 생성</p>
						</a>
						<%}else{ %>
						<a class="quick-button span2" href="create_server_guest">
							<i class="fa fa-fw fa-plus-circle"></i>
							<p>OS 요청</p>
						</a>
						<%} %>
						<%if(id == 1){ %>
							<a class="quick-button span2" href="users">
						<%}else{ %>
							<a class="quick-button span2">
						<%} %>
							<i class="icon-group"></i>
							<p>사용자</p>
							<span class="notification blue"><%=lu.size() %></span>
						</a>
						<div class="clearfix"></div>
					</div>	
				</div><!--/span-->
				
			</div><!--/row-->
			<div class="row-fluid">
				<div class="span3 statbox purple" onTablet="span6" onDesktop="span3">
					<div class="boxchart">5,6,7,2,0,4,2,4,8,2,3,3,2</div>
					<div class="number"><%=lu.get(0).getVisitCnt() %><i class="icon-arrow-up"></i></div>
					<div class="title">visits</div>
					<div class="footer">
						<a href="#"> 홈페이지 방문 수</a>
					</div>	
				</div>
				<div class="span3 statbox green" onTablet="span6" onDesktop="span3">
					<div class="boxchart">1,2,6,4,0,8,2,4,5,3,1,7,5</div>
					<div class="number"><%=ls.size()-1 %><i class="icon-arrow-up"></i></div>
					<div class="title">vOS</div>
					<div class="footer">
						<a href="#"> 가상 OS 요청 및 생성</a>
					</div>
				</div>
				<div class="span3 statbox blue noMargin" onTablet="span6" onDesktop="span3">
					<div class="boxchart">5,6,7,2,0,-4,-2,4,8,2,3,3,2</div>
					<div class="number"><%=ld.size()-1 %><i class="icon-arrow-up"></i></div>
					<div class="title">Domains</div>
					<div class="footer">
						<a href="#"> 서브 도메인 수</a>
					</div>
				</div>
				<div class="span3 statbox yellow" onTablet="span6" onDesktop="span3">
					<div class="boxchart">7,2,2,2,1,-4,-2,4,8,,0,3,3,5</div>
					<div class="number"><%=lr.size()-1 %><i class="icon-arrow-down"></i></div>
					<div class="title">resources</div>
					<div class="footer">
						<a href="#"> 자원 요청 및 변경</a>
					</div>
				</div>	
				
			</div>	

			
			
		<div class="row-fluid">
				<div class="box black span4" onTablet="span6" onDesktop="span4">
					<div class="box-header">
						<h2><i class="fa fa-list"></i><span class="break"></span>도메인 리스트</h2>
						<div class="box-icon">
							<a href="#" class="btn-minimize"><i class="halflings-icon white chevron-up"></i></a>
							<a href="#" class="btn-close"><i class="halflings-icon white remove"></i></a>
						</div>
					</div>
					<div class="box-content">
						<ul class="dashboard-list metro">
						<%int domainCnt = 0;
						for(int i=1;i<ld.size();i++){
							domainCnt++;
							if(domainCnt <= 10){
							%>
							<li>
								<a href="#">
								<%if(ld.get(i).getServer() != ""){ %>
									<i class="fa fa-check-square fa-3x yellow"></i>                               
									<strong>사용중 </strong>
									<%=ld.get(i).getSubDom() %>   
								<%}else{ %>  
									<i class="fa fa-square fa-3x blue"></i>                               
									<strong>사용가능 </strong>
									<%=ld.get(i).getSubDom() %>
								<%}
							}%>                            
								</a>
							</li>
						<%}%>
						</ul>
					</div>
				</div><!--/span-->
				
				<div class="box black span4" onTablet="span6" onDesktop="span4">
					<div class="box-header">
						<h2><i class="fa fa-list"></i><span class="break"></span>서버 리스트</h2>
						<div class="box-icon">
							<a href="#" class="btn-minimize"><i class="halflings-icon white chevron-up"></i></a>
							<a href="#" class="btn-close"><i class="halflings-icon white remove"></i></a>
						</div>
					</div>
					<div class="box-content">
						<ul class="dashboard-list metro">
						<%int serverCnt = 0;
						for(int i=1;i<ls.size();i++){ 
							serverCnt++;
							if(serverCnt <= 10){ %>
							<li>
								<a href="#">
								<%if(ls.get(i).getPermission() == 1){ %>
									<i class="icon-minus yellow"></i>                               
									<strong>waiting</strong>
									<%=ls.get(i).getName() %>   
								<%}else if(ls.get(i).getPermission() == 2){ %>  
									<i class="icon-arrow-up green"></i>                               
									<strong>running</strong>
									<%=ls.get(i).getName() %>
								<%}else if(ls.get(i).getPermission() == 3){ %>  
									<i class="icon-arrow-down red"></i>                               
									<strong>deny</strong>
									<%=ls.get(i).getName() %>    
								<%}else{%>
									<i class="icon-arrow-down red"></i>                               
									<strong>Service Stopped</strong>
									<%=ls.get(i).getName() %> 
									<%}%>                       
								</a>
							</li>
						<%	} 
						}%>
						</ul>
					</div>
				</div><!--/span-->
				
				<div class="box black span4" onTablet="span6" onDesktop="span4">
					<div class="box-header">
						<h2><i class="fa fa-user" style="color:white"></i><span class="break"></span><font color="white"> 사용자 리스트</font></h2>
						<div class="box-icon">
							<a href="#" class="btn-minimize"><i class="halflings-icon white chevron-up"></i></a>
							<a href="#" class="btn-close"><i class="halflings-icon white remove"></i></a>
						</div>
					</div>
					<div class="box-content">
						<ul class="dashboard-list metro">
						<%int userCnt = 0;
						for(int i=0;i<lu.size();i++){
							userCnt++;
							if(userCnt <= 5){
								if(lu.get(i).getId() == 1){ // admin%>
								<li class="red">
									<a href="#">
										<img class="avatar" alt="admin">
									</a>
									<strong>Name:</strong> <%=lu.get(i).getName() %><br>
									<strong>Since:</strong> <%=lu.get(i).getTime() %><br>
									<strong>Status:</strong> Administrator             
								</li>
								<%}else{ //guest %>
								<li class="yellow">
									<a href="#">
										<img class="avatar" alt="<%=lu.get(i).getName() %>">
									</a>
									<strong>Name:</strong> <%=lu.get(i).getName() %><br>
									<strong>Since:</strong> <%=lu.get(i).getTime() %><br>
									<strong>Status:</strong> Guest                               
								</li>
								<%}
							}
						}%>
						</ul>
					</div>
				</div><!--/span-->
			
			</div>
			
		<div class="row-fluid hideInIE8 circleStats">
				<a class="quick-button metro yellow span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-desktop "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.model %></font>
					</div>
				</a>
			
				<a class="quick-button metro red span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-cogs "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.cpus %> </font><font color="white" size="3"> vCores</font>
					</div>
				</a>
			
				<a class="quick-button metro blue span2" style="height:200px;">
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
								<span class="unit">%</span>
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
		
			<div class="row-fluid">
				<div class="box span5" style="border:none">
					<div id="clock" class="dark">
						<div class="display">
							<div class="weekdays"></div>
							<div class="ampm"></div>
							<div class="alarm"></div>
							<div class="digits"></div>
						</div>
					</div>
				</div>
				
				<div class="box span7" style="border:none; text-align: center;">
					<div id="clock" class="light" style="height:115px">
					<font class="fon" size="7px" color="white"><b><%=ld.get(0).getDomain() %>&nbsp;</b></font>
					<i class="fa fa-cloud fa-4x" style="color:white"></i>
				</div>
			</div>
			
		</div>
		<!-- end: Content -->
		
<%@ include file="layout/foot.jsp" %>
