<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%@ page import="net.kbssm.koloud.kDomain.*" %>
<%
	request.setCharacterEncoding("utf-8");
	kDomainConvert dc = new kDomainConvert();	
	List<kDomain> ld = dc.getDomainList();
	String clickCheck = request.getParameter("clickCheck");
	String clickIndex = request.getParameter("clickIndex");
	
	String domain = ld.get(0).getDomain();
	int flag = 0;
	String cutDom = "";
	for(int i=0;i<domain.length();i++){
		if(domain.charAt(i) == '.'){
			flag = 1;
		}
		if(flag == 1){
			cutDom += domain.charAt(i);
		}
	}
%>

		<!-- start: Content -->
		<div id="content" class="span10">
			<ul class="breadcrumb">
				<li>
					<i class="fa fa-home"></i>
					<a href="/koloud/home">Home</a> 
					<i class="fa fa-angle-right"></i>
				</li>
				<li><a href="/koloud/DNS_setting">DNS 설정</a></li>
			</ul>
			
			
			
		<!-- Page Content -->
		<div id="page-wrapper">
            <div class="container-fluid">

                <!-- /.row -->
                <form action="subdomain_temp_dashboard" METHOD="POST">
                <h1>서브 도메인 추가</h1><br>
                e.g., abc<%=cutDom %> -> <b>abc</b><br>
                	<div class="input-append">
                		<input id="appendedInputButton" type="text" size="5" tabindex="1" placeholder="abc" name="subdom"></input>
                		<button class="btn" type="submit" tabindex="2">추가</button>
                	</div>
<%-- 					<input type="text" name="subdom" placeholder="e.g., abc" style="margin-bottom: 0.2em; width: 70px"><%=cutDom %>  --%>
<!-- 					<button class='btn btn-success' type="submit" tabindex="1">Add</button> -->
				</form>
				<br><br>
				<hr>		
				<div id="sub_wrapper">
				       <h2>Sub Domains</h2>
					       <table class="table table-bordered" id="sub_table" style="width: 400px;">
					       		<thead>
					       			<tr>
						       			<td>서브 도메인 이름</td>
						       			<td>사용 여부</td>
						       			<td>삭제</td>
						       		</tr>
						       	</thead>
					       		<tbody>
					       		<%
				       			for(int i=1;i<ld.size();i++){
				       					%>
				       					<tr>
				       						<td><%=ld.get(i).getSubDom() %></td>
				       						<%if(ld.get(i).getServer() == ""){ %>
				       						<td><span class="label label-success">사용 가능</span> </td>
				       						<td><a href="DNS_setting?clickCheck=<%= ld.get(i).getSubDom()%>&clickIndex=<%=i%>"><button class='btn btn-danger'>삭제</button></a></td>
				       						<%}else{ %>
				       						<td><%=ld.get(i).getServer() %></td>
				       						<td><span class="label label-important">삭제 불가</span> </td>
				       							<%}%>
				       					</tr>
				       					<%
				       				}
					       		%>
				       		</tbody>
					       		<%
					       	if(clickCheck != null){
			       					int index_sub = Integer.parseInt(clickIndex);
       								if(ld.get(index_sub).getServer() == ""){
	       					 				dc.updateDomainList(clickCheck);
       												%>
       										<script type="text/javascript">
			       									location.href="/koloud/DNS_setting";
			       					 		</script>
			       					<%}else{
						       						%>
		       								<script type="text/javascript">
			       								alert("Server is using it!");
				       							location.href="/koloud/DNS_setting";
			       					 		</script>
													<%
							       		}
       							}%>
					       </table>  
				       </div>
				</div>
        </div>
        <!-- /#page-wrapper -->
        
<%@ include file = "../layout/foot.jsp"%>

