layui.use('form', function() {
    var form = layui.form;
    layui.form.render('select', 'form');
});

/**
 * 返回
 * @param mid
 */
function back(mid) {
    window.location.href = base + '/goods/manage?mid='+mid;
}

var imgCount = 5;//限制上传五个图片

/**
 * 上传文件
 */
layui.use('upload', function(){
    var upload = layui.upload;
    //执行实例
    var uploadInst = upload.render({
        elem: '#uploadImgBtn' //绑定元素
        ,url: base + '/file/upload/' //上传接口
        ,done: function(data){
            console.log(data);
            showImg(data.object);
        }
        ,error: function(data){
            tipMsg(2,"系统异常");
        }
    });
});

/**
 * 上传图片成功反显图片
 * @param obj
 */
function showImg(obj){
    imgCount --;
    if(imgCount == 0){
        $("#uploadImgBtn").addClass("layui-btn-disabled");
        tipMsg(2,"最多可上传5张图片");
    }
    var div = $("<div style='margin: 0 5px;' class='layui-input-inline imgDiv' value='"+obj.uuid+"'></div>");
    var path = $("<input type='hidden' class='imgPath' value='/"+obj.src+"'/>");
    var title = $("<input type='hidden' class='imgTitle' value='"+obj.title+"'/>");
    var img = $("<img class='img-size' title='"+obj.title+"'>");
    img.attr("src","../"+obj.src);
    var close = $("<i class=\"layui-icon layui-icon-close-fill img-close\"></i>");
    close.attr("value",obj.uuid);
    close.on('click',function () {
        var uuid = $(this).attr("value");
        delImg(uuid);
    });
    div.append(path);div.append(title);div.append(img);div.append(close);
    $("#uploadDiv").append(div);
}

/**
 * 删除图片
 * @param uuid
 */
function delImg(uuid) {
    imgCount ++;
    $("#uploadImgBtn").removeClass("layui-btn-disabled");
    var arr = $('.imgDiv');
    for(var i=0;i<arr.length;i++){
        if(uuid == $(arr[i]).attr('value')){
            $(arr[i]).remove();
            return;
        }
    }
}

/**
 * 提交审核
 */
function doAdd() {
    if(!verify()) return false;
    //判断单价的规范性
    var price = $("#gPrice").val();
    if(!verifyDecimal(price)){
        tipMsg(2,'请输入规范的价格');
        return false;
    }
    //至少上传一张图片
    var arr = $('.imgPath');
    if(arr.length == 0){
        tipMsg(2,'至少上传一张图片');
        return;
    }
    //图片路径拼接
    var imgPath = '';
    for (var i=0;i<arr.length;i++){
        if(i == 0) imgPath += $(arr[i]).val();
        else imgPath += ',' + $(arr[i]).val();
    }
    //图片标题拼接
    arr = $('.imgTitle');
    var imgTitle = '';
    for (var i=0;i<arr.length;i++){
        if(i == 0) imgTitle += $(arr[i]).val();
        else imgTitle += ',' + $(arr[i]).val();
    }
    var obj = {
        "mid" : $("#mid").val(),
        "gTitle" : $("#gTitle").val(),
        "gAuthor" : $("#gAuthor").val(),
        "gPress" : $("#gPress").val(),
        "gInventory" : $("#gInventory").val(),
        "gPrice" : $("#gPrice").val(),
        "gDetail" : $("#gDetail").val(),
        "imgPath" : imgPath,
        "imgTitle" : imgTitle,
        "gType" : $("#type").val()
    }
    var jsonStr = JSON.stringify(obj);
    var url = '/goods/submit';
    var resObj = myAjax(jsonStr,url);
    var type = 2;
    var msg = resObj.code + ":" + resObj.msg;
    tipMsg(type,msg);
    back($("#mid").val());
}