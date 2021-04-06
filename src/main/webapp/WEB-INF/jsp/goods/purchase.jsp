<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<form class="layui-form" action="">
	<input type="hidden" id="gid" value="${goods.id}"/>
	<input type="hidden" id="inventory" value="${goods.gInventory}"/>
	<div style="float: left;width: 50%;height: 700px;">
		<div class="layui-carousel" id="imgDiv">
			<div carousel-item>
				<c:forEach items="${goods.imgList}" var="img">
					<div><img src="<%=request.getContextPath() %>${img.imgUrl}" alt="${img.imgTitle}" style="width:100%;height: 100%;"></div>
				</c:forEach>
			</div>
		</div>
	</div>
	<div style="float: right;width: 50%;margin-top: 30px;">
		<div><h1><i class="layui-icon layui-icon-read" style="margin: 0 20px;font-size: 30px;color: orangered;"></i>${goods.gTitle}</h1></div>
		<div style="margin-top: 20px;width: 100%;height: 30%;font-size: 20px;">${goods.gDetail}</div>
		<div style="margin-top: 20px;"><h3><i class="layui-icon layui-icon-edit" style="margin: 0 15px;font-size: 20px;color: darkorange;"></i>作者 ： ${goods.gAuthor}</h3></div>
		<div style="margin-top: 20px;"><h3><i class="layui-icon layui-icon-component" style="margin: 0 15px;font-size: 20px;color: darkorange;"></i>出版社 ： ${goods.gPress}</h3></div>
		<div style="margin-top: 20px;margin-left: 10px;">
			<h2 style="font-size: 40px;color: orangered;">
				<i class="layui-icon layui-icon-rmb" style="margin-right: 20px;font-size: 35px;"></i>
				${goods.gPrice}
			</h2>
		</div>
		<div style="margin-top: 20px;margin-left: 10px;">
			<div class="layui-form-item" style="margin-left: -40px;">
				<label class="layui-form-label">购买数量</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input verify" id="count" value="${count}" oninput="value=value.replace(/[^\d]|^[0]/g,'')" />
				</div>
			</div>
		</div>
		<div>
			<button type="button" class="layui-btn layui-btn-danger" onclick="joinTrolley()">加入购物车</button>
			<button type="button" class="layui-btn" onclick="buy()">立即购买</button>
		</div>
	</div>
</form>
<script type="text/javascript">
	layui.use('carousel', function(){
		var carousel = layui.carousel;
		//建造实例
		carousel.render({
			elem: '#imgDiv'
			,width: '70%' //设置容器宽度
			,height: '100%'
			,arrow: 'none' //始终显示箭头
			,anim: 'default' //切换动画方式
			,autoplay: true
		});
	});
</script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/goods/purchase.js"></script>