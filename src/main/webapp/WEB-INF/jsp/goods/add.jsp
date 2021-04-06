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
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/goods/add.js"></script>
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
<div>
	<form class="layui-form layui-form-pane" lay-filter="form">
		<input type="hidden" id="mid" value="${mid}">
		<div style="padding: 20px;">
			<div class="layui-form-item">
				<label class="layui-form-label">标题</label>
				<div class="layui-input-inline">
					<input type="text" id="gTitle" name="gTitle" value="" autocomplete="off" placeholder="请输入标题" class="layui-input verify" >
				</div>
				<label class="layui-form-label">作者</label>
				<div class="layui-input-inline">
					<input type="text" id="gAuthor" name="gAuthor" value="" autocomplete="off" placeholder="请输入作者" class="layui-input verify" >
				</div>
				<label class="layui-form-label">出版社</label>
				<div class="layui-input-inline">
					<input type="text" id="gPress" name="gPress" value="" autocomplete="off" placeholder="请输入出版社" class="layui-input" >
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">库存</label>
				<div class="layui-input-inline">
					<input type="text" id="gInventory" name="gInventory" value="" autocomplete="off" placeholder="请输入库存" class="layui-input verify" oninput="value=value.replace(/[^\d]|^[0]/g,'')">
				</div>
				<label class="layui-form-label">单价(元)</label>
				<div class="layui-input-inline">
					<input type="text" id="gPrice" name="gPrice" value="" autocomplete="off" placeholder="请输入单价" class="layui-input verify" maxlength="8"/>
				</div>
				<label class="layui-form-label">类别</label>
				<div class="layui-input-inline">
					<select id="type" name="type" lay-verify="required">
						<c:forEach items="${types}" var="t">
							<option value="${t.id}">${t.tName}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">状态</label>
				<div class="layui-input-inline">
					<input type="text" id="status" name="status" value="待提交" autocomplete="off" placeholder="" class="layui-input" readonly="readonly">
				</div>
			</div>
			<textarea id="gDetail" name="gDetail" style="width: 920px;" placeholder="请输入该商品介绍详情(不超过600个字)" class="layui-textarea verify" maxlength="250"></textarea>
			<div class="layui-upload" style="margin-top: 20px;">
				<button type="button" class="layui-btn layui-btn-normal" id="uploadImgBtn">上传图片</button>
				<i class="layui-icon layui-icon-tips" style="color: orangered;">最多上传5张图片</i>
				<div class="layui-upload-list" id="uploadDiv">

				</div>
			</div>
		</div>
		<div style="float: left;padding: 0 20px;margin-bottom: 20px;">
			<button type="button" class="layui-btn layui-btn-warm" onclick="back(${mid})">返回列表</button>
			<button type="button" id="editBtn" class="layui-btn" onclick="doAdd()"><i class="layui-icon"></i>提交审核</button>
		</div>
	</form>
</div>
</body>
</html>
