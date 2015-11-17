<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%@ page import="net.kbssm.koloud.User.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String new_pw1 = request.getParameter("new_pw1");
	String new_pw2 = request.getParameter("new_pw2");
	String pw = lu.get(ul.getIndex(id)).getPassword();
	
	String clickCheck = request.getParameter("clickCheck");
	
%>

<!-- start: Content -->
		<div id="content" class="span10">
			<ul class="breadcrumb">
				<li>
					<i class="fa fa-home"></i>
					<a href="/koloud/update_account">편집</a> 
				</li>
			</ul>
		
	<!-- Page Content -->
		<div class="row-fluid">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Setting Account
                            <small>Subheading</small>
                        </h1>
                    </div>
                </div>
                <!-- /.row -->
                <!-- user info -->
                <div class="table-responsive">
                     <table class="table table-bordered table-hover table-striped">
                         <thead>
                             <tr>
                                 <th></th>
                                 <th>Information</th>
                             </tr>
                         </thead>
                         <tbody>
                          	 <tr>
                          	 	<td>Name</td>
                          	 	<td><%=name %></td>
                             <tr>
                          	 <tr>
                          	 	<td>Email</td>
                          	 	<td><%=ul.getEmail(id) %></td>
                             <tr>
                          	 <tr>
                          	 	<td>Status</td>
                          	 	<%if(lu.get(ul.getIndex(id)).getLevel() == 3) {%>
                          	 		<td>ADMIN</td><%} %> 
                          	 		
                          	 	<%if(lu.get(ul.getIndex(id)).getLevel() == 2){ %>
                          	 		<td>ACCEPTED MEMBER</td><%} %>
                          	 		
                          	 	<%if(lu.get(ul.getIndex(id)).getLevel() == 1){ %>
                          	 		<td>GUEST</td><%} %>
                          	 	</td>
                             <tr>
                         </tbody>
                      </table>
                </div>
                
                <br>
                <!-- user settings -->
                <form action="/koloud/account_temp" method="post">
					<div class ="form-group">
	                   	<h2><p class="form-control-static"><input type="hidden" name="name" value="<%=name %>"> <%=name %> </p></h2>
						<a href="/koloud/update_account?clickCheck=dashboard">Change Password for <b>Dashboard</b></a><br><br>
						<%if(clickCheck!=null){%>
		                	  	(Current) password : <input type="password" name="inputPw"><br>
			                	Enter new password : <input type="password" name="new_pw1"><br>
			                	Retype new password : <input type="password" name="new_pw2"><br><br>
			            		<button type="submit" name="btn-edit">save</button>     
			             <%} %>
	                </div>         	
            	</form>
            <!-- /.container-fluid -->
		
        </div>
        <!-- /#page-wrapper -->
<%@ include file = "../layout/foot.jsp"%>