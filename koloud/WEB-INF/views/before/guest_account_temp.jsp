<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.kbssm.koloud.User.*" %>
<%@ page import="java.util.List, java.util.ArrayList" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String name = request.getParameter("id");
	String new_pw1 = request.getParameter("new_pw1");
	String new_pw2 = request.getParameter("new_pw2");
	
	UserConvert uc = new UserConvert();
	if(name.equals("admin")){
		if(new_pw1!="" && new_pw2!=""){
			if(new_pw1.equals("admin")){
				%>
				<script type="text/javascript">
					alert("Password cannot be 'admin'");
					location.href="users";
				</script>
				<%
			}
			else if(new_pw1.equals(new_pw2)){
				uc.updateUserList(name, new_pw1);
				%>
				<script type="text/javascript">
					alert("Changes Success!");
					location.href="users";
				</script>
				<%
			}
			else{
				%>
				<script type="text/javascript">
					alert("new passwords are not match");
					location.href = "/koloud/users";
				</script>
				<%
			}			
		}else{
			%>
			<script type="text/javascript">
				alert("Fill out all forms!");
				location.href = "/koloud/users";
			</script>
			<%
		}
	}else{
		if(new_pw1!="" && new_pw2!=""){
			if(new_pw1.equals(new_pw2)){
				uc.updateUserList(name, new_pw1);
				%>
				<script type="text/javascript">
					alert("Changes Success!");
					location.href="/koloud/users";
				</script>
				<%
			}else{
				%>
				<script type="text/javascript">
					alert("new passwords are not match");
					location.href = "/koloud/users";
				</script>
				<%
			}
		}else{
			%>
			<script type="text/javascript">
				alert("Fill out all forms!");
				location.href = "/koloud/users";
			</script>
			<%
		}
	}
		
%>
