/**
 * 添加地址信息
 */
var index = $("#addrLen").val();
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
 * 删除地址
 * @param id
 */
function deleteAddr(id) {
    $("#"+id).remove();
}

/**
 * 注册动作
 */
function doEdit() {
    //表单数据验证
    if(!verify()){
        return false;
    }
    var addrArr = getAddr();
    $("#doEditBtn").addClass("layui-btn-disabled");
    var obj = {
        "id" : $("#uid").val(),
        "uName" : $("#uName").val(),
        "uAcc" : $("#uAcc").val(),
        "uPwd" : $("#uPwd").val(),
        "uIdentity" : $("#uIdentity").val(),
        "uPhone" : $("#uPhone").val(),
        "uEmail" : $("#uEmail").val(),
        "addrJsonStr" : JSON.stringify(addrArr)
    }
    var url="/user/doEdit";
    var jsonStr = JSON.stringify(obj);
    var resObj = myAjax(jsonStr,url);
    var type = 2;
    var msg = resObj.code + ":" + resObj.msg;
    if("U00"==resObj.code) type=1;
    tipMsg(type,msg);
    $("#doEditBtn").removeClass("layui-btn-disabled");
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

/**
 * 钱包
 */
function myWallet() {
    $('#mainContontDiv').load(base + '/user/wallet?uid='+$('#uid').val());
}