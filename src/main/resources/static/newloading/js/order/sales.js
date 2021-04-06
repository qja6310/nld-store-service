layui.use(['form','laydate'], function() {
    var form = layui.form
    var laydate = layui.laydate;
    //执行一个laydate实例
    laydate.render({
        elem: '#year' //指定元素
        ,type: 'year'
        ,max: $('#year').val()
    });
});

/**
 * 获取当前年份
 * @returns {number}
 */
function currYear() {
    var myDate = new Date();
    var year=myDate.getFullYear();
    console.log(year);
    return year;
}

/** 查询销售量 */
function doQuery() {
    window.location.href=base+'/order/sales?mid='+$('#mid').val()+'&year='+$('#year').val();
}