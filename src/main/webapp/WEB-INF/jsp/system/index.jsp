<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
	String base = request.getContextPath();
%>
<script type="text/javascript">
	var base = '<%=base%>'
</script>
<html>
<head>
	<meta charset="UTF-8">
	<title>书城后台管理</title>
	<meta name="viewport" content="width=device-width, initial-scale=1,maximum-scale=1,user-scalable=no"/>
	<meta name="apple-mobile-web-app-capable" content="yes"/>
	<meta name="apple-mobile-web-app-status-bar-style" content="black"/>
	<link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css">
<%--	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/layui/css/modules/">--%>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/layui/css/agent.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/layui/css/admin.css">
</head>
<body class="layui-layout-body">
<input type="hidden" id="adminId" value="${admin.id}" />
<div class="layui-layout layui-layout-admin" id="homes">
	<div class="layui-header">
		<div class="layui-logo">后台管理</div>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item">
				<a href="javascript:;">
					<img src="http://t.cn/RCzsdCq" class="layui-nav-img">
					${admin.aName}
				</a>
			</li>
			<li class="layui-nav-item"><a href="<%=request.getContextPath() %>/admin/logout">注销</a></li>
		</ul>
	</div>

	<div class="layui-side layui-bg-black" >
		<div class="layui-side-scroll" >
			<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
			<ul class="layui-nav layui-nav-tree"  lay-filter="test">
				<li class="layui-nav-item">
					<a class="" href="javascript:;">我的<span class="layui-nav-more"></span></a>
					<dl class="layui-nav-child" id="agent_sel" >
						<dd><a href="<%=request.getContextPath() %>/admin/toEdit?id=${admin.id}" fid=0>我的信息</a></dd>
					</dl>
				</li>
				<c:if test="${not empty menus}">
					<c:forEach items="${menus}" var="p">
						<li class="layui-nav-item">
							<a class="" href="javascript:;">${p.menuname}<span class="layui-nav-more"></span></a>
							<c:if test="${not empty p.menus}">
								<dl class="layui-nav-child" id="agent_sel" >
									<c:forEach items="${p.menus}" var="m">
										<dd><a href="<%=request.getContextPath() %>${m.path}" fid=${m.id}>${m.menuname}</a></dd>
									</c:forEach>
								</dl>
							</c:if>
						</li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
	</div>

	<div class="layui-body" id="agent_con">
		<div class="layui-tab" lay-allowClose="true" lay-filter="tess">
			<ul class="layui-tab-title">


			</ul>
			<div class="layui-tab-content" lay-filter="tabs">

			</div>
		</div>
	</div>

	<div class="layui-footer">
		<!-- 底部固定区域 -->
		© layui.com - 底部固定区域
	</div>
</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/js/layui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/modules/element.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/modules/laypage.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/modules/layer.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/js/admin.js"></script>
</body>
</html>