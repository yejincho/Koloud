function servInfo(){
//	console.log("clicked");
}
function stopClick(){
//	console.log("stop");
	var retVal = confirm("Stop your server?");
	var status = $()
	if(retVal ==  true){
		alert("Now your server is running!");
		console.log("run!");
	}
	else
		console.log("stay");
}
function runClick(){
	var retVal = confirm("Run your server?");
	if(retVal ==  true){
		alert("Server Stopped");
		console.log("stop!");
	}
	else
		console.log("stay");
}