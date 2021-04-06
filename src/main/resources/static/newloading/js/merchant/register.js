layui.use('form', function() {
    var form = layui.form;
    layui.form.render('select', 'form');
});

/**
 * 注册动作
 */
function doRegister() {
    //表单数据验证
    if(!verify()){
        return false;
    }
    $("#doRegisterBtn").addClass("layui-btn-disabled");
    $.ajax({
        type : "post",
        url : base + "/merchant/doRegister",
        data : {
            "mName" : $("#mName").val(),
            "mAcc" : $("#mACC").val(),
            "mPwd" : $("#mPwd").val(),
            "mAddr" : $("#mAddr").val(),
            "mEmail" : $("#mEmail").val(),
            "mPhone" : $("#mPhone").val(),
            "mBossIdentity" : $("#mBossIdentity").val(),
            "mBossName" : $("#mBossName").val(),
            "mBossPhone" : $("#mBossPhone").val(),
            "mBossEmail" : $("#mBossEmail").val(),
        },
        dataType : "json",
        success : function(data) {
            console.log(data);
            var code = data.code;
            if(code != "M00"){
                layer.msg(data.code + " : " + data.msg, {
                    icon : 2,
                    time : 2000,
                });
            }else{
                layer.msg(data.code + " : " + data.msg, {
                    icon : 1,
                    time : 2000,
                });
                window.location.href = base + "/merchant/progress?mAcc="+$("#mACC").val()+"&mPwd="+$("#mPwd").val();
            }
        },
        error : function(data) {
            layer.msg("操作失败", {
                icon : 2,
                time : 2000,
            });
            return;
        },
        complete : function () {
            $("#doRegisterBtn").removeClass("layui-btn-disabled");
        }
    });
}

/**
 * 表单验证
 * @returns {boolean}
 */
function verify() {
    var arr = $(".verify");
    for(var i = 0;i < arr.length;i++){
        if($(arr[i]).val().trim() == ''){
            var msg = $(arr[i]).attr("placeholder");
            layer.msg(msg,{
                icon: 2,
                time: 2000
            });
            return false;
        }
    }
    return true;
}