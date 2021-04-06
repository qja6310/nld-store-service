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
<title>商户注册</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/js/layui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/merchant/register.js?v=001"></script>
</head>
<body class="layui-layout-body" style="background: #F0F0F0;">
<div class="layui-layout layui-layout-admin">
	<div class="layui-header">
		<div class="layui-logo">商户注册</div>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item"><a href="<%=request.getContextPath() %>/merchant/login">返回登录</a></li>
			<li class="layui-nav-item"><a href="<%=request.getContextPath() %>/merchant/progress">查询进度</a></li>
		</ul>
	</div>
	<div>
		<div  style="width: 68%;margin: 0 auto;text-align: center;margin-top: 80px;">
			<form class="layui-form layui-form-pane" lay-filter="form">
				<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
					<legend>商户信息</legend>
				</fieldset>
				<div style="padding: 20px;">
					<div class="layui-form-item">
						<label class="layui-form-label">商户名</label>
						<div class="layui-input-inline">
							<input type="text" id="mName" name="mName" value="" autocomplete="off" placeholder="请输入姓名" class="layui-input verify">
						</div>
						<label class="layui-form-label">登录账号</label>
						<div class="layui-input-inline">
							<input type="text" id="mACC" name="mACC" value="" autocomplete="off" placeholder="请输入登录账号" class="layui-input verify">
						</div>
						<label class="layui-form-label">登录密码</label>
						<div class="layui-input-inline">
							<input type="password" id="mPwd" name="mPwd" value="" autocomplete="off" placeholder="请输入登录密码" class="layui-input verify">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">地址</label>
						<div class="layui-input-inline">
							<input type="text" id="mAddr" name="mAddr" value="" autocomplete="off" placeholder="请输入身份证号" class="layui-input verify">
						</div>
						<label class="layui-form-label">商户电话</label>
						<div class="layui-input-inline">
							<input type="text" id="mPhone" name="mPhone" value="" autocomplete="off" placeholder="请输入联系电话" class="layui-input verify" maxlength="11" oninput="value=value.replace(/[^\d]|^[0]/g,'')">
						</div>
						<label class="layui-form-label">商户邮箱</label>
						<div class="layui-input-inline">
							<input type="text" id="mEmail" name="mEmail" value="" autocomplete="off" placeholder="请输入电子邮箱" class="layui-input verify">
						</div>
					</div>
				</div>
				<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
					<legend>商户法人信息</legend>
				</fieldset>
				<div style="padding: 20px;">
					<div class="layui-form-item">
						<label class="layui-form-label">身份证号</label>
						<div class="layui-input-inline">
							<input type="text" id="mBossIdentity" name="mBossIdentity" value="" autocomplete="off" placeholder="请输入姓名" class="layui-input verify">
						</div>
						<label class="layui-form-label">姓名</label>
						<div class="layui-input-inline">
							<input type="text" id="mBossName" name="mBossName" value="" autocomplete="off" placeholder="请输入登录账号" class="layui-input verify">
						</div>
						<label class="layui-form-label">联系电话</label>
						<div class="layui-input-inline">
							<input type="text" id="mBossPhone" name="mBossPhone" value="" autocomplete="off" placeholder="请输入联系电话" class="layui-input verify" oninput="value=value.replace(/[^\d]|^[0]/g,'')">
						</div>
						<label class="layui-form-label">电子邮箱</label>
						<div class="layui-input-inline">
							<input type="text" id="mBossEmail" name="mBossEmail" value="" autocomplete="off" placeholder="请输入电子邮箱" class="layui-input verify">
						</div>
					</div>
				</div>
			</form>
			<div style="margin: 0 auto;width: 30%;">
				<button type="button" id="doRegisterBtn" class="layui-btn layui-btn-fluid" onclick="doRegister()" style="margin-top: 20px;"><i class="layui-icon layui-icon-ok-circle"></i>提交审核</button>
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
