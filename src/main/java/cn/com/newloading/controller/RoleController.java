package cn.com.newloading.controller;

import cn.com.newloading.bean.TMenu;
import cn.com.newloading.bean.TRole;
import cn.com.newloading.service.RoleService;
import cn.com.newloading.utils.Result;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/role")
public class RoleController extends BaseController{

    @Autowired
    RoleService roleService;

    @RequestMapping("/manage")
    public String manage(HttpServletRequest request, Model model){
        TRole role = new TRole();
        role.setrCode(params(request,model,"rCode"));
        role.setrName(params(request,model,"rName"));
        Map<String, Object> map = roleService.doQuery(role);
        model.addAttribute("roles",map.get("roles"));
        model.addAttribute("menus",map.get("menus"));
        return "role/manage";
    }

    @RequestMapping("/toAdd")
    public String toAdd(HttpServletRequest request, Model model){
        return "role/add";
    }

    @RequestMapping("/doAdd")
    @ResponseBody
    public Result doAdd(HttpServletRequest request){
        JSONObject jsonObject = (JSONObject) getParams(request);
        TRole role = new TRole();
        role.setrCode(jsonObject.getString("rCode"));
        role.setrName(jsonObject.getString("rName"));
        return roleService.doAdd(role);
    }

    @RequestMapping("/update")
    @ResponseBody
    public Result update(HttpServletRequest request){
        JSONObject jsonObject = (JSONObject) getParams(request);
        return roleService.update(jsonObject.getString("id"),jsonObject.getString("rName"),jsonObject.getString("menuIds"));
    }

    @RequestMapping("/menu")
    @ResponseBody
    public Result menu(HttpServletRequest request){
        String id = (String) getParams(request);
        List<TMenu> menus = roleService.getMenuByRoleId(id);
        return new Result("R00","成功",menus);
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Result delete(HttpServletRequest request){
        String id = (String) getParams(request);
        return roleService.delete(id);
    }

    @RequestMapping("/config")
    public String config(HttpServletRequest request,Model model){
        String aid = request.getParameter("aid");
        List<TRole> tRoles = roleService.toConfig(aid);
        model.addAttribute("roles",tRoles);
        model.addAttribute("aid",aid);
        return "role/config";
    }

    @RequestMapping("/doConfig")
    @ResponseBody
    public Result doConfig(HttpServletRequest request){
        JSONObject jsonObject = (JSONObject) getParams(request);
        String aid = jsonObject.getString("aid");
        String roleIds = jsonObject.getString("roleIds");
        return roleService.doConfig(aid,roleIds);
    }

    @RequestMapping("/jurisdiction")
    public String jurisdiction(HttpServletRequest request,Model model){
        String rid = request.getParameter("rid");
        Map<String, Object> map = roleService.jurisdiction(rid);
        model.addAttribute("rid",rid);
        model.addAttribute("allMenus", JSON.toJSONString(map.get("allMenus")));
        model.addAttribute("menus",JSON.toJSONString(map.get("menus")));
        return "role/jurisdiction";
    }
}
