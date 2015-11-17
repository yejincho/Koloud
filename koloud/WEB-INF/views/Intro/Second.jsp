<%@page import="net.kbssm.koloud.kDomain.*, java.util.List, java.util.ArrayList"%>
<html
	class="no-js wf-jaffacitweb-i3-active wf-jaffacitweb-n3-active wf-jaffacitweb-n7-active wf-active">
<head>
<meta charset="utf-8">
<title>Intro</title>
<link href="../koloud/resources/css/develop/Intro.css" rel="stylesheet">
<link href="../koloud/resources/font-awesome-4.2.0/css/font-awesome.min.css" rel="stylesheet">
<style type="text/css">
.tk-jaf-facitweb {
	font-family: "jaf-facitweb", sans-serif;
}
</style>
<link rel="stylesheet"
	href="https://use.typekit.net/c/dec476/1w;jaf-facitweb,2,Y1j:P:i3,Y1h:P:n3,Y1n:P:n7/d?3bb2a6e53c9684ffdc9a9bf5195b2a620ddcd3046f58c4dc110107391970d742d68f54f2302912f45338f8b83af8c369f5562da8832b6d369ea07aa62e5912a1f39424c41df45d8267fab52e225632fe4bf7b177ad3a7a5d906810a1e9f0f0bb0a241fe5500172f9d6b0cd13f72be0cbabbcf38d1ae56d9cf47d99fad1ab51f819f3854df7">


<%
	String domain = (String)session.getAttribute("domain");
	kDomainConvert dc = new kDomainConvert();	
	List<kDomain> ld = dc.getDomainList();
	String clickCheck = request.getParameter("clickCheck");
	String clickIndex = request.getParameter("clickIndex");
	
	String ftpDom = "tool";
	String sshDom = "console";
	int flag = 0;

	if(domain != null){
		for(int i=0;i<domain.length();i++){
			if(flag == 0 && domain.charAt(i) == '.'){
				ftpDom += domain.charAt(i);
				sshDom += domain.charAt(i);
				flag = 1;
			}
			else if(flag == 1){
				ftpDom += domain.charAt(i);
				sshDom += domain.charAt(i);
			} 
		}
	
%>
</head>
<%
%>
<body>
	<section>
		<div class="section-wrapper">
			<div class="layout-twothirds-center">
				<h1>Register Sub-Domains</h1>
				
				<div class="login-password-container">
					<div class="login-password-container-email">
					 <form action="subdomain_temp" METHOD="POST">
<!-- 						<input type="hidden" name=step value = "step2"> -->
						<input type="hidden" name="ftpdom" value = '<%=ftpDom%>'>
						<input type="hidden" name="sshdom" value = '<%=sshDom%>'>
						<div class="jumbotron">
							<h3><font color="#FF9900">[<%=ftpDom %>]</font></h3>
								- Will be used Domain for <i>ftp</i><br>
							<h3><font color="#FF9900">[<%=sshDom %>]</font></h3>
								- Will be used Domain for <i>ssh</i><br>
						</div>
						
						<small>e.g., abc.koloud.net -> <b>abc</b></small><br>
							<input type="text" name="subdom" placeholder="e.g., abc " tabindex="1" style="margin-bottom: 0.2em;">
							<button class='btn btn-success' type="submit" tabindex="2">Add</button>
				       <br><br><br>
				     </form>
				     
				     
				       <div id="sub_wrapper">
				       <label for="subdom"><i>added</i> Sub Domains</label>
					       <table class="table table-bordered" id="sub_table" style="width: 400px">
					       		<thead>
					       			<tr>
						       			<td>Sub Domain Name</td>
						       			<td>Delete</td>
						       		</tr>
						       	</thead>
					       		<tbody>
					       		<%
					       		if(ld.size() > 1){
					       			for(int i=1;i<ld.size();i++){
					       				if(ld.get(i).getId() == 1){
					       					%>
					       					<tr>
					       						<td><%=ld.get(i).getSubDom() %></td>
					       						<td><a href="index_second?clickCheck=<%= ld.get(i).getSubDom()%>&clickIndex=<%=i%>"><button class='btn btn-danger'>X</button></a></td>
					       						
					       						<%if(clickCheck != null){
					       								dc.updateDomainList(clickCheck);
					       								response.sendRedirect("/koloud/index_second");
					       								return;
	
						       						}
						       						%>
					       					</tr>
					       					<%
					       					}
					       				}
					       			}
					       		%>
					       		</tbody>
					       </table>  
				       </div>
					   <br>    
					   
					    <form action="intro_temp" method="post">
						    <input type="hidden" name=step value="step2">
							<input type="SUBMIT" value="NEXT" class="button button-green">
						</form>
						
					</div>
			</div>
			</div>
		</div>
	</section>
	
	
</body>
<%
}else{
	response.sendRedirect("/koloud/index_first");
	return;
}
%>
</html>