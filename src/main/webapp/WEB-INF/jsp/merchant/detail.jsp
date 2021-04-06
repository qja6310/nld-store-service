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
<title>商户注册进度查询</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/js/layui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/common/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/merchant/progress.js"></script>
</head>
<body>
	<div style="width: 70%;float:left;text-align: center;">
		<form class="layui-form layui-form-pane" lay-filter="form">
			<input type="hidden" id="id" value="${merchant.id}">
			<fieldset class="layui-elem-field layui-field-title">
				<legend>商户信息</legend>
			</fieldset>
			<div style="padding: 20px;">
				<div class="layui-form-item">
					<c:if test="${not empty merchant.mCode}">
						<label class="layui-form-label">商户编号</label>
						<div class="layui-input-inline">
							<input type="text" id="mCode" name="mCode" value="${merchant.mCode}" autocomplete="off" placeholder="" class="layui-input" readonly="readonly">
						</div>
					</c:if>
					<label class="layui-form-label">商户名</label>
					<div class="layui-input-inline">
						<input type="text" id="mName" name="mName" value="${merchant.mName}" autocomplete="off" placeholder="请输入姓名" class="layui-input verify" readonly="readonly">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">登录账号</label>
					<div class="layui-input-inline">
						<input type="text" id="mACC" name="mACC" value="${merchant.mAcc}" autocomplete="off" placeholder="请输入登录账号" class="layui-input" readonly="readonly">
					</div>
					<label class="layui-form-label">登录密码</label>
					<div class="layui-input-inline">
						<input type="password" id="mPwd" name="mPwd" value="${merchant.mPwd}" autocomplete="off" placeholder="请输入登录密码" class="layui-input verify" readonly="readonly">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">地址</label>
					<div class="layui-input-inline">
						<input type="text" id="mAddr" name="mAddr" value="${merchant.mAddr}" autocomplete="off" placeholder="请输入身份证号" class="layui-input verify" readonly="readonly">
					</div>
					<label class="layui-form-label">商户电话</label>
					<div class="layui-input-inline">
						<input type="text" id="mPhone" name="mPhone" value="${merchant.mPhone}" autocomplete="off" placeholder="请输入联系电话" class="layui-input verify" maxlength="11" readonly="readonly">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">商户邮箱</label>
					<div class="layui-input-inline">
						<input type="text" id="mEmail" name="mEmail" value="${merchant.mEmail}" autocomplete="off" placeholder="请输入电子邮箱" class="layui-input verify" readonly="readonly">
					</div>
					<c:if test="${not empty merchant.status}">
						<label class="layui-form-label">当前状态</label>
						<div class="layui-input-inline">
							<c:choose>
								<c:when test="${merchant.status == 10}">
									<input type="text" id="mStatus" name="mStatus" value="已提交" autocomplete="off" placeholder="" class="layui-input" readonly="readonly">
								</c:when>
								<c:when test="${merchant.status == 30}">
									<input type="text" id="mStatus" name="mStatus" value="待审核" autocomplete="off" placeholder="" class="layui-input" readonly="readonly">
								</c:when>
								<c:when test="${merchant.status == 40}">
									<input type="text" id="mStatus" name="mStatus" value="黑名单" autocomplete="off" placeholder="" class="layui-input" readonly="readonly">
								</c:when>
								<c:when test="${merchant.status == 50}">
									<input type="text" id="mStatus" name="mStatus" value="审核通过" autocomplete="off" placeholder="" class="layui-input" readonly="readonly">
								</c:when>
								<c:when test="${merchant.status == 60}">
									<input type="text" id="mStatus" name="mStatus" value="审核不通过" autocomplete="off" placeholder="" class="layui-input" readonly="readonly">
								</c:when>
							</c:choose>
						</div>
					</c:if>
				</div>
			</div>
			<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
				<legend>商户法人信息</legend>
			</fieldset>
			<div style="padding: 20px;">
				<div class="layui-form-item">
					<label class="layui-form-label">身份证号</label>
					<div class="layui-input-inline">
						<input type="text" id="mBossIdentity" name="mBossIdentity" value="${merchant.mBossIdentity}" autocomplete="off" placeholder="请输入姓名" class="layui-input verify" readonly="readonly">
					</div>
					<label class="layui-form-label">姓名</label>
					<div class="layui-input-inline">
						<input type="text" id="mBossName" name="mBossName" value="${merchant.mBossName}" autocomplete="off" placeholder="请输入登录账号" class="layui-input verify" readonly="readonly">
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">联系电话</label>
					<div class="layui-input-inline">
						<input type="text" id="mBossPhone" name="mBossPhone" value="${merchant.mBossPhone}" autocomplete="off" placeholder="请输入登录密码" class="layui-input verify" readonly="readonly">
					</div>
					<label class="layui-form-label">电子邮箱</label>
					<div class="layui-input-inline">
						<input type="text" id="mBossEmail" name="mBossEmail" value="${merchant.mBossEmail}" autocomplete="off" placeholder="请输入登录密码" class="layui-input verify" readonly="readonly">
					</div>
				</div>
			</div>
			<div style="float: left;padding: 0 20px;margin-bottom: 20px;">
				<c:if test="${merchant.status == '10' || merchant.status == '30'}">
					<textarea id="auditOpinion" name="auditOpinion" style="width: 610px;" placeholder="请输入审批意见，不超过250个字" class="layui-textarea verify" maxlength="250"></textarea>
					<button type="button" class="layui-btn auditBtn" onclick="audit('Y')" style="margin-top: 10px;float: left;"><i class="layui-icon layui-icon-ok-circle"></i>审核通过</button>
					<button type="button" class="layui-btn auditBtn layui-btn-danger" onclick="audit('N')" style="margin-top: 10px;float: left;"><i class="layui-icon layui-icon-close"></i>审核不通过</button>
				</c:if>
			</div>
		</form>
	</div>
	<div style="float: right;margin-top: 80px;margin-right: 20px;width: 25%;">
		<ul class="layui-timeline">
			<c:if test="${merchant.status == '10' || merchant.status == '30'}">
				<li class="layui-timeline-item">
					<i class="layui-icon layui-timeline-axis" style="color: orangered;"></i>
					<div class="layui-timeline-content layui-text">
						<h3 class="layui-timeline-title">等待审核</h3>
					</div>
				</li>
			</c:if>
			<c:forEach items="${pList}" var="p">
				<li class="layui-timeline-item">
					<i class="layui-icon layui-timeline-axis">&#xe63f;</i>
					<div class="layui-timeline-content layui-text">
						<h3 class="layui-timeline-title"><fmt:formatDate value="${p.operateTime}" pattern="yyyy-MM-dd hh:mm:ss"/></h3>
						<ul>
							<li>
								<c:choose>
									<c:when test="${p.status == 10}">
										已提交
									</c:when>
									<c:when test="${p.status == 30}">
										待审核
									</c:when>
									<c:when test="${p.status == 40}">
										黑名单
									</c:when>
									<c:when test="${p.status == 50}">
										审核通过
									</c:when>
									<c:when test="${p.status == 60}">
										审核不通过
									</c:when>
								</c:choose>
							</li>
						</ul>
						<p>${p.auditOpinion}</p>
					</div>
				</li>
			</c:forEach>
		</ul>
	</div>
</body>
</html>
