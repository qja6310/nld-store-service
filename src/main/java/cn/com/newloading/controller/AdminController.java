package cn.com.newloading.controller;

import cn.com.newloading.bean.TAdmin;
import cn.com.newloading.bean.TUser;
import cn.com.newloading.service.AdminService;
import cn.com.newloading.utils.Common;
import cn.com.newloading.utils.Result;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController extends BaseController{

    @Autowired
    AdminService adminService;

    @RequestMapping("/login")
    public String login(HttpServletRequest request, Model model){
        return "admin/login";
    }

    /**
     * 登录动作
     * @param request
     * @return
     */
    @RequestMapping("/doLogin")
    @ResponseBody
    public Result doLogin(HttpServletRequest request){
        String aAcc = request.getParameter("aAcc");
        String aPwd = request.getParameter("aPwd");
        TAdmin admin = adminService.doLogin(aAcc, aPwd);
        if(admin == null){
            return new Result("A88","账号或密码错误，登录失败!");
        }else{
            request.getSession().setAttribute("admin",admin);
            return new Result("A00","登录成功");
        }
    }

    @RequestMapping("/manage")
    public String manage(HttpServletRequest request, Model model){
        TAdmin admin = new TAdmin();
        admin.setPage(Common.PAGE);
        admin.setLimit(Common.LIMIT);
        admin.setBegin((Common.PAGE - 1) * Common.LIMIT);
        String aAcc = (String)request.getParameter("aAcc");
        String aName = (String)request.getParameter("aName");
        String aPhone = (String)request.getParameter("aPhone");
        admin.setaAcc(StringUtils.isEmpty(aAcc) ? null : aAcc);
        admin.setaName(StringUtils.isEmpty(aName) ? null : aName);
        admin.setaPhone(StringUtils.isEmpty(aPhone) ? null : aPhone);
        List<TAdmin> admins = adminService.doQuery(admin);
        model.addAttribute("admins",admins);
        model.addAttribute("page",Common.PAGE);
        model.addAttribute("limit",Common.LIMIT);
        model.addAttribute("aAcc",aAcc);
        model.addAttribute("aName",aName);
        model.addAttribute("aPhone",aPhone);
        return "admin/manage";
    }

    @RequestMapping("/doQuery")
    @ResponseBody
    public Result doQuery(HttpServletRequest request){
        TAdmin admin = new TAdmin();
        String page = (String)request.getParameter("page");
        admin.setPage(Integer.valueOf(page));
        admin.setLimit(Common.LIMIT);
        admin.setBegin(admin.getPage() * Common.LIMIT);
        String aAcc = (String)request.getParameter("aAcc");
        String aName = (String)request.getParameter("aName");
        String aPhone = (String)request.getParameter("aPhone");
        admin.setaAcc(StringUtils.isEmpty(aAcc) ? null : aAcc);
        admin.setaName(StringUtils.isEmpty(aName) ? null : aName);
        admin.setaPhone(StringUtils.isEmpty(aPhone) ? null : aPhone);
        List<TAdmin> admins = adminService.doQuery(admin);
        return new Result("M00","成功",admins);
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request, Model model){
       request.getSession().removeAttribute("admin");
       return "admin/login";
    }

    @RequestMapping("/toAdd")
    public String toAdd(HttpServletRequest request, Model model){
       return "admin/add";
    }

    @RequestMapping("/doAdd")
    @ResponseBody
    public Result doAdd(HttpServletRequest request){
        TAdmin admin = new TAdmin();
        String aAcc = (String)request.getParameter("aAcc");
        String aName = (String)request.getParameter("aName");
        String aPwd = (String)request.getParameter("aPwd");
        if(StringUtils.isEmpty(aPwd)){
            aPwd = "123456";
        }
        String aPhone = (String)request.getParameter("aPhone");
        String aEmail = (String)request.getParameter("aEmail");
        String isSuper = (String)request.getParameter("isSuper");
        admin.setaAcc(aAcc);
        admin.setaName(aName);
        admin.setaPwd(aPwd);
        admin.setaPhone(aPhone);
        admin.setaEmail(aEmail);
        admin.setIsSuper(isSuper);
        return adminService.addAdmin(admin);
    }

    @RequestMapping("/resetPwd")
    @ResponseBody
    public Result resetPwd(HttpServletRequest request){
        String params = (String)request.getParameter("params");
        String id = (String) getParams(params);
        return adminService.resetPwd(id);
    }

    @RequestMapping("/delAdmin")
    @ResponseBody
    public Result delAdmin(HttpServletRequest request){
        String params = (String)request.getParameter("params");
        String id = (String) getParams(params);
        return adminService.delAdmin(id);
    }

    @RequestMapping("/toEdit")
    public String toEdit(HttpServletRequest request, Model model){
        TAdmin admin = (TAdmin) request.getSession().getAttribute("admin");
        if(admin == null){
            return "admin/login";
        }
        model.addAttribute("admin",admin);
        return "admin/edit";
    }

    @RequestMapping("/doEdit")
    @ResponseBody
    public Result doEdit(HttpServletRequest request){
        TAdmin admin = new TAdmin();
        JSONObject jsonObject = (JSONObject) getParams(request);
        admin.setaAcc(jsonObject.getString("aAcc"));
        admin.setId(Long.valueOf(jsonObject.getString("id")));
        admin.setaName(jsonObject.getString("aName"));
        admin.setaPwd(jsonObject.getString("aPwd"));
        admin.setaPhone(jsonObject.getString("aPhone"));
        admin.setaEmail(jsonObject.getString("aEmail"));
        request.getSession().setAttribute("admin",admin);
        return adminService.editAdmin(admin);
    }
}
