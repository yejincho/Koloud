<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="javax.tools.JavaFileManager.Location"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.io.*, net.kbssm.koloud.User.UserConvert, net.kbssm.koloud.User.User" %>
<%@ page import="net.kbssm.koloud.Server.*" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="net.kbssm.koloud.mail.*, net.kbssm.koloud.OS.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
	<meta charset="utf-8">
	<title>Koloud</title>
	
	<!-- start: Mobile Specific -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- end: Mobile Specific -->
	
	<!-- start: CSS -->
	<link href="../koloud/resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="../koloud/resources/css/bootstrap-responsive.min.css" rel="stylesheet">
	<link href="../koloud/resources/css/style.css" rel="stylesheet">
	<link href="../koloud/resources/css/style-responsive.css" rel="stylesheet">
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800&subset=latin,cyrillic-ext,latin-ext' rel='stylesheet' type='text/css'>
	<link href="../koloud/resources/font-awesome-4.2.0/css/font-awesome.min.css" rel="stylesheet">
	<link href="../koloud/resources/font-awesome-4.2.0/css/font-awesome-ie7.min.css" rel="stylesheet">
	
	<!-- end: CSS -->
	

	<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	  	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<link id="ie-style" href="css/ie.css" rel="stylesheet">
	<![endif]-->
	
	<!--[if IE 9]>
		<link id="ie9style" href="css/ie9.css" rel="stylesheet">
	<![endif]-->
		
	<!-- start: Favicon -->
	<link rel="shortcut icon" href="img/favicon.ico">
	<!-- end: Favicon -->
	
	<!-- font -->
	<link href='http://fonts.googleapis.com/css?family=Ubuntu:400italic' rel='stylesheet' type='text/css'>
	<style>
		.fon {font-family: 'Ubuntu', sans-serif;}
	</style>
	<!-- font end -->
</head>
<body>

<%

	request.setCharacterEncoding("utf-8");
	String email = (String)session.getAttribute("id");
	String testVal = null;
	UserConvert ul = new UserConvert();
	List<User> lu = ul.getUserList();
	
// 	System.out.println(email);
	int id = 0;
	String name = null;
	
	if(email != null){
		for(int i=0;i<lu.size();i++){
			if(lu.get(i).getEmail().equals(email)){
				id = lu.get(i).getId();
				name = ul.getName(id);
			}
		}
	}
	else{
		%>
		<script type="text/javascript">
		alert("재로그인 해주세요.")
		location.href="/koloud/";
		</script>
		<%
	}
	String password = lu.get(0).getSysPassword();
	int level = ul.getLevel(id);
	  
	MailConvert mc = new MailConvert();
	List<Mail> lm = mc.getMailList();
	
	CreateOS c = new CreateOS();
	String s_totalDisk = c.getTotalDisk();
	String s_usingDisk = c.getUsingDisk();
	String s_leftDisk = c.getLeftDisk();
	String s_cpu = c.getCpu();
	String s_memory = c.getMemory();
	String s_percent = c.getDiskPercent();
	
%>
<!-- start: Header -->
	<div class="navbar">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="btn btn-navbar" data-toggle="collapse" data-target=".top-nav.nav-collapse,.sidebar-nav.nav-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</a>
				<a class="brand" href="/koloud/home"><span>Koloud <i class="fa fa-cloud"></i></span></a>
				<a class="brand" href="/koloud/aboutus"><span><font size="2" style="color:white">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;About</font></span></a>
				<a class="brand" href="/koloud/developer"><span><font size="2" style="color:white">&nbsp;&nbsp;Developer</font></span></a>
				<a class="brand" href="http://www.koloudbiz.com/files/koloud_manual.pdf"><span><font size="2" style="color:white">&nbsp;&nbsp;Manuals</font></span></a>
				<a class="brand" href="http://www.koloudbiz.com"><span><font size="2" style="color:white">&nbsp;&nbsp;Service Home</font></span></a>
				
				<!-- start: Header Menu -->
				<!-- message, alert, profile -->
				<div class="nav-no-collapse header-nav">
					<ul class="nav pull-right">
						<!-- start: Notifications Dropdown -->
						<li class="dropdown hidden-phone">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-align-left" style="color:white"></i></a>
                    <ul class="dropdown-menu tasks">
						<li class="dropdown-menu-title">
								<span>호스트 PC 자원 점유율</span>
						</li>
						<li>
                         <a href="charts">
								<span class="header">
									<span class="title">Disk 사용량</span>
									<span class="percent"><%=s_percent%>%</span>
								</span>
                            <div aria-valuenow="<%=s_percent%>" aria-valuemax="100" aria-valuemin="0" role="progressbar" class="taskProgress progressSlim red ui-progressbar ui-widget ui-widget-content ui-corner-all">
                                      <%=s_percent%><div style="width: <%=s_percent%>%;" class="ui-progressbar-value ui-widget-header ui-corner-left"></div></div> 
                                  </a>
                              </li>
                              <li>
                                  <a href="charts">
								<span class="header">
									<span class="title">Cpu 이용률</span>
									<span class="percent"><%=s_cpu%> %</span>
								</span>
                                      <div aria-valuenow="<%=s_cpu%>" aria-valuemax="100" aria-valuemin="0" role="progressbar" class="taskProgress progressSlim green ui-progressbar ui-widget ui-widget-content ui-corner-all">
											<%=s_cpu%>
										<div style="width: <%=s_cpu%>%;" class="ui-progressbar-value ui-widget-header ui-corner-left"></div></div> 
                                  </a>
                              </li>
                              <li>
                                  <a href="charts">
								<span class="header">
									<span class="title">Memory 사용량</span>
									<span class="percent"><%=s_memory%> %</span>
								</span>
                                      <div aria-valuenow="<%=s_memory%>" aria-valuemax="100" aria-valuemin="0" role="progressbar" class="taskProgress progressSlim yellow ui-progressbar ui-widget ui-widget-content ui-corner-all">
                                      <%=s_memory%><div style="width: <%=s_memory%>%;" class="ui-progressbar-value ui-widget-header ui-corner-left"></div></div> 
                                  </a>
                              </li>
							<li>
                          		<a class="dropdown-menu-sub-footer" href="charts">View all tasks</a>
							</li>	
						</ul>
						<!-- end: Notifications Dropdown -->
						
						<!-- start: Message Dropdown -->
						<li class="dropdown hidden-phone">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								<span><i class="fa fa-envelope" style="color:white"></i></span>
							</a>
							<ul class="dropdown-menu messages">
								<li class="dropdown-menu-title">
 									<span>You have <%=lm.size()-1 %> messages</span>
								</li>	
								<% int countMail = 0; 
								for(int i=1;i<lm.size();i++){
	                        			if(id == 1){ //admin
	                        				countMail++;
	                        				if(countMail <=  5){
				                        		%>
				                        		<li>
					                            <a href="/koloud/mail?clickedName=<%=lm.get(i).getReceiver_name() %>&index=<%=String.valueOf(i) %>">
				                                    <span class="header">
														 <span class="from"><strong><%=lm.get(i).getReceiver_name() %></strong></span>
														 <span class="time"><i class="fa fa-cock-o"></i><%=lm.get(i).getTime().toLocaleString()  %></span>
													</span>
				                                    <span class="message">
				                                         <%=lm.get(i).getSubject() %>
				                                    </span>  
					                            </a>
					                          </li>
						                        	<%
	                        				}
                        				}
	                        			else{ //guest
			                        		if(lm.get(i).getReceiver_name().equals(name)){
			                        			countMail++;
		                        				if(countMail <=  5){
			                        		%>
				                        		<li>
					                            <a href="/koloud/mail?clickedName=<%=lm.get(i).getReceiver_name() %>&index=<%=String.valueOf(i) %>">
				                                    <span class="header">
														 <span class="from"><strong><%=lm.get(i).getReceiver_name() %></strong></span>
														 <span class="time"><i class="fa fa-cock-o"></i><%=lm.get(i).getTime().toLocaleString()  %></span>
													</span>
				                                    <span class="message">
				                                         <%=lm.get(i).getSubject() %>
				                                    </span>  
					                            </a>
					                          </li>
	                        					<%}
	                        				}
                        	  			}
                        		}%>
								<li>
		                         <a class="dropdown-menu-sub-footer" href="/koloud/mail">View all messages</a>
								</li>
							</ul>
						</li>
						<!-- end: Message Dropdown -->
						
						<li>
							<a href="/koloud/update_account">
								<span><i class="fa fa-cog" style="color:white"></i></span>
							</a>
						</li>
						
						<!-- start: User Account Dropdown -->
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" >
	                        <i class="fa fa-user" style="color:white"></i> <font style="color:white"><%= name %></font>
	                     </a>
	                    <ul class="dropdown-menu">
	                    		<li class="dropdown-menu-title">
 									<span>Account Settings</span>
								</li>
	                        <li>
	                            <a href="/koloud/profile"><i class="fa fa-fw fa-user"></i> Profile</a>
	                        </li>
	                        <li>
	                            <a href="/koloud/mail"><i class="fa fa-fw fa-envelope"></i> Inbox</a>
	                        </li>
	                        <li>
	                            <a href="/koloud/update_account"><i class="fa fa-fw fa-gear"></i> Settings</a>
	                        </li>
	                        <li class="divider"></li>
	                        <li>
	                            <a href="/koloud/logout_temp"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
	                        </li>
	                    </ul>
						</li>
						<!-- end: User Dropdown -->
					</ul>
				</div>
				<!-- end: Header Menu -->
			</div>
		</div>
	</div>
	
<!-- about, contact us -->
<!--             Collect the nav links, forms, and other content for toggling -->
<!--             <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"> -->
<!--                 <ul class="nav navbar-nav"> -->
<!--                     <li> -->
<!--                         <a href='/koloud/about'>About</a> -->
<!--                     </li> -->
<!--                     <li> -->
<!--                         <a href="/koloud/contact">Contact</a> -->
<!--                     </li> -->
<!--                 </ul> -->
<!--             </div> -->
<!--             /.navbar-collapse -->
<!--                </div> -->
<!-- start: Header -->
	
		<div class="container-fluid-full">
		<div class="row-fluid">
				
			<!-- start: Left Menu -->
			<div id="sidebar-left" class="span2">
				<div class="nav-collapse sidebar-nav">
					<ul class="nav nav-tabs nav-stacked main-menu">
						<li><a href="/koloud/tables"><i class="fa fa-fw fa-list-ul"></i> 서버 리스트</a></li>	
						<li>
							<a data-toggle="collapse" href="javascript:;" data-target="#resource"><i class="fa fa-fw fa-pie-chart"></i> 자원 관리 <i class="fa fa-fw fa-caret-down"></i></a>
							<ul id="resource" style="display:block;">
								<li>
                                <a href="/koloud/charts"><i class="fa fa-fw fa-area-chart"></i> 호스트 자원</a>
                              </li>
                            <li>
                                <a href="/koloud/VMcharts"><i class="fa fa-fw fa-bar-chart"></i> 가상 머신 자원</a>
                            </li>
							</ul>	
						</li>
						
	                 <li><a href="/koloud/tables_Setting"><i class="fa fa-fw fa-cog"></i> 자원 설정 변경</a></li>
						<li><a href="/koloud/mail"><i class="fa fa-fw fa-envelope"></i> 메일</a></li>
						<%if(id==1){ %>
                    <li>
                        <a href="/koloud/create_server"><i class="fa fa-fw fa-plus-circle"></i> OS 생성</a>
                    </li>
                    <%}else{ %>
                    <li>
                        <a href="/koloud/create_server_guest"><i class="fa fa-fw fa-plus-circle"></i> OS 요청</a>
                    </li>
                    	<%} %>
                    <%if(level != 3){ %>
                    <li>
                        <a href="/koloud/all_tables"><i class="fa fa-fw fa-history"></i> 신청 기록</a>
                    </li>
                    <%}if(level == 3){%>

                    <li>
                        <a href="javascript:;" data-toggle="collapse" data-target="#admin"><i class="fa fa-fw fa-arrows-v"></i> 관리 <i class="fa fa-fw fa-caret-down"></i></a>
                        <ul id="admin" style="display:block;">
                            <li>
                                <a href="/koloud/users"><i class="fa fa-fw fa-users"></i> 사용자 리스트</a>
                              </li>
                            <li>
                                <a href="/koloud/DNS_setting"><i class="fa fa-fw fa-database"></i> DNS 설정</a>
                            </li>
                            <li>
                                <a href="/koloud/request"><i class="fa fa-fw fa-bars"></i> OS 요청</a>
                            </li>
                            <li>
                                <a href="/koloud/request_resources"><i class="fa fa-fw fa-bars"></i> 자원 변경 요청</a>
                            </li>
                            <li>
                                <a href="/koloud/blank"><i class="fa fa-fw fa-table"></i> Proxy </a>
                            </li>
                        </ul>
                    </li>
                     <%}%>
					</ul>
				</div>
			</div>
			<!-- end: Left Menu -->

</html>
