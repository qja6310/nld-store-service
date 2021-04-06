//防止页面后退
// history.pushState(null, null, document.URL);
// window.addEventListener('popstate', function () {
//     history.pushState(null, null, document.URL);
// });

layui.use('form', function() {
    var form = layui.form;
    layui.form.render('select', 'form');
});

$(document).ready(function () {
    init();
});

/** 初始方法 */
function init() {
    var url = $("#url").val();
    if(url.trim() == ''){
        $('#mainContontDiv').load(base + '/goods/index');
    }else{
        $('#mainContontDiv').load(base + url);
    }
}

function skipPage(type) {
    switch (type) {
        //商城首页
        case '10' :
            $('#mainContontDiv').load(base + '/goods/index');
            break;
        case '30' : //购物车
            $('#mainContontDiv').load(base + '/trolley/list?uid='+$('#uid').val());
            break;
        case '50' : //购物车
            $('#mainContontDiv').load(base + '/order/list?uid='+$('#uid').val());
            break;
        case '70' : //用户信息编辑
            if($('#uid').val() == '') return false;
            $('#mainContontDiv').load(base + '/user/edit?uid='+$('#uid').val());
            break;
    }
}