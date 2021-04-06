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
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/goods/manage.js"></script>
</head>
<body>
	<form class="layui-form layui-form-pane" lay-filter="form">
		<input type="hidden" id="page" value="${page}"/>
		<input type="hidden" id="limit" value="${limit}"/>
		<input type="hidden" id="hkeyword" value="${keyword}"/>
		<input type="hidden" id="hstatus" value="${status}"/>
		<input type="hidden" id="htype" value="${type}"/>
		<input type="hidden" id="mid" value="${mid}"/>
		<input type="hidden" id="roleFlag" value="${r}">
		<div style="padding: 20px;margin-left: 25px;">
			<div class="layui-form-item">
				<label class="layui-form-label">关键字</label>
				<div class="layui-input-inline">
					<input type="text" id="keyword" name="keyword" value="${keyword}" autocomplete="off" placeholder="请输入关键字查询" class="layui-input">
				</div>
				<label class="layui-form-label">类别</label>
				<div class="layui-input-inline">
					<select id="type" name="type" lay-verify="required">
						<option value="">全部</option>
						<c:forEach items="${types}" var="t">
							<option value="${t.id}" <c:if test="${type == t.id}">selected</c:if>>${t.tName}</option>
						</c:forEach>
					</select>
				</div>
				<label class="layui-form-label">状态</label>
				<div class="layui-input-inline">
					<select id= "status" name="status" lay-verify="required">
						<option value="">全部</option>
						<option value="30" <c:if test="${status == '30'}">selected</c:if>>待审核</option>
						<option value="50" <c:if test="${status == '50'}">selected</c:if>>审核通过</option>
						<option value="60" <c:if test="${status == '60'}">selected</c:if>>审核不通过</option>
						<option value="70" <c:if test="${status == '70'}">selected</c:if>>上架</option>
						<option value="80" <c:if test="${status == '80'}">selected</c:if>>下架</option>
						<option value="90" <c:if test="${status == '90'}">selected</c:if>>强制下架</option>
					</select>
				</div>
				<button class="layui-btn" onclick="doQuery()">查询</button>
				<c:if test="${r == 'm'}">
					<button type="button" class="layui-btn layui-btn-normal" onclick="toAdd()">新增</button>
				</c:if>
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
			<c:if test="${r == 'a'}">
				<th>商户</th>
				<th>商户编码</th>
			</c:if>
			<th>标题</th>
			<th>单价</th>
			<th>库存</th>
			<th>作者</th>
			<th>出版社</th>
			<th>状态</th>
			<th style="width: 20%;">操作</th>
		</tr>
		</thead>
		<tbody id="tbody">
		<c:if test="${empty goodsList}">
			<tr>
				<td colspan="8">暂无数据</td>
			</tr>
		</c:if>
		<c:if test="${not empty goodsList}">
			<c:forEach items="${goodsList}" var="g" varStatus="s">
				<tr>
					<td>${s.count}</td>
					<c:if test="${r == 'a'}">
						<td><a style="color: blue;cursor: pointer;" onclick="merchantDetail(${g.mid},'c')">${g.mName}</a></td>
						<td><a style="color: blue;cursor: pointer;" onclick="merchantDetail(${g.mid},'c')">${g.mCode}</a></td>
					</c:if>
					<td>${g.gTitle}</td>
					<td>${g.gPrice}</td>
					<td>${g.gInventory}</td>
					<td>${g.gAuthor}</td>
					<td>${g.gPress}</td>
					<td>
						<c:choose>
							<c:when test="${g.status == '10'}">已提交</c:when>
							<c:when test="${g.status == '30'}">待审核</c:when>
							<c:when test="${g.status == '50'}">审核通过</c:when>
							<c:when test="${g.status == '60'}">审核不通过</c:when>
							<c:when test="${g.status == '70'}">已上架</c:when>
							<c:when test="${g.status == '80'}">已下架</c:when>
							<c:when test="${g.status == '90'}">强制下架</c:when>
						</c:choose>
					</td>
					<td>
						<a style="margin: 0 10px;color: blue;cursor: pointer;" onclick="detail(${g.id})">查看</a>
						<c:if test="${r == 'm'}">
							<c:choose>
								<c:when test="${g.status == '50' || g.status == '80'}">
									<a style="margin: 0 10px;color: blue;cursor: pointer;" onclick="updateStatus(${g.id},'70')">上架</a>
								</c:when>
								<c:when test="${g.status == '70'}">
									<a style="margin: 0 10px;color: orangered;cursor: pointer;" onclick="updateStatus(${g.id},'80')">下架</a>
								</c:when>
							</c:choose>
							<a style="margin: 0 10px;color: orangered;cursor: pointer;" onclick="delGoods(${g.id})">删除</a>
						</c:if>
						<c:if test="${r == 'a'}">
							<c:choose>
								<c:when test="${g.status == '70'}">
									<a style="margin: 0 10px;color: orangered;cursor: pointer;" onclick="updateStatus(${g.id},'90')">强制下架</a>
								</c:when>
							</c:choose>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</c:if>
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
