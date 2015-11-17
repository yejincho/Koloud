<script type="text/javascript">
function progressbar(percent){
    //var szazalek=Math.round((meik*100)/ossz);
    document.getElementById("szliderbar").style.width=percent+'%';
    document.getElementById("szazalek").innerHTML=percent+'%';
}

var elapsedTime=0;
var myVar=setInterval(function(){timer()},100);

function timer()
{
	if(elapsedTime > 100)
    {
		document.getElementById("szazalek").style.color = "#FFF";
        document.getElementById("szazalek").innerHTML = "Completed.";
		if(elapsedTime >= 107)
		{
			clearInterval(interval);
			//history.go(-1);
			window.close();
		}
    }
	else
	{
		progressbar(elapsedTime);
	}
	elapsedTime++;
    
}

</script>

<body onload="drawszlider(121, 56);">
	OS is starting ...
    <div id="szlider">
    <div id="szliderbar">
    </div>
    <div id="szazalek">
    </div>
</div>   
</body>

<style>
#szlider{
    width:100%;
    height:15px;
    border:1px solid #000;
    overflow:hidden; }
#szliderbar{
    width:37%;
    height:15px;
    border-right: 1px solid #000000;
    background: #7777ee; }
#szazalek {
    color: #000000;
    font-size: 15px;
    font-style: italic;
    font-weight: bold;
    left: 25px;
    position: relative;
    top: -16px; }
</style>
