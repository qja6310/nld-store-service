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
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/merchant/manage.js"></script>
</head>
<body>
	<form class="layui-form layui-form-pane" lay-filter="form">
		<input type="hidden" id="page" value="${page}"/>
		<input type="hidden" id="limit" value="${limit}"/>
		<input type="hidden" id="hmAcc" value="${mAcc}"/>
		<input type="hidden" id="hmCode" value="${mCode}"/>
		<input type="hidden" id="hmName" value="${mName}"/>
		<input type="hidden" id="hmAddr" value="${mAddr}"/>
		<input type="hidden" id="hmEmail" value="${mEmail}"/>
		<input type="hidden" id="hmPhone" value="${mPhone}"/>
		<div style="padding: 20px;margin-left: 25px;">
			<div class="layui-form-item">
				<label class="layui-form-label">商户</label>
				<div class="layui-input-inline">
					<input type="text" id="mName" name="mName" value="${mName}" autocomplete="off" placeholder="请输入账号" class="layui-input">
				</div>
				<label class="layui-form-label">商户编号</label>
				<div class="layui-input-inline">
					<input type="text" id="mCode" name="mCode" value="${mCode}" autocomplete="off" placeholder="请输入账号" class="layui-input">
				</div>
				<label class="layui-form-label">商户账号</label>
				<div class="layui-input-inline">
					<input type="text" id="mAcc" name="mAcc" value="${mAcc}" autocomplete="off" placeholder="请输入账号" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">商户地址</label>
				<div class="layui-input-inline">
					<input type="text" id="mAddr" name="mAddr" value="${mAddr}" autocomplete="off" placeholder="请输入账号" class="layui-input">
				</div>
				<label class="layui-form-label">商户电话</label>
				<div class="layui-input-inline">
					<input type="text" id="mPhone" name="mPhone" value="${mPhone}" autocomplete="off" placeholder="请输入电话" class="layui-input" oninput="value=value.replace(/[^\d]|^[0]/g,'')">
				</div>
				<label class="layui-form-label">商户邮箱</label>
				<div class="layui-input-inline">
					<input type="text" id="mEmail" name="mEmail" value="${mEmail}" autocomplete="off" placeholder="请输入邮箱" class="layui-input">
				</div>
				<button class="layui-btn" onclick="doQuery()">查询</button>
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
			<th style="width: 5%;">序号</th>
			<th>商户</th>
			<th>商户编号</th>
			<th>商户账号</th>
			<th>商户电话</th>
			<th>电子邮箱</th>
			<th>法人</th>
			<th style="width: 10%;">操作</th>
		</tr>
		</thead>
		<tbody id="tbody">
		<c:forEach items="${merchants}" var="m" varStatus="s">
			<tr>
				<td>${s.count}</td>
				<td>${m.mName}</td>
				<td>${m.mCode}</td>
				<td>${m.mAcc}</td>
				<td>${m.mPhone}</td>
				<td>${m.mEmail}</td>
				<td>${m.mBossName}</td>
				<td>
					<c:choose>
						<c:when test="${m.status == '10' || m.status == '30'}">
							<a style="margin: 0 10px;color: blue;cursor: pointer;" onclick="detail(${m.id},'a')">审核</a>
						</c:when>
						<c:otherwise>
							<a style="margin: 0 10px;color: blue;cursor: pointer;" onclick="detail(${m.id},'c')">查看</a>
						</c:otherwise>
					</c:choose>
					<c:if test="${m.status != '10' && m.status != '30' && m.status != '60'}">
						<c:choose>
							<c:when test="${m.status == '40'}">
								<a style="margin: 0 10px;color: blue;cursor: pointer;" onclick="blacklist(${m.id},'50')">恢复</a>
							</c:when>
							<c:otherwise>
								<a style="margin: 0 10px;color: orangered;cursor: pointer;" onclick="blacklist(${m.id},'40')">拉黑</a>
							</c:otherwise>
						</c:choose>
					</c:if>
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
