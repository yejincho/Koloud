<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	
	int idd = Integer.parseInt(request.getParameter("id").toString());
	int index = Integer.parseInt(request.getParameter("index").toString());
	String permission = request.getParameter("permission");
	String receiver = request.getParameter("email");
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
				<form action="/koloud/request_temp">
				<div class ="form-group">
                    <p class="form-control-static">거절 사유를 입력해 주세요.</p>
                    <textarea rows="10" cols="50" name="reason"></textarea>
                </div>
                <input type="hidden" name="id" value="<%=idd %>">
                <input type="hidden" name="index" value="<%=index %>">
                <input type="hidden" name="email" value="<%=receiver %>">
				<%if(permission.equals("cancel")){%>
                <button type="submit" name="btn-reason" value="send-cancel">Send</button><button type="submit" name="btn-reason" value="cancel">cancel</button>
                <%}else{ %>
                <button type="submit" name="btn-reason" value="send-deny">Send</button><button type="submit" name="btn-reason" value="cancel">cancel</button>
                <%} %>
                </form>
            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->
        </div>
<%@ include file = "../layout/foot.jsp"%>

