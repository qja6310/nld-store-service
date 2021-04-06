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
<title>订单</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/layui/css/layui.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/assets/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layui/js/layui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/echarts/echarts.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/common/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/newloading/js/order/sales.js"></script>
</head>
<body>
<div style="float: left;width: 60%;">
	<form class="layui-form layui-form-pane" action="" lay-filter="form">
		<input type="hidden" id="mid" value="${mid}"/>
		<div class="layui-form-item">
			<label class="layui-form-label">年份</label>
			<div class="layui-input-inline">
				<input type="text" name="year" id="year" value="${year}" lay-verify="date" placeholder="yyyy" autocomplete="off" class="layui-input" readonly="readonly">
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
			<th style="width: 16%;text-align: right;">月份</th>
			<c:forEach items="${month}" var="m">
				<th style="width: 7%;text-align: center;">${m}月</th>
			</c:forEach>
		</tr>
		</thead>
		<tbody id="tbody">
			<tr>
				<td style="text-align: right;color: rgb(84,112,198);">成交额(元)</td>
				<c:forEach items="${cje}" var="c">
					<td style="text-align: center;color: rgb(84,112,198);">${c}</td>
				</c:forEach>
			</tr>
			<tr>
				<td style="text-align: right;">订单量(单)</td>
				<c:forEach items="${ddl}" var="d">
					<td style="text-align: right;">${d}</td>
				</c:forEach>
			</tr>
		</tbody>
	</table>
</div>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="viewDiv" style="float: right;width: 40%;height:400px;"></div>
<script type="text/javascript">
	// 基于准备好的dom，初始化echarts实例
	var myChart = echarts.init(document.getElementById('viewDiv'));
	var year = $('#year').val();
	// 指定图表的配置项和数据
	var option = {
		title: {
			text: '年报销量',
			subtext: year
		},
		tooltip: {
			trigger: 'axis'
		},
		legend: {
			data: ['成交额(元)', '订单量(单)']
		},
		toolbox: {
			show: true,
			feature: {
				dataView: {show: true, readOnly: false},
				magicType: {show: true, type: ['line', 'bar']},
				restore: {show: true},
				saveAsImage: {show: true}
			}
		},
		calculable: true,
		xAxis: [
			{
				type: 'category',
				data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
			}
		],
		yAxis: [
			{
				type: 'value'
			}
		],
		series: [
			{
				name: '成交额',
				type: 'bar',
				data: [${sum}],
				markPoint: {
					data: [
						{type: 'max', name: '最大值'},
						{type: 'min', name: '最小值'}
					]
				},
				markLine: {
					data: [
						{type: 'average', name: '平均值'}
					]
				}
			},
			{
				name: '订单量',
				type: 'bar',
				data: [${count}],
				// markPoint: {
				// 	data: [
				// 		{name: '年最高', value: 182.2, xAxis: 7, yAxis: 183},
				// 		{name: '年最低', value: 2.3, xAxis: 11, yAxis: 3}
				// 	]
				// },
				markLine: {
					data: [
						{type: 'average', name: '平均值'}
					]
				}
			}
		]
	};

	// 使用刚指定的配置项和数据显示图表。
	myChart.setOption(option);
</script>
</body>
</html>
