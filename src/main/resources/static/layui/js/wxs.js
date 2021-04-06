/*全局的访问后台地址前缀*/
var vsteamhref="http://www.microteam.cn";
var appid='wx433535076cc4ae31';
var t_link="http://www.microteam.cn/agent";
// var t_link="https://www.vsteam.cn/vsteam/agent";
// var vsteamhref="http://mtdev.microteam.cn";//测试地址
// var appid='wxa69ce7f4c1bdcb57';//测试
// var t_link="http://mtdev.microteam.cn/vsteam/csagent";
function wxfun(){
	var wxlink=window.location.href;
	var datalink={
		url:wxlink
	}
	datalink=JSON.stringify(datalink);
	var logo=t_link+'/image/microteam_icon.jpg';
	var slink=t_link+'/index.html';
	$.ajax({
		url:vsteamhref+':8060/rest/wechat/getSign',
		contentType:'application/json',
		data:datalink,
		dataType:'json',
		type:'post',
		timeout:10000,
		success:function(data){
            if (data.code==200){
            	var wxdata=data.result;
            	// alert(wxdata);
				wx.config({
				    debug: false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
				    appId: appid, // 必填，公众号的唯一标识
				    timestamp: wxdata.timestamp, // 必填，生成签名的时间戳
				    nonceStr: wxdata.nonceStr, // 必填，生成签名的随机串
				    signature: wxdata.signature,// 必填，签名
				    jsApiList: [// 必填，需要使用的JS接口列表
				    	'checkJsApi',
				        'onMenuShareWeibo',
				        'hideMenuItems',
				        'showMenuItems',
				        'onMenuShareTimeline',
				        'onMenuShareAppMessage',
				        'hideAllNonBaseMenuItem',
				        'showAllNonBaseMenuItem',
				        'translateVoice',
				        'startRecord',
				        'stopRecord',
				        'onVoiceRecordEnd',
				        'playVoice',
				        'onVoicePlayEnd',
				        'pauseVoice',
				        'stopVoice',
				        'uploadVoice',
				        'downloadVoice',
				        'chooseImage',
				        'previewImage',
				        'uploadImage',
				        'downloadImage',
				        'getNetworkType',
				        'openLocation',
				        'getLocation',
				        'hideOptionMenu',
				        'showOptionMenu',
				        'closeWindow',
				        'scanQRCode',
				        'chooseWXPay',
				        'openProductSpecificView',
				        'addCard',
				        'chooseCard',
				        'openCard',
				        'updateAppMessageShareData',
				        'updateTimelineShareData'
				    ] 
				})
				wx.ready(function () {
				    // wx.hideOptionMenu();//隐藏右上角的菜单
				    wx.hideMenuItems({
					menuList: [ "menuItem:share:qq","menuItem:share:weiboApp","menuItem:share:QZone"] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
					});
					//自定义“分享给朋友”及“分享到QQ”按钮的分享内容
				    wx.onMenuShareAppMessage({ 
				        title: '微队中国区代理开放申请', // 分享标题
				        desc: '捷“足”先登！微队AI足球黑科技中国区各省市代理已开放申请!', // 分享描述
				        link: slink, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
				        imgUrl: logo, // 分享图标
				        type: '', // 分享类型,music、video或link，不填默认为link
						dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
				        success:function(){

				        }
					});
					//自定义“分享到朋友圈”及“分享到QQ空间”按钮的分享内容
					wx.updateTimelineShareData({ 
				        title: '微队中国区代理开放申请', // 分享标题
				        link:slink, // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
				        imgUrl: logo, // 分享图标
				        success:function(){

				        }
					});
				})
			}
		}
	})
}
wxfun();