/**
 * 购买
 */
function buy() {
    if(!verify()) return false;
    var gid = $("#gid").val();
    var count = $("#count").val();
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
 * 加入购物车
 * @returns {boolean}
 */
function joinTrolley() {
    if(!verify()) return false;
    var gid = $("#gid").val();
    var count = $("#count").val();
    var url = '/goods/purchase?id='+gid+'&count='+count;
    if(isLogin(url)){
        var obj={
            'gid' : gid,
            'count' : count,
            'uid' : $('#uid').val()
        }
        var jsonStr=JSON.stringify(obj);
        url = '/trolley/join';
        var resObj = myAjax(jsonStr,url);
        var type = 2;
        var msg = resObj.code + ":"+resObj.msg;
        if('C00' == resObj.code) type = 1;
        tipMsg(type,msg);
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