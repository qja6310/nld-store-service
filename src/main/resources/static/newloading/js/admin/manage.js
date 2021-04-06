layui.use('form', function() {
    var form = layui.form;
});

/** 查询 */
function doQuery() {
    window.location.href = base + "/admin/manage?aAcc="+$("#aAcc").val()+"&aName="+$("#aName").val()+"&aPhone="+$("#aPhone").val();
}

/** 继续加载数据 */
function doLoading() {
    $.ajax({
        type: "post",
        url: base + "/admin/doQuery",
        data: {
            "aAcc": $("#haAcc").val(),
            "aName": $("#haName").val(),
            "aPhone": $("#haPhone").val(),
            "page" : $("#page").val(),
            "limit" : $("#limit").val(),
        },
        dataType: "json",
        success: function (data) {
            console.log(data);
            loadDataToTable(data.object);
            var page = $("#page").val();
            $("#page").val(parseInt(page) + 1);
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

/**
 * 加载数据进表格
 * @param admins
 */
function loadDataToTable(admins) {
    if(admins.length == 0){
        tipMsg(2,'没有更多了');
        return;
    }
    var seq = $("#tbody tr").length;
    for(var i = 0;i < admins.length;i++){
        seq ++;
        var tr = $("<tr></tr>");
        var td1 = $("<td>"+seq+"</td>");
        var td2 = $("<td>"+admins[i].aName+"</td>");
        var td3 = $("<td>"+admins[i].aAcc+"</td>");
        var td4 = $("<td>"+admins[i].aPhone+"</td>");
        var td5 = $("<td>"+admins[i].aEmail+"</td>");
        var td6 = $("<td></td>");

        var a1 = $("<a style=\"margin: 0 10px;color: blue;cursor: pointer;\">角色配置</a>");
        var a2 = $("<a style=\"margin: 0 10px;color: orangered;cursor: pointer;\">重置密码</a>");
        a2.attr("aid",admins[i].id);
        a2.on('click',function () {
            var id = $(this).attr('aid');
            resetPwd(id);
        });
        var a3 = $("<a style=\"margin: 0 10px;color: orangered;cursor: pointer;\">删除</a>");
        a3.attr("aid",admins[i].id);
        a3.on('click',function () {
            var id = $(this).attr('aid');
            delAdmin(id);
        });
        td6.append(a1);
        td6.append(a2);
        td6.append(a3);

        tr.append(td1);tr.append(td2);tr.append(td3);tr.append(td4);tr.append(td5);tr.append(td6);
        $("#tbody").append(tr);
    }
}

/**
 * 新增页面
 */
function addPage() {
    layer.open({
        type: 2,//0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
        title: ['新增人员', 'font-size: 15px;font-weight: 500;'],
        area: ['900px', '400px'],
        // shadeClose: true, //点击遮罩关闭
        content: base + '/admin/toAdd',
        closeBtn: 2,
        end: function () {
            doQuery();
        }
    });
}

/**
 * 删除
 * @param id
 */
function delAdmin(id) {
    layer.confirm("确定删除？", {
        icon : 3,
        title : '提示'
    }, function(index) {
        layer.close(index);
        var url = "/admin/delAdmin";
        var resObj = myAjax(id,url);
        var type;
        var msg = resObj.code + " : " + resObj.msg;
        if (resObj.code == "A00") type = 1;
        else type = 2;
        tipMsg(type,msg);
        if(type == 1) doQuery();
    });
}
/** 密码重置 */
function resetPwd(id) {
    layer.confirm("确定重置密码？", {
        icon : 3,
        title : '提示'
    }, function(index) {
        layer.close(index);
        var url = "/admin/resetPwd";
        var resObj = myAjax(id,url,false);
        var type;
        var msg = resObj.code + " : " + resObj.msg;
        if (resObj.code == "A00") type = 1;
        else type = 2;
        tipMsg(type,msg);
    });
}

/** 配置角色 */
function toConfigRole(id) {
    layer.open({
        type: 2,//0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
        title: ['角色配置', 'font-size: 15px;font-weight: 500;'],
        area: ['350px', '500px'],
        // shadeClose: true, //点击遮罩关闭
        content: base + '/role/config?aid='+id,
        closeBtn: 2,
        end: function () {
            doQuery();
        }
    });
}


