package cn.com.newloading.controller;

import cn.com.newloading.bean.TAdmin;
import cn.com.newloading.bean.TMenu;
import cn.com.newloading.bean.TMerchant;
import cn.com.newloading.bean.TUser;
import cn.com.newloading.service.SystemService;
import cn.com.newloading.utils.Common;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/system")
public class SystemController {

    @Autowired
    SystemService systemService;

    /**
     * 管理员登录成功
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/index")
    public String index(HttpServletRequest request, Model model){
        TAdmin admin = (TAdmin) request.getSession().getAttribute("admin");
        if(admin == null){
            return "admin/login";
        }
        List<TMenu> menus = systemService.getMenuByAdmin(admin);
        model.addAttribute("menus",menus);
        model.addAttribute("admin",admin);
        return "system/index";
    }

    /**
     * 商户登录成功
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/merchantIndex")
    public String merchantIndex(HttpServletRequest request, Model model){
        TMerchant merchant = (TMerchant) request.getSession().getAttribute("merchant");
        if(merchant == null){
            return "merchant/login";
        }
        model.addAttribute("merchant",merchant);
        return "system/merchantIndex";
    }

    @RequestMapping("/userIndex")
    public String userIndex(HttpServletRequest request,Model model){
        TUser user = (TUser) request.getSession().getAttribute("user");
        if(user != null){
            model.addAttribute("user",user);
        }
        String url = (String) request.getSession().getAttribute("url");
        if(!Common.isBlank(url)){
            model.addAttribute("url",url);
        }
        return "system/userIndex";
    }
}
