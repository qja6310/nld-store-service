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
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/goods/edit.js"></script>
<style type="text/css">
	.img-size{
		width: 150px;
		height: 150px;
		border-style: ridge;
	}
	.img-close{
		position: absolute;
		margin-left: -30px;
		font-size: 30px;
		color: orangered;
	}
</style>
</head>
<body>
<div <c:if test="${flag != '999'}">style="float:left;width: 70%;"</c:if><c:if test="${flag != '999'}">style="float:left;width: 100%;"</c:if>>
	<form class="layui-form layui-form-pane" lay-filter="form">
		<input type="hidden" id="mid" value="${mid}">
		<input type="hidden" id="id" value="${goods.id}">
		<input type="hidden" id="imgCount" value="${imgCount}">
		<input type="hidden" id="status" value="${goods.status}">
		<input type="hidden" id="roleFlag" value="${r}">
		<div style="padding: 20px;">
			<div class="layui-form-item">
				<label class="layui-form-label">标题</label>
				<div class="layui-input-inline">
					<input type="text" id="gTitle" name="gTitle" value="${goods.gTitle}" autocomplete="off" placeholder="请输入标题" class="layui-input verify" >
				</div>
				<label class="layui-form-label">作者</label>
				<div class="layui-input-inline">
					<input type="text" id="gAuthor" name="gAuthor" value="${goods.gAuthor}" autocomplete="off" placeholder="请输入作者" class="layui-input verify" >
				</div>
				<label class="layui-form-label">出版社</label>
				<div class="layui-input-inline">
					<input type="text" id="gPress" name="gPress" value="${goods.gPress}" autocomplete="off" placeholder="请输入出版社" class="layui-input" >
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">库存</label>
				<div class="layui-input-inline">
					<input type="text" id="gInventory" name="gInventory" value="${goods.gInventory}" autocomplete="off" placeholder="请输入库存" class="layui-input verify" oninput="value=value.replace(/[^\d]|^[0]/g,'')">
				</div>
				<label class="layui-form-label">单价(元)</label>
				<div class="layui-input-inline">
					<input type="text" id="gPrice" name="gPrice" value="${goods.gPrice}" autocomplete="off" placeholder="请输入单价" class="layui-input verify" maxlength="8"/>
				</div>
				<label class="layui-form-label">类别</label>
				<div class="layui-input-inline">
					<select id="type" name="type" lay-verify="required">
						<c:forEach items="${types}" var="t">
							<option value="${t.id}" <c:if test="${goods.gType == t.id}">selected</c:if>>${t.tName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">状态</label>
				<div class="layui-input-inline">
					<input type="text" id="statusName" name="statusName" value="" autocomplete="off" placeholder="" class="layui-input" readonly="readonly">
				</div>
			</div>
			<textarea id="gDetail" name="gDetail" style="width: 920px;" placeholder="请输入该商品介绍详情(不超过600个字)" class="layui-textarea verify" maxlength="600">${goods.gDetail}</textarea>
			<div class="layui-upload" style="margin-top: 20px;">
				<button type="button" class="layui-btn layui-btn-normal" id="uploadImgBtn">上传图片</button>
				<i class="layui-icon layui-icon-tips" style="color: orangered;" id="tip">最多上传5张图片</i>
				<div class="layui-upload-list" id="uploadDiv">
					<c:forEach items="${imgs}" var="img">
						<div style='margin: 0 5px;' class='layui-input-inline imgDiv' value='${img.id}'>
							<input type='hidden' class='imgPath' value='${img.imgUrl}'/>
							<input type='hidden' class='imgTitle' value='${img.imgTitle}'>
							<img class='img-size' src='<%=request.getContextPath() %>${img.imgUrl}' title='${img.imgTitle}'>
							<i class="layui-icon layui-icon-close-fill img-close" value="${img.id}" onclick="delImg(${img.id})"></i>
						</div>
					</c:forEach>
				</div>
			</div>
			<c:if test="${flag != '999' && r == 'a' && goods.status == '30'}">
				<textarea id="auditOpinion" name="auditOpinion" style="width: 920px;" placeholder="请输入审核意见(不超过250个字)" class="layui-textarea" maxlength="250"></textarea>
			</c:if>
		</div>
		<c:if test="${flag != '999'}">
			<div style="float: left;padding: 0 20px;margin-bottom: 20px;">
				<button type="button" class="layui-btn layui-btn-warm" onclick="back(${mid})">返回列表</button>
				<c:choose>
					<c:when test="${r == 'm'}">
						<c:if test="${goods.status == '10' || goods.status == '70' || goods.status == '50' || goods.status == '60'}">
							<button type="button" id="editBtn" class="layui-btn" onclick="doEdit()"><i class="layui-icon"></i>确认修改</button>
						</c:if>
					</c:when>
					<c:when test="${r == 'a' && goods.status == '30'}">
						<button type="button" class="layui-btn" onclick="updateStatus(${goods.id},'50')">审核通过</button>
						<button type="button" class="layui-btn layui-btn-danger" onclick="updateStatus(${goods.id},'60')">审核不通过</button>
					</c:when>
				</c:choose>
			</div>
		</c:if>
	</form>
</div>
<c:if test="${flag != '999'}">
	<div style="float: right;margin-top: 40px;margin-right: 20px;width: 25%;">
		<ul class="layui-timeline">
			<c:if test="${goods.status == '10' || goods.status == '30'}">
				<li class="layui-timeline-item">
					<i class="layui-icon layui-timeline-axis" style="color: orangered;"></i>
					<div class="layui-timeline-content layui-text">
						<h3 class="layui-timeline-title">等待审核</h3>
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
										已提交
									</c:when>
									<c:when test="${p.status == 30}">
										待审核
									</c:when>
									<c:when test="${p.status == 50}">
										审核通过
									</c:when>
									<c:when test="${p.status == 60}">
										审核不通过
									</c:when>
									<c:when test="${p.status == 70}">
										已上架
									</c:when>
									<c:when test="${p.status == 80}">
										已下架
									</c:when>
									<c:when test="${p.status == 90}">
										强制下架
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
</c:if>
</body>
</html>
