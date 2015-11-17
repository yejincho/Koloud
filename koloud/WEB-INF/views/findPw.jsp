<html
	class="no-js wf-jaffacitweb-i3-active wf-jaffacitweb-n3-active wf-jaffacitweb-n7-active wf-active">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Log in to Koloud</title>
<meta name="description" content="Log in to Trello.">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../koloud/resources/css/login.css" rel="stylesheet">
<style>/*! normalize.css v3.0.1 | MIT License | git.io/normalize */

</style>

<style type="text/css">
.tk-jaf-facitweb {
	font-family: "jaf-facitweb", sans-serif;
}
</style>
<link rel="stylesheet"
	href="https://use.typekit.net/c/dec476/1w;jaf-facitweb,2,Y1j:P:i3,Y1h:P:n3,Y1n:P:n7/d?3bb2a6e53c9684ffdc9a9bf5195b2a620ddcd3046f58c4dc110107391970d742d68f54f2302912f45338f8b83af8c369f5562da8832b6d369ea07aa62e5912a1f39424c41df45d8267fab52e225632fe4bf7b177ad3a7a5d906810a1e9f0f0bb0a241fe5500172f9d6b0cd13f72be0cbabbcf38d1ae56d9cf47d99fad1ab51f819f3854df7">
</head>
<body>
	<section>
		<div class="section-wrapper">
			<div class="layout-twothirds-center">
				<input id="returnUrl" type="hidden" value="/logged-out">
				<div id="error" class="hidden">
					<p class="error-message"></p>
				</div>
				<h1>Find Password</h1>
				<form action="findPw_temp" METHOD="POST">
				<div class="login-password-container">
					<div class="login-password-container-email">
						<label for="user">UserName <span class="quiet"></span></label> 
							<input type="text" name="user" value="" tabindex="1" placeholder="e.g., jinnie"> 
						<label for="email">Email</label> 
							<input type="email" name="email" tabindex="2" placeholder="e.g., koloud@koloud.com"> 
							
							<input type="SUBMIT" tabindex="3" value="Find" class="button button-green">
					</div>
				<p class="quiet">
					Temporal password will send to your email  <br>
					<a href="/koloud" tabindex="4">Log In</a>
				</p>
			</div>
			</form>
		</div>
		</div>
	</section>
	
<%@ include file="layout/foot.jsp" %>