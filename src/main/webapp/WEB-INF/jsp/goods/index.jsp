<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<form class="layui-form" action="" lay-filter="form">
	<input type="hidden" id="hkeyword" value="${keyword}"/>
	<input type="hidden" id="htypeIds" value="${typeIds}"/>
	<input type="hidden" id="page" value="${page}"/>
	<input type="hidden" id="mid" value="${mid}"/>
	<div class="layui-form-item" style="margin-left: 25%;">
		<div class="layui-input-inline" style="width: 50%;">
			<input type="text" class="layui-input" id="keyword" name="keyword" value="${keyword}" placeholder="关键字查询"/>
		</div>
		<div class="layui-input-inline">
			<button type="button" class="layui-btn" onclick="doQueryGoods()">搜索</button>
		</div>
	</div>
	<div class="layui-form-item" style="margin-left: 25%;">
		<c:forEach items="${types}" var="t">
			<input type="checkbox" name="type" class="type" value="${t.id}" title="${t.tName}"
				<c:if test="${t.checked == '1'}">checked</c:if>>
		</c:forEach>
	</div>
	<hr class="layui-bg-green">
	<div style="margin-top: 20px;">
		<div class="layui-row layui-col-space15" id="goodsDiv">
			<c:if test="${not empty goodsList}">
				<c:forEach items="${goodsList}" var="g">
					<div class="layui-col-md2">
						<div class="layui-card">
							<div class="layui-card-body" style="text-align: center;">
								<img style="width: 180px;height: 220px;" src="<%=request.getContextPath() %>${g.imgPath}" alt="${g.imgTitle}" onclick="purchase(${g.id})">
							</div>
							<div class="layui-card-header" onclick="purchase(${g.id})">
								<a style="float: left;color: blue;">${g.gTitle}</a>
								<a style="float: right;color: orangered;"><i class="layui-icon layui-icon-rmb"></i>${g.gPrice}</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${empty goodsList}">
				<div style="text-align: center;">-------------暂无商品--------------</div>
			</c:if>
		</div>
	</div>
	<div>
	<c:if test="${not empty goodsList}">
		<button type="button" class="layui-btn layui-btn-primary layui-btn-fluid" onclick="doLoadingGoods()">
			<i class="layui-icon layui-icon-loading"></i>
			继续加载
		</button>
	</c:if>
	</div>
</form>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/goods/index.js"></script>
