$('#homes dd a').click(function(){
    return false;
})
layui.use(['element', 'layer'],function(){
    var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块
    var layer = layui.layer;
    //监听导航点击及生成选项卡（已存在则切换到该选项卡）
    var tabArr=[];
    element.on('nav(test)', function(elem){
        // console.log(elem.attr('fid'));
        var str=elem.html();
        var fid=elem.attr('fid');
        var href=elem.attr('href');
        if (tabArr.length>20) {
            layer.msg('已达到最大上线20');
        }
        if (tabArr.indexOf(fid)==-1&&fid!=undefined) {//不存在
            tabArr.push(fid);
            element.tabAdd('tess', {
                title: str
                ,content: '<iframe width="100%" height="100%" frameborder="no" border="0" marginwidth="0" marginheight="0"   src="' + href + '"></iframe>' //支持传入html
                ,id: fid
            });
            element.tabChange('tess', fid);//选项卡切换
        }else{
            element.tabChange('tess', fid);
        }
        element.on('tabDelete(tess)', function(data){
            //console.log($(this).parent().attr('lay-id')); //当前Tab标题所在的原始DOM元素
            for (var i = 0; i < tabArr.length; i++) {
                if(tabArr[i]==$(this).parent().attr('lay-id')){
                    tabArr.splice(i,1);
                }

            }
        });
        
    });
});
// $('#agent_sel dd').click(function(){
// 	console.log($(this).index());
// 	var ind=$(this).index();
// 	$('#agent_con>div').css('display','none');
// 	$('#agent_con>div').eq(ind).css('display','block');
// })

