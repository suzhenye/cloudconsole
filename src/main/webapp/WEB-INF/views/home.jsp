<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.*"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudInfo"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudUser"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudApplication"%>
<%@page import="org.cloudfoundry.client.lib.CloudFoundryClient"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudOrganization"%>
<%@page import="org.cloudfoundry.client.lib.domain.CloudSpace"%>
<%
	CloudFoundryClient client = (CloudFoundryClient) session.getAttribute("client");
	String user = client.getCloudInfo().getUser();
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Dashboard - 云平台统一监控</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta name="description" content="" />
        <meta name="author" content="stilearning" />

        <!-- google font -->
        <link href="<c:url value="/css/google-css.css"/>" rel="stylesheet" type="text/css" />

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

		<link rel="stylesheet" href="<c:url value="/css/select2.css"/>" />
        <link rel="stylesheet" href="<c:url value="/css/fullcalendar.css"/>" />
        <link rel="stylesheet" href="<c:url value="/css/bootstrap-wysihtml5.css"/>" />

        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>

    <body>
        <!-- section header -->
        <header class="header">
            <!--nav bar helper-->
            <div class="navbar-helper">
                <div class="row-fluid">
                    <!--panel site-name-->
                    <div class="span2">
                        <div class="panel-sitename">
                            <h2><a href="./home"><span class="color-teal">CloudFoundry</span>Console</a></h2>
                        </div>
                    </div>
                    <div class="span2" style="float:right;">
                    	<div class="panel-ext" >
                        	<div class="btn-group user-group">
                                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                                    <img class="corner-all" align="middle" src="img/user-thumb.png" title="<%=user %>" alt="<%=user %>" /> <!--this for display on PC device-->
                                    <button class="btn btn-small btn-inverse"><%=user %></button> <!--this for display on tablet and phone device-->
                                </a>
                                <ul class="dropdown-menu dropdown-user" role="menu" aria-labelledby="dLabel">
                                    <li>
                                        <div class="media">
                                            <a class="pull-left" href="#">
                                                <img class="img-circle" src="img/user.png" title="profile" alt="profile" />
                                            </a>
                                            <div class="media-body description">
                                                <p><strong><%=client.getCloudInfo().getDescription() %></strong></p>
                                                <p class="muted"><%=client.getCloudInfo().getSupport() %></p>
                                                <a href="./userinfo?username=<%=user %>" class="btn btn-primary btn-small btn-block">用户预览</a>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="dropdown-footer">
                                        <div>
                                            <a class="btn btn-small pull-right" href="login.html">登出</a>
                                            <a class="btn btn-small" href="#">添加用户</a>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                       	</div>
                    </div>
                </div>
            </div><!--/nav bar helper-->
        </header>

        <!-- section content -->
        <section class="section">
            <div class="row-fluid">
                <!-- span side-left -->
                <div class="span1">
                    <!--side bar-->
                    <aside class="side-left">
                        <ul class="sidebar">
                            <li class="active first"> <!--always define class .first for first-child of li element sidebar left-->
                                <a href="./home" title="dashboard">
                                    <div class="helper-font-24">
                                        <i class="icofont-dashboard"></i>
                                    </div>
                                    <span class="sidebar-text">控制台</span>
                                </a>
                            </li>
                            <li>
                                <a href="./organization" title="Organizations">
                                    <div class="helper-font-24">
                                        <i class="icofont-magnet"></i>
                                    </div>
                                    <span class="sidebar-text">租户管理</span>
                                </a>
                            </li>
                            <li>
                                <a href="./spaceView" title="spaces">
                                    <div class="helper-font-24">
                                        <i class="icofont-edit"></i>
                                    </div>
                                    <span class="sidebar-text">租户空间</span>
                                </a>
                            </li>
                            <li>
                                <a href="./securityView" title="spaces">
                                    <div class="helper-font-24">
                                        <i class="icofont-umbrella"></i>
                                    </div>
                                    <span class="sidebar-text">安全组</span>
                                </a>
                            </li>
                            <li>
                                <a href="./appView" title="apps">
                                    <div class="helper-font-24">
                                        <i class="icofont-bar-chart"></i>
                                    </div>
                                    <span class="sidebar-text">应用管理</span>
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
                            <li>
                                <a href="./domain" title="Routes">
                                    <div class="helper-font-24">
                                        <i class="icofont-table"></i>
                                    </div>
                                    <span class="sidebar-text">域名管理</span>
                                </a>
                            </li>
                            <li>
                                <a href="./services" title="ServiceMarket">
                                    <div class="helper-font-24">
                                        <i class="icofont-columns"></i>
                                    </div>
                                    <span class="sidebar-text">服务市场</span>
                                </a>
                            </li>
                            <li>
                                <a href="./serviceGateway" title="ServiceGateway">
                                    <div class="helper-font-24">
                                        <i class="icofont-reorder"></i>
                                    </div>
                                    <span class="sidebar-text">服务网关</span>
                                </a>
                            </li>
                            <li>
                                <a href="./eventView" title="events">
                                    <div class="helper-font-24">
                                        <i class="icofont-envelope-alt"></i>
                                    </div>
                                    <span class="sidebar-text">平台事件</span>
                                </a>
                            </li>
                            <li>
                                <a href="./dea" title="Dea">
                                    <div class="helper-font-24">
                                        <i class="icofont-cloud"></i>
                                    </div>
                                    <span class="sidebar-text">DEA监控</span>
                                </a>
                            </li>
                            <li>
                                <a href="#" title="more">
                                    <div class="badge badge-important">5</div>
                                    <div class="helper-font-24">
                                        <i class="icofont-th-large"></i>
                                    </div>
                                    <span class="sidebar-text">组件监控</span>
                                </a>
                                <ul class="sub-sidebar corner-top shadow-silver-dark">
                                    <li>
                                        <a href="./monit" title="not found">
                                            <div class="helper-font-24">
                                                <i class="icofont-warning-sign"></i>
                                            </div>
                                            <span class="sidebar-text">集群状态</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="./loadBalance" title="login">
                                            <div class="helper-font-24">
                                                <i class="icofont-lock"></i>
                                            </div>
                                            <span class="sidebar-text">负载均衡</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="./trafficView" title="invoice">
                                            <div class="helper-font-24">
                                                <i class="icofont-barcode"></i>
                                            </div>
                                            <span class="sidebar-text">流量控制</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="./monitEvent" title="pricing table">
                                            <div class="helper-font-24">
                                                <i class="icofont-briefcase"></i>
                                            </div>
                                            <span class="sidebar-text">事件信息</span>
                                        </a>
                                    </li>
                                    <li class="divider"></li>
                                    <li>
                                        <a href="./bonus-page/resume/index.html" title="resume">
                                            <div class="helper-font-24">
                                                <i class="icofont-user"></i>
                                            </div>
                                            <span class="sidebar-text">Resume</span>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </aside><!--/side bar -->
                </div><!-- span side-left -->
                
                <!-- span content -->
                <div class="span11">
                    <!-- content -->
                    <div class="content">
                        <!-- content-header -->
                        <div class="content-header">
                            <ul class="content-header-action pull-right">
                                <li>
                                    <a href="#">
                                        <span data-chart="peity-bar" data-height="32" data-colours='["#00A600", "#00A600"]'>5,3,9,6,5,9,7,3,5,2</span>
                                        <div class="action-text color-green"><%=client.getCloudInfo().getLimits().getMaxServices() %>  <span class="helper-font-small color-silver-dark">服务数量</span></div>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="#">
                                        <span data-chart="peity-bar" data-height="32" data-colours='["#00A0B1", "#00A0B1"]'>9,7,9,6,3,5,3,5,5,2</span>
                                        <div class="action-text color-teal">1437 <span class="helper-font-small color-silver-dark">用户数量</span></div>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="#">
                                        <span data-chart="peity-bar" data-height="32" data-colours='["#BF1E4B", "#BF1E4B"]'>6,5,9,7,3,5,2,5,3,9</span>
                                        <div class="action-text color-red"><%=client.getCloudInfo().getLimits().getMaxApps() %> <span class="helper-font-small color-silver-dark">应用数量</span></div>
                                    </a>
                                </li>
                            </ul>
                            <h2><i class="icofont-home"></i> 云部署控制台 <small>欢迎进入Cloud DevOps 控制台</small></h2>
                        </div><!-- /content-header -->
                        
                        <!-- content-breadcrumb -->
                        <div class="content-breadcrumb">
                            <!--breadcrumb-nav-->
                            <ul class="breadcrumb-nav pull-right">
                                <li class="divider"></li>
                                <li class="btn-group">
                                    <a href="#" class="btn btn-small btn-link dropdown-toggle" data-toggle="dropdown">
                                        <i class="icofont-tasks"></i> 组织空间切换
                                        <i class="icofont-caret-down"></i>
                                    </a>
                                    <ul class="dropdown-menu">
                                    <%
                                   		List<CloudOrganization> organizations = client.getOrganizations();
                            			for (CloudOrganization organization : organizations) {
                                    %>
                                        <li class="nav-header"><%=organization.getName() %>
                                        	<ul class="dropdown-submenu">
                                        	<%
                                        		List<CloudSpace> spaces = client.getSpaces();
                                        		for (CloudSpace space : spaces) {
                                        			List<CloudSpace> orgspaces = client.getSpaceFromOrgName(organization.getName());
                                        			for (CloudSpace orgspace : orgspaces){
                                        				if (orgspace.getMeta().getGuid().toString().equals(space.getMeta().getGuid().toString())) {
                                        	%>
                                        		<li><a href="switchOrgSpace?orgName=<%=organization.getName()%>&spaceName=<%=space.getName() %>" ><%=space.getName() %></a></li>
                                        	<%                                       				
                                        				}
                                        			}
                                        		}
                                        	%>
                                        	</ul>
                                        </li>
                                    <%
                            			}
                                    %>
                                    </ul>
                                </li>
                                <li class="divider"></li>
                                <li class="btn-group">
                                    <a href="#" class="btn btn-small btn-link">
                                        <i class="icofont-money"></i> Orders <span class="color-red">(+12)</span>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li class="btn-group">
                                    <a href="#" class="btn btn-small btn-link">
                                        <i class="icofont-user"></i> Users <span class="color-red">(+34)</span>
                                    </a>
                                </li>
                            </ul><!--/breadcrumb-nav-->
                            
                            <!--breadcrumb-->
                            <ul class="breadcrumb">
                                <li><a href="index.html"><i class="icofont-home"></i> Dashboard</a> <span class="divider">&rsaquo;</span></li>
                                <li class="active">平 台 概 览</li>
                            </ul><!--/breadcrumb-->
                        </div><!-- /content-breadcrumb -->
                        
                        <!-- content-body -->
                        <div class="content-body">
                            <!-- dashboar -->
                            <!-- shortcut button -->
                            <div class="shortcut-group">
                                <ul class="a-btn-group">
                                    <li>
                                        <a href="./appView" class="a-btn grd-white" rel="tooltip" title="应用监控">
                                            <span></span>
                                            <span><i class="icofont-leaf color-silver-dark"></i></span>
                                            <span class="color-silver-dark"><i class="icofont-file color-silver-dark"></i></span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="./uploadApp" class="a-btn grd-white" rel="tooltip" title="上传应用">
                                            <span></span>
                                            <span><i class="icofont-upload color-silver-dark"></i></span>
                                            <span class="color-silver-dark"><i class="icofont-upload-alt color-silver-dark"></i></span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="./eventView" class="a-btn grd-white" rel="tooltip" title="查看事件">
                                            <span></span>
                                            <span><i class="icofont-envelope color-silver-dark"></i></span>
                                            <span class="color-silver-dark"><i class="icofont-envelope-alt color-teal"></i></span>
                                            <div class="badge badge-info">9</div> <!--don't use span here!-->
                                        </a>
                                    </li>
                                    <li>
                                        <a href="./services" class="a-btn grd-white" rel="tooltip" title="服务市场">
                                            <span></span>
                                            <span><i class="icofont-barcode color-silver-dark"></i></span>
                                            <span class="color-silver-dark"><i class="icofont-shopping-cart color-red"></i></span>
                                            <div class="label label-important">2</div> <!--don't use span here!-->
                                        </a>
                                    </li>
                                    <li>
                                        <a href="./monit" class="a-btn grd-white" rel="tooltip" title="Monit集群监控">
                                            <span></span>
                                            <span><i class="icofont-bar-chart color-silver-dark"></i></span>
                                            <span class="color-silver-dark"><i class="typicn-lineChart"></i></span>
                                        </a>
                                    </li>
                                    <li class="clearfix"></li>
                                </ul>
                            </div><!-- /shortcut button -->
                            
                            <div class="divider-content"><span></span></div>
                            
                            <!-- tab stat -->
                            <div class="box-tab corner-all">
                                <div class="box-header corner-top">
                                    <div class="header-control pull-right">
                                        <a data-box="collapse"><i class="icofont-caret-up"></i></a>
                                    </div>
                                    <ul class="nav nav-tabs" id="tab-stat">
                                        <li class="active"><a data-toggle="tab" href="#system-stat">路由统计</a></li>
                                        <li><a data-toggle="tab" href="#server-stat">资源统计</a></li>
                                    </ul>
                                </div>
                                <div class="box-body">
                                    <div class="tab-content">
                                        <div class="tab-pane fade in active" id="system-stat">
                                            <div class="row-fluid">
                                                <div class="span4">
                                                    <div class="dashboard-stat">
                                                        <div id="visitor-stat" class="chart" style="height: 120px;"></div>
                                                        <div class="stat-label grd-green color-white">访问数量</div>
                                                    </div>
                                                </div>
                                                <div class="span4">
                                                    <div class="dashboard-stat">
                                                        <div id="order-stat" class="chart" style="height: 120px;"></div>
                                                        <div class="stat-label grd-teal color-white">用户数量</div>
                                                    </div>
                                                </div>
                                                <div class="span4">
                                                    <div class="dashboard-stat">
                                                        <div id="user-stat" class="chart" style="height: 120px;"></div>
                                                        <div class="stat-label grd-red color-white">应用数量</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane fade" id="server-stat">
                                            <div class="row-fluid">
                                                <div class="span4">
                                                    <div class="dashboard-stat" rel="tooltip" title="usage <%=client.getCloudInfo().getUsage().getTotalMemory() %>M of <%=client.getCloudInfo().getLimits().getMaxTotalMemory() %>M">
                                                        <input data-chart="knob" type="text" data-readonly="true" data-width="120" data-height="120" data-fgcolor="#00A600" value="<%=client.getCloudInfo().getUsage().getTotalMemory() %>" data-min="0" data-max="<%=client.getCloudInfo().getLimits().getMaxTotalMemory() %>" />
                                                        <div class="stat-label grd-green color-white">内存使用</div>
                                                    </div>
                                                </div>
                                                <div class="span4">
                                                    <div class="dashboard-stat" rel="tooltip" title="1112kb %> of 2234kb">
                                                        <input data-chart="knob" type="text" data-readonly="true" data-width="120" data-height="120" data-fgcolor="#00A0B1" value="1112" data-min="0" data-max="<%=2234 %>" />
                                                        <div class="stat-label grd-teal color-white">磁盘使用</div>
                                                    </div>
                                                </div>
                                                <div class="span4">
                                                    <div class="dashboard-stat" rel="tooltip" title="server condition 70%, it's good!">
                                                        <input data-chart="knob" type="text" data-readonly="true" data-width="120" data-height="120" data-fgcolor="#AC193D" value="70" data-min="0" data-max="100" />
                                                        <div class="stat-label grd-red color-white">集群健康</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div><!-- /tab stat -->
                            
                            <!--schedule-->
                            <div class="box corner-all">
                                <div class="box-header grd-white color-silver-dark corner-top">
                                    <div class="header-control">
                                        <a data-box="collapse"><i class="icofont-caret-up"></i></a>
                                    </div>
                                    <span>Schedule this month</span>
                                </div>
                                <div class="box-body">
                                    <div id="schedule"></div>
                                </div>
                            </div>
                            <!--schedule-->
                            
                            <!--/dashboar-->
                        </div><!--/content-body -->
                    </div><!-- /content -->
                </div><!-- /span content -->
                
                <!-- span side-right -->
                <div class="span2">
                    <!-- side-right -->
                    
                </div><!-- /span side-right -->
            </div>
        </section>

        <!-- section footer -->
        <footer>
            <a rel="to-top" href="#top"><i class="icofont-circle-arrow-up"></i></a>
        </footer>

        <!-- javascript
        ================================================== -->
        <script type="text/javascript" src='<c:url value="/js/widgets.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/calendar/moment.min.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/jquery.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/jquery-ui.min.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/bootstrap.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/uniform/jquery.uniform.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/peity/jquery.peity.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/select2/select2.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/knob/jquery.knob.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/flot/jquery.flot.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/flot/jquery.flot.resize.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/flot/jquery.flot.categories.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/wysihtml5/wysihtml5-0.3.0.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/wysihtml5/bootstrap-wysihtml5.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/calendar/fullcalendar.js"></c:url>'></script> <!-- this plugin required jquery ui-->
        <script type="text/javascript" src='<c:url value="/js/calendar/jquery.qtip-1.0.0-rc3.js"></c:url>'></script>
        <!-- required stilearn template js, for full feature-->
        <script type="text/javascript" src='<c:url value="/js/holder.js"></c:url>'></script>
        <script type="text/javascript" src='<c:url value="/js/stilearn-base.js"></c:url>'></script>

        <script type="text/javascript">
            $(document).ready(function() {
                // try your js
                
                // normalize event tab-stat, we hack something here couse the flot re-draw event is any some bugs for this case
                $('#tab-stat > a[data-toggle="tab"]').on('shown', function(){
                    if(sessionStorage.mode == 4){ // this hack only for mode side-only
                        $('body,html').animate({
                            scrollTop: 0
                        }, 'slow');
                    }
                });
                
                // peity chart
                $("span[data-chart=peity-bar]").peity("bar");
                
                // Input tags with select2
                $('input[name=reseiver]').select2({
                    tags:[]
                });
                
                // uniform
                $('[data-form=uniform]').uniform();
                
                // wysihtml5
                $('[data-form=wysihtml5]').wysihtml5()
                toolbar = $('[data-form=wysihtml5]').prev();
                btn = toolbar.find('.btn');
                
                $.each(btn, function(k, v){
                    $(v).addClass('btn-mini')
                });
                
                // Server stat circular by knob
                $("input[data-chart=knob]").knob();
                
                // system stat flot
                d1 = [ ['jan', 231], ['feb', 243], ['mar', 323], ['apr', 352], ['maj', 354], ['jun', 467], ['jul', 429] ];
                d2 = [ ['jan', 87], ['feb', 67], ['mar', 96], ['apr', 105], ['maj', 98], ['jun', 53], ['jul', 87] ];
                d3 = [ ['jan', 34], ['feb', 27], ['mar', 46], ['apr', 65], ['maj', 47], ['jun', 79], ['jul', 95] ];
                
                var visitor = $("#visitor-stat"),
                order = $("#order-stat"),
                user = $("#user-stat"),
                
                data_visitor = [{
                        data: d1,
                        color: '#00A600'
                    }],
                data_order = [{
                        data: d2,
                        color: '#2E8DEF'
                    }],
                data_user = [{
                        data: d3,
                        color: '#DC572E'
                    }],
                 
                
                options_lines = {
                    series: {
                        lines: {
                            show: true,
                            fill: true
                        },
                        points: {
                            show: true
                        },
                        hoverable: true
                    },
                    grid: {
                        backgroundColor: '#FFFFFF',
                        borderWidth: 1,
                        borderColor: '#CDCDCD',
                        hoverable: true
                    },
                    legend: {
                        show: false
                    },
                    xaxis: {
                        mode: "categories",
                        tickLength: 0
                    },
                    yaxis: {
                        autoscaleMargin: 2
                    }
        
                };
                
                // render stat flot
                $.plot(visitor, data_visitor, options_lines);
                $.plot(order, data_order, options_lines);
                $.plot(user, data_user, options_lines);
                
                // tootips chart
                function showTooltip(x, y, contents) {
                    $('<div id="tooltip" class="bg-black corner-all color-white">' + contents + '</div>').css( {
                        position: 'absolute',
                        display: 'none',
                        top: y + 5,
                        left: x + 5,
                        border: '0px',
                        padding: '2px 10px 2px 10px',
                        opacity: 0.9,
                        'font-size' : '11px'
                    }).appendTo("body").fadeIn(200);
                }

                var previousPoint = null;
                $('#visitor-stat, #order-stat, #user-stat').bind("plothover", function (event, pos, item) {
                    
                    if (item) {
                        if (previousPoint != item.dataIndex) {
                            previousPoint = item.dataIndex;

                            $("#tooltip").remove();
                            var x = item.datapoint[0].toFixed(2),
                            y = item.datapoint[1].toFixed(2);
                            label = item.series.xaxis.ticks[item.datapoint[0]].label;
                            
                            showTooltip(item.pageX, item.pageY,
                            label + " = " + y);
                        }
                    }
                    else {
                        $("#tooltip").remove();
                        previousPoint = null;            
                    }
                    
                });
                // end tootips chart
		
                var calendar = $('#schedule').fullCalendar({
                    header: {
                        left: 'title',
                        center: '',
                        right: 'prev,next today,month,basicWeek,basicDay'
                    },
                    eventLimit: {
                        'agenda': 6, // adjust to 6 only for agendaWeek/agendaDay
                        'default': true // give the default value to other views
                    },
                    events: 'getEventSchedule',
                    eventRender: function(event, element) {
                        element.qtip({
                            content: event.description
                        });
                    }
                    
                });
                // end Schedule Calendar
            });
      
        </script>
    </body>
</html>