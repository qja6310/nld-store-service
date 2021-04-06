layui.use('form', function() {
    var form = layui.form;
    layui.form.render('select', 'form');
});

/**
 * 注册动作
 */
function doEdit() {
    //表单数据验证
    if(!verify())return false;
    $("#editBtn").addClass("layui-btn-disabled");
    var url = "/merchant/doEdit";
    var obj = {
        "id" : $("#id").val(),
        "mName" : $("#mName").val(),
        "mAcc" : $("#mACC").val(),
        "mPwd" : $("#mPwd").val(),
        "mAddr" : $("#mAddr").val(),
        "mEmail" : $("#mEmail").val(),
        "mPhone" : $("#mPhone").val(),
        "mBossIdentity" : $("#mBossIdentity").val(),
        "mBossName" : $("#mBossName").val(),
        "mBossPhone" : $("#mBossPhone").val(),
        "mBossEmail" : $("#mBossEmail").val()
    }
    var jsonStr = JSON.stringify(obj);
    var resObj = myAjax(jsonStr,url);
    var type = 2;
    var msg = resObj.code + ":" + resObj.msg;
    if(resObj.code == 'M00') type = 1;
    tipMsg(type,msg);
}