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
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/admin/manage.js"></script>
</head>
<body>
	<form class="layui-form layui-form-pane" lay-filter="form">
		<input type="hidden" id="page" value="${page}"/>
		<input type="hidden" id="limit" value="${limit}"/>
		<input type="hidden" id="haAcc" value="${aAcc}"/>
		<input type="hidden" id="haName" value="${aName}"/>
		<input type="hidden" id="haPhone" value="${aPhone}"/>
		<div style="padding: 20px;margin-left: 25px;">
			<div class="layui-form-item">
				<label class="layui-form-label">姓名</label>
				<div class="layui-input-inline">
					<input type="text" id="aName" name="aName" value="${aName}" autocomplete="off" placeholder="请输入姓名" class="layui-input">
				</div>
				<label class="layui-form-label">账号</label>
				<div class="layui-input-inline">
					<input type="text" id="aAcc" name="aAcc" value="${aAcc}" autocomplete="off" placeholder="请输入账号" class="layui-input">
				</div>
				<label class="layui-form-label">联系号码</label>
				<div class="layui-input-inline">
					<input type="text" id="aPhone" name="aPhone" value="${aPhone}" autocomplete="off" placeholder="请输入联系号码" class="layui-input" oninput="value=value.replace(/[^\d]|^[0]/g,'')">
				</div>
				<button class="layui-btn" onclick="doQuery()">查询</button>
				<button type = "button" class="layui-btn layui-btn layui-btn-normal" id="addPageBtn" onclick="addPage()">新增</button>
			</div>
		</div>
	</form>
	<table class="layui-table">
		<colgroup>
			<col width="150">
			<col width="200">
			<col>
		</colgroup>
		<thead>
		<tr>
			<th>序号</th>
			<th>姓名</th>
			<th>账号</th>
			<th>联系电话</th>
			<th>电子邮箱</th>
			<th style="width: 15%;">操作</th>
		</tr>
		</thead>
		<tbody id="tbody">
		<c:forEach items="${admins}" var="a" varStatus="s">
			<tr>
				<td>${s.count}</td>
				<td>${a.aName}</td>
				<td>${a.aAcc}</td>
				<td>${a.aPhone}</td>
				<td>${a.aEmail}</td>
				<td>
					<a style="margin: 0 10px;color: blue;cursor: pointer;" onclick="toConfigRole(${a.id})">角色配置</a>
					<a style="margin: 0 10px;color: orangered;cursor: pointer;" onclick="resetPwd(${a.id})">密码重置</a>
					<a style="margin: 0 10px;color: orangered;cursor: pointer;" onclick="delAdmin(${a.id})">删除</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div>
		<button type="button" class="layui-btn layui-btn-primary layui-btn-fluid" onclick="doLoading()">
			<i class="layui-icon layui-icon-loading"></i>
			继续加载
		</button>
	</div>
</body>
</html>
