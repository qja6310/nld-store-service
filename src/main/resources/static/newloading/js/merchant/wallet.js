layui.use('form', function() {
    var form = layui.form;
    layui.form.render('select', 'form');
});
/** 提现展示 */
function wytx(type) {
    if('O' == type) $('#txDiv').css("display","block");
    else $('#txDiv').css("display","none");
}

/** 确认提现 */
function qrtx() {
    if(!verify()) return false;
    var money = $('#money').val();
    if(!verifyDecimal(money)){
        tipMsg(2,"请输入正确的金额");
        return false;
    }
    //余额是否充足
    if(parseFloat($('#yue').val()) < parseFloat(money)){
        tipMsg(2,"余额不够");
        return false;
    }
    layer.confirm("是否确认提现?", {
        icon : 3,
        title : '提示'
    }, function(index) {
        layer.close(index);
        var obj = {
            "mid" : $("#mid").val(),
            "money" : money,
            "cardNo" : $("#cardNo").val()
        }
        var jsonStr = JSON.stringify(obj);
        var url = "/merchant/withdraw";
        var resObj = myAjax(jsonStr,url);
        var type = 2;
        var msg = resObj.code + ":" + resObj.msg;
        if(resObj.code == 'M00') type = 1;
        tipMsg(type,msg);
        if(resObj.code == 'M00'){
            window.location.href = base + "/merchant/wallet?id="+$("#mid").val();
        }
    });
}