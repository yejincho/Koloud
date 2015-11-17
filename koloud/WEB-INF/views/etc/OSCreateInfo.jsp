<%@ include file="../layout/Wrapper.jsp" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	
%>
<body>
	<div id="content" class="span10">
		<ul class="breadcrumb">
			<li>
				<i class="fa fa-home"></i>
				<a href="/koloud/home">Home</a> 
				<i class="fa fa-angle-right"></i>
			</li>
			<li><a href="/koloud/OSCreateInfo">INFO</a></li>
		</ul>
		<div class="row-fluid" style="height:300px" >	
			<div class="box-content" >
				<div class="alert alert-block" style="height:150px">
					<h4 class="alert-heading">Attention!</h4><br>
					<h3><p>OS생성이 요청되었습니다. 예상 대기 시간은 <b>15분</b> 입니다.</p></h3>
					<h4>1~2분 후 서버 리스트를 확인하세요.</h4><br>
					<p>* 팝업창을 닫을 시, 정상적으로 생성이 되지 않을 수 있습니다.</p>
				</div>
			</div>
		</div><!--/span-->
	</div>
<%@ include file="../layout/foot.jsp" %>