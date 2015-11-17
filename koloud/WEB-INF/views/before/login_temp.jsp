<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="javax.tools.JavaFileManager.Location"%>
<%@ page import="java.io.*, net.kbssm.koloud.User.UserConvert, net.kbssm.koloud.User.User, java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("user");
	String pw = request.getParameter("password");	
	
	UserConvert cv = new UserConvert();
	List<User> lu = cv.getUserList();
	
		
	//password check
	for(int i=0;i<lu.size();i++){
		if(name.equals("admin")){ //email 값이 admin이면...(admin 최초 or 로그인 시)
			if(lu.get(i).getName().equals(name) && lu.get(i).getPassword().equals(pw)){ 	//check password right
				if(lu.get(i).getPassword().equals("admin")){ 	//password == admin ... move to domain setting pages
					response.sendRedirect("/koloud/index_first");
				}else{
					%>
					<script type="text/javascript">
						alert("이메일을 입력해 주세요.");
						location.href = "/koloud"; 
					</script>
					<%
				}
			}else{ //password wrong
				%>
				<script type = "text/javascript">
					alert("wrong password");
		 			location.href = "/koloud/"; 
				</script>
				<%
			}
		}
		//admin, guest 둘다.. 이메일 입력 받는 경우
		if(lu.get(i).getEmail().equals(name)){
			System.out.println(name);
			if(lu.get(i).getPassword().equals(pw)){ 		//check password right
				
				session.setAttribute("id", name);

				cv.updateVisitCnt(); //방문 수 카운트 업
				
				response.sendRedirect("/koloud/home");
				return;
			}else{ //password wrong
				%>
				<script type = "text/javascript">
					alert("wrong password");
		 			location.href = "/koloud/"; 
				</script>
				<%
			}
		}else{ 												//Invalid email
			%>
			<script type = "text/javascript">
				alert("check your Email");
	 			location.href = "/koloud/"; 
			</script>
			<%
		}
	}
			
	
%>
<script src="../koloud/resources/js/jquery.js"></script>
</body>
</html>