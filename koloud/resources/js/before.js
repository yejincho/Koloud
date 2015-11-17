//function loginCheck(){
//	window.location.href = '/koloud/home';
//	
//}

function loginCheck(){
	console.log("check");
	$.ajax({
		type: "GET"
		,url:"/koloud/"
		,dataType:"jsp"
		,async: false
		,success: response_parse
	});
	console.log("fail?");
	function response_parse(jsp){
		console.log("success!")
		$users = $(jsp).find("login-password-container-email");
		
		var user_count = $users.length;
		console.log(user_count);
		$("div").html("<b>가입자 수 : " + user_count + " 명</b>");
		
		$users.each(function(){
			
			var user_email = $(this).find("user").text();
			var user_password = $(this).find("password").text();
			
			var html = "<tr>";
				html += "<td>"+ user_email +"</td>";
				html += "<td>"+ user_password +"</td>";
				html += "</tr>";
				
			$("body").append(html);
		});
	}
	
	
}