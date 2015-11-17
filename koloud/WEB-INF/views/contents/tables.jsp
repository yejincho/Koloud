<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="net.kbssm.koloud.Virtual.VirtualConvert, net.kbssm.koloud.kDomain.*"%>
<%@ page import = "org.libvirt.Connect, org.libvirt.Domain, org.libvirt.LibvirtException, org.libvirt.Network, org.libvirt.StoragePool, org.libvirt.StorageVol" %>
<%@page import="net.kbssm.koloud.kDomain.*, net.kbssm.koloud.OS.*"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	ServerConvert sv = new ServerConvert(id);
	List<Server> ls = sv.getServerList();

	UserConvert uc = new UserConvert();
	
	Connect conn = new Connect("qemu:///system",true); 
	
	String ip = c.ip();
	
	String status = null;
	String clickCheck = request.getParameter("clickCheck");
	String clickId =request.getParameter("clickId");
	String virtIp = "";
	
	String serverType = request.getParameter("serverType");
	String create_btn = request.getParameter("create_btn");
	
	String clicked = request.getParameter("clicked");
	if(create_btn != null){
		response.sendRedirect("/koloud/tables");
		return;
	}
	
	Timestamp currentTime = new Timestamp(System.currentTimeMillis());
	
	int CntforServer = 0;
	int CntforServerAdmin = 0;
	for(int i=1;i<ls.size();i++){
		if(ls.get(i).getId() == id && ls.get(i).getPermission() == 2 && (currentTime.getTime() - ls.get(i).getTime().getTime() > 60000*18)){
			CntforServer++;
		}
		if(ls.get(i).getPermission() == 2 && (currentTime.getTime() - ls.get(i).getTime().getTime() > 60000*18)){
			CntforServerAdmin++;
		}
	}
	
	boolean osComplete = false;
%> 
<script type="text/javascript">
	function gotoFtp(){

		var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
	    var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;

	    width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
	    height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

	    var w = 635; //865
	    var h = 857; //857
	    var left = ((width / 2) - (w / 2)) + dualScreenLeft;
	    var top = ((height / 2) - (h / 2)) + dualScreenTop;
	    var newWindow = window.open('about:blank', 'ftp', 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
		
	    newWindow.location.href="http://<%=ip%>:81";
	}
	function gotoSsh(){
		var dualScreenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
	    var dualScreenTop = window.screenTop != undefined ? window.screenTop : screen.top;

	    width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
	    height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;

	    var w = 912; //865
	    var h = 857; //857
	    var left = ((width / 2) - (w / 2)) + dualScreenLeft;
	    var top = ((height / 2) - (h / 2)) + dualScreenTop;
	    var newWindow = window.open('about:blank', 'ssh', 'scrollbars=yes, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
	    newWindow.location.href="http://<%=ip%>:82";
	}
	
	function OnButton2(){
		location.href="/koloud/ServerCreateInfo";
	}
	
	function OnButton1(){		

		var port = document.f1.port.value;
		if(port == 20 || port == 21 || port == 22 || port == ""){
			alert("사용할 수 없는 포트번호입니다.");
			document.f1.port.focus();
		}
		else if(port > 65535){
			alert("포트 크기 최대는 65535입니다.");
			document.f1.port.focus();
		}
		else{
			var win = window.open("","value","width=450, height=50");
			document.f1.target = "value";
			document.f1.action="http://<%=ip%>:8080/koloud/server_auto";
			document.f1.submit();
			OnButton2();
		}		
		
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
				<li><a href="/koloud/tables">OS List</a></li>
			</ul>
<!-- new -->
			<div class="row-fluid sortable">		
				<div class="box span12">
					<div class="box-header" data-original-title>
						<h2><i class="fa fa-list-ul"></i><span class="break"></span>가상 OS 리스트</h2>
					</div>
					<div class="box-content">
						<table class="table table-striped table-bordered bootstrap-datatable datatable">
						  <thead>
							  <tr>
							  	  <th>사용자</th>
								  <th>서버 이름</th>
								  <th>운영체제</th>
								  <th>스펙(cpu,ram,disk)</th>
								  <th>상태</th>
							  </tr>
						  </thead>   
						  <tbody>
						   <% 
                                for(int i=1;i<ls.size();i++){
                                	if(id != 1){ //guest
                                		if(ls.get(i).getId() == id && ls.get(i).getPermission() == 2){ //guest id check, accepted
//                                 			if(currentTime.getTime() - ls.get(i).getTime().getTime() > 60000*18){ //after 18 minutes
													Domain domain = conn.domainLookupByName(ls.get(i).getName());			
			                 	%> 					 <tr>
			                 							  <td><%= ul.getName(ls.get(i).getId()) %></td>
		                                            <td><a href="/koloud/tables?os=<%=ls.get(i).getOs() %>&clickCheck=<%= ls.get(i).getName() %>&clickId=<%=String.valueOf(i)%>"><%=ls.get(i).getName() %></a></td>
		                                            <td><%= ls.get(i).getOs() %></td>
		                                            <td><%= ls.get(i).getCpu() %> vCore  /  <%= ls.get(i).getRam() %> MB  /  <%=ls.get(i).getDisk() %> GB</td>
		                                            <% if(ls.get(i).getServer() == ""){ %>
		                                            <td><font size="2px">*서버를 먼저 선택하셔야 합니다.</font></td>
		                                            <%}else{ 
		                                            if(domain.getInfo().state.toString().equals("VIR_DOMAIN_RUNNING")){%>
		                                            	<td><span class="label label-success">running</span> </td>
		                                            <%}else{ %>
		                                            	<td><span class="label label-important">stop</span></td>
		                                            	<%} %>
		                                        </tr>
		                                    			  <% }
// 		                                		}
                                			}
	                                }else{ //admin
	                                	if(ls.get(i).getPermission() == 2){
// 	                                		if(currentTime.getTime() - ls.get(i).getTime().getTime() > 60000*18){ //after 18 minutes
												Domain domain = conn.domainLookupByName(ls.get(i).getName());
	                               	%> 
		                                    <tr>
		                                    	  <td><%= ul.getName(ls.get(i).getId()) %></td>
		                                        <td><a href="/koloud/tables?os=<%=ls.get(i).getOs() %>&clickCheck=<%= ls.get(i).getName() %>&clickId=<%=String.valueOf(i)%>"><%=ls.get(i).getName() %></a></td>
		                                        <td><%= ls.get(i).getOs() %></td>
		                                        <td><%= ls.get(i).getCpu() %> vCore  /  <%= ls.get(i).getRam() %> MB  /  <%=ls.get(i).getDisk() %> GB</td>
		                                        <% if(ls.get(i).getServer() == ""){ %>
		                                            <td><font size="2px">*서버를 먼저 선택하셔야 합니다.</font></td>
		                                            <%}else{ 
		                                            if(domain.getInfo().state.toString().equals("VIR_DOMAIN_RUNNING")){%>
		                                            	<td><span class="label label-success">running</span> </td>
		                                            <%}else{ %>
		                                            	<td><span class="label label-important">stop</span></td>
		                                            	<%} %>
		                                        </tr>
		                                    	<% }
// 	                                			}
		                                	}
                                		}                                  	
                                	}
                                %>
                         </tbody>
                     </table>
                  </div>
                  
				</div><!--/span-->
              <div class ="form-group">
                         	<p class="form-control-static">*To show in detail information, Click Server Name</p>
              </div>
			
			</div><!--/row-->


                             
                             <%
                             if(clickCheck!=null && clickId!=null){
								kDomainConvert dc = new kDomainConvert();
								List<kDomain> dl = dc.getDomainList();
								
                            	int index = Integer.parseInt(clickId);
                            	String os = request.getParameter("os");
                            	
                            	Domain domain = conn.domainLookupByName(ls.get(index).getName());
                                try {
                            		String msg = "", emsg = "";
                            		Process p = null;
                           			String[] cmd = {"/bin/bash","-c","echo " + password
                           							+ " | sudo -S sh /netsh/virt-addr.sh "+ ls.get(index).getName() };
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
                            	
                            	////////////////////////////////////////////////////////////////////////////////////////////////make server!!!
                            	
                             	if(ls.get(index).getServer().equals("waiting") || 
                             			ls.get(index).getServer() == "" && domain.getInfo().state.toString().equals("VIR_DOMAIN_SHUTOFF")){
                             		if(currentTime.getTime() - ls.get(0).getTime().getTime() <= 60000*6){ //after 5 minutes
	     						    		long leftTime = 6 - ((currentTime.getTime() - ls.get(0).getTime().getTime())/60000);
	     						    		%>
	     						    		<br>
	     						    		<div class="alert alert-error">
	                                 	 	<strong>현재 다른 서버 생성 중!</strong>
	                                 	 		다른 서버가 생성 중 입니다. 잠시만 기다려 주세요. 예상 대기시간 <%=leftTime%>분&nbsp;<i class="fali fa fa-spinner fa-spin"></i> 
	                                 	</div>
	                                 	 <%
	     						    	}
                             		else{
	                            		%>
	                           		<form action="/koloud/tables">
			                            <input type="hidden" name="clickCheck" value='<%=clickCheck %>'>
			                            <input type="hidden" name="clickId" value='<%=clickId %>'>
			                            <input type="hidden" name="s_name" value='<%=ls.get(index).getName() %>'>
		                           		<input type="hidden" name="index" value='<%=String.valueOf(index) %>'>
		                           		<input type="hidden" name="os" value='<%=os %>'>
		                           		
	                           			<hr>
	                           			<h3>[<%=ls.get(index).getName() %>]</h3><br>
	                           			<div class="control-group">
	                           				<label class="control-label"><h3>서버 타입 선택(수동/자동)</h3></label>
		                           				<div class="controls">
			                                    <label class="radio"> 
			                                    	<input type="radio" name="serverType" value="own" >서버 선택 안함
			                                    </label>
			                                    <div style="clear: both"></div>
			                                    <label class="radio"> 
			                                    	<input type="radio" name="serverType" value="auto" >서버 자동으로 만들기 - apm, tomcat6, tomcat7 제공
			                                    </label>
			                                </div>
		                           		</div>
	                           		
		                               <button type="submit" class="btn" name="buttonCheck" value="clicked">만들기</button>
	                       			   <br><br><br>
	                           		</form>
	                           		
	                           		
	                           		<input type="hidden" name="os" value='<%= ls.get(index).getOs()%>'>
	                           		<input type="hidden" name="serverType" value='<%= serverType%>'>
	                           		<input type="hidden" name="server_name" value='<%= request.getParameter("s_name")%>'>
	                           		
									    <% 
									    if(serverType != null){
									    	//domain count
									    	int domainCnt = 0;
											for(int i=1;i<dl.size();i++){
												if(dl.get(i).getServer() == ""){
													domainCnt++;
												}
											}
											
											//domain X
											if(domainCnt == 0){%>
												<div class="alert alert-block">
													<h4 class="alert-heading">No subdomain!</h4>
													<p>사용 가능한 서브 도메인이 없습니다. 관리자에게 문의하세요. - <b><%=lu.get(0).getEmail() %></b></p>
												</div>
											<%}else{
										 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  domain yes 	
												String os_name = request.getParameter("os");
												if(!ls.get(index).getServer().equals("waiting")){ //waiting 상태가 아니면 프로그레스 바 실행!!
													if(os_name.equals("Ubuntu")){
			                           				%>
			                           		
							           					<!-- os progress bar -->
										    		<h5>OS 켜는 중</h5>
									    			<div class="progress progressAnimate yellow"></div>
													<div class="field_notice">진행률: <span class="must progressAnimateValue">0%</span></div>
													<%
													}else{%>
					                           		
					                           					<!-- os progress bar -->
											    		<h5>OS 켜는 중</h5>
										    			<div class="progress progressUploadAnimate yellow"></div>
													<div class="field_notice">진행률: <span class="must progressUploadAnimateValue">0%</span></div>
													<%
														
													}
												} 
										    	CreateOS create = new CreateOS();
										    	create.startOS(request.getParameter("s_name"));
									    		sv.updateServerList(index, 5, "waiting");
									    	%>
											    	<form name="f1" target="pop_win"><!-- action="server_auto"  -->
				                           		<input type="hidden" name="index" value='<%= index %>'>
				                           		<input type="hidden" name="os" value='<%= ls.get(index).getOs()%>'>
				                           		<input type="hidden" name="serverType" value='<%= serverType%>'>
				                           		<input type="hidden" name="server_name" value='<%= request.getParameter("s_name")%>'>
											<%
										    if(serverType.equals("auto")){  // make server we provide
										    	
										    	%>
												<h3>[자동 생성]</h3><br>
												<%
										    	if(os_name.equals("CentOS")){
											%>
											
												<div class="form-group">
												    <h4>서버 종류를 고르세요.</h4>
												    <select class="form-control" name="server">
												        <option value="APM+Phpmyadmin">APM + phpmyadmin</option>
												        <option value="Tomcat6">Tomcat 6</option>
												        <option value="Tomcat7">Tomcat 7</option>
												    </select>
												</div>
												<div class="form-group">
												    <h4>서브 도메인을 선택하세요.</h4>
												    <select class="form-control" name="domain">
												    <%for(int i=1;i<dl.size();i++){ 
										 				if(dl.get(i).getServer() == ""){%> 
															<option value='<%= dl.get(i).getSubDom()%>'><%= dl.get(i).getSubDom()%></option>
														<%} 
														}
												}else{ //ubuntu%>
													<div class="form-group">
													    <h4>서버 종류를 고르세요.</h4>
													    <select class="form-control" name="server">
													        <option value="Apache">Apache</option>
													        <option value="Tomcat6">Tomcat 6</option>
													        <option value="Tomcat7">Tomcat 7</option>
													    </select>
													</div>
													<div class="form-group">
													    <h4>서브 도메인을 선택하세요.</h4>
													    <select class="form-control" name="domain">
													    <%for(int i=1;i<dl.size();i++){ 
											 				if(dl.get(i).getServer() == ""){%> 
																<option value='<%= dl.get(i).getSubDom()%>'><%= dl.get(i).getSubDom()%></option>
															<%} 
														  }
													}%>    
											    	</select>
												</div>
												<input type="hidden" name="port" value="1">
																					    
											<%
										    }else{ // make own server
											%>
											<h3>[서버 생성]</h3><br>
												<input type="hidden" name=server value="undefined">
												<div class="form-group">
												    <h4>서브 도메인을 선택하세요.</h4>
												    <select class="form-control" name="domain">
												    <%for(int i=1;i<dl.size();i++){ 
										 				if(dl.get(i).getServer() == ""){%> 
															<option value='<%= dl.get(i).getSubDom()%>'><%= dl.get(i).getSubDom()%></option>
														<%} 
										 			}%>     
											    	</select>
											    	<br><br>
											    	포트 번호 설정 (20,21,22제외, 1~65535 까지 가능) : <input type="text" name="port" value="80"><!-- else  -->
												</div>
											<%}%>
											<button type="button" name="create_btn" class="btn" onclick="OnButton1()">Create Server</button>
			                               </form>
			                               
		                               <%
									   }
									    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////doamin yes
									    }
                             		}
                             //server exist	
                             }else if(ls.get(index).getServer() == "" && domain.getInfo().state.toString().equals("VIR_DOMAIN_RUNNING")){
                            	 %>
                            	 	<br>
                            	 <div class="alert alert-error">
                            	 	<strong>OS 생성 중!</strong>
                            	 	OS가 아직 생성 중 입니다. 잠시만 기다려 주세요. &nbsp;<i class="fali fa fa-spinner fa-spin"></i> 
                            	 </div>
                            	 <%
                             }else if(ls.get(index).getServer().equals("temp_server")){%>
                            	 <br>
                            	 <div class="alert alert-error">
                            	 	<strong>서버 생성 중!</strong>
                            	 		서버가 아직 생성 중 입니다. 잠시만 기다려 주세요. &nbsp;<i class="fali fa fa-spinner fa-spin"></i> 
                            	 </div>
                             <%}else{
                             System.out.println(domain.getInfo().state.toString());%>
                             <h3>[<%=ls.get(index).getName() %>]</h3>
                             <div align="right">
                             	Connet to FTP,<button class="btn btn-mini btn-info" onclick="gotoFtp()">Goto FTP</button>
                             	Connet to SSH,<button class="btn btn-mini btn-warning" onclick="gotoSsh()">Goto SSH</button></a>
                             </div>
                             <table class="table table-bordered table-hover table-striped">
                                <thead>
                                    <tr>
                                        <th>Detail</th>
                                        <th>Instance information</th>
                                    </tr>
	                            </thead>
	                            <tbody>
	                            	<tr>
		                            	<td>서버 이름</td>
		                            	<td><%= ls.get(index).getName() %></td>
		                            </tr>
		                            <tr>
		                            	<td>공인 IP</td>
		                            	<td><%= ls.get(index).getIp() %></td>
		                            </tr>
		                            <%
                                    try {
                                		String msg = "", emsg = "";
                                		Process p = null;
                               			String[] cmd = {"/bin/bash","-c","echo " + password
                               							+ " | sudo -S sh /netsh/virt-addr.sh "+ ls.get(index).getName() };
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
		                            }%>
						                <tr>
						                    <td>가상 IP</td>
						                    <td><%= virtIp%></td>
						                </tr>
						                <tr>
						                    <td>서브 도메인</td>
						                    <td><%= ls.get(index).getDomain()%></td>
						                </tr>
		                            <tr>
		                            	<td>운영체제</td>
		                            	<td><%= ls.get(index).getOs() %></td>
		                            </tr>
		                            <tr>
		                            	<td>서버 타입</td>
		                            	<td><%= ls.get(index).getServer() %></td>
		                            </tr>
		                            <tr>
		                            	<td>Cpu</td>
		                            	<td><%= ls.get(index).getCpu()%> vCore</td>
		                            </tr>
		                            <tr>
		                            	<td>Memory</td>
		                            	<td><%=ls.get(index).getRam() %> MB</td>
		                            </tr>
		                            <tr>
		                            	<td>Disk</td>
		                            	<td><%= ls.get(index).getDisk()%> GB</td>
		                            </tr>
		                            <tr>
		                            	<td>상태</td>
		                            	<%if(domain.getInfo().state.toString().equals("VIR_DOMAIN_RUNNING")){%>
		                            	<td><span class="label label-success">running</span> </td>
		                            	<%}else{ %>
		                            	<td><span class="label label-important">stop</span></td>
		                            	<%} %>
		                            </tr>
		                            <%if(id == 1){ %>
		                            <tr>
		                            	<td><font color="#FF8000">*사용자 이름</font></td>
		                            	<td><font color="#FF8000"><%= ul.getName(ls.get(index).getId())%></font></td>
		                            </tr>
		                            <%} %>
	                            </tbody>
	                            </table>
	                                                     	
		                     
	                            <%
									Domain d = conn.domainLookupByName(ls.get(index).getName());
	                            if(d.getInfo().state.toString().equals("VIR_DOMAIN_RUNNING")){ %>
		                            <form action="server_status_temp" method="post">
	                         		<input type="hidden" name="ser_index" value='<%=String.valueOf(index) %>'>
	                            	<button type="submit" class="btn btn-danger" name="status_btn" value="deleted" style="float:right; margin-right: 3px">Delete</button>
		                            <button type="submit" class="btn btn-warning" name="status_btn" value="restart" style="float:right; margin-right: 8px">restart</button>
		                            <button type="submit" class="btn btn-danger" name="status_btn" value="stop" style="float:right; margin-right: 3px">stop</button>
		                            <button type="submit" class="btn btn-success" name="status_btn" value="start" style="float:right; margin-right: 3px" disabled="disabled">start</button>
		                            <br>
		                            </form>
	                            <%}else{%>
										<form action="server_status_temp" method="post">
	                         		<input type="hidden" name="ser_index" value='<%=String.valueOf(index) %>'>
										<button type="submit" class="btn btn-danger" name="status_btn" value="deleted" style="float:right; margin-right: 3px">Delete</button>
	                            	<button type="submit" class="btn btn-warning" name="status_btn" value="restart" style="float:right; margin-right: 8px" disabled="disabled">restart</button>
		                            <button type="submit" class="btn btn-danger" name="status_btn" value="stop" style="float:right; margin-right: 3px" disabled="disabled">stop</button>
		                            <button type="submit" class="btn btn-success" name="status_btn" value="start" style="float:right; margin-right: 3px">start</button>
		                            </form>
		                            <br>
	                            	<%}
                             	}
                             }
                             	
                       	conn.close();
                       	%>
                             	
                        </div>
		<!-- /.row -->
<%@include file = "../layout/foot.jsp"%>