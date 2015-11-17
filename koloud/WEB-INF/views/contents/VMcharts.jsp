<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../layout/Wrapper.jsp"%>
<%@page import="net.kbssm.koloud.kDomain.*,net.kbssm.koloud.OS.*"%>
<%@ page import="net.kbssm.koloud.Virtual.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="org.libvirt.*"%>
<!-- <link href="../koloud/resources/css/style.css" rel="stylesheet"> -->
<%
	request.setCharacterEncoding("utf-8");
	ServerConvert sv = new ServerConvert(id);
	List<Server> ls = sv.getServerList();
	
	kDomainConvert dc = new kDomainConvert();
	List<kDomain> ld = dc.getDomainList();

	UserConvert uc = new UserConvert();
	
	//	System.out.println(sv.getServerList().size());
	String status = null;
	String clickCheck = request.getParameter("clickCheck");
	String clickId = request.getParameter("clickId");

	//virtual os info

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
	int CntforServerNull = 0;
	for(int i=1;i<ls.size();i++){
		if(ls.get(i).getId() == id && ls.get(i).getPermission() == 2){
			CntforServer++;
		}
		if(ls.get(i).getServer() != ""){
			CntforServerNull++;	
		}
	}
	
	long kbTogb = 1024*1024*1024;
%>

		<!-- start: Content -->
		<div id="content" class="span10">
			<ul class="breadcrumb">
				<li>
					<i class="fa fa-home"></i>
					<a href="/koloud/home">Home</a> 
					<i class="fa fa-angle-right"></i>
				</li>
				<li>
					<i class="fa  fa-dashcube"></i>
					<a href=" ">자원 관리</a> 
					<i class="fa fa-angle-right"></i>
				</li>
				<li><a href="/koloud/VMcharts">가상 OS 자원</a></li>
			</ul>
			
			
		<!-- Page Heading -->
<!-- 		<li class="active"><i class="fa fa-bar-chart-o"></i> 호스트 정보</li> -->
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
				<h3>Pick a Server to Monitoring</h3>
				<form action="server_status_temp" METHOD="POST">
					<div class="table-responsive">
						<!--                         <input type="hidden" name="server" value="not"> -->
						<table class="table table-bordered table-hover table-striped">
							<thead>
								<tr>
									<th>서버 이름</th>
									<th>운영체제</th>
									<th>스펙(cpu, ram, disk)</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<%
								if(id != 1 && CntforServer == 0 || id != 1 && CntforServerNull == 0){
	                            	%>
	                            	<td colspan="4" align="center">No Monitoring List for Virtual OS</td>
	                            	<%
	                            }else if(id == 1 && ls.size() == 1 || id == 1 && CntforServerNull == 0){
	                            	%>
	                            	<td colspan="4" align="center">No Monitoring List for Virtual OS</td>
	                            	<%
	                            }
								if (id != 1) { //guest%>
											
									<div class="form-group">
										<p class="form-control-static">*정보를 보시려면 서버를 키셔야 합니다.</p>
									</div>
									<%for (int i = 1; i < ls.size(); i++) {
										if (ls.get(i).getId() == id && ls.get(i).getServer() != "" && ls.get(i).getPermission() == 2) { //guest id check, server exist
											Domain domain;
											domain = conn.domainLookupByName(ls.get(i).getName());
											
											if(domain.getInfo().state.toString().equals("VIR_DOMAIN_RUNNING")){%>
											
											<tr>
												<td><a
													href="/koloud/VMcharts?clickCheck=<%=ls.get(i).getName()%>&clickId=<%=String.valueOf(i)%>"><%=ls.get(i).getName()%></a></td>
												<td><%=ls.get(i).getOs()%></td>
												<td><%=ls.get(i).getCpu()%> vCore / <%=ls.get(i).getRam()%> MB / <%=ls.get(i).getDisk()%> GB</td>
												<td><span class="label label-success">running</span></td>
											</tr>
			                            <%}else{ %>
			                            <tr>
												<td><%=ls.get(i).getName()%></td>
												<td><%=ls.get(i).getOs()%></td>
												<td><%=ls.get(i).getCpu()%> vCore / <%=ls.get(i).getRam()%> MB / <%=ls.get(i).getDisk()%> GB</td>
												<td><span class="label label-important">stop</span></td>
											</tr>
			                                <%}
										}
									}
								} else { //admin
									%>
									<div class="form-group">
										<p class="form-control-static">*정보를 보시려면 서버를 키셔야 합니다.</p>
									</div>
									<%
									for (int i = 1; i < ls.size(); i++) {
										if (ls.get(i).getServer() != "" && !ls.get(i).getServer().equals("waiting") 
												&& !ls.get(i).getServer().equals("temp_server") && ls.get(i).getPermission() == 2) {
											Domain domain;
											domain = conn.domainLookupByName(ls.get(i).getName());
											
											if(domain.getInfo().state.toString().equals("VIR_DOMAIN_RUNNING")){%>
											<tr>
												<td><a
													href="/koloud/VMcharts?clickCheck=<%=ls.get(i).getName()%>&clickId=<%=String.valueOf(i)%>"><%=ls.get(i).getName()%></a></td>
												<td><%=ls.get(i).getOs()%></td>
												<td><%=ls.get(i).getCpu()%> vCore / <%=ls.get(i).getRam()%> MB / <%=ls.get(i).getDisk()%> GB</td>
												<td><span class="label label-success">running</span></td>
											</tr>
			                            <%}else{ %>
			                            <tr>
												<td><%=ls.get(i).getName()%></td>
												<td><%=ls.get(i).getOs()%></td>
												<td><%=ls.get(i).getCpu()%> vCore / <%=ls.get(i).getRam()%> MB / <%=ls.get(i).getDisk()%> GB</td>
												<td><span class="label label-important">stop</span></td>
											</tr>
			                                <%}
										}
									}
								}
							%>
							</tbody>
						</table>
					</div>
				</form>
				<!-- clickCheck == true(Show Detail info) -->
				
				<%
					if (clickCheck != null && clickId != null) {	
						int index = Integer.parseInt(clickId);
							String virtIp = "";
	
							try {
								
								Domain domain = conn.domainLookupByName(ls.get(index).getName());
								String msg = "", emsg = "";
								Process p = null;
								System.out.println(ls.get(index).getName());
								String[] cmd = {
										"/bin/bash",
										"-c",
										"echo " + password
												+ " | sudo -S sh /netsh/virt-addr.sh "
												+ ls.get(index).getName() };
								p = Runtime.getRuntime().exec(cmd);
								p.waitFor();
								BufferedReader inOut = new BufferedReader(
										new InputStreamReader(p.getInputStream()));
								BufferedReader inErr = new BufferedReader(
										new InputStreamReader(p.getErrorStream()));
								while ((msg = inOut.readLine()) != null) {
									String a = msg;
// 									System.out.println(a.charAt(0));
									if (a.charAt(0) == '1')
										virtIp = a;
								}
								while ((emsg = inErr.readLine()) != null) {
									System.out.println("Error = " + emsg);
								}
								p.destroy();
							} catch (Exception e) {
								System.out.println(e.toString());
							}
					%>
				
	
	
				<!-- For test -->
				<%
				Domain domain = conn.domainLookupByName(clickCheck);
     			StoragePool strPool = conn.storagePoolLookupByName("default");
     			StorageVol testStVol = conn.storageVolLookupByPath("/var/lib/libvirt/images/" + clickCheck + ".img");
				
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
							<td>CPU 이용률</td>
							<td><%= Math.floor((double)domain.getInfo().nrVirtCpu/domain.getMaxVcpus()*100)%>%</td>
						</tr>
						<tr>
							<td>Memory 사용률</td>
							<td><%= Math.floor((double)(domain.getInfo().maxMem - domain.getInfo().memory)/domain.getInfo().maxMem * 100) %>%</td>
						</tr>
						<tr>
							<td>Disk 사용률</td>
							<td><%=testStVol.getInfo().allocation/testStVol.getInfo().capacity%>%</td>
						</tr>
						<tr>
							<td>운영체제</td>
							<td>Ubuntu</td>
						</tr>
					</tbody>
					
				</table>
				
				
				<!-- For Circletest -->
				
				
				<div class="row-fluid hideInIE8 circleStats">
				
					<div class="span2" onTablet="span4" onDesktop="span2">
	                	<div class="circleStatsItemBox yellow">
							<div class="header">Disk 유효량</div>
							<span class="percent">percent</span>
							<div class="circleStat">
	                    		<input type="text" value="<%=Math.floor((double)(testStVol.getInfo().capacity - testStVol.getInfo().allocation)/testStVol.getInfo().capacity*100) %>" class="whiteCircle" />
							</div>		
							<div class="footer">
								<span class="count">
									<span class="number">20</span>
									<span class="unit">GB</span>
								</span>
								<span class="sep"> / </span>
								<span class="value">
									<span class="number"><%= testStVol.getInfo().allocation / kbTogb %></span>
									<span class="unit">GB</span>
								</span>	
							</div>
	                	</div>
					</div>	

					<div class="span2" onTablet="span4" onDesktop="span2">
	                	<div class="circleStatsItemBox green">
							<div class="header">Memory 유효량</div>
							<span class="percent">percent</span>
							<div class="circleStat">
	                    		<input type="text" value="<%=Math.floor((double)(domain.getInfo().memory)/domain.getInfo().maxMem * 100) %>" class="whiteCircle" />
							</div>
							<div class="footer">
								<span class="count">
									<span class="number">64</span>
									<span class="unit">MB</span>
								</span>
								<span class="sep"> / </span>
								<span class="value">
									<span class="number"><%=domain.getInfo().maxMem / 1024 %></span>
									<span class="unit">MB</span>
								</span>	
							</div>
	                	</div>
					</div>

					<div class="span2" onTablet="span4" onDesktop="span2">
	                	<div class="circleStatsItemBox greenDark">
							<div class="header">Cpu 사용량</div>
							<span class="percent">percent</span>
	                    	<div class="circleStat">
	                    		<input type="text" value="<%=Math.floor((double)domain.getInfo().nrVirtCpu/domain.getMaxVcpus()*100) %>" class="whiteCircle" />
							</div>
							<div class="footer">
								<span class="count">
									<span class="number">5</span>
									<span class="unit">%</span>
								</span>
								<span class="sep"> / </span>
								<span class="value">
									<span class="number"><%=domain.getMaxVcpus() %></span>
									<span class="unit">vCores</span>
								</span>	
							</div>
	                	</div>
					</div>

				</div>			
				<%} %>
	
	
			</div>
	<!-- /.row -->
	<%
	if(clickCheck != null){
		String subdom = "";
		CreateOS os = new CreateOS();
		String ip = os.ip();
		String url = "http://"+ip+":1990/?scope=";
		for(int i=1;i<ld.size();i++){
			if(ld.get(i).getServer().equals(clickCheck)){
				subdom = ld.get(i).getSubDom();
			}
		}
		String cutdom = "";
		for(int i=0;i<subdom.length();i++){
			if(subdom.charAt(i) == '.')
				break;
			else{
				cutdom += subdom.charAt(i);
			}
		}
		url += cutdom;
	%>
	<iframe src="<%=url%>" style="width: 100%; height:560px; border:none;"></iframe>
	<%} %>
	<% conn.close(); %>
	<!-- /#page-wrapper -->
		</div>

<%@include file="../layout/foot.jsp"%>