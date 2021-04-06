// var vhtml="http://www.microteam.cn";
var vhtml="http://mtdev.microteam.cn";
$.ajax({
        url:vhtml+':8060/rest/agent/getAgentInfo?page=1&pageSize=10&character=enterprise&language=english',
        contentType: "application/json",
        dataType: 'json', //服务器返回json格式数据
        type: 'get', //HTTP请求类型
        timeout: 10000, //超时时间设置为10秒；
        success: function (json){
            if (json.code==200) {
                var html = json.result;
                console.log(html);
                c_page(html.total);
            }else{
                alert('获取数据失败');
            }
        }
})
function companydata(page_num=1){
    $.ajax({
        url:vhtml+':8060/rest/agent/getAgentInfo?page='+page_num+'&pageSize=10&character=enterprise&language=english',
        contentType: "application/json",
        dataType: 'json', //服务器返回json格式数据
        type: 'get', //HTTP请求类型
        timeout: 10000, //超时时间设置为10秒；
        success: function (json){
           
        }
    })
}
companydata();
function c_page(num){
    layui.use(['laypage'], function(){
        var laypage = layui.laypage
        ,layer = layui.layer;
        laypage.render({
            elem: 'company_page'
            ,count: num //数据总数
            ,jump: function(obj){
              // console.log(obj);
              companydata(obj.curr);

            }
        })
    })
}
