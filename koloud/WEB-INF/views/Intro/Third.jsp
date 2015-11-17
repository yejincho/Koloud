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
// 	kDomainConvert dc = new kDomainConvert();	
// 	List<kDomain> ld = dc.getDomainList();
	
%>
</head>
<body>
	<section>
		<div class="section-wrapper">
			<div class="layout-twothirds-center">
				<input id="returnUrl" type="hidden" value="/logged-out">
				<div id="error" class="hidden">
					<p class="error-message"></p>
				</div>
				<h1>Register Account</h1>
				<div class="login-password-container">
					<div class="login-password-container-email">
						 <form action="intro_temp" METHOD="POST">
						 		<label for="user">Username</label> 
						 		<input type="text" disabled="disabled" value="admin">
								<label for="email">Email</label> 
								<input type="email" name="email" id="email" tabindex="1" autocorrect="off" spellcheck="false"
										autocapitalize="off" autofocus="" placeholder="e.g., joyejin@mail.com"> <br>
							
								[Current Password is <i><b><font color="#FF9900">"admin"</font></b></i>]<br>
								Change Password
								<input type="password" name="usrPw" tabindex="2" placeholder="e.g., ************">
								Check Again
								<input type="password" name="usrPwCheck" tabindex="3" placeholder="e.g., ************"> 
					        
							    <input type="hidden" name=step value="step3">
								<input type="SUBMIT" tabindex="44" value="NEXT" class="button button-green">
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	
	
</body>
</html>