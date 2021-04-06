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
                $('#mainContontDiv').load(base + '/order/detail?oid='+oid);
            }else if($("#r").val() == 'm'){
                window.location.href=base+'/order/detail?oid='+oid+'&r=m&mid='+$('#mid').val();
            }
        }
    });
}

function back() {
    window.location.href=base+'/order/list?mid='+$('#mid').val();
}