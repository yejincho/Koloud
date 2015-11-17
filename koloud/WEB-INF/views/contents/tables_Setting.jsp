<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="net.kbssm.koloud.Resource.*"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%@ page import="net.kbssm.koloud.Virtual.*" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="org.libvirt.*" %>
<%
	request.setCharacterEncoding("utf-8");
	ServerConvert sc = new ServerConvert();
	List<Server> ls = sc.getServerList();
	ResourceConvert rc = new ResourceConvert();
	List<Resource> lr = rc.getResourceList();
	
	String clickCheck = request.getParameter("clickCheck");
	String clickId = request.getParameter("clickId");
	String clickCheckEdit = request.getParameter("clickCheckEdit");
	
	Connect conn = null;  
	try{
        conn = new Connect("qemu:///system", true);

	}catch (LibvirtException e) {
        System.out.println("exception caught:"+e);
        System.out.println(e.getError());
    }
	
	int CntForResource = 0;
	int CntForServer = 0;
	int CntForServerNull = 0;
	
	for(int i=1;i<ls.size();i++){
		if(ls.get(i).getId() == id && ls.get(i).getPermission() == 2){
			CntForServer++;
		}
		if(ls.get(i).getServer() != ""){
			CntForServerNull++;
		}
	}
	for(int i=1;i<lr.size();i++){
		if(lr.get(i).getId() == id){
			CntForResource++;
		}
	}
	
	long kbTogb = 1024*1024*1024;
	long temp = 1024*1024;
%>


<link href="../koloud/resources/css/resourcelist.css" rel="stylesheet">

	<div id="content" class="span10">
		<ul class="breadcrumb">
			<li>
				<i class="fa fa-home"></i>
				<a href="/koloud/home">Home</a> 
				<i class="fa fa-angle-right"></i>
			</li>
			<li><a href="/koloud/mail">자원 설정</a></li>
		</ul>
		
		<div class="row-fluid sortable">		
			<div class="col-lg-6">
			
			<form action="setting_temp" METHOD="POST">
            <input type="hidden" name="id" value=<%=String.valueOf(id) %>>
              <div class="table-responsive">
	              <h2>서버 자원 목록</h2>
                  <table class="table table-hover">
						  <thead>
							  <tr>
							  	  <th>tkdydwk dlfma</th>
								  <th>서버 이름</th>
								  <th>Cpu</th>
								  <th>Ram(사용가능 / 총 계)</th>
								  <th>Disk(사용가능 / 총 계)</th>
							  </tr>
						  </thead>   
						  <tbody>
                     			<%
                                for(int i=1;i<ls.size();i++){ 
                                	if(ls.get(i).getServer() != "" && ls.get(i).getPermission() == 2){
                                		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    	                             	//virtual os info
    	                       			String s_name = ls.get(i).getName();
    	                       			Domain domain = conn.domainLookupByName(s_name);
    	                       			StoragePool strPool = conn.storagePoolLookupByName("default");
    	                       			StorageVol testStVol = conn.storageVolLookupByPath("/var/lib/libvirt/images/" + s_name + ".img");
//     	                         		System.out.println(testStVol.getInfo().allocation); //total
//     	                         		System.out.println(testStVol.getInfo().capacity); //left
    	                         		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	                         			if(id == 1){
		                                %>
                                   <tr>
                                   	<td><%=ul.getName(ls.get(i).getId()) %>
                                       <td><a href="/koloud/tables_Setting?clickCheck=<%= ls.get(i).getName() %>&clickId=<%=String.valueOf(i)%>"><%= ls.get(i).getName() %></a></td>
                                       <td><%= domain.getInfo().nrVirtCpu%> vCore</td>
                                       <td> <%=domain.getInfo().memory / 1024%> MB / <%= domain.getInfo().maxMem / 1024%>  MB</td>
                                       <td><%= testStVol.getInfo().capacity / kbTogb - testStVol.getInfo().allocation / kbTogb%> GB / <%= testStVol.getInfo().capacity /kbTogb %> GB </td>
                                   </tr>
			                               	<%
			                               	}
		                               else{
		                              		if(ls.get(i).getId() == id){
		                              		
		                              		%>
		                                   <tr>
		                                      <td><%=ul.getName(ls.get(i).getId()) %>
		                                      <td><a href="/koloud/tables_Setting?clickCheck=<%= ls.get(i).getName() %>&clickId=<%=String.valueOf(i)%>"><%= ls.get(i).getName() %></a></td>
		                                       <td><%= domain.getInfo().nrVirtCpu%> vCore</td>
		                                       <td><%= domain.getInfo().memory / 1024%>MB / <%=  domain.getInfo().maxMem /1024%>MB</td>
		                                       <td><%= testStVol.getInfo().capacity / kbTogb - testStVol.getInfo().allocation /kbTogb %> GB / <%=testStVol.getInfo().capacity / kbTogb%> GB </td>
		                                   </tr>
		                              		<%} 
		                              		}
                              			}
                             		}%>
                                </tbody>
                             </table>
                           </div>
                         </form>
                             <div class ="form-group">
                             	<p class="form-control-static">*자원 사용량 변경을 원하시면, 서버 이름을 클릭해 주세요.</p>
                             </div>
                             
                             <!-- Resource Edit -->
							 <%if(clickCheck!=null && clickId!=null){ 	                     	
	                            	int index = Integer.parseInt(clickId); 
	                             	String s_name = ls.get(index).getName();
	                             	
                         			Domain domain = conn.domainLookupByName(s_name);
                         			StoragePool strPool = conn.storagePoolLookupByName("default");
                         			StorageVol testStVol = conn.storageVolLookupByPath("/var/lib/libvirt/images/" + s_name + ".img");
	                            
	                         %>
	                         <br>
	                         
	                         
	                         <!-- new -->
	                         <div class="row-fluid sortable">
								<div class="box span12">
									<div class="box-header" data-original-title>
										<h2><i class="fa fa-pencil-square-o "></i><span class="break"></span>[<%= ls.get(index).getName()%>] 자원 변경</h2>
										<div class="box-icon">
										</div>
									</div>
									<div class="box-content">
									<form class="form-horizontal" method="post" action="/koloud/setting_temp">
		                            <input type="hidden" name="s_name" value="<%=ls.get(index).getName() %>">
		                            <input type="hidden" name="index" value="<%=index %>"> 
		                            <input type="hidden" name="allocDisk" value="<%=testStVol.getInfo().capacity %>">
	                         		<input type="hidden" name="id" value=<%=String.valueOf(id) %>>
										<fieldset>
										  <div class="control-group">
											 	<label class="control-label"> Cpu 선택</label>
									  			<div class="controls">
												<select class="form-control" name="cpu" data-rel="chosen">
						                             <option value="1">1 vCore</option>
						                             <option value="2">2 vCore</option>
						                             <option value="3">3 vCore</option>
						                     </select>
						                         &nbsp;&nbsp;&nbsp;/ &nbsp;&nbsp;&nbsp;<%= domain.getInfo().nrVirtCpu %> vCore (현재 할당량)
				                    			</div>
					                   	  </div>
					                   	  <div class="control-group">
											 	<label class="control-label"> Ram 선택</label>
									  			<div class="controls">
												<select class="form-control" name="ram" data-rel="chosen">
						                             <option value="512">512 MB</option>
						                             <option value="682">682 MB</option>
						                             <option value="852">852 MB</option>
						                             <option value="1024">1024 MB</option>
						                         </select>
						                         &nbsp;&nbsp;&nbsp;/ &nbsp;&nbsp;&nbsp;<%= domain.getInfo().maxMem / 1024%> MB (현재 할당량)
				                    			</div>
					                   	  </div>
					                   	  <div class="control-group">
											 	<label class="control-label"> Disk 선택</label>
									  			<div class="controls">
												<select class="form-control" name="disk" data-rel="chosen">
						                             <option value="20">20 GB</option>
						                             <option value="30">30 GB</option>
						                             <option value="40">40 GB</option>
						                             <option value="50">50 GB</option>
						                         </select>
						                         &nbsp;&nbsp;&nbsp;/ &nbsp;&nbsp;&nbsp;<%= testStVol.getInfo().capacity / kbTogb%> GB &nbsp; &nbsp;(현재 할당량)
				                    			</div>
					                   	  </div>
										  <div class="form-actions">
											<button type="submit" class="btn btn-primary">요청 보내기</button>
										  </div>
										</fieldset>
									</div>
								</div><!--/span-->
		                    <%}%>
                             <br>
                             </div>
		                    
		                    
                       	
                       	<!-- Resource Request Table -->
                       	<br><br><br>
                       	<div class="box-content">
                       	<h3>신청 내역</h3>
							<table class="table table-striped table-bordered bootstrap-datatable datatable">
                            <thead>
                               <tr>
                                   <th>날짜</th>
                                   <th>서버 이름</th>
                                   <th>Cpu</th>
                                   <th>Ram</th>
                                   <th>Disk</th>
                                   <th>허가 여부</th>
                                   <th>비고</th>
                               </tr>
	                    	</thead>
	                    	<tbody>
	                    	<% 
	                    	for(int i=1;i<lr.size();i++){
	                    		if(lr.get(i).getId() == id){
	                    			%>
	                    			<tr>
	                                   <td><%=lr.get(i).getTime() %></td>
	                                   <td><%=lr.get(i).getS_name() %></td>
	                                   <td><%=lr.get(i).getCpu() %> vCore</td>
	                                   <td><%=lr.get(i).getRam() / 1024 %> MB</td>
	                                   <td><%=lr.get(i).getDisk() / kbTogb%> GB</td>
	                                   <%if(lr.get(i).getPermission().equals("denied")){ %>
	                                   <td><span class="label label-important"><%=lr.get(i).getPermission() %></span></td>
	                                   <%}else if(lr.get(i).getPermission().equals("accepted")){ %>
	                                   <td><span class="label label-success"><%=lr.get(i).getPermission() %></span></td>
	                                   <%}else if(lr.get(i).getPermission().equals("waiting")){ %>
	                                   <td><span class="label label-warning"><%=lr.get(i).getPermission() %></span></td>
	                                   <%}
	                    				if(lr.get(i).getReason().equals("")){ %>
	                                   <td>-</td>
	                                   <%}else{ %>
	                                   <td><%=lr.get(i).getReason() %></td>
	                                   <%} %>
                               		</tr>
                               		<%
	                    		}
	                    	}
	                    	%>
	                    	</tbody>
	                    
	                    </table>
	                    
                        </div>
                        
                    </div>
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->
            <% conn.close(); %>
        <!-- /#page-wrapper -->
<!-- <script src="../../../koloud/resources/js/develop/table.js"></script> -->
<%@include file = "../layout/foot.jsp"%>
