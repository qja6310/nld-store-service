layui.use('form', function() {
    var form = layui.form;
    layui.form.render('select', 'form');
    /* form.on('select(fMenu)', function(data){
          getFMenu();
    }); */
});

/**
 * 登录动作
 */
function doLogin(obj) {
    //表单数据验证
    if(!verify()){
        return false;
    }
    $(obj).addClass("layui-btn-disabled");
    $.ajax({
        type : "post",
        url : base + "/admin/doLogin",
        data : {
            "aAcc" : $("#aAcc").val(),
            "aPwd" : $("#aPwd").val()
        },
        dataType : "json",
        success : function(data) {
            console.log(data);
            var code = data.code;
            if(code != "A00"){
                layer.msg(data.code + " : " + data.msg, {
                    icon : 2,
                    time : 2000,
                });
            }else{
                layer.msg(data.code + " : " + data.msg, {
                    icon : 1,
                    time : 2000,
                });
                var url = data.object;
                if(url == '' || url == null || url == undefined){
                    url = "/system/index";
                }
                window.location.href = base + url;
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
            $(obj).removeClass("layui-btn-disabled");
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