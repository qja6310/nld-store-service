layui.use('form', function() {
    var form = layui.form;
    layui.form.render('select', 'form');
    layui.form.render('radio', 'form');
});
/**
 * 添加地址信息
 */
function addAddr() {
    var tr = $("<tr class=\"addrTr\" value=\""+$('#addrLen').val()+"\"></tr>");
    var td0 = $("<td style='text-align: center'><input type=\"radio\" name=\"addr\" value=\""+$('#addrLen').val()+"\" title=\"\"></td>");
    var td1 = $("<td><input class='layui-input' id='conname'/></td>");
    var td2 = $("<td><input class='layui-input' id='conphone'/></td>");
    var td3 = $("<td><input class='layui-input' id='conaddr'/></td>");
    tr.append(td0);
    tr.append(td1);
    tr.append(td2);
    tr.append(td3);
    $("#addAddrTr").before(tr);
    $("#addAddrTr").remove();
}

/**
 * 支付
 */
function toPay() {
    var conName='';
    var conPhone='';
    var conAddr='';
    var val = $("#tbody input[name='addr']:checked").val();
    if(val == undefined || val == ''){
        tipMsg(2,"请选择收货地址");
        return false;
    }
    var len = $('#addrLen').val();
    if(val == len){
        conName = $('#conname').val();
        conPhone = $('#conphone').val();
        conAddr = $('#conaddr').val();
    }else{
        var trs = $('.addrTr');
        for(var i=0;i<trs.length;i++){
            if(val==$(trs[i]).attr('value')){
                conName = $(trs[i]).find('td').eq(1).text();
                conPhone = $(trs[i]).find('td').eq(2).text();
                conAddr = $(trs[i]).find('td').eq(3).text();
                break;
            }
        }
    }
    var payWay = $("input[name='payWay']:checked").val();
    if("alipay" == payWay){
        window.location.href = base + "/order/toPay/alipay?uid="+$('#uid').val()+"&mid="+$('#mid').val()
            +"&gid="+$('#gid').val()
            +"&count="+$('#count').val()
            +"&payMoney="+$('#payMoney').val()
            +"&remark="+$('#remark').val()
            +"&conName="+conName
            +"&conPhone="+conPhone
            +"&conAddr="+conAddr;
    }else{
        var obj = {
            "uid" : $('#uid').val(),
            "mid" : $('#mid').val(),
            "gid" : $('#gid').val(),
            "count" : $('#count').val(),
            "payMoney" : $('#payMoney').val(),
            "remark" : $('#remark').val(),
            "conName" : conName,
            "conPhone" : conPhone,
            "conAddr" : conAddr,
        }
        var jsonStr = JSON.stringify(obj);
        var url = base + "/order/toPay/nldpay";
        var resObj = myAjax(jsonStr,url);
        debugger;
        if(resObj.code == 'O00'){
            var oid = resObj.object;
            $('#mainContontDiv').load(base + '/order/detail?oid='+oid+'&r=u');
        }else{
            tipMsg(2,resObj.msg);
            return false;
        }
    }
}