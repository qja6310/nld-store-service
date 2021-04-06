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
    var isSuper = $("#isSuper").prop("checked");
    if(isSuper)isSuper = 1;
    else isSuper = 0;
    $.ajax({
        type: "post",
        url: base + "/admin/doAdd",
        data: {
            "aAcc": $("#aAcc").val(),
            "aName": $("#aName").val(),
            "aPwd": $("#aPwd").val(),
            "aPhone": $("#aPhone").val(),
            "aEmail": $("#aEmail").val(),
            "isSuper": isSuper,
        },
        dataType: "json",
        success: function (data) {
            console.log(data);
            if (data.code == "A00") {
                layer.msg(data.code + " : " + data.msg, {
                    icon : 1,
                    time : 2000,
                });
                //关闭弹框
                var index = parent.layer.getFrameIndex(window.name);
                parent.layer.close(index);
            } else {
                layer.msg(data.code + " : " + data.msg, {
                    icon : 2,
                    time : 2000,
                });
            }
        },
        error: function (data) {
            layer.msg("操作失败", {
                icon: 2,
                time: 2000,
            });
            return;
        },
    });
}

/** 修改信息 */
function doEdit() {
    if(!verify()) return false;
    var obj = {
        "id" : $("#id").val(),
        "aAcc": $("#aAcc").val(),
        "aName": $("#aName").val(),
        "aPwd": $("#aPwd").val(),
        "aPhone": $("#aPhone").val(),
        "aEmail": $("#aEmail").val()
    }
    var jsonStr = JSON.stringify(obj);
    var url = "/admin/doEdit";
    var resObj = myAjax(jsonStr,url);
    var type = 2;
    var msg = resObj.code + ":" + resObj.msg;
    if("A00" == resObj.code) type = 1;
    tipMsg(type,msg);
}