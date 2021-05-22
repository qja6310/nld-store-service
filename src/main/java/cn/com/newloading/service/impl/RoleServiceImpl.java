package cn.com.newloading.service.impl;

import cn.com.newloading.bean.TMenu;
import cn.com.newloading.bean.TRole;
import cn.com.newloading.dao.TMenuDao;
import cn.com.newloading.dao.TRoleDao;
import cn.com.newloading.service.RoleService;
import cn.com.newloading.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {

    @Autowired
    TRoleDao roleDao;
    @Autowired
    TMenuDao menuDao;
    @Override
    public Map<String, Object> doQuery(TRole role) {
        Map<String,Object> map = new HashMap<>();
        //查询所有角色
        List<TRole> tRoles = roleDao.doQuery(role);
        map.put("roles",tRoles);
        //查询所有一级菜单
        List<TMenu> tMenus = menuDao.queryAllMenuByPid(0);
        for (TMenu m : tMenus){
            //二级菜单
            m.setMenus(menuDao.queryAllMenuByPid(m.getId()));
        }
        map.put("menus",tMenus);
        return map;
    }

    @Override
    public Result doAdd(TRole role) {
        //角色编号不可重复
        int c = roleDao.checkReleCode(role.getrCode());
        if(c > 0){
            return new Result("R99","该角色编码已经存在，换一个试试");
        }
        roleDao.insertSelective(role);
        return new Result("R00","操作成功");
    }

    @Override
    public Result delete(String id) {
        //确认角色没有人使用菜可以删除
        Integer c = roleDao.chenckRoleUsed(Long.valueOf(id));
        if(c > 0){
            return new Result("R99","当前角色正在被使用，不可删除");
        }
        int i = roleDao.deleteByPrimaryKey(Long.valueOf(id));
        if(i > 0){
            return new Result("R00","操作成功");
        }
        return new Result("R77","操作失败");
    }

    @Override
    public List<TMenu> getMenuByRoleId(String id) {
        return menuDao.queryMenuByRoleId(Long.valueOf(id));
    }

    @Override
    public Result update(String id, String rName, String menuIds) {
        if(!StringUtils.isEmpty(rName)){//角色名不为空修改
            TRole role = new TRole();
            role.setId(Long.valueOf(id));
            role.setrName(rName);
            int i = roleDao.updateByPrimaryKeySelective(role);
            if(i > 0) return new Result("R00","操作成功");
        }
        if(!StringUtils.isEmpty(menuIds)){//修改权限
            //超级管理员权限不可修改
            TRole role = roleDao.selectByPrimaryKey(Long.valueOf(id));
            if("CJGLY".equals(role.getrCode())){
                return new Result("R88","该角色不可重新配置权限");
            }
            //先删除已有的
            roleDao.deleteMenuByRoleId(Long.valueOf(id));
            String[] arr = menuIds.split(",");
            for(String mid : arr){
                roleDao.insertRoleMenu(Long.valueOf(id),Long.valueOf(mid));
            }
            return new Result("R00","操作成功");
        }
        return new Result("R77","操作失败");
    }

    @Override
    public List<TRole> toConfig(String aid) {
        List<TRole> tRoles = roleDao.doQuery(null);
        List<Long> ids = roleDao.getRoleByAid(Long.valueOf(aid));
        for (int i = 0;i < tRoles.size();i++){
            for (int j = 0;j < ids.size();j++){
                if(tRoles.get(i).getId() == ids.get(j)) tRoles.get(i).setChecked("1");
            }
        }
        return tRoles;
    }

    @Override
    public Result doConfig(String aid, String roleIds) {
        //删除原来的配置
        roleDao.deleteRoleByAid(Long.valueOf(aid));
        String[] arr = roleIds.split(",");
        for (String rid : arr) roleDao.insertAdminRole(Long.valueOf(aid),Long.valueOf(rid));
        return new Result("R00","操作成功");
    }

    @Override
    public Map<String, Object> jurisdiction(String rid) {
        Map<String, Object> resMap = new HashMap<>();
        //查询所以菜单
        List<Map> allMenus = menuDao.queryAllMenu();
        resMap.put("allMenus",allMenus);
        List<Map> menus = menuDao.queryMenuByRoleId2(Long.valueOf(rid));
        resMap.put("menus",menus);
        return resMap;
    }
}
