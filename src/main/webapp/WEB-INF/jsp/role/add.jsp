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
<title>新增角色</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/js/layui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/common/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/role/add.js"></script>
</head>
<body>
	<form class="layui-form layui-form-pane" lay-filter="form">
		<div style="padding: 20px;">
			<div class="layui-form-item">
				<label class="layui-form-label">角色名称</label>
				<div class="layui-input-inline">
					<input type="text" id="rName" name="rName" value="" autocomplete="off" placeholder="请输入角色名称" class="layui-input verify">
				</div>
				<label class="layui-form-label">角色编号</label>
				<div class="layui-input-inline">
					<input type="text" id="rCode" name="rCode" value="" autocomplete="off" placeholder="请输入角色编号" class="layui-input verify">
				</div>
				<button type="button" class="layui-btn" onclick="doAdd()">确认新增</button>
			</div>
		</div>
	</form>
</body>
</html>
