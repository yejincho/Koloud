<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../layout/Wrapper.jsp"%>
<%@page import="net.kbssm.koloud.kDomain.*"%>
<%@ page import="net.kbssm.koloud.Virtual.*"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="org.libvirt.*, net.kbssm.koloud.OS.*"%>

<%

	request.setCharacterEncoding("utf-8");
	ServerConvert sv = new ServerConvert(id);
	List<Server> ls = sv.getServerList();
	//	System.out.println(sv.getServerList().size());
	String status = null;
	String clickCheck = request.getParameter("clickCheck");
	String clickId = request.getParameter("clickId");

	UserConvert uc = new UserConvert();

	//virtual os info
	String ip = c.ip();
	
	int vCpu = 0;
	NodeInfo node = null;

	Connect conn = null;
	try {
		conn = new Connect("qemu:///system", true);

	} catch (LibvirtException e) {
		System.out.println("exception caught:" + e);
		System.out.println(e.getError());
	}
	try {
		node = conn.nodeInfo();

	} catch (LibvirtException e) {
		System.out.println("exception caught:" + e);
		System.out.println(e.getError());
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
				<li>
					<i class="fa  fa-dashcube"></i>
					<a href=" ">자원 관리</a> 
					<i class="fa fa-angle-right"></i>
				</li>
				<li><a href="/koloud/VMcharts">호스트 자원</a></li>
			</ul>
				
			<!-- old -->
			<!-- tabs -->
			<div class="tabbable">
				<ul class="nav nav-tabs">
					<li class="active"><a href="#all" data-toggle="tab">전체</a></li>
					<li><a href="#disk" data-toggle="tab">디스크</a></li>
					<li><a href="#network" data-toggle="tab">네트워크</a></li>
					<li><a href="#cpu" data-toggle="tab">Cpu</a></li>
					<li><a href="#memory" data-toggle="tab">Memory</a></li>
					<li><a href="#loadAvg" data-toggle="tab">서버 부하량</a></li>
				</ul>
				
				<!-- 호스트 정보 -->
				<div class="tab-content">
				
				<!-- all -->
				<div class="tab-pane active" id="all">
					<li class="active"><i class="fa fa-bar-chart-o"></i> 호스트 정보</font></li><br>
		<div class="row-fluid hideInIE8 circleStats">
				
				<a class="quick-button metro blue span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-desktop "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.model %></font>
					</div>
				</a>
			
				<a class="quick-button metro pink span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-cogs "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.cpus %> </font><font color="white" size="3"> vCores</font>
					</div>
				</a>
			
				<a class="quick-button metro red span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-line-chart "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.mhz %> </font><font color="white" size="3"> Hz</font>
					</div>
				</a>
				
				<div class="span2" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox green">
						<div class="header">Disk</div>
						<span class="percent">percent</span>
						<div class="circleStat">
                    		<input type="text" value="<%= s_percent %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">20</span>
								<span class="unit">GB</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number"><%= s_totalDisk %></span>
								<span class="unit">GB</span>
							</span>	
						</div>
                	</div>
				</div>

				<div class="span2" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox greenDark">
						<div class="header">Memory 이용률</div>
						<span class="percent">percent</span>
                    	<div class="circleStat">
                    		<input type="text" value="<%=s_memory %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">64</span>
								<span class="unit">MB</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number"><%=node.memory / 1024 %></span>
								<span class="unit">MB</span>
							</span>	
						</div>
                	</div>
				</div>

				<div class="span2 noMargin" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox pink">
						<div class="header">CPU 점유율</div>
						<span class="percent">percent</span>
                    	<div class="circleStat">
                    		<input type="text" value="<%=s_cpu %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">64</span>
								<span class="unit">GHz</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number">100</span>
								<span class="unit">%</span>
							</span>	
						</div>
                	</div>
				</div>

			</div>	
				
			
						<div class="col-lg-6">
							<table class="table table-bordered table-hover table-striped">
								<thead>
									<tr align="center">
										<th>CPU Model</th>
										<th>CPUS</th>
										<th>Hz</th>
										<th>RAM</th>
										<th>CPU Utilization</th>
										<th>Memory Utilization</th>
									</tr>
								</thead>
								<tbody>
									<tr align="center">
										<td><%=node.model%></td>
										<td><%=node.cpus%></td>
										<td><%=node.mhz%> MHz</td>
										<td><%=node.memory%> KB</td>
										<td>
											<%=s_cpu%> %
										</td>
										<td>
											<%=s_memory%> %
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<h3>Disk IOs for /dev/sda(Day / Week)</h3>
						<img src="http://<%=ip %>:81/munin/localdomain/localhost.localdomain/diskstats_iops/sda-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/diskstats_iops/sda-week.png"/><br>
						<h3>Disk latency for /dev/sda(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/diskstats_latency/sda-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/diskstats_latency/sda-week.png"/><br>
						<h3>Disk throughput for /dev/sda(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/diskstats_throughput/sda-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/diskstats_throughput/sda-week.png"/><br>
						<h3>Disk usage in percent(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/df-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/df-week.png"/><br>
						<h3>eth0 traffic(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/if_eth0-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/if_eth0-week.png"/><br>
						<h3>eth0 errors(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/if_err_eth0-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/if_err_eth0-week.png"/><br>
						<h3>CPU usage(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/cpu-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/cpu-week.png"/><br>
						<h3>CPU frequency scaling(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/cpuspeed-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/cpuspeed-week.png"/><br>
						<h3>Memory usage(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/memory-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/memory-week.png"/><br><br>
						<h3>IO Service time(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/iostat_ios-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/iostat_ios-week.png"/><br><br>
						<h3>Load average(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/load-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/load-week.png"/><br><br>
						<h3>Interrupts and context switches(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/interrupts-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/interrupts-week.png"/><br><br>
						
					</div>
					<!-- DISK -->
					<div class="tab-pane" id="disk">
					<li class="active"><i class="fa fa-bar-chart-o"></i> 호스트 정보</font></li><br>
		<div class="row-fluid hideInIE8 circleStats">
				
				<a class="quick-button metro blue span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-desktop "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.model %></font>
					</div>
				</a>
			
				<a class="quick-button metro pink span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-cogs "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.cpus %> </font><font color="white" size="3"> vCores</font>
					</div>
				</a>
			
				<a class="quick-button metro red span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-line-chart "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.mhz %> </font><font color="white" size="3"> Hz</font>
					</div>
				</a>
				
				<div class="span2" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox green">
						<div class="header">Disk</div>
						<span class="percent">percent</span>
						<div class="circleStat">
                    		<input type="text" value="<%= s_percent %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">20</span>
								<span class="unit">GB</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number"><%= s_totalDisk %></span>
								<span class="unit">GB</span>
							</span>	
						</div>
                	</div>
				</div>

				<div class="span2" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox greenDark">
						<div class="header">Memory 이용률</div>
						<span class="percent">percent</span>
                    	<div class="circleStat">
                    		<input type="text" value="<%=s_memory %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">64</span>
								<span class="unit">MB</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number"><%=node.memory / 1024 %></span>
								<span class="unit">MB</span>
							</span>	
						</div>
                	</div>
				</div>

				<div class="span2 noMargin" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox pink">
						<div class="header">CPU 점유율</div>
						<span class="percent">percent</span>
                    	<div class="circleStat">
                    		<input type="text" value="<%=s_cpu %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">64</span>
								<span class="unit">GHz</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number">100</span>
								<span class="unit">%</span>
							</span>	
						</div>
                	</div>
				</div>

			</div>	
				
			
						<div class="col-lg-6">
							<table class="table table-bordered table-hover table-striped">
								<thead>
									<tr align="center">
										<th>CPU Model</th>
										<th>CPUS</th>
										<th>Hz</th>
										<th>RAM</th>
										<th>CPU Utilization</th>
										<th>Memory Utilization</th>
									</tr>
								</thead>
								<tbody>
									<tr align="center">
										<td><%=node.model%></td>
										<td><%=node.cpus%></td>
										<td><%=node.mhz%> MHz</td>
										<td><%=node.memory%> KB</td>
										<td>
											<%=s_cpu%> %
										</td>
										<td>
											<%=s_memory%> %
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<h3>Disk IOs for /dev/sda(Day / Week)</h3>
						<img src="http://<%=ip %>:81/munin/localdomain/localhost.localdomain/diskstats_iops/sda-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/diskstats_iops/sda-week.png"/><br>
						<h3>Disk latency for /dev/sda(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/diskstats_latency/sda-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/diskstats_latency/sda-week.png"/><br>
						<h3>Disk throughput for /dev/sda(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/diskstats_throughput/sda-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/diskstats_throughput/sda-week.png"/><br>
						<h3>Disk usage in percent(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/df-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/df-week.png"/><br>
						
					</div>
					
					<!-- network -->
					<div class="tab-pane" id="network">
					<li class="active"><i class="fa fa-bar-chart-o"></i> 호스트 정보</li><br>
					<div class="row-fluid hideInIE8 circleStats">
				
				<a class="quick-button metro blue span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-desktop "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.model %></font>
					</div>
				</a>
			
				<a class="quick-button metro pink span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-cogs "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.cpus %> </font><font color="white" size="3"> vCores</font>
					</div>
				</a>
			
				<a class="quick-button metro red span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-line-chart "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.mhz %> </font><font color="white" size="3"> Hz</font>
					</div>
				</a>
				
				<div class="span2" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox green">
						<div class="header">Disk</div>
						<span class="percent">percent</span>
						<div class="circleStat">
                    		<input type="text" value="<%= s_percent %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">20</span>
								<span class="unit">GB</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number"><%= s_totalDisk %></span>
								<span class="unit">GB</span>
							</span>	
						</div>
                	</div>
				</div>

				<div class="span2" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox greenDark">
						<div class="header">Memory 이용률</div>
						<span class="percent">percent</span>
                    	<div class="circleStat">
                    		<input type="text" value="<%=s_memory %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">64</span>
								<span class="unit">MB</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number"><%=node.memory / 1024 %></span>
								<span class="unit">MB</span>
							</span>	
						</div>
                	</div>
				</div>

				<div class="span2 noMargin" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox pink">
						<div class="header">CPU 점유율</div>
						<span class="percent">percent</span>
                    	<div class="circleStat">
                    		<input type="text" value="<%=s_cpu %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">64</span>
								<span class="unit">GHz</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number">100</span>
								<span class="unit">%</span>
							</span>	
						</div>
                	</div>
				</div>

			</div>	
					
						<div class="col-lg-6">
							<table class="table table-bordered table-hover table-striped">
								<thead>
									<tr align="center">
										<th>CPU Model</th>
										<th>CPUS</th>
										<th>Hz</th>
										<th>RAM</th>
										<th>CPU Utilization</th>
										<th>Memory Utilization</th>
									</tr>
								</thead>
								<tbody>
									<tr align="center">
										<td><%=node.model%></td>
										<td><%=node.cpus%></td>
										<td><%=node.mhz%> MHz</td>
										<td><%=node.memory%> KB</td>
										<td>
											<%=s_cpu%> %
										</td>
										<td>
											<%=s_memory%> %
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<h3>eth0 traffic(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/if_eth0-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/if_eth0-week.png"/><br>
						<h3>eth0 errors(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/if_err_eth0-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/if_err_eth0-week.png"/><br>
					</div>
					<div class="tab-pane" id="cpu">
					<li class="active"><i class="fa fa-bar-chart-o"></i> 호스트 정보</li><br>
					<div class="row-fluid hideInIE8 circleStats">
				
				<a class="quick-button metro blue span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-desktop "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.model %></font>
					</div>
				</a>
			
				<a class="quick-button metro pink span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-cogs "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.cpus %> </font><font color="white" size="3"> vCores</font>
					</div>
				</a>
			
				<a class="quick-button metro red span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-line-chart "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.mhz %> </font><font color="white" size="3"> Hz</font>
					</div>
				</a>
				
				<div class="span2" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox green">
						<div class="header">Disk</div>
						<span class="percent">percent</span>
						<div class="circleStat">
                    		<input type="text" value="<%= s_percent %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">20</span>
								<span class="unit">GB</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number"><%= s_totalDisk %></span>
								<span class="unit">GB</span>
							</span>	
						</div>
                	</div>
				</div>

				<div class="span2" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox greenDark">
						<div class="header">Memory 이용률</div>
						<span class="percent">percent</span>
                    	<div class="circleStat">
                    		<input type="text" value="<%=s_memory %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">64</span>
								<span class="unit">MB</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number"><%=node.memory / 1024 %></span>
								<span class="unit">MB</span>
							</span>	
						</div>
                	</div>
				</div>

				<div class="span2 noMargin" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox pink">
						<div class="header">CPU 점유율</div>
						<span class="percent">percent</span>
                    	<div class="circleStat">
                    		<input type="text" value="<%=s_cpu %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">64</span>
								<span class="unit">GHz</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number">100</span>
								<span class="unit">%</span>
							</span>	
						</div>
                	</div>
				</div>

			</div>	
				
						<div class="col-lg-6">
							<table class="table table-bordered table-hover table-striped">
								<thead>
									<tr align="center">
										<th>CPU Model</th>
										<th>CPUS</th>
										<th>Hz</th>
										<th>RAM</th>
										<th>CPU Utilization</th>
										<th>Memory Utilization</th>
									</tr>
								</thead>
								<tbody>
									<tr align="center">
										<td><%=node.model%></td>
										<td><%=node.cpus%></td>
										<td><%=node.mhz%> MHz</td>
										<td><%=node.memory%> KB</td>
										<td>
											<%=s_cpu%> %
										</td>
										<td>
											<%=s_memory%> %
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<h3>CPU usage(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/cpu-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/cpu-week.png"/><br>
						<h3>CPU frequency scaling(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/cpuspeed-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/cpuspeed-week.png"/><br>
					</div>
					<!-- memory -->
					<div class="tab-pane" id="memory">
					<li class="active"><i class="fa fa-bar-chart-o"></i> 호스트 정보</li><br>
					<div class="row-fluid hideInIE8 circleStats">
				
				<a class="quick-button metro blue span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-desktop "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.model %></font>
					</div>
				</a>
			
				<a class="quick-button metro pink span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-cogs "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.cpus %> </font><font color="white" size="3"> vCores</font>
					</div>
				</a>
			
				<a class="quick-button metro red span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-line-chart "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.mhz %> </font><font color="white" size="3"> Hz</font>
					</div>
				</a>
				
				<div class="span2" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox green">
						<div class="header">Disk</div>
						<span class="percent">percent</span>
						<div class="circleStat">
                    		<input type="text" value="<%= s_percent %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">20</span>
								<span class="unit">GB</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number"><%= s_totalDisk %></span>
								<span class="unit">GB</span>
							</span>	
						</div>
                	</div>
				</div>

				<div class="span2" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox greenDark">
						<div class="header">Memory 이용률</div>
						<span class="percent">percent</span>
                    	<div class="circleStat">
                    		<input type="text" value="<%=s_memory %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">64</span>
								<span class="unit">MB</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number"><%=node.memory / 1024 %></span>
								<span class="unit">MB</span>
							</span>	
						</div>
                	</div>
				</div>

				<div class="span2 noMargin" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox pink">
						<div class="header">CPU 점유율</div>
						<span class="percent">percent</span>
                    	<div class="circleStat">
                    		<input type="text" value="<%=s_cpu %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">64</span>
								<span class="unit">GHz</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number">100</span>
								<span class="unit">%</span>
							</span>	
						</div>
                	</div>
				</div>

			</div>	
				
					
						<div class="col-lg-6">
							<table class="table table-bordered table-hover table-striped">
								<thead>
									<tr align="center">
										<th>CPU Model</th>
										<th>CPUS</th>
										<th>Hz</th>
										<th>RAM</th>
										<th>CPU Utilization</th>
										<th>Memory Utilization</th>
									</tr>
								</thead>
								<tbody>
									<tr align="center">
										<td><%=node.model%></td>
										<td><%=node.cpus%></td>
										<td><%=node.mhz%> MHz</td>
										<td><%=node.memory%> KB</td>
										<td>
											<%=s_cpu%> %
										</td>
										<td>
											<%=s_memory%> %
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<h3>Memory usage(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/memory-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/memory-week.png"/><br><br>
						<h3>IO Service time(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/iostat_ios-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/iostat_ios-week.png"/><br><br>
					</div>
					<div class="tab-pane" id="loadAvg">
					<li class="active"><i class="fa fa-bar-chart-o"></i> 호스트 정보</li><br>
					<div class="row-fluid hideInIE8 circleStats">
				
				<a class="quick-button metro blue span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-desktop "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.model %></font>
					</div>
				</a>
			
				<a class="quick-button metro pink span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-cogs "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.cpus %> </font><font color="white" size="3"> vCores</font>
					</div>
				</a>
			
				<a class="quick-button metro red span2" style="height:200px;">
					<div> &nbsp;</div>
					<i class="fa fa-line-chart "></i>
					<div> &nbsp;</div>
					
					<div>
					<font color="white" size="5"><%=node.mhz %> </font><font color="white" size="3"> Hz</font>
					</div>
				</a>
				
				<div class="span2" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox green">
						<div class="header">Disk</div>
						<span class="percent">percent</span>
						<div class="circleStat">
                    		<input type="text" value="<%= s_percent %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">20</span>
								<span class="unit">GB</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number"><%= s_totalDisk %></span>
								<span class="unit">GB</span>
							</span>	
						</div>
                	</div>
				</div>

				<div class="span2" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox greenDark">
						<div class="header">Memory 이용률</div>
						<span class="percent">percent</span>
                    	<div class="circleStat">
                    		<input type="text" value="<%=s_memory %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">64</span>
								<span class="unit">MB</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number"><%=node.memory / 1024 %></span>
								<span class="unit">MB</span>
							</span>	
						</div>
                	</div>
				</div>

				<div class="span2 noMargin" onTablet="span4" onDesktop="span2">
                	<div class="circleStatsItemBox pink">
						<div class="header">CPU 점유율</div>
						<span class="percent">percent</span>
                    	<div class="circleStat">
                    		<input type="text" value="<%=s_cpu %>" class="whiteCircle" />
						</div>
						<div class="footer">
							<span class="count">
								<span class="number">64</span>
								<span class="unit">GHz</span>
							</span>
							<span class="sep"> / </span>
							<span class="value">
								<span class="number">100</span>
								<span class="unit">%</span>
							</span>	
						</div>
                	</div>
				</div>

			</div>	
				
						<div class="col-lg-6">
							<table class="table table-bordered table-hover table-striped">
								<thead>
									<tr align="center">
										<th>CPU Model</th>
										<th>CPUS</th>
										<th>Hz</th>
										<th>RAM</th>
										<th>CPU Utilization</th>
										<th>Memory Utilization</th>
									</tr>
								</thead>
								<tbody>
									<tr align="center">
										<td><%=node.model%></td>
										<td><%=node.cpus%></td>
										<td><%=node.mhz%> MHz</td>
										<td><%=node.memory%> KB</td>
										<td>
											<%=s_cpu%> %
										</td>
										<td>
											<%=s_memory%> %
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<h3>Load average(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/load-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/load-week.png"/><br><br>
						<h3>Interrupts and context switches(Day / Week)</h3>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/interrupts-day.png"/>
						<img src="http://<%=ip%>:81/munin/localdomain/localhost.localdomain/interrupts-week.png"/><br><br>
					</div>
				</div>
				<!-- end tabcontent -->
				</div>
				<!-- end tabbable -->
				

				<script type="text/javascript">
					jQuery(document).ready(function ($) {
						$('#tabs').tab();
					});
				</script>
				
				</div> <!-- container --> 
				<% conn.close(); %>
		
<!-- /#page-wrapper -->

<%@include file="../layout/foot.jsp"%>
