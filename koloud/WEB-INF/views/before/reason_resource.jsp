<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String s_name = request.getParameter("s_name");
	int index_resource = Integer.parseInt(request.getParameter("index_resource").toString());
	String permission = request.getParameter("permission");
	
%>	

		<!-- start: Content -->
		<div id="content" class="span10">
			<ul class="breadcrumb">
				<li>
					<i class="fa fa-home"></i>
					<a href="/koloud/home">Home</a> 
					<i class="fa fa-angle-right"></i>
					<a href="/koloud/request_resources">자원 변경 요청</a> 
					<i class="fa fa-angle-right"></i>
				</li>
				<li><a href=" ">거절 사유</a></li>
			</ul>
			
			
			
		<!-- Page Content -->
		<div class="row-fluid">
		   <div class="col-lg-6">
            
                <!-- Page Heading -->
                <h3>Send Guest</h3>
                <!-- /.row -->
				<form action="/koloud/request_resource_temp">
				<div class ="form-group">
                    <p class="form-control-static">거절 사유를 입력해 주세요.</p>
                    <textarea rows="10" cols="300" name="reason"></textarea>
                </div>
                <input type="hidden" name="servername" value="<%=s_name %>">
                <input type="hidden" name="index_resource" value="<%=index_resource %>">
                <input type="hidden" name="index" value="<%=String.valueOf(0) %>">
				
                <button type="submit" name="btn-reason" value="send-deny">Send</button>
                <button type="submit" name="btn-reason" value="cancel">cancel</button>
                
                </form>
            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->
        </div>
<%@ include file = "../layout/foot.jsp"%>

