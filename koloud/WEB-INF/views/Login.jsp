<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<head>
	
	<!-- start: Meta -->
	<meta charset="utf-8">
	<title>Login</title>
	<meta name="description" content="Metro Admin Template.">
	<meta name="author" content="Łukasz Holeczek">
	<meta name="keyword" content="Metro, Metro UI, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
	<!-- end: Meta -->
	
	<!-- start: Mobile Specific -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- end: Mobile Specific -->
	
	<!-- start: CSS -->
	<link href="../koloud/resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="../koloud/resources/css/bootstrap-responsive.min.css" rel="stylesheet">
	<link href="../koloud/resources/css/style.css" rel="stylesheet">
	<link href="../koloud/resources/css/style-responsive.css" rel="stylesheet">
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800&subset=latin,cyrillic-ext,latin-ext' rel='stylesheet' type='text/css'>
	<link href="../koloud/resources/font-awesome-4.2.0/css/font-awesome.min.css" rel="stylesheet">
	<link href="../koloud/resources/font-awesome-4.2.0/css/font-awesome-ie7.min.css" rel="stylesheet">
	<!-- end: CSS -->
	

	<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
	  	<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<link id="ie-style" href="css/ie.css" rel="stylesheet">
	<![endif]-->
	
	<!--[if IE 9]>
		<link id="ie9style" href="css/ie9.css" rel="stylesheet">
	<![endif]-->
		
	<!-- start: Favicon -->
	<link rel="shortcut icon" href="img/favicon.ico">
	<!-- end: Favicon -->
	
		<style type="text/css">
			body { background: url("../koloud/resources/img/bg-login.jpg") !important; }
		</style>
		
		
		
</head>

<body>
		<div class="container-fluid-full">
		<div class="row-fluid">
					
			<div class="row-fluid">
				<div class="login-box">
					<div class="icons">
						<a href="index.html"><i class=""></i></a>
						<a href="#"><i class=""></i></a>
					</div>
					<h2>Login to Koloud</h2>
					<form action="login_temp" METHOD="POST">
						<fieldset>
							
							<div class="input-prepend" title="Username">
								<span class="add-on"><i class="fa fa-user"></i></span>
								<input class="input-large span10" name="user" id="user" type="text" tabindex="1" placeholder="type email"/>
							</div>
							<div class="clearfix"></div>

							<div class="input-prepend" title="Password">
								<span class="add-on"><i class="fa fa-lock"></i></span>
								<input class="input-large span10" name="password" id="password" type="password"  tabindex="2" placeholder="type password"/>
							</div>
							<div class="clearfix"></div>
							
							<div class="button-login">	
								<button type="submit" class="btn btn-primary" tabindex="4" >Login</button>
							</div>
							<div class="clearfix"></div>
							</fieldset>
					</form>
					<hr>
					<p>Forgot Password? <a href="/koloud/findPw" tabindex="5" > Find your password.</a></p>
					<p>Do not have an account? <a href="/koloud/register" tabindex="6">Create a
						Koloud account.</a></p>	
						
				</div><!--/span-->
			</div><!--/row-->
			

	</div><!--/.fluid-container-->
	
		</div><!--/fluid-row-->
	
	<!-- start: JavaScript-->

		<script src="js/jquery-1.9.1.min.js"></script>
	<script src="js/jquery-migrate-1.0.0.min.js"></script>
	
		<script src="js/jquery-ui-1.10.0.custom.min.js"></script>
	
		<script src="js/jquery.ui.touch-punch.js"></script>
	
		<script src="js/modernizr.js"></script>
	
		<script src="js/bootstrap.min.js"></script>
	
		<script src="js/jquery.cookie.js"></script>
	
		<script src='js/fullcalendar.min.js'></script>
	
		<script src='js/jquery.dataTables.min.js'></script>

		<script src="js/excanvas.js"></script>
	<script src="js/jquery.flot.js"></script>
	<script src="js/jquery.flot.pie.js"></script>
	<script src="js/jquery.flot.stack.js"></script>
	<script src="js/jquery.flot.resize.min.js"></script>
	
		<script src="js/jquery.chosen.min.js"></script>
	
		<script src="js/jquery.uniform.min.js"></script>
		
		<script src="js/jquery.cleditor.min.js"></script>
	
		<script src="js/jquery.noty.js"></script>
	
		<script src="js/jquery.elfinder.min.js"></script>
	
		<script src="js/jquery.raty.min.js"></script>
	
		<script src="js/jquery.iphone.toggle.js"></script>
	
		<script src="js/jquery.uploadify-3.1.min.js"></script>
	
		<script src="js/jquery.gritter.min.js"></script>
	
		<script src="js/jquery.imagesloaded.js"></script>
	
		<script src="js/jquery.masonry.min.js"></script>
	
		<script src="js/jquery.knob.modified.js"></script>
	
		<script src="js/jquery.sparkline.min.js"></script>
	
		<script src="js/counter.js"></script>
	
		<script src="js/retina.js"></script>

		<script src="js/custom.js"></script>
	<!-- end: JavaScript-->
	
</body>
</html>









































<!-- <html -->
<!-- 	class="no-js wf-jaffacitweb-i3-active wf-jaffacitweb-n3-active wf-jaffacitweb-n7-active wf-active"> -->
<!-- <head> -->
<!-- <meta charset="utf-8"> -->
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
<!-- <title>Log in to Koloud</title> -->
<!-- <meta name="description" content="Log in to Trello."> -->
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!-- <link href="../koloud/resources/css/login.css" rel="stylesheet"> -->
<!-- <style>/*! normalize.css v3.0.1 | MIT License | git.io/normalize */ -->

<!-- </style> -->

<!-- <style type="text/css"> -->
<!--  .tk-jaf-facitweb {  -->
<!--  	font-family: "jaf-facitweb", sans-serif;  -->
<!--  }  -->
<!-- </style> -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://use.typekit.net/c/dec476/1w;jaf-facitweb,2,Y1j:P:i3,Y1h:P:n3,Y1n:P:n7/d?3bb2a6e53c9684ffdc9a9bf5195b2a620ddcd3046f58c4dc110107391970d742d68f54f2302912f45338f8b83af8c369f5562da8832b6d369ea07aa62e5912a1f39424c41df45d8267fab52e225632fe4bf7b177ad3a7a5d906810a1e9f0f0bb0a241fe5500172f9d6b0cd13f72be0cbabbcf38d1ae56d9cf47d99fad1ab51f819f3854df7"> -->
<!-- </head> -->
<!-- <body> -->
<!-- 	<section> -->
<!-- 		<div class="section-wrapper"> -->
<!-- 			<div class="layout-twothirds-center"> -->
<!-- 				<input id="returnUrl" type="hidden" value="/logged-out"> -->
<!-- 				<div id="error" class="hidden"> -->
<!-- 					<p class="error-message"></p> -->
<!-- 				</div> -->
<!-- 				<h1>Log in to Koloud</h1> -->
<!-- 				<form action="login_temp" METHOD="POST"> -->
<!-- 				<div class="login-password-container"> -->
<!-- 					<div class="login-password-container-email"> -->
<!-- 						<label for="user">Email <span class="quiet"></span></label>  -->
<!-- 							<input type="text" name="user" id="user" value="" tabindex="1" placeholder="e.g., jinnie@gmail.com">  -->
<!-- 						<label for="password">Password</label>  -->
<!-- 							<input type="password" name="password" autocomplete="off" id="password" tabindex="2" placeholder="e.g., ************">  -->
<!-- 							<button id="login1" tabindex="3" type="button" class="button button-green">
<!-- 							input type="button" id="login1" value="Log In" class="button button-green" onclick="loginCheck()" -->
<!-- 							<input type="SUBMIT" tabindex="3" value="Log In" class="button button-green"> -->
<!-- 					</div> -->
<!-- 					<p class="quiet"> -->
<!-- 						Forgot your password? <a href="/koloud/findPw" tabindex="5">Find	your password.</a> -->
<!-- 					</p> -->
<!-- 				<p class="quiet"> -->
<!-- 					Do not have an account? <a href="/koloud/register" tabindex="6">Create a -->
<!-- 						Koloud account.</a> -->
<!-- 				</p> -->
<!-- 			</div> -->
<!-- 			</form> -->
<!-- 		</div> -->
<!-- 		</div> -->
<!-- 	</section> -->
	
	
<!-- <script src="../koloud/resources/js/before.js"></script> -->
<!-- </body> -->
<!-- </html> -->