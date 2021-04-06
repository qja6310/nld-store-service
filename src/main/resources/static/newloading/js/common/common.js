/**
 * 表单验证
 * @returns {boolean}
 */
function verify() {
    var arr = $(".verify");
    for(var i = 0;i < arr.length;i++){
        if($(arr[i]).val().trim() == ''){
            var msg = $(arr[i]).attr("placeholder");
            tipMsg(2,msg);
            return false;
        }
    }
    return true;
}

/**
 * 统一请求ajax  同步
 * @param jsonStr
 * @param url  请求地址
 */
function myAjax(jsonStr,url) {
    var result;
    var done = false;
    $.ajax({
      async: false,
      type: "post",
      url: base + url,
      data: {
          "params": jsonStr
      },
      dataType: "json",
      success: function (data) {
          done = true;
          result =  data;
      },
      error: function (data) {
          tipMsg(2,"操作失败");
          return;
      },
    });
    if(done) return result;
}

/**
 * 弹框
 * @param type
 * @param msg
 * @param time
 */
function tipMsg(type,msg,time) {
    if(time == undefined || time == '') time = 2000;
    layer.msg(msg, {
        icon: type,
        time: time,
    });
}

/**
 * 验证是否为decimal
 * @param price
 */
function verifyDecimal(price) {
    var p;
    try{
        if(price.indexOf('.') > 0){
            p = price.substring(price.indexOf('.') + 1,price.length);
            if(p.length > 2) return false;
        }
        p = parseFloat(price);
        if($.isNumeric(p)) return true;
        return false;
    }catch (e) {
        return false;
    }
}