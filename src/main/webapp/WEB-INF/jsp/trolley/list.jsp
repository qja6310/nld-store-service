<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<form class="layui-form layui-form-pane" action="">
	<c:choose>
		<c:when test="${not empty pcList}">
			<c:forEach items="${pcList}" var="pc">
				<div class="layui-card" style="height: 300px;">
					<input type="hidden" id="count-${pc.id}" value="${pc.count}">
					<input type="hidden" id="gid-${pc.id}" value="${pc.goods.id}">
					<div class="layui-card-body">
						<div>
							<img src="<%=request.getContextPath() %>${pc.goods.imgPath}" alt="${pc.goods.imgTitle}" style="width:120px;height: 150px;margin-right: 50px;">
							<label style="margin-right: 50px;font-size: 20px;">《${pc.goods.gTitle}》</label>
							<label style="margin-right: 50px;">作者：${pc.goods.gAuthor}</label>
							<label style="margin-right: 50px;">出版社：${pc.goods.gPress}</label>
							<label style="margin-right: 50px;">单价：${pc.goods.gPrice}</label>
							<label class="" style="margin-right: 50px;">购买数量：</label>
							<div class="layui-input-inline">
								<input class="layui-input verify" id="nCount-${pc.id}" value="10" style="margin-left: -40px;">
							</div>
						</div>
					</div>
					<div class="layui-card-header" style="margin-top: 30px;">
						<h3>
							<button type="button" class="layui-btn layui-btn-danger" style="float: right;margin: 0 5px;" onclick="delTrolley(${pc.id})">删除</button>
							<button type="button" class="layui-btn layui-btn-normal" style="float: right;margin: 0 5px;" onclick="buy(${pc.id})">立即下单</button>
						</h3>
					</div>
				</div>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<label>购物车空空如也~~~</label>
		</c:otherwise>
	</c:choose>
</form>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/trolley/list.js"></script>