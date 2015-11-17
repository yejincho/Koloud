<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<!-- start: Content -->
		<div id="content" class="span10">
			<ul class="breadcrumb">
				<li>
					<i class="fa fa-home"></i>
					<a href="/koloud/home">Home</a> 
					<i class="fa fa-angle-right"></i>
				</li>
				<li><a href="/koloud/blank">Proxy Monitoring</a></li>
			</ul>


		<!-- Page Content (íì´ì§ ë´ì©)-->
		<div class="col-lg-6">
			<%
			CreateOS os = new CreateOS();
			String ip = os.ip();
			String url = "http://"+ip+":1990/"; 
			%>

			<iframe src="<%=url%>" style="width: 100%; height:1000px; border:none;"></iframe>
       </div>
       <!-- /.container-fluid -->

        
<%@ include file = "../layout/foot.jsp"%>

