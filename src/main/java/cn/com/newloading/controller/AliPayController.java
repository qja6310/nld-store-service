package cn.com.newloading.controller;

import cn.com.newloading.config.AlipayConfig;
import cn.com.newloading.utils.Alipay;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

@Controller
@RequestMapping("/alipay")
public class AliPayController extends BaseController{

    public static void useAlipay(HttpServletRequest req, HttpServletResponse response, Alipay alipay,String callBackUrl) throws Exception{
        req.getSession().setAttribute("alipay_callback_url",callBackUrl);
        //获得初始化的AlipayClient
        AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);

        //设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(AlipayConfig.return_url);
        alipayRequest.setNotifyUrl(AlipayConfig.notify_url);

        //商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = alipay.getOrderNo();
//        付款金额，必填
        String total_amount = alipay.getOrderMoney();
        //订单名称，必填
        String subject = alipay.getObjName();
        //商品描述，可空
        String body = alipay.getRemark();

        alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\","
                + "\"total_amount\":\""+ total_amount +"\","
                + "\"subject\":\""+ subject +"\","
                + "\"body\":\""+ body +"\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

        //请求
        String result = alipayClient.pageExecute(alipayRequest).getBody();

        response.setCharacterEncoding("UTF-8");//设置将字符以"UTF-8"编码输出到客户端浏览器
        //通过设置响应头控制浏览器以UTF-8的编码显示数据
        response.setHeader("content-type", "text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.write(result);
    }

    /**
     * 支付成功回调
     * @param request
     * @return
     */
    @RequestMapping("/callBack")
    public String callBack(HttpServletRequest request){
        String callBackUrl = (String) request.getSession().getAttribute("alipay_callback_url");
        String httpPrefix = request.getContextPath();
        httpPrefix = httpPrefix.replace("alipay/","");
        callBackUrl = callBackUrl.indexOf("/") == 0 ? callBackUrl : "/"+callBackUrl;
        return "redirect:" + httpPrefix + callBackUrl;
    }
}