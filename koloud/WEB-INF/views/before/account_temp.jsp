<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.kbssm.koloud.User.*" %>
<%@ page import="java.util.List, java.util.ArrayList" %>

<%
	request.setCharacterEncoding("utf-8");
	String email = (String)session.getAttribute("id");
	UserConvert ul = new UserConvert();
	List<User> lu = ul.getUserList();
	
	int id = 0;
	
	
	for(int i=0;i<lu.size();i++){
		if(lu.get(i).getEmail().equals(email)){
			id = lu.get(i).getId();
		}
	}
	

	String name = request.getParameter("name");
	String new_pw1 = request.getParameter("new_pw1");
	String new_pw2 = request.getParameter("new_pw2");
	
	
	String inputPw = request.getParameter("inputPw");
	
	System.out.println(name);
	System.out.println(inputPw);
	System.out.println(id);
	if(id != 1){ //guest
		if(inputPw!=null && new_pw1!=null && new_pw2!=null){
			if(ul.getPassword(id).equals(inputPw)){
				if(new_pw1.equals(new_pw2)){
					ul.updateUserList(id, name, new_pw1);
					%>
					<script type="text/javascript">
						alert("Save Changes Success!");
						location.href = "/koloud/home";
					</script>
					<%
				}
				else{
					%>
					<script type="text/javascript">
						alert("new passwords are not match");
						location.href = "/koloud/update_account";
					</script>
					<%
				}
			}
			else{
				%>
				<script type="text/javascript">
					alert("password is wrong!");
					location.href = "/koloud/update_account";
				</script>
				<%
			}
			
		}else{
			%>
			<script type="text/javascript">
				alert("Fill out all forms!");
				location.href = "/koloud/update_account";
			</script>
			<%
		}
	}
	else{ //admin
		if(new_pw1!="" && new_pw2!=""){
			if(new_pw1.equals("admin")){
				%>
				<script type="text/javascript">
					alert("Password cannot be 'admin'");
					location.href="update_account";
				</script>
				<%
			}
			else if(new_pw1.equals(new_pw2)){
				ul.updateUserList(id, name, new_pw1);
				%>
				<script type="text/javascript">
					alert("Save Changes Success!");
					location.href = "/koloud/home";
				</script>
				<%
			}
			else{
				%>
				<script type="text/javascript">
					alert("new passwords are not match");
					location.href = "/koloud/update_account";
				</script>
				<%
			}			
		}else{
			%>
			<script type="text/javascript">
				alert("Fill out all forms!");
				location.href = "/koloud/update_account";
			</script>
			<%
		}
		
	}
		
	
	
	
%>
