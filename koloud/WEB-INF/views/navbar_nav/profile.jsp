<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%@ page import="java.util.*, java.text.*"%>
<link href="../koloud/resources/css/profile.css" rel="stylesheet"> 
<%
	request.setCharacterEncoding("utf-8");
	String date = new SimpleDateFormat("yyyy.MM.dd	HH:mm").format(new Date());
%>
<script type="text/javascript">
	function valueSend(){
		location.href="mail";
	}
</script>
<!-- new -->
<!-- start: Content -->
		<div id="content" class="span10">
			<ul class="breadcrumb">
				<li>
					<i class="fa fa-home"></i>
					<a href="/koloud/profile">Profile</a> 
				</li>
			</ul>
		
		<!-- new -->
		<div class="span10 noMarginLeft" >
			<div class="message dark">
				<div class="header">
					<h1><i class="fa fa-usr"></i><b><%=name %></b></h1>
					<div class="from"><i class="fa fa-user"></i> <b><%=name %></b> / <%=email %></div>
					<div class="date"><i class="fa fa-clock-o"></i> <%=date %></div>
					<div class="menu"></div>
				</div>
				<div class="content">
					<p style="text-align: center">
					<% if(name.equals("admin")){ %>
						Level : <b>Administrator</b><br>
					<%}else{ %>
						Level : <b>Guest</b><br>
					<%} %>
					Register date : <b><%=ul.getUserList(id).get(0).getTime().toLocaleString() %></b><br>
					Email : <b><%=ul.getUserList(id).get(0).getEmail() %></b><br>
					</p>
				</div>
				<div class="attachments" style="float:right;">
					<a href="/koloud/update_account"><button class="btn btn-success"><i class="fa fa-pencil"></i></button></a>
					<a href="/koloud/mail"><button class="btn btn-warning"><i class="fa fa-envelope"></i></button></a>
				</div>
			</div>
		</div>

<%@ include file="../layout/foot.jsp" %>