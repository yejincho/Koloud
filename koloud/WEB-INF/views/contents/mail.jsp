<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../layout/Wrapper.jsp" %>
<%
	request.setCharacterEncoding("utf-8");

	int CntforMail = 0;
	for(int i=1;i<lm.size();i++){
		if(lm.get(i).getReceiver_name().equals(name)){
			CntforMail++;
		}
	}
%>

		<div id="content" class="span10">
			<ul class="breadcrumb">
				<li>
					<i class="fa fa-home"></i>
					<a href="/koloud/home">Home</a> 
					<i class="fa fa-angle-right"></i>
				</li>
				<li><a href="/koloud/mail">메일링</a></li>
			</ul>
			
			<div class="col-lg-6">
           <h2>메일 목록</h2><br>
				<div class="box-content">
				<table class="table table-striped table-bordered bootstrap-datatable datatable">
					  <thead>
						  <tr>
							  <th>번호</th>
							  <th>수신자(이름)</th>
							  <th>내용</th>
							  <th>날짜</th>
						  </tr>
					  </thead>   
					  <tbody><%
                         if(id == 1){
                             for(int i=1;i<lm.size();i++){ %>
                             	<tr>
                             		<td><%= i %></td>
                             		<td><b><%=lm.get(i).getReceiver_name() %></b>(<%=lm.get(i).getReceiver_email() %>)</td>
                             		<td><a href="/koloud/mailContent?clickedName=<%=lm.get(i).getReceiver_name() %>&index=<%=String.valueOf(i) %>"><b><%= lm.get(i).getSubject() %></b> - <%=lm.get(i).getType() %></a></td>
                             		<td>0<%=lm.get(i).getTime().getMonth()+1 %>.<%=lm.get(i).getTime().getDate() %>&nbsp; <%=lm.get(i).getTime().getHours() %>:<%=lm.get(i).getTime().getMinutes() %>:<%=lm.get(i).getTime().getSeconds() %></td>
                             	</tr>
                             <%}
                         }else{
                         	for(int i=1;i<lm.size();i++){
								if(lm.get(i).getReceiver_name().equals(name)){%>
                            	<tr>
                            		<td><%= i %></td>
                            		<td><b><%=lm.get(i).getReceiver_name() %></b>(<%=lm.get(i).getReceiver_email() %>)</td>
                            		<td><a href="/koloud/mailContent?clickedName=<%=lm.get(i).getReceiver_name() %>&index=<%=String.valueOf(i) %>"><b><%= lm.get(i).getSubject() %></b> - <%=lm.get(i).getType() %></a></td>
                            		<td>0<%=lm.get(i).getTime().getMonth()+1 %>.<%=lm.get(i).getTime().getDate() %>&nbsp; <%=lm.get(i).getTime().getHours() %>:<%=lm.get(i).getTime().getMinutes() %>:<%=lm.get(i).getTime().getSeconds() %></td>
                            	</tr>
                            <%		}
                            	}
                         }%>
						</tbody>
				</table>
              </div>
             </div>
          </div>
                    	
                         
        
<%@ include file = "../layout/foot.jsp"%>

