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
			<div class="row-fluid sortable">
				<div class="box span12">
					<div class="box-header" data-original-title>
						<h2><i class="fa fa-pencil-square-o "></i><span class="break"></span>옵션 선택</h2>
						<div class="box-icon">
						</div>
					</div>
					<div class="box-content">
						<form class="form-horizontal" action="request_server_temp" method="post" role="form" >
							<fieldset>
							  <div class="control-group">
									<label class="control-label" for="focusedInput">서버 이름</label>
									<div class="controls">
									  <input class="input-xlarge focused" id="focusedInput" name="s_name" type="text" value="">
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
								<button type="submit" class="btn btn-primary">Send Request</button>
							  </div>
							</fieldset>
						  </form>
					
					</div>
				</div><!--/span-->
			
			</div><!--/row-->
		</div>
<%@include file = "../layout/foot.jsp"%>


