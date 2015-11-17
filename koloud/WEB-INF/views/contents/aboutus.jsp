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
				<li><a href="/koloud/aboutus">About</a></li>
			</ul>
			
			
		<!-- Page Content -->
		<div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row text-center">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            About Koloud
                        </h1>
                        <br>
                        
                        	Service Name, Koloud<br><br>
                        	-Version-<br>
                        	Ubuntu Version, 12.04<br>
                        	CentOS Version, 6.6<br>
                        	Koloud Version, 2.0<br><br>
                        	-State-<br>
                        	Service State, run<br><br>
                        	-Update-
                        	Recently Update, 2015.02.28<br><br><br><br>
                        	<font color="blue"><i>copyright, gbssm</i></font><br>
                        	
                    </div>
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->
        
<%@ include file = "../layout/foot.jsp"%>

