<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%--<div style="float: right;">--%>
<%--	<button type="button" id="doEditBtn" class="layui-btn layui-btn-primary">返回</button>--%>
<%--</div>--%>
<%--<hr class="layui-border-blue" />--%>
<div  style="margin: 0 auto;text-align: center;">
	<form class="layui-form layui-form-pane" lay-filter="form">
		<input type="hidden" id="uid" value="${uid}">
		<div style="padding: 20px;">
			<div class="layui-form-item">
				<label class="layui-form-label">余额</label>
				<div class="layui-input-inline">
					<input type="text" id="yue" name="yue" value="${data.yue}" autocomplete="off" placeholder="" class="layui-input" readonly="readonly">
				</div>
				<button type="button" class="layui-btn" style="float: left;" onclick="wytx('O')">提现</button>
				<button type="button" class="layui-btn layui-btn-normal" style="float: left;" onclick="wycz('O')">充值</button>
			</div>
			<div class="layui-form-item" style="display: none;" id="txDiv">
				<label class="layui-form-label">收款卡号</label>
				<div class="layui-input-inline">
					<input type="text" id="cardNo" name="cardNo" value="" placeholder="请输入收款卡号" autocomplete="off" class="layui-input verify" oninput="value=value.replace(/[^\d]|^[0]/g,'')">
				</div>
				<label class="layui-form-label">提取金额</label>
				<div class="layui-input-inline">
					<input type="text" id="txmoney" name="txmoney" value="" placeholder="请输入提取金额" autocomplete="off" class="layui-input verify">
				</div>
				<button type="button" class="layui-btn"style="float: left;" onclick="qrtx()"><i class="layui-icon layui-icon-ok-circle"></i></button>
				<button type="button" class="layui-btn layui-btn-warm" style="float: left;" onclick="wytx('C')"><i class="layui-icon layui-icon-close"></i></button>
			</div>
			<div class="layui-form-item" style="display: none;" id="czDiv">
				<label class="layui-form-label">充值金额</label>
				<div class="layui-input-inline">
					<input type="text" id="czmoney" name="czmoney" value="" placeholder="请输入提取金额" autocomplete="off" class="layui-input verify">
				</div>
				<button type="button" class="layui-btn layui-btn-normal"style="float: left;" onclick="qrcz()"><i class="layui-icon layui-icon-ok-circle"></i></button>
				<button type="button" class="layui-btn layui-btn-warm" style="float: left;" onclick="wycz('C')"><i class="layui-icon layui-icon-close"></i></button>
			</div>
		</div>
	</form>
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
		<legend>我的账单</legend>
	</fieldset>
	<table class="layui-table">
		<colgroup>
			<col width="150">
			<col width="200">
			<col>
		</colgroup>
		<thead>
		<tr>
			<th style="width: 20%;">类型</th>
			<th style="width: 20%;">金额</th>
			<th style="width: 20%;">当前</th>
			<th style="width: 20%;">卡号</th>
			<th style="width: 20%;">时间</th>
		</tr>
		</thead>
		<tbody id="tbody">
			<c:if test="${empty data.records}">
				<tr><td colspan="5">暂无数据</td></tr>
			</c:if>
			<c:if test="${not empty data.records}">
				<c:forEach items="${data.records}" var="r" varStatus="s">
					<tr>
						<td>
							<c:choose>
								<c:when test="${r.type == '10'}">充值</c:when>
								<c:when test="${r.type == '40'}">提现</c:when>
								<c:when test="${r.type == '50'}">消费</c:when>
								<c:when test="${r.type == '60'}">退款</c:when>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${r.type == '10' || r.type == '60'}">
									<label style="font-weight: 900;color: blue;">+ ${r.money}</label>
								</c:when>
								<c:when test="${r.type == '40' || r.type == '50'}">
									<label style="font-weight: 900;color: orangered;">- ${r.money}</label>
								</c:when>
							</c:choose>
						</td>
						<td style="color: green;font-weight: 900;">${r.yue}</td>
						<td>${r.cardNo}</td>
						<td><fmt:formatDate value="${r.opreateTime}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/user/wallet.js"></script>