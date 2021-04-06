package cn.com.newloading.controller;

import javax.servlet.http.HttpServletRequest;

import cn.com.newloading.bean.TAddress;
import cn.com.newloading.bean.TUser;
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
}
