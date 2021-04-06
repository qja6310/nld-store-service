layui.use('form', function() {
    var form = layui.form;
    layui.form.render('select', 'form');
    /* form.on('select(fMenu)', function(data){
          getFMenu();
    }); */
});

/**
 * 添加地址信息
 */
var index = 1;
function addAddr() {
    var tr = $("<tr></tr>");
    tr.attr("id","tr-" + index);
    var td1 = $("<td><input class='layui-input'/></td>");
    var td2 = $("<td><input class='layui-input'/></td>");
    var td3 = $("<td><input class='layui-input'/></td>");
    var td4 = $("<td><button class='layui-btn layui-btn-sm layui-btn-danger'>删除</button></td>");
    td4.attr("tr","tr-" + index);
    td4.on("click",function () {
        var id = $(this).attr("tr");
        $("#"+id).remove();
    });
    tr.append(td1);
    tr.append(td2);
    tr.append(td3);
    tr.append(td4);
    $("#addAddrTr").before(tr);
    index ++;
}

/**
 * 注册动作
 */
function doRegister() {
    //表单数据验证
    if(!verify()){
        return false;
    }
    var addrArr = getAddr();
    $("#doRegisterBtn").addClass("layui-btn-disabled");
    $.ajax({
        type : "post",
        url : base + "/user/doRegister",
        data : {
            "uName" : $("#uName").val(),
            "uAcc" : $("#uAcc").val(),
            "uPwd" : $("#uPwd").val(),
            "uIdentity" : $("#uIdentity").val(),
            "uPhone" : $("#uPhone").val(),
            "uEmail" : $("#uEmail").val(),
            "addrJsonStr" : JSON.stringify(addrArr)
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
                window.location.href = base + "/user/login";
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