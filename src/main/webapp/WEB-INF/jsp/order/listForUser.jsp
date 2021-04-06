<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<form class="layui-form layui-form-pane" action="" lay-filter="form">
	<input type="hidden" id="r" value="${r}"/>
	<input type="hidden" id="hstatus" value="${status}">
	<input type="hidden" id="page" value="${page}">
	<div class="layui-form-item">
		<label class="layui-form-label">订单状态</label>
		<div class="layui-input-inline">
			<select id="status" name="status" lay-verify="required">
				<option value="">全部</option>
				<option value="10" <c:if test="${status == '10'}">selected</c:if>>待支付</option>
				<option value="30" <c:if test="${status == '30'}">selected</c:if>>已支付</option>
				<option value="50" <c:if test="${status == '50'}">selected</c:if>>已发货</option>
				<option value="60" <c:if test="${status == '60'}">selected</c:if>>已签收</option>
			</select>
		</div>
		<button type="button" class="layui-btn" onclick="doQuery()">查询</button>
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
		<th style="width: 5%;">订单号</th>
		<th style="width: 15%;">商品名称</th>
		<th style="width: 10%;">购买数量</th>
		<th style="width: 10%;">支付金额</th>
		<th style="width: 15%;">下单时间</th>
		<th style="width: 10%;">收件人</th>
		<th style="width: 5%;">状态</th>
		<th style="width: 10%;">操作</th>
	</tr>
	</thead>
	<tbody id="tbody">
	<c:forEach items="${list}" var="o">
		<tr>
			<td>
				<a style="color: blue;cursor: pointer;" onclick="detail(${o.id})">${o.oNumber}</a>
			</td>
			<td>
				<a style="color: blue;cursor: pointer;" onclick="goodsDetail(${o.goods.id})">${o.goods.gTitle}</a></td>
			<td>${o.count}</td>
			<td>${o.payMoney}</td>
			<td><fmt:formatDate value="${o.cTime}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
			<td>${o.conName}</td>
			<td>
				<c:choose>
					<c:when test="${o.status == '10'}">待支付</c:when>
					<c:when test="${o.status == '30'}">已支付</c:when>
					<c:when test="${o.status == '50'}">已发货</c:when>
					<c:when test="${o.status == '60'}">已签收</c:when>
				</c:choose>
			</td>
			<td>
				<a style="margin: 0 10px;color: blue;cursor: pointer;" onclick="detail(${o.id})">详情</a>
				<c:if test="${r == 'u'}">
					<c:choose>
						<c:when test="${o.status == '10'}">
							<a style="margin: 0 10px;color: blue;cursor: pointer;" onclick="toPay(${o.id})">继续支付</a>
						</c:when>
						<c:when test="${o.status == '50'}">
							<a style="margin: 0 10px;color: blue;cursor: pointer;" onclick="updateStatus(${o.id})">签收</a>
						</c:when>
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
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/order/list.js"></script>