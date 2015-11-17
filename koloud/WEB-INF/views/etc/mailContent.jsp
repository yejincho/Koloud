<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%@ page import="java.util.List, java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String receiver = request.getParameter("clickedName");
	String s_index = request.getParameter("index");
	int index = Integer.parseInt(s_index);
	
%>
	<div id="content" class="span10">
		<ul class="breadcrumb">
			<li>
				<i class="fa fa-home"></i>
				<a href="/koloud/home">Home</a> 
				<i class="fa fa-angle-right"></i>
				<a href="/koloud/mail">메일링</a> 
				<i class="fa fa-angle-right"></i>
			</li>
			<li><a href="/koloud/mailContent">메일읽기</a></li>
		</ul>
		
		<div class="span10 noMarginLeft">
			<div class="message dark">
				<div class="header">
					<h1>"<%=lm.get(index).getSubject() %>"</h1>
					<div class="from"><i class="fa fa-user"></i> <b><%=lm.get(index).getReceiver_name() %></b> / <%=lm.get(index).getReceiver_email() %></div>
					<div class="date"><i class="fa fa-clock-o"></i> 0<%=lm.get(index).getTime().getMonth()+1 %>.<%=lm.get(index).getTime().getDate() %>&nbsp; <b><%=lm.get(index).getTime().getHours() %>:<%=lm.get(index).getTime().getMinutes() %>:<%=lm.get(index).getTime().getSeconds() %></b></div>
					<div class="menu"></div>
				</div>
				<div class="content">
					<p>
						<%=lm.get(index).getContents() %>
					</p>
				</div>
				<div class="attachments" style="float:right;">
					<a href="/koloud/mail"><button class="btn">목록으로</button></a>
				</div>
			</div>
		</div>
	</div>
<%@ include file="../layout/foot.jsp"%>