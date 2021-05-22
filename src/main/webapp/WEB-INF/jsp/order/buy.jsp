<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<form class="layui-form" action="">
	<input type="hidden" id="gid" value="${goods.id}"/>
	<input type="hidden" id="inventory" value="${goods.gInventory}"/>
	<input type="hidden" id="addrLen" value="${addrLen}"/>
	<input type="hidden" id="mid" value="${merchant.id}"/>
	<input type="hidden" id="count" value="${count}"/>
	<input type="hidden" id="payMoney" value="${payMoney}"/>
	<c:if test="${not empty msg}">
		<div style="color: orangered;">${msg}</div>
	</c:if>
	<div class="layui-card" style="height: 300px;">
		<div class="layui-card-header"><h3>${merchant.mName}</h3></div>
		<div class="layui-card-body">
			<div>
				<img src="<%=request.getContextPath() %>${goods.imgPath}" alt="${goods.imgTitle}" style="width:120px;height: 150px;margin-right: 50px;">
				<label style="margin-right: 50px;font-size: 20px;">《${goods.gTitle}》</label>
				<label style="margin-right: 50px;">作者：${goods.gAuthor}</label>
				<label style="margin-right: 50px;">出版社：${goods.gPress}</label>
			</div>
			<div style="margin-top: 50px;">
				<label style="float: left;margin-right: 50px;color: orangered;font-size: 25px;">购买数量：${count}</label>
				<label style="float: right;margin-right: 50px;color: orangered;font-size: 25px;">
					支付金额：<i class="layui-icon layui-icon-rmb" style="margin:0 20px;font-size: 25px;"></i>${payMoney}
				</label>
			</div>
		</div>
	</div>
</form>
<div class="layui-card">
	<div class="layui-card-header"><h3>收货地址</h3></div>
	<div class="layui-card-body">
		<table class="layui-table">
			<colgroup>
				<col width="150">
				<col width="200">
				<col>
			</colgroup>
			<thead>
			<tr>
				<th style="width: 5%;text-align: center">选择</th>
				<th>收货人</th>
				<th>联系电话</th>
				<th>收货地址</th>
			</tr>
			</thead>
			<tbody id="tbody">
			<c:forEach items="${user.addressList}" var="addr" varStatus="s">
				<tr class="addrTr" value="${s.index}" id="tr-${s.index}">
					<td style="text-align: center;"><input type="radio" name="addr" value="${s.index}" title=""></td>
					<td>${addr.conName}</td>
					<td>${addr.conPhone}</td>
					<td>${addr.detailAddr}</td>
				</tr>
			</c:forEach>
			<tr id="addAddrTr">
				<td colspan="4" style="text-align: center;"><button class="layui-btn" onclick="addAddr()">添加地址</button></td>
			</tr>
			</tbody>
		</table>
	</div>
</div>
<textarea id="remark" name="remark" style="width: 98%;margin-left: 13px;" placeholder="备注，不超过250个字" class="layui-textarea" maxlength="250"></textarea>
<form class="layui-form" action="" lay-filter="form" style="margin-top: 10px;">
	<div class="layui-form-item" style="float: right;">
		<label class="layui-form-label">支付方式</label>
		<div class="layui-input-block">
			<input type="radio" name="payWay" value="nldpay" title="钱包" checked>
			<input type="radio" name="payWay" value="alipay" title="支付宝">
			<button type="button" class="layui-btn layui-btn-normal" onclick="toPay()">确认支付</button>
		</div>
	</div>
</form>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/order/buy.js"></script>