layui.use('form', function() {
    var form = layui.form;
    layui.form.render('select', 'form');
    /* form.on('select(fMenu)', function(data){
          getFMenu();
    }); */
});

/**
 * 注册动作
 */
function doLogin(obj) {
    //表单数据验证
    if(!verify()){
        return false;
    }
    $(obj).addClass("layui-btn-disabled");
    $.ajax({
        type : "post",
        url : base + "/user/doLogin",
        data : {
            "uAcc" : $("#uAcc").val(),
            "uPwd" : $("#uPwd").val()
        },
        dataType : "json",
        success : function(data) {
            console.log(data);
            var code = data.code;
            if(code != "U00"){
                layer.msg(data.code + " : " + data.msg, {
                    icon : 2,
                    time : 2000,
                });
            }else{
                layer.msg(data.code + " : " + data.msg, {
                    icon : 1,
                    time : 2000,
                });
                var url = "/system/userIndex";
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

/**
 * 获取地址
 * @returns {any[]}
 */
function getAddr() {
    var arr = new Array();
    $("#tbody tr").each(function () {
        if("addAddrTr" != $(this).attr("id")){
            var addr = {
                "conName" : $(this).find("td").eq(0).find("input").val(),
                "conPhone" : $(this).find("td").eq(1).find("input").val(),
                "detailAddr" : $(this).find("td").eq(2).find("input").val(),
            }
            arr.push(addr);
        }
    });
    return arr;
}