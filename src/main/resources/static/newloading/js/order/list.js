layui.use('form', function() {
    var form = layui.form;
    layui.form.render('select', 'form');
});
/** 查询 */
function doQuery() {
    var status = $('#status').val();
    if($("#r").val() == 'u'){
        $('#mainContontDiv').load(base + '/order/list?uid='+$('#uid').val()+'&status='+status);
    }else if($("#r").val() == 'm'){
        var oNumber = $("#oNumber").val();
        window.location.href=base+'/order/list?mid='+$('#mid').val()+'&status='+status+'&oNumber='+oNumber;
    }else if($("#r").val() == 'a'){
        var oNumber = $("#oNumber").val();
        var mName = $("#mName").val();
        window.location.href=base+'/order/list?status='+status+'&oNumber='+oNumber+'&mName='+mName;
    }
}

/** 详情 */
function detail(oid) {
    if($("#r").val() == 'u'){
        $('#mainContontDiv').load(base + '/order/detail?oid='+oid+'&r=u');
    }else{
        window.location.href=base+'/order/detail?oid='+oid+'&r='+$('#r').val()+'&mid='+$("#mid").val();
    }
}

/**
 * 继续支付
 * @param oid
 */
function toPay(oid) {
    window.location.href = base + "/order/toPay?oid="+oid;
}

/**
 * 商品详情
 * @param gid
 */
function goodsDetail(gid) {
    $('#mainContontDiv').load(base + '/goods/purchase?id='+gid);
}

/**
 * 修改状态
 * @param oid
 * @param status
 */
function updateStatus(oid,status) {
    var msg='';
    var opRemark='';
    if(status == '60'){
        msg = '是否已签收？';
        opRemark='该商品已签收';
    }else if(status == '50'){
        msg = '是否确认发货？';
        opRemark='商家已发货';
    }
    layer.confirm(msg, {
        icon : 3,
        title : '提示'
    }, function(index) {
        layer.close(index);
        var obj={
            'oid' : oid,
            'status' : status,
            'opRemark' : opRemark
        }
        var url='/order/updateStatus';
        var jsonStr=JSON.stringify(obj);
        var resObj = myAjax(jsonStr,url);
        var type = 2;
        msg = resObj.code + ":" + resObj.msg;
        if(resObj.code == 'O00') type = 1;
        tipMsg(type,msg);
        if(resObj.code == 'O00'){
            if($("#r").val() == 'u'){
                $('#mainContontDiv').load(base + '/order/list?uid='+$("#uid").val());
            }else if($("#r").val() == 'm'){
                window.location.href=base+'/order/list?mid='+$('#mid').val()
            }
        }
    });
}

/**
 * 审核或者详情
 * @param id
 * @param tp
 */
function merchantDetail(id,tp) {
    layer.open({
        type: 2,//0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
        title: ['详情', 'font-size: 15px;font-weight: 500;'],
        area: ['1000px', '650px'],
        shadeClose: true, //点击遮罩关闭
        content: base + "/merchant/detail?id="+id+"&tp="+tp,
        closeBtn: 2,
    });
}

/**
 * 商品详情
 * @param id
 */
function goodsDetail(id) {
    layer.open({
        type: 2,//0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
        title: ['详情', 'font-size: 15px;font-weight: 500;'],
        area: ['1000px', '650px'],
        shadeClose: true, //点击遮罩关闭
        content: base + '/goods/edit?id='+id+'&flag=999',
        closeBtn: 2,
    });
}

//继续加载
function doLoading() {
    var obj;
    var r = $("#r").val();
    if(r == 'm'){
        obj = {
            "status" : $("#hstatus").val(),
            "oNumber" : $("#hoNumber").val(),
            "page" : $("#page").val(),
            "mid" : $("#mid").val()
        }
    }else if(r == 'a'){
        obj = {
            "status" : $("#hstatus").val(),
            "oNumber" : $("#hoNumber").val(),
            "mName" : $("#hmName").val(),
            "page" : $("#page").val(),
        }
    }else if(r == 'u'){
        obj = {
            "status" : $("#hstatus").val(),
            "page" : $("#page").val(),
            "uid" : $("#uid").val()
        }
    }
    var jsonStr = JSON.stringify(obj);
    var url = "/order/doQuery";
    var resObj = myAjax(jsonStr,url);
    loadDataToTable(resObj.object,r);
}

/**
 * 画表格
 * @param list
 * @param flag  角色标识
 */
function loadDataToTable(list,flag) {
    if(list.length == 0){
        tipMsg(2,"没有更多了");
        return;
    }
    for (var i = 0;i < list.length;i++){
        var tr = $('<tr></tr>');
        var td0 = $('<td></td>');
        var a0 = $('<a style="color: blue;cursor: pointer;">'+list[i].oNumber+'</a>');
        a0.attr("oid",list[i].id);
        a0.on('click',function () {
            var oid = $(this).attr('oid');
            detail(oid);
        });
        td0.append(a0);
        tr.append(td0);
        var td1 = $('<td></td>');
        var a1 = $('<a style="color: blue;cursor: pointer;">'+list[i].goods.gTitle+'</a></td>');
        a1.attr('gid',list[i].goods.id);
        a1.on('click',function () {
            var gid = $(this).attr('gid');
            goodsDetail(gid)
        });
        td1.append(a1);
        tr.append(td1);
        var td2 = $('<td>'+list[i].count+'</td>');
        tr.append(td2);
        var td3 = $('<td>'+list[i].payMoney+'</td>');
        tr.append(td3);
        var td4 = $('<td>'+list[i].cfTime+'</td>');
        tr.append(td4);
        if(flag == 'a'){
            var td5 = $('<td></td>');
            var a5 = $('<a style="color: blue;cursor: pointer;">'+list[i].merchant.mName+'</a>');
            a5.attr("mid",list[i].merchant.id);
            a5.on('click',function () {
                var mid = $(this).attr('mid');
                merchantDetail(mid,'c');
            });
            td5.append(a5);
            tr.append(td5);
        }
        var td6 = $('<td>'+list[i].conName+'</td>');
        tr.append(td6);
        var td7 = $('<td>'+getStatusName(list[i].status)+'</td>');
        tr.append(td7);
        var td8 = $('<td></td>');
        var a8 = $('<a style="margin: 0 10px;color: blue;cursor: pointer;" onclick="detail(${o.id})">详情</a>');
        a8.attr("oid",list[i].id);
        a8.on('click',function () {
            var oid = $(this).attr('oid');
            detail(oid);
        });
        td8.append(a8);
        if(flag == 'm' && list[i].status == '30'){
            var a82 = $('<a style="margin: 0 10px;color: blue;cursor: pointer;">确认发货</a>');
            a82.attr("oid",list[i].id);
            a82.on('click',function () {
                var oid = $(this).attr('oid');
                updateStatus(oid,'50');
            });
            td.append(a82);
        }
        tr.append(td8);
        $('#tbody').append(tr);
    }
    var page = $("#page").val();
    $("#page").val(parseInt(page) + 1);
}

/**
 * 获取状态名
 * @param status
 * @returns {string}
 */
function getStatusName(status) {
    var statusName = '';
    switch (status) {
        case '10':
            statusName = '待支付';
            break;
        case '30':
            statusName = '已支付';
            break;
        case '50':
            statusName = '已发货';
            break;
        case '60':
            statusName = '已签收';
            break;
    }
    return statusName;
}