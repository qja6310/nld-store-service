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
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/order/detail.js"></script>
</head>
<body>
<div>
	<button type="button" class="layui-btn layui-btn-primary" onclick="back()">返回</button>
</div>
<hr class="layui-border-blue" />
<div style="float: left;width: 70%;">
	<input type="hidden" id="r" value="${r}" />
	<input type="hidden" id="mid" value="${mid}" />
	<div class="layui-card" style="height: 300px;">
		<div class="layui-card-header"><h3 style="font-size: 20px;">订单号：${order.oNumber}</h3></div>
		<div class="layui-card-body">
			<div>
				<img src="<%=request.getContextPath() %>${goods.imgPath}" alt="${goods.imgTitle}" style="width:120px;height: 150px;margin-right: 50px;">
				<label style="margin-right: 50px;font-size: 20px;">《${goods.gTitle}》</label>
				<label style="margin-right: 50px;">作者：${goods.gAuthor}</label>
				<label style="margin-right: 50px;">出版社：${goods.gPress}</label>
				<div>
					${order.oRemark}
				</div>
			</div>
			<div style="margin-top: 50px;">
				<label style="float: left;margin-right: 50px;color: orangered;font-size: 25px;">购买数量：${order.count}</label>
				<label style="float: right;margin-right: 50px;color: orangered;font-size: 25px;">
					支付金额：<i class="layui-icon layui-icon-rmb" style="margin:0 20px;font-size: 25px;"></i>${order.payMoney}
				</label>
			</div>
		</div>
	</div>
	<div class="layui-card">
		<div class="layui-card-header"><h3 style="font-size: 20px;">收货地址</h3></div>
		<div class="layui-card-body">
			<label style="margin-right: 50px;font-size: 20px;">${order.conName}</label>
			<label style="margin-right: 50px;">${order.conPhone}</label>
			<label style="margin-right: 50px;">${order.conAddr}</label>
		</div>
	</div>
	<c:if test="${r == 'm' && order.status == '30'}">
		<div>
			<button type="button" class="layui-btn layui-btn-normal" style="float: right;" onclick="updateStatus(${order.id},'50')">确认发货</button>
		</div>
	</c:if>
</div>
<div style="float: right;width: 20%;margin-top: 150px">
	<ul class="layui-timeline">
		<c:if test="${order.status != '60'}">
			<li class="layui-timeline-item">
				<i class="layui-icon layui-timeline-axis" style="color: orangered;"></i>
				<div class="layui-timeline-content layui-text">
					<h3 class="layui-timeline-title">
						<c:choose>
							<c:when test="${order.status == '10'}">待支付</c:when>
							<c:when test="${order.status == '30'}">待发货</c:when>
							<c:when test="${order.status == '50'}">待签收</c:when>
						</c:choose>
					</h3>
				</div>
			</li>
		</c:if>
		<c:forEach items="${progressList}" var="p">
			<li class="layui-timeline-item">
				<i class="layui-icon layui-timeline-axis">&#xe63f;</i>
				<div class="layui-timeline-content layui-text">
					<h3 class="layui-timeline-title"><fmt:formatDate value="${p.operateTime}" pattern="yyyy-MM-dd hh:mm:ss"/></h3>
					<ul>
						<li>
							<c:choose>
								<c:when test="${p.status == 10}">
									待支付
								</c:when>
								<c:when test="${p.status == 30}">
									已支付
								</c:when>
								<c:when test="${p.status == 50}">
									已发货
								</c:when>
								<c:when test="${p.status == 60}">
									已签收
								</c:when>
							</c:choose>
						</li>
					</ul>
					<p>${p.opRemark}</p>
				</div>
			</li>
		</c:forEach>
	</ul>
</div>
</body>
</html>
