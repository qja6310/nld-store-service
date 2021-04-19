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
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>图书商城首页</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/newloading/css/common.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/js/layui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/common/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/user/userIndex.js"></script>
	<style type="text/css">
		.a-link{
			font-style: italic;
			margin-top: 10px;
			color: steelblue;
		}
	</style>
</head>
<body class="layui-layout-body"> <!-- style="background: #eeeeee;" -->
<input type="hidden" id="uid" value="${user.id}"/>
<input type="hidden" id="url" value="${url}"/>
<div class="layui-layout layui-layout-admin">
	<div class="layui-header">
		<div class="layui-logo" onclick="skipPage('10')" style="cursor: pointer;">书城首页</div>
		<c:if test="${not empty user}">
			<ul class="layui-nav layui-layout-left">
				<li class="layui-nav-item"><a style="cursor: pointer;" onclick="skipPage('10')">首页</a></li>
				<li class="layui-nav-item"><a style="cursor: pointer;" onclick="skipPage('30')">购物车</a></li>
				<li class="layui-nav-item"><a style="cursor: pointer;" onclick="skipPage('50')">我的订单</a></li>
			</ul>
		</c:if>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item">
				<a onclick="skipPage('70')" style="cursor: pointer;">
					<img src="http://t.cn/RCzsdCq" class="layui-nav-img">
					<c:if test="${not empty user}">${user.uName}</c:if>
					<c:if test="${empty user}">未登录</c:if>
				</a>
			</li>
			<li class="layui-nav-item">
				<c:if test="${not empty user}"><a href="<%=request.getContextPath() %>/user/logout">注销</a></c:if>
				<c:if test="${empty user}"><a href="<%=request.getContextPath() %>/user/login">登录</a></c:if>
			</li>
		</ul>
	</div>
	<div id="mainContontDiv" style="margin: 2% 6%;overflow-y: auto;overflow-x: hidden;height: 80%;">

	</div>
	<div class="layui-footer" style="left: 0px;">
		<!-- 底部固定区域 -->
		© layui.com - 底部固定区域
	</div>
</div>
</body>
</html>
