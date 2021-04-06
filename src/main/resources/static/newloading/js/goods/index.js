layui.use('form', function() {
    var form = layui.form;
    layui.form.render('select', 'form');
    layui.form.render('checkbox', 'form');
});

/** 查询 */
function doQueryGoods() {
    var keyword = $("#keyword").val();
    var mid = $("#mid").val();
    //拼接复选框id
    var typeIds="";
    var types = $(".type");
    for(var i=0;i<types.length;i++){
        if($(types[i]).prop("checked")){
            typeIds += $(types[i]).val()+",";
        }
    }
    if(typeIds != '') typeIds = typeIds.substring(0,typeIds.length - 1);
    $('#mainContontDiv').load(base + '/goods/index?keyword='+keyword+'&mid='+mid+'&typeIds='+typeIds);
}

/** 继续加载商品 */
function doLoadingGoods() {
    var keyword = $("#hkeyword").val();
    var mid = $("#mid").val();
    var page = $("#page").val();
    var obj = {
        "keyword" : keyword,
        "mid" : mid,
        "page" : page,
        "typeIds" : $("#htypeIds").val()
    }
    var jsonStr = JSON.stringify(obj);
    var url = "/goods/user/doQuery";
    var resObj = myAjax(jsonStr,url);
    loadDataToDiv(resObj.object);
}

/**
 * 加载数据显示
 * @param goodsList
 */
function loadDataToDiv(goodsList) {
    if(goodsList.length == 0){
        tipMsg(2,'没有更多了');
        return;
    }
    for(var i = 0;i < goodsList.length;i++){
        var div = $('<div className="layui-col-md2"></div>');
        var card = $('<div className="layui-card"></div>');
        var body = $('<div className="layui-card-body" style="text-align: center;"></div>');
        var img = $('<img style="width: 180px;height: 220px;" src="<%=request.getContextPath() %>'+goodsList[i].imgPath+'" alt="'+goodsList[i].imgTitle+'">');
        body.append(img);
        var header = $('<div className="layui-card-header">'+goodsList[i].gTitle+'<br />'+ goodsList[i].gPrice +'</div>');
        card.append(body);
        card.append(header);
        div.append(card);
        $("#goodsDiv").append(div);
    }
}

/**
 * 商品详情
 * @param id
 */
function purchase(id) {
    $('#mainContontDiv').load(base + '/goods/purchase?id='+id);
}