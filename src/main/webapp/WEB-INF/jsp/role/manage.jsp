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
<link rel="stylesheet" href="<%=request.getContextPath() %>/zui/css/zui.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/js/layui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/zui/js/zui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/common/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/role/manage.js"></script>
</head>
<body>
	<div>
		<form class="layui-form layui-form-pane" lay-filter="form">
			<div style="padding: 20px;margin-left: 25px;">
				<div class="layui-form-item">
					<label class="layui-form-label">角色编号</label>
					<div class="layui-input-inline">
						<input type="text" id="rCode" name="rCode" value="${rCode}" autocomplete="off" placeholder="请输入编号" class="layui-input">
					</div>
					<label class="layui-form-label">角色名称</label>
					<div class="layui-input-inline">
						<input type="text" id="rName" name="rName" value="${rName}" autocomplete="off" placeholder="请输入名称" class="layui-input">
					</div>
					<button class="layui-btn" onclick="doQuery()">查询</button>
					<button type="button" class="layui-btn layui-btn-normal" onclick="toAdd()">新增</button>
				</div>
			</div>
		</form>
	</div>
	<div style="width: 70%;float:left;text-align: center;">
		<table class="layui-table">
			<colgroup>
				<col width="150">
				<col width="200">
				<col>
			</colgroup>
			<thead>
			<tr>
				<th>角色编号</th>
				<th>角色名称</th>
				<th style="width: 30%;">操作</th>
			</tr>
			</thead>
			<tbody id="tbody">
			<c:forEach items="${roles}" var="r" varStatus="s">
				<tr>
					<td>${r.rCode}</td>
					<td>
						<input class="layui-input" id="rName-${r.id}" value="${r.rName}" placeholder="请输入名称">
					</td>
					<td>
						<a style="margin: 0 10px;color: blue;cursor: pointer;" onclick="updateName(${r.id})">修改名称</a>
						<a class="jurisdiction" fid="${r.id}" id="jurisdict-${r.id}" style="margin: 0 10px;color: blue;cursor: pointer;" onclick="jurisdict(${r.id})">权限查看</a>
						<c:if test="${r.rCode != 'CJGLY'}">
							<a style="margin: 0 10px;color: orangered;cursor: pointer;" onclick="delRole(${r.id})">角色删除</a>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	<div id="menuTree" class="demo-tree-more" style="float: right;margin-right: 20px;width: 25%;">
		<ul class="tree tree-lines" data-ride="tree">
			<c:forEach items="${menus}" var="m1">
				<li class="has-list open in">
					<a>
						<div class="checkbox-primary menuName-1" style="display: none;">
							<input type="checkbox" class="hide checkBox checkBox-1" id="menu_${m1.id}" value="${m1.id}">
							<label for="menu_${m1.id}">${m1.menuname}</label>
						</div>
						<div class="menuName-2">${m1.menuname}</div>
					</a>
					<ul>
						<c:forEach items="${m1.menus}" var="m2">
							<li>
								<a>
									<div class="checkbox-primary menuName-1" style="display: none;">
										<input type="checkbox" class="checkBox checkBox-2" id="menu_${m2.id}" value="${m2.id}" pid="${m1.id}">
										<label for="menu_${m2.id}">${m2.menuname}</label>
									</div>
									<div class="menuName-2">${m2.menuname}</div>
								</a>
							</li>
						</c:forEach>
					</ul>
				</li>
			</c:forEach>
		</ul>
	</div>
</body>
</html>
