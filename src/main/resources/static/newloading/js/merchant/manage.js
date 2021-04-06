layui.use('form', function() {
    var form = layui.form;
});

/** 查询 */
function doQuery() {
    window.location.href = base + "/merchant/manage?mAcc="+$("#mAcc").val()
        +"&mName="+$("#mName").val()+"&mPhone="+$("#mPhone").val()
        +"&mCode="+$("#mCode").val()+"&mEmail="+$("#mEmail").val()
        +"&mAddr="+$("#mAddr").val();
}

/** 继续加载数据 */
function doLoading() {
    var obj = {
        "mAcc" : $("#hmAcc").val(),
        "mName" : $("#hmName").val(),
        "mPhone" : $("#hmPhone").val(),
        "mCode" : $("#hmCode").val(),
        "mEmail" : $("#hmEmail").val(),
        "mAddr" : $("#hmAddr").val(),
        "page" : $("#page").val(),
    }
    var jsonStr = JSON.stringify(obj);
    var url = "/merchant/doQuery";
    var resObj = myAjax(jsonStr,url);
    loadDataToTable(resObj.object);
    var page = $("#page").val();
    $("#page").val(parseInt(page) + 1);
}

/**
 * 加载数据进表格
 * @param admins
 */
function loadDataToTable(merchants) {
    if(merchants.length == 0){
        tipMsg(2,'没有更多了');
    }
    var seq = $("#tbody tr").length;
    for(var i = 0;i < merchants.length;i++){
        seq ++;
        var tr = $("<tr></tr>");
        var td1 = $("<td>"+seq+"</td>");
        var td2 = $("<td>"+merchants[i].mName+"</td>");
        var td3 = $("<td>"+merchants[i].mCode+"</td>");
        var td4 = $("<td>"+merchants[i].mAcc+"</td>");
        var td5 = $("<td>"+merchants[i].mPhone+"</td>");
        var td6 = $("<td>"+merchants[i].mEmail+"</td>");
        var td7 = $("<td>"+merchants[i].mBossName+"</td>");
        var td8 = $("<td></td>");
        var txt = '查看';
        var type = 'c';
        if(merchants[i].status == '10' || merchants[i].status == '30'){
            txt = '审核';
            type = 'a';
        }
        var a1 = $("<a style=\"margin: 0 10px;color: blue;cursor: pointer;\">"+txt+"</a>");
        a1.attr("mid",merchants[i].id);
        a1.attr("tp",type);
        a1.on('click',function () {
            var id = $(this).attr('mid');
            var tp = $(this).attr('tp');
            detail(id,tp);
        });
        td8.append(a1);
        if(merchants[i].status != '10' && merchants[i].status != '30' && merchants[i].status != '60'){
            if(merchants[i].status == '40'){
                txt = '恢复';
                type = '50';
            }else{
                txt = '拉黑';
                type = '40';
            }
            var a2 = $("<a style=\"margin: 0 10px;cursor: pointer;\">"+txt+"</a>");
            if(merchants[i].status == '40') a2.css("color","blue");
            else a2.css("color","orangered")
            a2.attr("mid",merchants[i].id);
            a2.attr("tp",type);
            a2.on('click',function () {
                var id = $(this).attr('mid');
                var tp = $(this).attr('tp');
                blacklist(id,tp);
            });
            td8.append(a2);
        }
        tr.append(td1);tr.append(td2);tr.append(td3);tr.append(td4);tr.append(td5);tr.append(td6);tr.append(td7);tr.append(td8);
        $("#tbody").append(tr);
    }
}

/**
 * 审核或者详情
 * @param id
 * @param tp
 */
function detail(id,tp) {
    layer.open({
        type: 2,//0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
        title: ['详情', 'font-size: 15px;font-weight: 500;'],
        area: ['1000px', '650px'],
        // shadeClose: true, //点击遮罩关闭
        content: base + "/merchant/detail?id="+id+"&tp="+tp,
        closeBtn: 2,
        end: function () {
            doQuery();
        }
    });
}

/**
 * 拉黑或者恢复
 * @param id
 * @param tp
 */
function blacklist(id,tp) {
    var msg;
    if (tp == '40'){
        msg = "该商户是否拉进黑名单？";
    }else{
        msg = "该商户是否拉出黑名单？";
    }
    layer.confirm(msg, {
        icon : 3,
        title : '提示'
    }, function(index) {
        layer.close(index);
        var obj = {
            "id": id,
            "status": tp
        }
        var jsonStr = JSON.stringify(obj);
        var url = '/merchant/blacklist';
        var resObj = myAjax(jsonStr,url);
        var type;
        msg = resObj.code + " : " + resObj.msg;
        if (resObj.code == "M00") type = 1;
        else type = 2;
        tipMsg(type,msg);
        doQuery();
    });
}




