package cn.com.newloading.controller;

import cn.com.newloading.bean.TGoods;
import cn.com.newloading.bean.TMerchant;
import cn.com.newloading.bean.TOrder;
import cn.com.newloading.bean.TUser;
import cn.com.newloading.service.GoodsService;
import cn.com.newloading.service.MerchantService;
import cn.com.newloading.service.OrderService;
import cn.com.newloading.service.UserService;
import cn.com.newloading.utils.Alipay;
import cn.com.newloading.utils.Common;
import cn.com.newloading.utils.DateUtil;
import cn.com.newloading.utils.Result;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/order")
public class OrderController extends BaseController {

    @Autowired
    GoodsService goodsService;
    @Autowired
    UserService userService;
    @Autowired
    MerchantService merchantService;
    @Autowired
    OrderService orderService;

    @RequestMapping("/list")
    public String list(HttpServletRequest request,Model model){
        String uid = request.getParameter("uid");
        String mid = request.getParameter("mid");
        String status = request.getParameter("status");//状态
        String oNumber = request.getParameter("oNumber");//订单号
        String mName = request.getParameter("mName");//商家名称
        if(Common.isBlank(status)) status=null;
        if(Common.isBlank(oNumber)) oNumber=null;
        String r = "";
        if(!Common.isBlank(uid)) r="u";
        if(!Common.isBlank(mid)) r="m";
        if(Common.isBlank(uid)&&Common.isBlank(mid)) r="a";
        model.addAttribute("r",r);
        TOrder order = new TOrder();
        order.setuId(Common.isBlank(uid) ? null : Long.valueOf(uid));
        order.setStatus(status);
        order.setmId(Common.isBlank(mid) ? null : Long.valueOf(mid));
        order.setoNumber(oNumber);
        order.setmName(mName);
        order.setPage(Common.PAGE);
        order.setLimit(Common.LIMIT);
        order.setBegin((order.getPage() - 1) * order.getLimit());
        List<TOrder> list = orderService.list(order);
        model.addAttribute("status",status);
        model.addAttribute("oNumber",oNumber);
        model.addAttribute("list",list);
        model.addAttribute("mid",mid);
        model.addAttribute("mName",mName);
        model.addAttribute("page",order.getPage());
        if("u".equals(r)) return "order/listForUser";
        return "order/list";
    }

    @RequestMapping("/doQuery")
    @ResponseBody
    public Result doQuery(HttpServletRequest request){
        JSONObject jsonObject = (JSONObject) getParams(request);
        String uid = jsonObject.getString("uid");
        String mid = jsonObject.getString("mid");
        String status = jsonObject.getString("status");//状态
        String oNumber = jsonObject.getString("oNumber");//订单号
        String mName = jsonObject.getString("mName");//商家名称
        String page = jsonObject.getString("page");//商家名称
        TOrder order = new TOrder();
        order.setuId(Common.isBlank(uid) ? null : Long.valueOf(uid));
        order.setStatus(Common.isBlank(status) ? null : status);
        order.setmId(Common.isBlank(mid) ? null : Long.valueOf(mid));
        order.setoNumber(Common.isBlank(oNumber) ? null : oNumber);
        order.setmName(Common.isBlank(mName) ? null : mName);
        order.setPage(Integer.valueOf(page));
        order.setLimit(Common.LIMIT);
        order.setBegin(order.getPage() * order.getLimit());
        List<TOrder> list = orderService.list(order);
        //时间格式转换
        for(TOrder o : list){
            o.setCfTime(DateUtil.dateToString(o.getcTime()));
        }
        return new Result("O00","成功",list);
    }

    @RequestMapping("/buy")
    public String buy(HttpServletRequest request, Model model){
        TUser user = (TUser) request.getSession().getAttribute("user");
        String gid = request.getParameter("gid");
        String count = request.getParameter("count");
        if(user == null){//如果用户没有登录要回到登录页
            //如果重新登录直接进购买页面
            String url = "/order/buy?gid="+gid+"&count="+count;
            request.getSession().setAttribute("url",url);
            String httpPrefix = request.getContextPath();
            return "redirect:"+httpPrefix+"/user/login";
        }
        TGoods goods = goodsService.purchase(gid);
        if(goods == null){
            model.addAttribute("msg","该商品已下架");
            request.getSession().removeAttribute("url");
            return "system/error";
        }
        goods.setImgPath(goods.getImgList().get(0).getImgUrl());
        goods.setImgTitle(goods.getImgList().get(0).getImgTitle());

        TMerchant merchant = merchantService.getMerchant(String.valueOf(goods.getmId()));
        model.addAttribute("merchant",merchant);

        user = userService.getUser(String.valueOf(user.getId()));
        model.addAttribute("goods",goods);
        model.addAttribute("user",user);
        double price = goods.getgPrice().doubleValue();
        Integer c = Integer.valueOf(count);
        if(c > goods.getgInventory()){
            c = goods.getgInventory();
            model.addAttribute("msg","当前库存仅剩"+c+"件");
        }
        double payMoney = c * price;
        model.addAttribute("count",c);
        model.addAttribute("payMoney",payMoney);
        model.addAttribute("addrLen",user.getAddressList().size());
        return "order/buy";
    }

    /**
     * ali支付
     * @param req
     * @param response
     */
    @RequestMapping(value = "/toPay/alipay")
    public void toPay(HttpServletRequest req, HttpServletResponse response)throws Exception {
        /**
         * 先查询订单，如果订单不存在，再创建订单
         */
        TOrder order = null;
        String oid = req.getParameter("oid");
        if(!Common.isBlank(oid)){
            order = orderService.getOrder(oid);
            req.getSession().setAttribute("order",order);//存到session，回调时需要用到
        }else{
            //创建订单
            order = createOrder(req);
        }
        Alipay alipay = new Alipay(order.getoNumber(),order.getPayMoney(),order.getoNumber());
        AliPayController.useAlipay(req,response,alipay,"/order/callBack");
    }

    @RequestMapping(value = "/toPay/nldpay")
    @ResponseBody
    public Result toPay(HttpServletRequest req){
        /** 先查询订单，如果订单不存在，再创建订单*/
        TOrder order = null;
        String oid = req.getParameter("oid");
        if(!Common.isBlank(oid)){
            order = orderService.getOrder(oid);
        }else{
            JSONObject jsonObject = (JSONObject) getParams(req);
            String gid = jsonObject.getString("gid");
            String mid = jsonObject.getString("mid");
            order = new TOrder();
            order.setgId(Long.valueOf(gid));
            order.setmId(Long.valueOf(mid));
            order.setuId(Long.valueOf(jsonObject.getString("uid")));
            order.setCount(Integer.valueOf(jsonObject.getString("count")));
            order.setPayMoney(jsonObject.getString("payMoney"));
            order.setoRemark(jsonObject.getString("remark"));
            order.setConName(jsonObject.getString("conName"));
            order.setConPhone(jsonObject.getString("conPhone"));
            order.setConAddr(jsonObject.getString("conAddr"));
        }
        //todo  支付订单
        Result result = orderService.nldpay(order);
        logger.info("==========返回:" + result.toString());
        return result;
    }

    /**
     * 创建订单
     * @param request
     * @return
     */
    public TOrder createOrder(HttpServletRequest request){
        String gid = request.getParameter("gid");
        String mid = request.getParameter("mid");
        TOrder order = new TOrder();
        order.setgId(Long.valueOf(gid));
        order.setmId(Long.valueOf(mid));
        order.setuId(Long.valueOf(request.getParameter("uid")));
        order.setCount(Integer.valueOf(request.getParameter("count")));
        order.setPayMoney(request.getParameter("payMoney"));
        order.setoRemark(request.getParameter("remark"));
        order.setConName(request.getParameter("conName"));
        order.setConPhone(request.getParameter("conPhone"));
        order.setConAddr(request.getParameter("conAddr"));
        order.setPayWay("alipay");
        order = orderService.createOrder(order);
        request.getSession().setAttribute("order",order);//存到session，回调时需要用到
        return order;
    }

    /**
     * 支付成功回调
     * @param request
     * @return
     */
    @RequestMapping("/callBack")
    public String callBack(HttpServletRequest request,Model model){
        TOrder order = (TOrder) request.getSession().getAttribute("order");
        String httpPrefix = request.getContextPath();
        httpPrefix = httpPrefix.replace("order/","");
        if(order == null){
            model.addAttribute("msg","发生异常");
            return "redirect:" + httpPrefix + "/system/userIndex";
        }
        Result result = orderService.updateStatus(String.valueOf(order.getId()), "30","支付成功，等待发货");
        if("O00".equals(result.getCode())){//付款成功
            String oid = String.valueOf(order.getId());
            String url = "/order/detail?oid="+oid+"&r=u";
            request.getSession().setAttribute("url",url);
            request.getSession().removeAttribute("order");
        }else{
            model.addAttribute("msg","修改状态失败");
        }
        return "redirect:" + httpPrefix + "/system/userIndex";
    }

    /**
     * 订单详情
     * @param request
     * @return
     */
    @RequestMapping("/detail")
    public String detail(HttpServletRequest request,Model model){
        String oid = request.getParameter("oid");
        Map<String, Object> map = orderService.detail(oid);
        String r = request.getParameter("r");
        String mid = "";
        if("m".equals(r)) mid = request.getParameter("mid");
        model.addAttribute("order",map.get("order"));
        model.addAttribute("merchant",map.get("merchant"));
        model.addAttribute("progressList",map.get("progressList"));
        model.addAttribute("goods",map.get("goods"));
        model.addAttribute("r",r);
        model.addAttribute("mid",mid);
        if("u".equals(r)) return "order/detailForUser";
        return "order/detail";
    }

    @RequestMapping("/updateStatus")
    @ResponseBody
    public Result updateStatus(HttpServletRequest request){
        JSONObject jsonObject = (JSONObject) getParams(request);
        return orderService.updateStatus(jsonObject.getString("oid"),
                jsonObject.getString("status"),jsonObject.getString("opRemark"));
    }

    @RequestMapping("/sales")
    public String sales(HttpServletRequest request,Model model){
        String midStr = request.getParameter("mid");
        String year = request.getParameter("year");
        if(Common.isBlank(year)) year = DateUtil.currentYear();
        Long mid = Common.isBlank(midStr) ? null : Long.valueOf(midStr);
        Map<String, Object> map = orderService.sales(mid, Integer.valueOf(year));
        model.addAttribute("year",year);
        model.addAttribute("sum",map.get("sum"));
        model.addAttribute("count",map.get("count"));
        model.addAttribute("cje",map.get("cje"));//成交额
        model.addAttribute("ddl",map.get("ddl"));//成交订单量
        model.addAttribute("month",map.get("month"));//成交订单量
        if(!Common.isBlank(midStr)) model.addAttribute("mid",mid);
        return "order/sales";
    }
}
