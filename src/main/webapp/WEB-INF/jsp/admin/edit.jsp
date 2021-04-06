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
<title></title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/js/layui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/common/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/admin/add.js"></script>
</head>
<body>
	<form class="layui-form layui-form-pane" lay-filter="form">
		<input type="hidden" id="id" value="${admin.id}">
		<div style="padding: 20px;">
			<div class="layui-form-item">
				<label class="layui-form-label">姓名</label>
				<div class="layui-input-inline">
					<input type="text" id="aName" name="aName" value="${admin.aName}" autocomplete="off" placeholder="请输入姓名" class="layui-input verify">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">登录账号</label>
				<div class="layui-input-inline">
					<input type="text" id="aAcc" name="aAcc" value="${admin.aAcc}" autocomplete="off" placeholder="请输入登录账号" class="layui-input verify">
				</div>
				<label class="layui-form-label">登录密码</label>
				<div class="layui-input-inline">
					<input type="text" id="aPwd" name="aPwd" value="${admin.aPwd}" autocomplete="off" placeholder="请输入登录密码" class="layui-input verify">
				</div>
				<div class="layui-form-mid layui-word-aux">默认密码:123456</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">联系号码</label>
				<div class="layui-input-inline">
					<input type="text" id="aPhone" name="aPhone" value="${admin.aPhone}" autocomplete="off" placeholder="请输入联系电话" class="layui-input verify" oninput="value=value.replace(/[^\d]|^[0]/g,'')">
				</div>
				<label class="layui-form-label">电子邮箱</label>
				<div class="layui-input-inline">
					<input type="text" id="aEmail" name="aEmail" value="${admin.aEmail}" autocomplete="off" placeholder="请输入电子邮箱" class="layui-input verify">
				</div>
			</div>
			<div class="layui-form-item">
				<button type="button" class="layui-btn" onclick="doEdit()">确认</button>
			</div>
		</div>
	</form>
</body>
</html>
