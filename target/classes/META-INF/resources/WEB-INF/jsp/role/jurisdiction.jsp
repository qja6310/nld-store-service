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
<title>权限配置</title>
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
<link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/js/layui.js"></script>
<script type="application/javascript" src="<%=request.getContextPath() %>/zTree_v3/js/jquery.ztree.all.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/common/common.js"></script>
</head>
<body>
	<div>
		<input type="hidden" id="rid" value="${rid}"/>
		<div>
			<ul id="menuTree" class="ztree"></ul>
		</div>
		<script>
			var settings = {
				data: {
					simpleData: {
						enable: true,  //true 、 false 分别表示 使用 、 不使用 简单数据模式
						idKey: "id",  //节点数据中保存唯一标识的属性名称
						pIdKey: "pid",    //节点数据中保存其父节点唯一标识的属性名称
						rootPId: 0  //用于修正根节点父节点数据，即 pIdKey 指定的属性值
					},
					key: {
						name: "menuName"  //zTree 节点数据保存节点名称的属性名称  默认值："name"
					}
				},
				check:{
					enable:true,  //true 、 false 分别表示 显示 、不显示 复选框或单选框
					nocheckInherit:true  //当父节点设置 nocheck = true 时，设置子节点是否自动继承 nocheck = true
				}
			};
			var zNodes = ${allMenus};
			zTreeObj = $.fn.zTree.init($("#menuTree"), settings, zNodes); //初始化树
			zTreeObj.expandAll(true);    //true 节点全部展开、false节点收缩
			var arr = ${menus};
			var seletedList = arr;
			for(var i=0;i<seletedList.length;i++){
				//设置选中的节点
				var node = zTreeObj.getNodeByParam("id", seletedList[i].id);
				zTreeObj.checkNode(node, true, false);
			}
		</script>
	</div>
	<div style="position:absolute;bottom:0px;width: 100%;">
		<button type="button" class="layui-btn layui-btn-normal" style="width: 100%" onclick="takeEffect()">生效</button>
	</div>
</body>
<script>
	layui.use('form', function() {
		var form = layui.form;
	});
	function takeEffect() {
		var zTreeOjb = $.fn.zTree.getZTreeObj("menuTree");
		var checkedNodes = zTreeObj.getCheckedNodes();
		var menuIds = '';
        for (var i = 0;i < checkedNodes.length;i++){
			if(menuIds == '') menuIds += checkedNodes[i].id;
			else menuIds += "," + checkedNodes[i].id;
        }
        var obj = {
            "id" : $("#rid").val(),
            "menuIds" : menuIds
        }
        var jsonStr = JSON.stringify(obj);
        var url = '/role/update';
        var resObj = myAjax(jsonStr,url);
        var type;
        var msg = resObj.code + " : " + resObj.msg;
        if (resObj.code == "R00") type = 1;
        else type = 2;
        tipMsg(type,msg);
	}
</script>
</html>
