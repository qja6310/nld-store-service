layui.use('form', function() {
    var form = layui.form;
});

function toAdd() {
    window.location.href = base + "/goods/toAdd?mid="+$("#mid").val();
}

/** 查询 */
function doQuery() {
    window.location.href = base + "/goods/manage?mid="+$("#mid").val()
        +"&keyword="+$("#keyword").val()+"&status="+$("#status").val()
        +"&type="+$("#type").val();
}
/** 继续加载数据 */
function doLoading() {
    var obj = {
        "mid" : $("#mid").val(),
        "keyword" : $("#hkeyword").val(),
        "status" : $("#hstatus").val(),
        "page" : $("#page").val(),
        "roleFlag" : $("#roleFlag").val(),
        "type" : $("#htype").val()
    }
    var jsonStr = JSON.stringify(obj);
    var url = "/goods/doQuery";
    var resObj = myAjax(jsonStr,url);
    loadDataToTable(resObj.object);
    var page = $("#page").val();
    $("#page").val(parseInt(page) + 1);
}

/**
 * 加载数据进表格
 * @param admins
 */
function loadDataToTable(goodsList) {
    if(goodsList.length == 0){
        tipMsg(2,'没有更多了');
        return;
    }
    var seq = $("#tbody tr").length;
    for(var i = 0;i < goodsList.length;i++){
        seq ++;
        var tr = $("<tr></tr>");
        var td1 = $("<td>"+seq+"</td>");
        var td2 = $("<td>"+goodsList[i].gTitle+"</td>");
        var td3 = $("<td>"+goodsList[i].gPrice+"</td>");
        var td4 = $("<td>"+goodsList[i].gInventory+"</td>");
        var td5 = $("<td>"+goodsList[i].gAuthor+"</td>");
        var td6 = $("<td>"+goodsList[i].gPress+"</td>");
        var status = getStatus(goodsList[i].status);
        var td7 = $("<td>"+status+"</td>");
        var td8 = $("<td></td>");
        var a1 = $("<a style=\"margin: 0 10px;color: blue;cursor: pointer;\">查看</a>");
        a1.attr("gid",goodsList[i].id);
        a1.on('click',function () {
            var id = $(this).attr('gid');
            detail(id);
        });
        td8.append(a1);
        if(goodsList[i].status == '50' || goodsList[i].status == '80' ||  goodsList[i].status == '70'){
            var txt = '';
            var type = '';
            if(goodsList[i].status == '50' || goodsList[i].status == '80'){
                txt = '上架';
                type = '70';
            }else if(goodsList[i].status == '70'){
                txt = '下架';
                type = '80';
            }
            var a2 = $("<a style=\"margin: 0 10px;cursor: pointer;\">"+txt+"</a>");
            if(goodsList[i].status == '70') a2.css("color","orangered");
            else a2.css("color","blue");
            a2.attr("gid",goodsList[i].id);
            a2.attr("tp",type);
            a2.on('click',function () {
                var id = $(this).attr('mid');
                var tp = $(this).attr('tp');
                updateStatus(id,tp);
            });
            td8.append(a2);
        }
        var a3 = $("<a style=\"margin: 0 10px;color: orangered;cursor: pointer;\">删除</a>");
        a3.attr("gid",goodsList[i].id);
        a3.on('click',function () {
            var id = $(this).attr('gid');
            delGoods(id);
        });
        td8.append(a3);

        tr.append(td1);tr.append(td2);tr.append(td3);tr.append(td4);tr.append(td5);tr.append(td6);tr.append(td7);tr.append(td8);
        $("#tbody").append(tr);
    }
}

function getStatus(status) {
    var name = '';
    switch (status) {
        case '10' :
            name = '已提交';
            break;
        case '30' :
            name = '待审核';
            break;
        case '50' :
            name = '审核通过';
            break;
        case '60' :
            name = '审核不通过';
            break;
        case '70' :
            name = '已上架';
            break;
        case '80' :
            name = '已下架';
            break;
        case '90' :
            name = '强制下架';
            break;
    }
    return name;
}

/**
 *
 * 详情
 * @param id
 * @param tp
 */
function detail(id) {
    window.location.href=base + '/goods/edit?id='+id+'&mid='+$('#mid').val();
}

/**
 * 上下架
 * @param id
 * @param status
 */
function updateStatus(id,status) {
    var msg = '是否确认下架?';
    if(status == '70') msg = '是否确认上架';
    if(status == '90') msg = '是否强制下架';
    var url = '/goods/update';
    var obj = {
        'id' : id,
        'status' : status
    }
    var jsonStr = JSON.stringify(obj);
    request(msg,url,jsonStr);
}

/**
 * 删除
 * @param id
 */
function delGoods(id) {
    var msg = '是否确认删除?';
    var url = '/goods/delete';
    request(msg,url,id);
}

/**
 * 请求
 * @param msg
 * @param url
 * @param param
 */
function request(msg,url,param) {
    layer.confirm(msg, {
        icon : 3,
        title : '提示'
    }, function(index) {
        layer.close(index);
        var resObj = myAjax(param,url);
        var type = 2;
        msg = resObj.code + ':' + resObj.msg;
        if('G00' == resObj.code) type = 1;
        tipMsg(type,msg);
        doQuery();
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