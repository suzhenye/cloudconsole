<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudInfo"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudApplication"%>
<%@page import="org.cloudfoundry.client.lib.CloudFoundryClient"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudOrganization" %>
<%@page import="org.cloudfoundry.client.lib.domain.CloudSpace" %>
<%@page import="org.cloudfoundry.client.lib.domain.CloudSecurityGroup" %>
<%@page import="org.cloudfoundry.client.lib.domain.CloudSecurityRules" %>
<%@page import="org.cloudfoundry.client.lib.util.JsonUtil" %>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%
	CloudFoundryClient client = (CloudFoundryClient) session.getAttribute("client");
	List<String> spaceSecuritySelected = (List<String>)session.getAttribute("spaceSecuritySelected");
	String securityGroupName = request.getParameter("name");
	List<CloudSecurityGroup> securityGroups = client.getSecurityGroups();
	CloudSecurityGroup cloudSecurityGroup = null;
	for (CloudSecurityGroup securityGroup : securityGroups) {
		if (securityGroup.getName().equals(securityGroupName)) {
			cloudSecurityGroup = securityGroup;
			break;
		}
	}
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
<link rel="stylesheet"
	href="<c:url value="/css/bootstrap-editable.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/css/bootstrap-responsive.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/stilearn.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/css/stilearn-responsive.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/stilearn-helper.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/stilearn-icon.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/font-awesome.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/animate.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/uniform.default.css"/>" />

<link rel="stylesheet" href="<c:url value="/css/select2.css"/>" />
<link rel="stylesheet" href="<c:url value="/css/fullcalendar.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/css/bootstrap-wysihtml5.css"/>" />

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
	<!-- section content -->
	<section class="section">
		<div class="row-fluid">
			<!-- span side-left -->
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
						<li><a href="./organization" title="Organizations">
								<div class="helper-font-24">
									<i class="icofont-magnet"></i>
								</div> <span class="sidebar-text">租户管理</span>
						</a></li>
						<li><a href="./spaceView" title="spaces">
								<div class="helper-font-24">
									<i class="icofont-edit"></i>
								</div> <span class="sidebar-text">租户空间</span>
						</a></li>
						<li class="active first">
                        	<a href="./securityView" title="spaces">
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
									</a>
								</li>
							</ul>
						</li>
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
                        	<a href="./eventView" title="spaces">
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
								<li><a href="./monit" title="cluster monit">
										<div class="helper-font-24">
											<i class="icofont-warning-sign"></i>
										</div> <span class="sidebar-text">集群状态</span>
								</a></li>
								<li><a href="./loadBalance" title="router loadbalance">
										<div class="helper-font-24">
											<i class="icofont-lock"></i>
										</div> <span class="sidebar-text">负载均衡</span>
								</a></li>
								<li><a href="./trafficView" title="traffice controller">
										<div class="helper-font-24">
											<i class="icofont-barcode"></i>
										</div> <span class="sidebar-text">流量控制</span>
								</a></li>
								<li><a href="./monitEvent" title="monit event">
										<div class="helper-font-24">
											<i class="icofont-briefcase"></i>
										</div> <span class="sidebar-text">事件信息</span>
								</a></li>
								<li class="divider"></li>
								<li><a href="./bonus-page/resume/index.html" title="resume">
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
				<div class="content">
					<div class="content-header">
						<h2>
							<i class="icofont-home"></i> 绑定和解绑安全组  <small> Bind Your Space to SecurityGroup</small>
						</h2>
					</div>
					<div class="content-breadcrumb">
						<ul class="breadcrumb">
							<li><a href="./home"><i class="icofont-home"></i>Dashboard</a>
								<span class="divider">&rsaquo;</span></li>
							<li><a href="./securityView">云安全组</a><span class="divider">&rsaquo;</span></li>
							<li class="active"><%=cloudSecurityGroup.getName()%></li>
						</ul>
					</div>
					<div class="content-body">
                        <div class="row-fluid">
                        	<div class="box-body">
                        		<form class="form-horizontal" action="./editSpacesFromSecurityGroup" method="post">
                        		<fieldset>
                        			<legend>绑定和解绑安全组<%=securityGroupName %>到CloudSpace</legend>
                        			<div class="control-group">
                                    	<label class="control-label" for="securityGroup">安全组名：</label>
                                       	<div class="controls">
                                            <input type="text" id="securityGroup" name="securityGroup" class="grd-white" readonly="readonly" value="<%=cloudSecurityGroup.getName() %>" />
                                        </div>
                                   	</div>
                                   	<!-- 移除或添加组织空间 -->
                                    <div class="control-group">
                                    	<label class="control-label" for="inputSelectMultiGroup">添加或移除组织部门:</label>
                                    	<div class="controls">
                                    		<select id="inputSelectMultiGroup" data-form="select2" id="orgspace" name="orgspace"
                                           			style="width:220px" data-placeholder="我需要合适的部门" multiple="multiple">
                                           	<%
                                           				List<CloudOrganization> orgs = client.getOrganizations();
                                           				String orgName = "";
                                           				for(CloudOrganization org : orgs){
                                           					orgName = org.getName(); 
                                           					List<CloudSpace> spaces = client.getSpaceFromOrgName(orgName);
                                           			%>                                           			
                                           				<optgroup label="<%=orgName %>">
                                           					<%  
                                           						
                                           						for(CloudSpace space : spaces){
                                           							if(spaceSecuritySelected.size()!=0){
                                           								Boolean exitflag = false;
                                           								for(String s : spaceSecuritySelected){
                                           									if(s.equals(orgName + "--" + space.getName())){
                                           										exitflag = true;
                                           					%>
                                           					<option selected="selected"><%=orgName %>--<%=space.getName()%></option>
                                           					
                                           					<%  
                                           							}
                                           						}
                                           						if(exitflag==false){                   								
                                           					%>   
                                           						<option><%=orgName%>--<%=space.getName()%></option>
                                           					<%
                                           						}
                                           					%>         					
                                           						
                                           					
                                           					<%	
                                           							}else{
                                         					%>
                                         					<option><%=orgName%>--<%=space.getName()%></option>
                                         					<%  
                                           							}	
                                           						}
                                           					%>
                                                        </optgroup>                                                       
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
	</section>
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
		src='/cloudconsole/js/calendar/fullcalendar.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/datatables/jquery.dataTables.js'></script>
	<script type="text/javascript"
		src='/cloudconsole/js/datatables/DT_bootstrap.js'></script>
	<script type="text/javascript"
		src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
	<script type="text/javascript"
		src="<c:url value="/js/bootstrap-editable.js" />"></script>
	<script type="text/javascript"
		src='/cloudconsole/js/jquery.json.min.js'></script>
	
	<script>
	$.fn.editable.defaults.mode = 'popup';
	$(function() {
		$.each($(".autoEdit"), function(index, value) {
			$(value).editable();
		});

		var callback = function(data, config) {
			var res = eval('(' + data + ')');
			if (!res.success) {
				var errorMsg = "<div class='alert alert-error'> "
						+ "<a class=\"close\" data-dismiss='alert'>close</a>"
						+ "<strong>Error!</strong>" + res.msg + "</div>";
				$("#tabResources").prepend(errorMsg);
			}
		};

		$("#name").editable({
			success : callback
		});

		$("#staging").editable({
			success : callback
		});

		$('#running').editable({
			success : callback
		});
		
		$('#rules').editable({
			success : callback
		});
	});
	</script>
	
	<script type="text/javascript">
		function getJson(){
			var jsonString = $("#rules").attr("value");
            var encoded = $.toJSON( jsonString );
            return encoded;
		}
	</script>
	
	
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
                //$('[data-form=wysihtml5]').wysihtml5();
                
                
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