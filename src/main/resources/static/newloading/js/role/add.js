layui.use('form', function() {
    var form = layui.form;
});

/**
 * 新增用户
 */
function doAdd() {
    if(!verify()){
        return false;
    }
    var obj = {
        "rName" : $("#rName").val(),
        "rCode" : $("#rCode").val(),
    }
    var jsonStr = JSON.stringify(obj);
    var url = "/role/doAdd";
    var resObj = myAjax(jsonStr,url);
    var type = 2;
    var msg = resObj.code + ":" + resObj.msg;
    if ('R00' == resObj.code) type = 1;
    tipMsg(type,msg);
    if ('R00' == resObj.code){
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    }
}