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
<title>请登录</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/js/layui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/merchant/login.js"></script>
	<style type="text/css">
		.a-link{
			font-style: italic;
			margin-top: 10px;
			color: steelblue;
		}
	</style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
	<div>
		<div style="width: 20%;margin: 0 auto;text-align: center;margin-top: 80px;">
			<form class="layui-form layui-form-pane" lay-filter="form" style="margin: 0 auto;">
				<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
					<legend>请登录</legend>
				</fieldset>
				<div style="padding: 20px;margin-left: 25px;">
					<div class="layui-form-item">
						<label class="layui-form-label">账号</label>
						<div class="layui-input-inline">
							<input type="text" id="mAcc" name="mAcc" value="sanzhisongshu4.m" autocomplete="off" placeholder="请输入账号" class="layui-input verify">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">密码</label>
						<div class="layui-input-inline">
							<input type="password" id="mPwd" name="mPwd" value="123456" autocomplete="off" placeholder="请输入密码" class="layui-input verify">
						</div>
					</div>
				</div>
			</form>
			<div style="margin: 0 auto;width: 70%;">
				<button type="button" id="doLoginBtn" class="layui-btn layui-btn-fluid" onclick="doLogin(this)" style="margin-top: 20px;">
					<i class="layui-icon layui-icon-ok-circle"></i>登录
				</button>
				<a class="a-link" style="float: left;" href="<%=request.getContextPath() %>/merchant/register">我要开店</a>
				<a class="a-link" style="float: right;" href="<%=request.getContextPath() %>/merchant/progress">进度如何</a>
			</div>
		</div>
	</div>
	<div class="layui-footer" style="left: 0px;">
		<!-- 底部固定区域 -->
		© layui.com - 底部固定区域
	</div>
</div>
</body>
</html>
