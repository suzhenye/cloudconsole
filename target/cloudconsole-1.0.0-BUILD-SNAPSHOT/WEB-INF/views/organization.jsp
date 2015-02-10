<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudInfo"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudApplication"%>
<%@page import="org.cloudfoundry.client.lib.CloudFoundryClient"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudOrganization" %>
<%@page import="org.cloudfoundry.client.lib.domain.CloudSpace" %>
<%@page import="org.cloudfoundry.client.lib.domain.CloudUser" %>
<%@page import="org.cloudfoundry.client.lib.domain.CloudDomain" %>
<%@page import="org.cloudfoundry.client.lib.domain.CloudQuota" %>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.cloudconsole.model.RegisterUser" %>
<%
	CloudFoundryClient client = (CloudFoundryClient) session.getAttribute("client");
	List<RegisterUser> notRegisterUsers = new ArrayList<RegisterUser>();
	notRegisterUsers = (List<RegisterUser>) session.getAttribute("notRegisterUsers");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Dashboard - 云平台统一监控</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="" />
<meta name="author" content="stilearning" />

<!-- google font -->
<link href="<c:url value="/css/google-css.css"/>" rel="stylesheet"
	type="text/css" />

<!-- styles -->
<link rel="stylesheet" href="<c:url value="/css/bootstrap.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/bootstrap-responsive.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/stilearn.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/stilearn-responsive.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/stilearn-helper.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/stilearn-icon.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/font-awesome.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/animate.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/uniform.default.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/DT_bootstrap.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/select2.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/bootstrap-wysihtml5.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/responsive-tables.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/datepicker.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/colorpicker.css"/>" />

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
	function doDelete(orgQuotaName){
		$.ajax({
			type:"GET",
			url:"orgQuotaOperation",
			cache:"false",
			data:{
				orgQuotaName:orgQuotaName
			},
			complete : function(data, textStatus, jqXHR){
				if("error" == textStatus){
					var err =  data.responseText;
					var errorMsg = "<div class='alert alert-error'> " +  
				  				"<a class=\"close\" data-dismiss='alert'>*</a>"+  
				  				"<strong>Error!</strong>"+err+"</div>";  
					$(".container").prepend(errorMsg);
				}else{
					location.reload();
				}
			}
		});
	}
</script>
</head>


<body>
	<!-- section header -->
	<header class="header">
		<!--nav bar helper-->
		<div class="navbar-helper">
			<div class="row-fluid">
				<!--panel site-name-->
				<div class="span2">
					<div class="panel-sitename">
						<h2>
							<a href="./home"><span class="color-teal">CloudFoundry</span>Console</a>
						</h2>
					</div>
				</div>
			</div>
		</div>
		<!--/nav bar helper-->
	</header>

	<section class="section">
		<div class="row-fluid">
			<div class="span1">
				<!--side bar-->
				<aside class="side-left">
					<ul class="sidebar">
						<li>
							<!--always define class .first for first-child of li element sidebar left-->
							<a href="./home" title="dashboard">
								<div class="helper-font-24">
									<i class="icofont-dashboard"></i>
								</div> <span class="sidebar-text">控制台</span>
						</a>
						</li>
						<li class="active first"><a href="./organization"
							title="Organizations">
								<div class="helper-font-24">
									<i class="icofont-magnet"></i>
								</div> <span class="sidebar-text">租户管理</span>
						</a>
							<ul class="sub-sidebar corner-top shadow-silver-dark">
								<li><a href="./orgManager" title="组织管理">
										<div class="helper-font-24">
											<i class="icofont-warning-sign"></i>
										</div> <span class="sidebar-text">管理组织</span>
								</a></li>
								<li><a href="./quotaManager" title="资源配额管理">
										<div class="helper-font-24">
											<i class="icofont-warning-sign"></i>
										</div> <span class="sidebar-text">配额管理</span>
								</a></li>
							</ul>
						</li>
						<li><a href="./spaceView" title="spaces">
								<div class="helper-font-24">
									<i class="icofont-edit"></i>
								</div> <span class="sidebar-text">租户空间</span>
						</a></li>
						<li>
                        	<a href="./securityView" title="Security">
                            <div class="helper-font-24">
                            	<i class="icofont-umbrella"></i>
                            </div>
                            <span class="sidebar-text">安全组</span>
                            </a>
                         </li>
						<li><a href="./appView" title="apps">
								<div class="helper-font-24">
									<i class="icofont-bar-chart"></i>
								</div> <span class="sidebar-text">应用管理</span>
						</a>
							<ul class="sub-sidebar corner-top shadow-silver-dark">
								<li><a href="./uploadApp" title="cluster monit">
										<div class="helper-font-24">
											<i class="icofont-warning-sign"></i>
										</div> <span class="sidebar-text">上传应用</span>
								</a></li>
							</ul></li>
						<li><a href="./domain" title="Routes">
								<div class="helper-font-24">
									<i class="icofont-table"></i>
								</div> <span class="sidebar-text">域名管理</span>
						</a></li>
						<li><a href="./services" title="ServiceMarket">
								<div class="helper-font-24">
									<i class="icofont-columns"></i>
								</div> <span class="sidebar-text">服务市场</span>
						</a></li>
						<li><a href="./serviceGateway" title="ServiceGateway">
								<div class="helper-font-24">
									<i class="icofont-reorder"></i>
								</div> <span class="sidebar-text">服务网关</span>
						</a></li>
						<li>
                        	<a href="./eventView" title="cloudEvent">
                            <div class="helper-font-24">
                            	<i class="icofont-envelope-alt"></i>
                            </div>
                            <span class="sidebar-text">平台事件</span>
                            </a>
                        </li>
						<li><a href="./dea" title="Dea">
								<div class="helper-font-24">
									<i class="icofont-cloud"></i>
								</div> <span class="sidebar-text">DEA监控</span>
						</a></li>						
						<li><a href="#" title="more">
								<div class="badge badge-important">5</div>
								<div class="helper-font-24">
									<i class="icofont-th-large"></i>
								</div> <span class="sidebar-text">组件监控</span>
						</a>
							<ul class="sub-sidebar corner-top shadow-silver-dark">
								<li><a href="./monit" title="not found">
										<div class="helper-font-24">
											<i class="icofont-warning-sign"></i>
										</div> <span class="sidebar-text">集群状态</span>
								</a></li>
								<li><a href="./loadBalance" title="login">
										<div class="helper-font-24">
											<i class="icofont-lock"></i>
										</div> <span class="sidebar-text">负载均衡</span>
								</a></li>
								<li><a href="./trafficView" title="invoice">
										<div class="helper-font-24">
											<i class="icofont-barcode"></i>
										</div> <span class="sidebar-text">流量控制</span>
								</a></li>
								<li><a href="./monitEvent" title="pricing table">
										<div class="helper-font-24">
											<i class="icofont-briefcase"></i>
										</div> <span class="sidebar-text">事件信息</span>
								</a></li>
								<li class="divider"></li>
								<li><a href="/bonus-page/resume/index.html" title="resume">
										<div class="helper-font-24">
											<i class="icofont-user"></i>
										</div> <span class="sidebar-text">Resume</span>
								</a></li>
							</ul></li>
					</ul>
				</aside>
				<!--/side bar -->
			</div>
			<!-- span side-left -->

			<div class="span11">
				<!-- content -->
				<div class="content">
					<div class="content-header">
						<h2>
							<i class="icofont-home"></i> Cloud Organization <small>数据中心统一配置中心</small>
						</h2>
					</div>
					<!-- /content-header -->

					<!-- content-breadcrumb -->
					<div class="content-breadcrumb">
						<!--breadcrumb-nav-->
						<ul class="breadcrumb-nav pull-right">
							<li class="divider"></li>
							<li class="btn-group">
                            	<a href="./editUserPrivilege" class="btn btn-small btn-link">
                                	<i class="icofont-money"></i> 用户授权
                                </a>
                            </li>						
							<li class="divider"></li>
							<li class="btn-group"><a href="./usermanager"
								class="btn btn-small btn-link"> <i class="icofont-user"></i>
									用户管理 <span class="color-red">
									<%
										if( notRegisterUsers.size()>0 ){
									%>
									(+<%=notRegisterUsers.size() %>)
									<%
										}else{
									%>
									(0)
									<%
										}
									%>
									</span>
							</a></li>
						</ul>
						<!--/breadcrumb-nav-->

						<!--breadcrumb-->
						<ul class="breadcrumb">
							<li><a href="./home"><i class="icofont-home"></i>
									Dashboard</a> <span class="divider">&rsaquo;</span></li>
							<li class="active">数据中心概览</li>
						</ul>
						<!--/breadcrumb-->
					</div>
					<!-- /content-breadcrumb -->
				<div class="content-body">
					<div class="row-fluid">
							<div class="span12">
								<div class="box-tab corner-all">
									<div class="box-header corner-top">
										<ul class="nav nav-pills">
											<li class="active"><a data-toggle="tab" href="#orgListTab">组织列表</a></li>
											<li><a data-toggle="tab" href="#orgCreateTab">创建组织</a></li>
											<li><a data-toggle="tab" href="#orgQuotaListTab">数据中心配额列表</a></li>
											<li><a data-toggle="tab" href="#orgQuotaCreateTab">创建数据中心配额</a></li>
											<li><a data-toggle="tab" href="#orgQuotaSelectTab">分配配额</a></li>
										</ul>
									</div>
									<div class="box-body">
										<div class="tab-content">
											<div class="tab-pane fade in active" id="orgListTab">
												<table class="table table-bordered table-striped autoTable">
													<thead>
														<tr>
															<th>数据中心名称</th>
															<th>中心拥有空间数</th>
															<th>中心资源内存资源</th>
															<th>可拥有最大路由数量</th>
															<th>可容纳的服务数量</th>
															<th>创建数据中心时间</th>
														</tr>
													</thead>
													<%
														List<CloudOrganization> orgs = client.getOrganizations();
														for(CloudOrganization org : orgs){
															String orgName = org.getName();
													%>
													<tbody>
														<tr>
															<td><a href="orgManager?orgName=<%=orgName %>"><%=orgName %></a></td>
															<td><%=client.getSpaceFromOrgName(orgName).size() %></td>
															<td><%=org.getQuota()==null ? client.getCloudInfo().getLimits().getMaxTotalMemory() : org.getQuota().getMemoryLimit() %></td>
															<td><%=org.getQuota()==null ? "无限制" : org.getQuota().getTotalRoutes() %></td>
															<td><%=org.getQuota()==null ? client.getCloudInfo().getLimits().getMaxServices() : org.getQuota().getTotalServices() %></td>
															<td><%=org.getMeta().getCreated() %></td>
														</tr>
													</tbody>
													<%
														}
													%>
												</table>
                                            </div>
                                            <div class="tab-pane fade" id="orgCreateTab">
                                            	<form class="form-horizontal" action="doAddOrganization" method="post" id="form-validate">
                                            		<fieldset>
                                            			<legend>创建组织</legend>
														<div class="control-group">
															<label class="control-label" for="orgName" >创建组织名：</label>
                                   							<div class="controls">
                                                                <input type="text" id="orgName" name="orgName" class="grd-white" />
                                                            </div>
														</div>
														<div class="control-group">
															<label class="control-label" for="orgQuota">选择资源配额(可选)：</label>
															<div class="controls">
																<select id="orgQuota" name="orgQuota" data-form="select2" style="width:220px" data-placeholder="请选择您的资源配额">
																	<option></option>
																	<%
																		List<CloudQuota> orgQuotas = client.getQuotas();
																		for(CloudQuota orgQuota : orgQuotas){
																	%>
																	<option><%=orgQuota.getName() %></option>
																	<%
																		}
																	%>
																</select>
															</div>
														</div>
                                            			<div class="form-actions">
                                                            <button type="submit" class="btn btn-primary">保存设置</button>
                                   							<button type="button" class="btn">取消设置</button>
                                                        </div>
                                            		</fieldset>
                                            	</form>
                                            </div>
                                            <div class="tab-pane fade" id="orgQuotaListTab">
                                            	<table class="table table-bordered table-striped">
                                            		<thead>
                                            			<tr>
															<th>配额名</th>
															<th>允许最大服务数量</th>
															<th>允许最大路由数</th>
															<th>空间内存资源极限</th>
															<th>空间配额创建时间</th>
															<th>操作</th>
														<tr>
                                            		</thead>
                                            		<tbody>
                                            		<%
                                            			List<CloudQuota> orgQuotaList = client.getQuotas();
                                            		 	for (CloudQuota orgQuota : orgQuotaList) {
                                            		 		String quotaName = orgQuota.getName();
                                            		%>
                                            			<tr>
                                            				<td><%=quotaName %></td>
                                            				<td><%=orgQuota.getTotalServices() %></td>
                                            				<td><%=orgQuota.getTotalRoutes() %></td>
                                            				<td><%=orgQuota.getMemoryLimit() %></td>
                                            				<td><%=orgQuota.getMeta().getCreated() %></td>
                                            				<%
                                            					if(quotaName.equals("default")){
                                            				%>
                                            				<td>不允许</td>
                                            				<%
                                            					}else{
                                            				%>
                                            				<td width="60">
                                            					<a href="#" onclick="doDelete('<%=orgQuota.getName() %>')"><button class="btn btn-small"><i class="icon-remove"></i></button></a>
                                            				</td>
                                            				<%
                                            		 			}
                                            				%>
                                            			</tr>                     		
                                            		<%
                                            		 	}
                                            		%>
                                            		</tbody>
                                            	</table>
                                            </div>
                                            <div class="tab-pane fade" id="orgQuotaCreateTab">
                                            	<form class="form-horizontal" action="doCreateOrgQuota" method="post" id="form-validate">
                                            		<fieldset>
                                            			<legend>创建数据中心资源配额</legend>
                                            			<div class="control-group">
															<label class="control-label" for="orgQuotaName" >创建资源配额名：</label>
                                   							<div class="controls">
                                                                <input type="text" id="orgQuotaName" name="orgQuotaName" class="grd-white" />
                                                            </div>
														</div>
														<div class="control-group">
															<label class="control-label" for="total_services">请输入最大支持服务：</label>
															<div class="controls">
																<input type="text" class="grd-white" placeholder="5到200" data-validate="{required: true, number:true, min: 5, max: 200, messages:{required:'请输入5到200之间的数', number:'请输入数字', min:'请输入最小超过5的数(包括5)', max:'请输入最大不超过200的数(包括200)'}}" name="total_services" id="total_services" />
															</div>
														</div>
														<div class="control-group">
															<label class="control-label" for="total_routes">请输入最大支持路由：</label>
															<div class="controls">
																<input type="text" class="grd-white" placeholder="10到20" data-validate="{required: true, number:true, min: 10, max: 20, messages:{required:'请输入10到20之间的数', number:'请输入数字', min:'请输入最小超过10的数(包括10)', max:'请输入最大不超过20的数(包括20)'}}" name="total_routes" id="total_routes" />
															</div>
														</div>
														<div class="control-group">
															<label class="control-label" for="memory_limit">最大的内存资源限制：</label>
															<div class="controls">
																<input type="text" class="grd-white" placeholder="2048到10024" data-validate="{required: true, number:true, min: 2048, max: 10024, messages:{required:'请输入2048到10024之间的数', number:'请输入数字', min:'请输入最小超过2048的数(包括2048)', max:'请输入最大不超过10024的数(包括10024)'}}" name="memory_limit" id="memory_limit" />
															</div>
														</div>
														<div class="form-actions">
                                                            <button type="submit" class="btn btn-primary">保存设置</button>
                                   							<button type="button" class="btn">取消设置</button>
                                                        </div>
                                            		</fieldset>
                                            	</form>
                                            </div>
                                            <div class="tab-pane fade" id="orgQuotaSelectTab">
                                            	<form class="form-horizontal" action="doAssociateOrgQuota" method="post" id="form-validate">
                                            		<fieldset>
                                            		<legend>分配配额资源到组织</legend>
                                            		<div class="control-group">
                                            			<label class="control-label" for="associateQuota">请选择资源配额：</label>          		
                                            			<div class="controls">
                                            				<select id="associateOrgQuota" name="associateOrgQuota" data-form="select2" style="width:200px" data-placeholder="请选择您的资源配额：">
                                            				<option></option>
                                            				<%
                                            					List<CloudQuota> quotas =  client.getQuotas();
                                            					for (CloudQuota quota : quotas) {
                                            				%>
                                            				<option><%=quota.getName() %></option>
                                            				<%
                                            					}
                                            				%>
                                            				</select>
                                            			</div>
                                            		</div>
                                            		<div class="control-group">  
                                            			<label class="control-label" for="associateQuota">请选数据中心：</label>     		
                                            			<div class="controls">
                                            				<select id="associateOrgQuota" name="orgSelect" data-form="select2" style="width:200px" data-placeholder="数据中心：">
                                            				<option></option>
                                            				<%
                                            					List<CloudOrganization> organizations = client.getOrganizations();
                                            					for (CloudOrganization organization : organizations) {
                                            				%>
                                            				<option><%=organization.getName() %></option>
                                            				<%
                                            					}
                                            				%>
                                            				</select>
                                            			</div>
                                            		</div>
                                            		<div class="form-actions">
                                                            <button type="submit" class="btn btn-primary">保存设置</button>
                                   							<button type="button" class="btn">取消设置</button>
                                                    </div>
                                                    </fieldset>
                                            	</form>
                                            </div>
										</div>
									</div>
								</div>
							</div>
						</div>	
					</div>
				</div>
		</div>
		</div>
	</section>

	<!-- section footer -->
	<footer>
		<a rel="to-top" href="#top"><i class="icofont-circle-arrow-up"></i></a>
	</footer>

	<script type="text/javascript"
		src='/cloudconsole/js/widgets.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/jquery.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/jquery-ui.min.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/bootstrap.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/datepicker/bootstrap-datepicker.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/colorpicker/bootstrap-colorpicker.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/uniform/jquery.uniform.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/validate/jquery.validate.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/validate/jquery.metadata.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/wizard/jquery.ui.widget.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/wizard/jquery.wizard.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/peity/jquery.peity.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/select2/select2.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/knob/jquery.knob.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/flot/jquery.flot.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/flot/jquery.flot.resize.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/flot/jquery.flot.categories.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/wysihtml5/wysihtml5-0.3.0.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/wysihtml5/bootstrap-wysihtml5.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/datatables/jquery.dataTables.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/datatables/DT_bootstrap.js'></script>
		
	<script type="text/javascript">
            $(document).ready(function() {
                // try your js
                
                // auto complete
                $('#inputAuto').typeahead({
                    source : ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Dakota","North Carolina","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
                });
                
                // select2
                $('#inputTags').select2({tags:["red", "green", "blue"]});
                $('[data-form=select2]').select2();
                $('[data-form=select2-group]').select2();
                
                // this select2 on side right
                $('#tagsSelect').select2({
                    tags:["red", "green", "blue"],
                    tokenSeparators: [",", " "]
                });
                
                
                // datepicker
                $('[data-form=datepicker]').datepicker();

                // coloricker
                $('[data-form=colorpicker]').colorpicker();
                
                
                // uniform
                $('[data-form=uniform]').uniform()

                // wysihtml5
                $('[data-form=wysihtml5]').wysihtml5();
                
                
                // validate form
                $('#form-validate').validate();
                
                // wizard
                $('#form-wizard').wizard({
                    stepsWrapper: "#wrapped",
                    submit: ".submit",
                    beforeSelect: function( event, state ) {
                        var inputs = $(this).wizard('state').step.find(':input');
                        return !inputs.length || !!inputs.valid();
                    }
                }).submit(function( event ) {
                    
                    
                }).wizard('form').validate({
                    errorPlacement: function(error, element) { 
                        if ( element.is(':radio') || element.is(':checkbox') ) {
                                $('#error-gender').html(error);
                        } else { 
                                error.insertAfter( element );
                        }
                    }
                });
                
            });
            </script>

</body>

</html>