/**
 * 删除
 * @param tid
 */
function delTrolley(tid) {
    layer.confirm("确定移出购物车吗？", {
        icon : 3,
        title : '提示'
    }, function(index) {
        layer.close(index);
        var url = "/trolley/delete";
        var resObj = myAjax(tid,url);
        var type = 2;
        var msg = resObj.code + ":" + resObj.msg;
        if('C00' == resObj.code) type=1;
        tipMsg(type,msg);
        if('C00' == resObj.code){
            var uid = $("#uid").val();
            $('#mainContontDiv').load(base + '/trolley/list?uid='+uid);
        }
    });
}

/**
 * 购买
 */
function buy(tid) {
    if(!verify()) return false;
    var gid = $("#gid-"+tid).val();
    var count = $("#nCount-"+tid).val();
    if(parseInt(count) > parseInt($("#inventory").val())){
        tipMsg(2,"库存不够了");
        return false;
    }
    var url = '/order/buy?gid='+gid+'&count='+count;
    if(isLogin(url)){
        $('#mainContontDiv').load(base + url);
    }else{
        window.location.href=base+'/user/login';
    }
}

/**
 * 判断用户是否登录
 * @param targetUrl
 * @returns {boolean}
 */
function isLogin(targetUrl) {
    var url = '/user/isLogin';
    var resObj = myAjax(targetUrl,url);
    if('U00' == resObj.code) return true;
    return false;
}