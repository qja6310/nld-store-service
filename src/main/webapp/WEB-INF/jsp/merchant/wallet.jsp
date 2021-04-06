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
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/merchant/wallet.js"></script>
</head>
<body>
	<form class="layui-form layui-form-pane" lay-filter="form">
		<input type="hidden" id="mid" value="${mid}"/>
		<div style="padding: 20px;margin-left: 25px;">
			<div class="layui-form-item">
				<label class="layui-form-label">当前余额</label>
				<div class="layui-input-inline">
					<input type="text" id="yue" name="yue" value="${yue}" autocomplete="off" class="layui-input" readonly="readonly">
				</div>
				<button type="button" class="layui-btn" onclick="wytx('O')">我要提现</button>
			</div>
			<div class="layui-form-item" style="display: none;" id="txDiv">
				<label class="layui-form-label">收款卡号</label>
				<div class="layui-input-inline">
					<input type="text" id="cardNo" name="cardNo" value="" placeholder="请输入收款卡号" autocomplete="off" class="layui-input verify" oninput="value=value.replace(/[^\d]|^[0]/g,'')">
				</div>
				<label class="layui-form-label">提取金额</label>
				<div class="layui-input-inline">
					<input type="text" id="money" name="money" value="" placeholder="请输入提取金额" autocomplete="off" class="layui-input verify">
				</div>
				<button type="button" class="layui-btn layui-btn-danger" onclick="qrtx()">确定提现</button>
				<button type="button" class="layui-btn layui-btn-warm" onclick="wytx('C')">我不提了</button>
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
			<th>收款卡号</th>
			<th>提现金额</th>
			<th>提现时间</th>
		</tr>
		</thead>
		<tbody id="tbody">
		<c:if test="${not empty records}">
			<c:forEach items="${records}" var="r" varStatus="s">
				<tr>
					<td>${s.count}</td>
					<td>${r.money}</td>
					<td>${r.cardNo}</td>
					<td><fmt:formatDate value="${r.operateTime}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty records}">
			<tr>
				<td colspan="4" style="text-align: center;">暂没有提现记录</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</body>
</html>
