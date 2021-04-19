package cn.com.newloading.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.newloading.bean.TAddress;
import cn.com.newloading.bean.TUser;
import cn.com.newloading.bean.UserWalletRecord;
import cn.com.newloading.utils.Alipay;
import cn.com.newloading.utils.DateUtil;
import cn.com.newloading.utils.Result;
import com.alibaba.fastjson.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;

import cn.com.newloading.service.UserService;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController extends BaseController{

	private Logger looger = LoggerFactory.getLogger(getClass());

	@Autowired
	private UserService userService;


	/**
	 * 注册页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/register")
	public String register(HttpServletRequest request, Model model){
		looger.info("==============进入注册页面");
		return "user/register";
	}

	/**
	 * 注册业务
	 * @param request
	 * @return
	 */
	@RequestMapping("/doRegister")
	@ResponseBody
	public Result doRegister(HttpServletRequest request){
		TUser user = new TUser();
		//用户注册参数
		String uName = request.getParameter("uName");
		String uPwd = request.getParameter("uPwd");
		String uAcc = request.getParameter("uAcc");
		String uIdentity = request.getParameter("uIdentity");
		String uPhone = request.getParameter("uPhone");
		String uEmail = request.getParameter("uEmail");
		user.setuAcc(uAcc);
		user.setuEmail(uEmail);
		user.setuIdentify(uIdentity);
		user.setuName(uName);
		user.setuPwd(uPwd);
		user.setuPhone(uPhone);
		//收货地址的新增
		String addrJsonStr = request.getParameter("addrJsonStr");//收货地址添加为数组，使用json传参
		return userService.doRegister(user, addrJsonStr);
	}

	/**
	 * 登录页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/login")
	public String login(HttpServletRequest request, Model model){
		TUser user = (TUser) request.getSession().getAttribute("user");
		if(user == null){
			return "user/login";
		}
//		String url = (String) request.getSession().getAttribute("url");
		String httpPrefix = request.getContextPath();
		return "redirect:" + httpPrefix + "/system/userIndex";
	}

	/**
	 * 登录动作
	 * @param request
	 * @return
	 */
	@RequestMapping("/doLogin")
	@ResponseBody
	public Result doLogin(HttpServletRequest request){
		String uAcc = request.getParameter("uAcc");
		String uPwd = request.getParameter("uPwd");
		TUser tUser = userService.doLogin(uAcc, uPwd);
		if(tUser == null){
			return new Result("U88","账号或密码错误，登录失败!");
		}else{
			request.getSession().setAttribute("user",tUser);
			return new Result("U00","登录成功");
		}
	}

	@RequestMapping("/logout")
	public String logout(HttpServletRequest request){
		request.getSession().removeAttribute("user");
		request.getSession().removeAttribute("url");
		String httpPrefix = request.getContextPath();
		return "redirect:" + httpPrefix + "/system/userIndex";
	}

	/**
	 * 编辑页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/edit")
	public String edit(HttpServletRequest request,Model model){
		String id = request.getParameter("uid");
		TUser user = userService.getUser(id);
		model.addAttribute("user",user);
		int addrLen = 0;
		if(user.getAddressList() != null) addrLen = user.getAddressList().size();
		model.addAttribute("addrLen",addrLen);
		return "user/edit";
	}

	/**
	 * 编辑动作
	 * @param request
	 * @return
	 */
	@RequestMapping("/doEdit")
	@ResponseBody
	public Result doEdit(HttpServletRequest request){
		TUser user = new TUser();
		JSONObject jsonObject = (JSONObject) getParams(request);
		//用户修改参数
		String id = jsonObject.getString("id");
		String uName = jsonObject.getString("uName");
		String uPwd = jsonObject.getString("uPwd");
		String uAcc = jsonObject.getString("uAcc");
		String uIdentity = jsonObject.getString("uIdentity");
		String uPhone = jsonObject.getString("uPhone");
		String uEmail = jsonObject.getString("uEmail");
		user.setId(Long.valueOf(id));
		user.setuAcc(uAcc);
		user.setuEmail(uEmail);
		user.setuIdentify(uIdentity);
		user.setuName(uName);
		user.setuPwd(uPwd);
		user.setuPhone(uPhone);
		//收货地址的新增
		String addrJsonStr = jsonObject.getString("addrJsonStr");//收货地址添加为数组，使用json传参
		Result result = userService.doEdit(user, addrJsonStr);
		//修改信息成功，刷新session中的信息
		if("U00".equals(result.getCode())){
			request.getSession().setAttribute("user",user);
		}
		return result;
	}

	@RequestMapping("/isLogin")
	@ResponseBody
	public Result isLogin(HttpServletRequest request){
		TUser user = (TUser) request.getSession().getAttribute("user");
		if(user != null) return new Result("U00","");
		String url = (String) getParams(request);
		request.getSession().setAttribute("url",url);
		return new Result("U99","");
	}

	@RequestMapping("/wallet")
	public String myWallet(HttpServletRequest request,Model model){
		String uid = request.getParameter("uid");
		Map<String, Object> map = userService.wallet(uid);
		model.addAttribute("data",map);
		model.addAttribute("uid",uid);
		return "user/wallet";
	}

	@RequestMapping("/recharge")
	public void recharge(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String uid = request.getParameter("uid");
		String money = request.getParameter("money");
		UserWalletRecord record = new UserWalletRecord();
		record.setUid(Long.valueOf(uid).longValue());
		record.setMoney(BigDecimal.valueOf(Double.valueOf(money)));
		request.getSession().setAttribute("user_wallet_record",record);
		String no = DateUtil.dateToString(new Date(),"yyyyMMddhhmmssSSS");
		String name = "充值我的钱包";
		Alipay alipay = new Alipay(no,money,name);
		String callBackUrl = "/user/recharge/callBack";
		AliPayController.useAlipay(request,response,alipay,callBackUrl);
	}

	@RequestMapping("/recharge/callBack")
	public String callBack(HttpServletRequest request,Model model){
		UserWalletRecord record = (UserWalletRecord) request.getSession().getAttribute("user_wallet_record");
		TUser user = (TUser) request.getSession().getAttribute("user");
		String httpPrefix = request.getContextPath();
		logger.info("===========httpPrefix="+httpPrefix);
		if(user == null){
			model.addAttribute("msg","登录信息已过期");
			return "redirect:" + httpPrefix + "/system/userIndex";
		}
		//TODO  执行业务
		Result result = userService.recharge(record);
		if("U00".equals(result.getCode())){
			model.addAttribute("msg","登录信息已过期");
			return "redirect:" + httpPrefix + "/system/userIndex";
		}
		String url = "/user/wallet?uid="+user.getId();
		request.getSession().setAttribute("url",url);
		return "redirect:" + httpPrefix + "/system/userIndex";
	}

	/**
	 * 提现
	 * @param request
	 * @return
	 */
	@RequestMapping("/tx")
	@ResponseBody
	public Result tx(HttpServletRequest request){
		JSONObject jsonObject = (JSONObject) getParams(request);
		String uid = jsonObject.getString("uid");
		String txmoney = jsonObject.getString("txmoney");
		String cardNo = jsonObject.getString("cardNo");
		UserWalletRecord record = new UserWalletRecord();
		record.setUid(Long.valueOf(uid));
		record.setMoney(new BigDecimal(txmoney));
		record.setCardNo(cardNo);
		return userService.tx(record);
	}
}
