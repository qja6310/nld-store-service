<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<div style="float: right;">
	<button type="button" id="doEditBtn" class="layui-btn layui-btn-primary" onclick="doEdit()">保存</button>
	<button type="button" id="toWalletBtn" class="layui-btn layui-btn-primary" onclick="myWallet()">钱包</button>
</div>
<hr class="layui-border-blue" />
<div  style="margin: 0 auto;text-align: center;margin-top: 50px;">
	<form class="layui-form layui-form-pane" lay-filter="form">
		<input type="hidden" id="addrLen" value="${addrLen}">
<%--		<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">--%>
<%--			<legend>基础信息</legend>--%>
<%--		</fieldset>--%>
		<div style="padding: 20px;">
			<div class="layui-form-item">
				<label class="layui-form-label">姓名</label>
				<div class="layui-input-inline">
					<input type="text" id="uName" name="uName" value="${user.uName}" autocomplete="off" placeholder="请输入姓名" class="layui-input verify">
				</div>
				<label class="layui-form-label">登录账号</label>
				<div class="layui-input-inline">
					<input type="text" id="uAcc" name="uAcc" value="${user.uAcc}" autocomplete="off" placeholder="请输入登录账号" class="layui-input verify">
				</div>
				<label class="layui-form-label">登录密码</label>
				<div class="layui-input-inline">
					<input type="text" id="uPwd" name="uPwd" value="${user.uPwd}" autocomplete="off" placeholder="请输入登录密码" class="layui-input verify">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">身份证号</label>
				<div class="layui-input-inline">
					<input type="text" id="uIdentity" name="uIdentity" value="${user.uIdentify}" autocomplete="off" placeholder="请输入身份证号" class="layui-input verify">
				</div>
				<label class="layui-form-label">联系电话</label>
				<div class="layui-input-inline">
					<input type="text" id="uPhone" name="uPhone" value="${user.uPhone}" autocomplete="off" placeholder="请输入联系电话" class="layui-input verify" maxlength="11" oninput="value=value.replace(/[^\d]|^[0]/g,'')">
				</div>
				<label class="layui-form-label">电子邮箱</label>
				<div class="layui-input-inline">
					<input type="text" id="uEmail" name="uEmail" value="${user.uEmail}" autocomplete="off" placeholder="请输入电子邮箱" class="layui-input verify">
				</div>
			</div>
		</div>
	</form>
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;text-align: left;">
		<legend>收货地址</legend>
	</fieldset>
	<table class="layui-table">
		<colgroup>
			<col width="150">
			<col width="200">
			<col>
		</colgroup>
		<thead>
		<tr>
			<th>收货人</th>
			<th>联系电话</th>
			<th>收货地址</th>
			<th style="width: 10%;">操作</th>
		</tr>
		</thead>
		<tbody id="tbody">
			<c:forEach items="${user.addressList}" var="a" varStatus="s">
				<tr id="tr-${s.count}">
					<td><input class='layui-input' value="${a.conName}"/></td>
					<td><input class='layui-input' value="${a.conPhone}"/></td>
					<td><input class='layui-input' value="${a.detailAddr}"/></td>
					<td>
						<button class='layui-btn layui-btn-sm layui-btn-danger' onclick="deleteAddr('tr-${s.count}')">删除</button>
					</td>
				</tr>
			</c:forEach>
			<tr id="addAddrTr">
				<td colspan="4" style="text-align: center;">
					<button class="layui-btn layui-btn-fluid layui-btn-warm" onclick="addAddr()">
						<i class="layui-icon layui-icon-add-circle-fine"></i>
						添加地址</button>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/user/edit.js"></script>