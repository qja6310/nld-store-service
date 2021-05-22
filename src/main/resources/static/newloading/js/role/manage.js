layui.use('form', function() {
    var form = layui.form;
});

/** 查询 */
function doQuery() {
    window.location.href = base + "/role/manage?rCode="+$("#rCode").val()+"&rName="+$("#rName").val();
}

/** 新增 */
function toAdd() {
    layer.open({
        type: 2,//0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
        title: ['新增角色', 'font-size: 15px;font-weight: 500;'],
        area: ['800', '150px'],
        // shadeClose: true, //点击遮罩关闭
        content: base + '/role/toAdd',
        closeBtn: 2,
        end: function () {
            doQuery();
        }
    });
}

/**
 * 权限配置
 * @param rid
 */
function jurisdiction(rid) {
    layer.open({
        type: 2,//0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
        title: ['新增角色', 'font-size: 15px;font-weight: 500;'],
        area: ['300px', '500px'],
        // shadeClose: true, //点击遮罩关闭
        content: base + '/role/jurisdiction?rid='+rid,
        closeBtn: 2,
        end: function () {
            doQuery();
        }
    });
}

/**
 * 修改名称
 * @param id
 */
function updateName(id) {
    if($("#rName-"+id).val() == ''){
        tipMsg(2,$("#rName-"+id).attr("placeholder"));
        return;
    }
    var obj = {
        "id" : id,
        "rName" : $("#rName-"+id).val()
    }
    var jsonStr = JSON.stringify(obj);
    var url = '/role/update';
    var resObj = myAjax(jsonStr,url);
    var type;
    var msg = resObj.code + " : " + resObj.msg;
    if (resObj.code == "R00") type = 1;
    else type = 2;
    tipMsg(type,msg);
}

/**
 * 菜单配置
 * @param id
 */
// function jurisdict(id) {
//     var ev = $("#jurisdict-"+id);
//     var txt = ev.text();
//     if(txt != '权限查看'){//配置权限
//         arr = $(".checkBox");
//         var menuIds = '';
//         for (var i = 0;i < arr.length;i++){
//             if($(arr[i]).prop('checked')){
//                 if(menuIds == '') menuIds += $(arr[i]).val();
//                 else menuIds += "," + $(arr[i]).val();
//             }
//         }
//         var obj = {
//             "id" : id,
//             "menuIds" : menuIds
//         }
//         var jsonStr = JSON.stringify(obj);
//         var url = '/role/update';
//         var resObj = myAjax(jsonStr,url);
//         var type;
//         var msg = resObj.code + " : " + resObj.msg;
//         if (resObj.code == "R00") type = 1;
//         else type = 2;
//         tipMsg(type,msg);
//     }else{//权限查看
//         ev.text("配置权限");
//         var arr = $(".jurisdiction");
//         //其他按钮上的文字变为权限查看
//         for (var i = 0;i < arr.length;i++){
//             if(id != $(arr[i]).attr('fid')){
//                 $(arr[i]).text("权限查看");
//             }
//         }
//         $(".checkBox").prop("checked",false);
//         //获取已配置的菜单
//         var url = '/role/menu';
//         var resObj = myAjax(id,url);
//         //所有的menuName-1可见，menuName-2不可见
//         $(".menuName-1").show();
//         $(".menuName-2").hide();
//         var menus = resObj.object;
//         for (var i = 0;i < menus.length;i++){
//             var id = menus[i].id;
//             $("#menu_"+id).prop("checked",true);
//         }
//     }
// }

/**
 * 角色删除
 * @param id
 */
function delRole(id) {
    var msg = "确认删除该角色？";
    layer.confirm(msg, {
        icon : 3,
        title : '提示'
    }, function(index) {
        layer.close(index);
        var url = '/role/delete';
        var resObj = myAjax(id,url);
        var type;
        msg = resObj.code + " : " + resObj.msg;
        if (resObj.code == "R00") type = 1;
        else type = 2;
        tipMsg(type,msg);
        doQuery();
    });
}

/** 复选框联动 */
/** 一级 */
$(document).on('click','.checkBox-1',function () {
    var checked = $(this).prop('checked');
    var pid = $(this).val();
    var arr = $('.checkBox-2');
    for (var i = 0;i < arr.length;i++){
        if(pid == $(arr[i]).attr('pid')){
            $(arr[i]).prop('checked',checked);
        }
    }
});
/** 二级 */
$(document).on('click','.checkBox-2',function () {
    var checked = $(this).prop('checked');
    var pid = $(this).attr("pid");
    if(checked) {
        $('#menu_'+pid).prop('checked',checked);
        return;
    }
    var arr = $('.checkBox-2');
    for (var i = 0;i < arr.length;i++){
        if(pid == $(arr[i]).attr('pid')
            && $(this).attr('id') != $(arr[i]).attr('id')
            && $(arr[i]).prop('checked')){
            $('#menu_'+pid).prop('checked',true);
            return;
        }
    }
    $('#menu_'+pid).prop('checked',checked);
    return;
});
