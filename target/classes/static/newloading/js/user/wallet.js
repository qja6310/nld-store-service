/** 提现 */
function wytx(type) {
    if(type == 'O'){
        $('#czDiv').hide();
        $('#txDiv').show();
    }
    else $('#txDiv').hide();
}

/** 充值 */
function wycz(type) {
    if(type == 'O'){
        $('#txDiv').hide();
        $('#czDiv').show();
    }
    else $('#czDiv').hide();
}

/** 确认充值 */
function qrcz() {
    var czmoney = $("#czmoney").val();
    if(czmoney == ''){
        tipMsg(2,"请输入充值金额");
        return false;
    }
    if(!verifyDecimal(czmoney)){
        tipMsg(2,"请输入正确的金额");
        return false;
    }
    window.location.href = base + "/user/recharge?uid="
        +$('#uid').val()
        +"&money="+czmoney;
}

/**确认提现*/
function qrtx() {
    var cardNo = $("#cardNo").val();
    if(cardNo == ''){
        tipMsg(2,"请输入银行卡号");
        return false;
    }
    var txmoney = $("#txmoney").val();
    if(txmoney == ''){
        tipMsg(2,"请输入提现金额");
        return false;
    }
    if(!verifyDecimal(txmoney)){
        tipMsg(2,"请输入正确的金额");
        return false;
    }
    var obj = {
        'txmoney':txmoney,
        'cardNo':cardNo,
        'uid':$('#uid').val()
    }
    var jsonStr = JSON.stringify(obj);
    var url = "/user/tx";
    var resObj = myAjax(jsonStr,url);
    if(resObj.code == 'U00'){
        $('#mainContontDiv').load(base + '/user/wallet?uid='+$('#uid').val());
    }else{
        tipMsg(2,resObj.msg);
        return false;
    }
}