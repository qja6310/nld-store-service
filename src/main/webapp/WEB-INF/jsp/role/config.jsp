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
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/role/config.js"></script>
</head>
<body>
	<form class="layui-form layui-form-pane" lay-filter="form">
		<input type="hidden" id="aid" value="${aid}"/>
		<div style="margin: 10px;">
			<c:forEach items="${roles}" var="r">
				<div><input type="checkbox" class="checkBox" title="${r.rName}" <c:if test="${r.checked == '1'}">checked</c:if> value="${r.id}"></div>
			</c:forEach>
			<button type="button" style="margin: 10px;" class="layui-btn" onclick="doConfig()">确认</button>
		</div>
	</form>
</body>
</html>
