layui.use('form', function() {
    var form = layui.form;
});

/**
 * 新增用户
 */
function doConfig() {
    var arr = $('.checkBox');
    var roleIds = '';
    for(var i = 0;i < arr.length;i++){
        if($(arr[i]).prop('checked')){
            if(roleIds == '') roleIds += $(arr[i]).val();
            else roleIds += "," + $(arr[i]).val();
        }
    }
    var obj = {
        "aid" : $("#aid").val(),
        "roleIds" : roleIds,
    }
    var jsonStr = JSON.stringify(obj);
    var url = "/role/doConfig";
    var resObj = myAjax(jsonStr,url);
    var type = 2;
    var msg = resObj.code + ":" + resObj.msg;
    if ('R00' == resObj.code) type = 1;
    tipMsg(type,msg);
    var index = parent.layer.getFrameIndex(window.name);
    parent.layer.close(index);
}