<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%@page import="javax.swing.text.Document"%>
<%@ page import="net.kbssm.koloud.Virtual.*" %>
<%@ page import="java.io.*" %>
<%@page import="net.kbssm.koloud.kDomain.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="org.libvirt.*, net.kbssm.koloud.OS.*"%>
<link href="../koloud/resources/css/plugins/chosen.css" rel="stylesheet">
<%
	request.setCharacterEncoding("utf-8");
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
%>
<script type="text/javascript">
	function valuesend(){
		var win = window.open("","value","width=450, height=50");
		document.frm.target = "value";
		document.frm.action="http://<%=ip%>:8080/koloud/server_temp";
		document.frm.submit();
	}
	function alert_d(){
		var servername = frm.s_name.value;
		var first = servername.substr(0,1);
		var reg = true;
		if(servername == "")
			reg = false;
		else if(first == '0' || first == '1' || first == '2' || first == '3' || first == '4' || first == '5' || first == '6' || 
				first == '7' || first == '8' || first == '9' || first == ' ')
			reg = false;
		if(reg == true){
			var serReg = /^[a-zA-Z_0-9]*$/;
			if(serReg.test(servername) == true){
				location.href="/koloud/OSCreateInfo";
				
			}
			else{
				frm.s_name.focus();
				location.href="/koloud/create_server";
				
			}
		}else{
			frm.s_name.focus();
			location.href="/koloud/create_server";
		}
		
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
				<li><a href="/koloud/create_server">OS 생성</a></li>
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
			
			
			<!-- new -->
			<div class="row-fluid sortable">
				<div class="box span12">
					<div class="box-header" data-original-title>
						<h2><i class="fa fa-pencil-square-o "></i><span class="break"></span>옵션 선택</h2>
						<div class="box-icon">
						</div>
					</div>
					<div class="box-content">
						<form class="form-horizontal" name="frm" method="post">
							<fieldset>
							  <div class="control-group">
									<label class="control-label" for="focusedInput">서버 이름</label>
									<div class="controls">
									  <input class="input-large span5" id="s_name" name="s_name" type="text" tabindex="1" placeholder="type server name"/>
									  <input type="hidden" name="ip" value=<%=ip %>>
	                         	  <input type="hidden" name="id" value=<%=String.valueOf(id) %>>
									</div>
							  </div>

						<div class="control-group">
							<label class="control-label">RAM 선택</label>
							<div class="controls">
								<label class="radio"> <input type="radio" name="ram"
									id="opRam1" value="512" checked="">512 MB
								</label>
								<div style="clear: both"></div>
								<label class="radio"> <input type="radio" name="ram"
									id="opRam1" value="682">682 MB
								</label>
								<div style="clear: both"></div>
								<label class="radio"> <input type="radio" name="ram"
									id="opRam1" value="852">852 MB
								</label>
								<div style="clear: both"></div>
								<label class="radio"> <input type="radio" name="ram"
									id="opRam1" value="1024">1024 MB
								</label>
							</div>
						</div>


						<div class="control-group">
							<label class="control-label">CPU 선택</label>
							<div class="controls">
								<label class="radio"> <input type="radio" name="cpu"
									id="opcpu1" value="1" checked="">1 vCore
								</label>
								<div style="clear: both"></div>
								<label class="radio"> <input type="radio" name="cpu"
									id="opcpu1" value="2">2 vCore
								</label>
								<div style="clear: both"></div>
								<label class="radio"> <input type="radio" name="cpu"
									id="opcpu1" value="3">3 vCore
								</label>
							</div>
						</div>
						
						

						<div class="control-group">
							<label class="control-label">DISK 선택</label>
							<div class="controls">
								<label class="radio"> <input type="radio" name="disk"
									id="opdisk1" value="20" checked="">20 GB
								</label>
								<div style="clear: both"></div>
								<label class="radio"> <input type="radio" name="disk"
									id="opdisk1" value="30">30 GB
								</label>
								<div style="clear: both"></div>
								<label class="radio"> <input type="radio" name="disk"
									id="opdisk1" value="40">40 GB
								</label>
								<div style="clear: both"></div>
								<label class="radio"> <input type="radio" name="disk"
									id="opdisk1" value="50">50 GB
								</label>
							</div>
						</div>



							  <div class="control-group">
								 	<label class="control-label"> OS 선택</label>
						  			<div class="controls">
									  	<select class="form-control" name="os" data-rel="chosen">
			                             <option value="Ubuntu">Ubuntu 32bit 12.04 LTS Server</option>
			                             <option value="CentOS">CentOS 32bit 6.6 Server</option>
			                         </select>
	                    			</div>
		                   </div>
							  
							  <div class="form-actions">
								<button type="button" class="btn btn-primary" onclick="valuesend(); alert_d()">Create OS</button>
							  </div>
							</fieldset>
						  </form>
					
					</div>
				</div><!--/span-->
			
			</div><!--/row-->
		</div>
<%@include file = "../layout/foot.jsp"%>


