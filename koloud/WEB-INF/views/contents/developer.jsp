<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%@ page import="net.kbssm.koloud.kDomain.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
%>

		<!-- start: Content -->
		<div id="content" class="span10">
			<ul class="breadcrumb">
				<li>
					<i class="fa fa-home"></i>
					<a href="/koloud/home">Home</a> 
					<i class="fa fa-angle-right"></i>
				</li>
				<li><a href="/koloud/aboutus">Developer</a></li>
			</ul>
			
			
			<!-- Page Content -->
		<div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row text-center">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Contact Us<br/><br/>
                            <small>contact to koloud's engineers</small>
                        </h1>
                        <br>
                        <h3>JungHO, Mun</h3> - <i>Network</i><br>
                        +82 10-2969-4200<br>
                        munjh4200@naver.com<br><br><br>
                        
                        <h3>DongWuk, Jang</h3> - <i>Packaging</i><br>
                        +82 10-9900-7244<br>
                        scvjdu@gmail.com<br><br><br>
                        
                        <h3>Jinnie YeJin, Jo</h3> - <i>Web</i><br>
                        +82 10-7134-2065<br>
                        joyajin91@gmail.com<br><br>
                    </div>
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->
        
<%@ include file = "../layout/foot.jsp"%>
<%
//   String s = null;
		
// 		String[] array = {"ls"};
// 		String pas = "dd";
// 		Process proc = null;
// 		    BufferedWriter writer = null;
// 		try
// 		{
// 		    proc = Runtime.getRuntime().exec(array);
// 		    System.out.println(proc);
// // 		        writer = new BufferedWriter(new OutputStreamWriter(proc.getOutputStream()));
// // 		        writer.write(pas);
// 		        System.out.print("~~~~~~~~~~~~~~~~~~");
// 		}
// 		catch (IOException e)
// 		{
// 	    	e.printStackTrace();
// 		}
	
// 		try {
             
//         // run the Unix "ps -ef" command
//             // using the Runtime exec method:
//             Process p = Runtime.getRuntime().exec("sudo reboot");
             
//             BufferedReader stdInput = new BufferedReader(new
//                  InputStreamReader(p.getInputStream()));
 
//             BufferedReader stdError = new BufferedReader(new
//                  InputStreamReader(p.getErrorStream()));
 
//             // read the output from the command
//             System.out.println("Here is the standard output of the command:\n");
//             while ((s = stdInput.readLine()) != null) {
//                 System.out.println(s);
//             }
             
//             // read any errors from the attempted command
//             System.out.println("Here is the standard error of the command (if any):\n");
//             while ((s = stdError.readLine()) != null) {
//                 System.out.println(s);
//             }
             
//         }
//         catch (IOException e) {
//             System.out.println("exception happened - here's what I know: ");
//             e.printStackTrace();
//         }
%>