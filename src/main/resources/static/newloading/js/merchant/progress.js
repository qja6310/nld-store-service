layui.use('form', function() {
    var form = layui.form;
    layui.form.render('select', 'form');
});

$(document).ready(function () {
    init();
})

/** 初始化 */
function init() {
    if($("#msg").val() != '' && $("#msg").val() != undefined) tipMsg(2,$("#msg").val());
}

function doQuery() {
    if($("#qmACC").val().trim() == ''){
        layer.msg("输入查询账号", {
            icon : 2,
            time : 2000,
        });
        return;
    }
    if($("#qmPwd").val().trim() == ''){
        layer.msg("输入密码", {
            icon : 2,
            time : 2000,
        });
        return;
    }
    window.location.href = base + "/merchant/progress?mAcc="+$("#qmACC").val()+"&mPwd="+$("#qmPwd").val();
}

/**
 * 可编辑
 */
function editBtn() {
    var arr = $(".verify");
    for(var i = 0;i < arr.length;i++){
        $(arr[i]).attr("readonly",false);
    }
    var btn = $("<button type=\"button\" id=\"doRegisterBtn\" class=\"layui-btn layui-btn-fluid\" style=\"margin-top: 20px;\"><i class=\"layui-icon layui-icon-ok-circle\"></i>提交审核</button>");
    btn.on("click",function () {
        doRegister();
    });
    $("#editBtn").after(btn);
    $("#editBtn").remove();
}

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
            "id" : $("#id").val(),
            "mName" : $("#mName").val(),
            "mACC" : $("#mACC").val(),
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
 * 审核
 * @param r
 */
function audit(r) {
    if(!verify()) return false;
    var msg;
    if (r == 'N'){
        msg = "是否确认不通过审核？";
        r = '60';
    }else{
        msg = "是否确认通过审核？";
        r = '50';
    }
    layer.confirm(msg, {
        icon : 3,
        title : '提示'
    }, function(index) {
        layer.close(index);
        var obj = {
            "id" : $("#id").val(),
            "auditOpinion" : $("#auditOpinion").val(),
            "status" : r
        }
        var jsonStr = JSON.stringify(obj);
        var url = '/merchant/audit';
        $(".auditBtn").addClass("layui-btn-disabled");
        var resObj = myAjax(jsonStr,url);
        var type;
        msg = resObj.code + " : " + resObj.msg;
        if (resObj.code == "M00") type = 1;
        else type = 2;
        tipMsg(type,msg);
        //关闭弹框
        var index = parent.layer.getFrameIndex(window.name);
        parent.layer.close(index);
    });
}