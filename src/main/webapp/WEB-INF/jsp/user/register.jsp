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
<title>用户注册</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/js/layui.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/common/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/user/userRegister.js"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
	<div class="layui-header">
		<div class="layui-logo">用户注册</div>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item"><a href="<%=request.getContextPath() %>/user/login">返回登录</a></li>
		</ul>
	</div>
	<div  style="width: 52%;margin: 0 auto;text-align: center;margin-top: 80px;">
	<form class="layui-form layui-form-pane" lay-filter="form">
		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
			<legend>基础信息</legend>
		</fieldset>
		<div style="padding: 20px;">
			<div class="layui-form-item">
				<label class="layui-form-label">姓名</label>
				<div class="layui-input-inline">
					<input type="text" id="uName" name="uName" value="" autocomplete="off" placeholder="请输入姓名" class="layui-input verify">
				</div>
				<label class="layui-form-label">登录账号</label>
				<div class="layui-input-inline">
					<input type="text" id="uAcc" name="uAcc" value="" autocomplete="off" placeholder="请输入登录账号" class="layui-input verify">
				</div>
				<label class="layui-form-label">登录密码</label>
				<div class="layui-input-inline">
					<input type="password" id="uPwd" name="uPwd" value="" autocomplete="off" placeholder="请输入登录密码" class="layui-input verify">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">身份证号</label>
				<div class="layui-input-inline">
					<input type="text" id="uIdentity" name="uIdentity" value="" autocomplete="off" placeholder="请输入身份证号" class="layui-input verify">
				</div>
				<label class="layui-form-label">联系电话</label>
				<div class="layui-input-inline">
					<input type="text" id="uPhone" name="uPhone" value="" autocomplete="off" placeholder="请输入联系电话" class="layui-input verify" maxlength="11" oninput="value=value.replace(/[^\d]|^[0]/g,'')">
				</div>
				<label class="layui-form-label">电子邮箱</label>
				<div class="layui-input-inline">
					<input type="text" id="uEmail" name="uEmail" value="" autocomplete="off" placeholder="请输入电子邮箱" class="layui-input verify">
				</div>
			</div>
		</div>
	</form>
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
		<legend>收货地址</legend>
	</fieldset>
	<table class="layui-table">
		<colgroup>
			<col width="150">
			<col width="200">
			<col>
		</colgroup>
		<thead>
		<tr>
			<th>收货人</th>
			<th>联系电话</th>
			<th>收货地址</th>
			<th style="width: 10%;">操作</th>
		</tr>
		</thead>
		<tbody id="tbody">
		<tr id="addAddrTr">
			<td colspan="4" style="text-align: center;"><button class="layui-btn" onclick="addAddr()">添加地址</button></td>
		</tr>
		</tbody>
	</table>
	<div style="margin: 0 auto;width: 30%;">
		<button type="button" id="doRegisterBtn" class="layui-btn layui-btn-fluid" onclick="doRegister()" style="margin-top: 20px;"><i class="layui-icon layui-icon-ok-circle"></i>注册</button>
	</div>
</div>
	<div class="layui-footer" style="left: 0px;">
		<!-- 底部固定区域 -->
		© layui.com - 底部固定区域
	</div>
</div>
</body>
</html>
