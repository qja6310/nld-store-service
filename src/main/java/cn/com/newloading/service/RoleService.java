package cn.com.newloading.service;

import cn.com.newloading.bean.TAdmin;
import cn.com.newloading.bean.TMenu;
import cn.com.newloading.bean.TRole;
import cn.com.newloading.utils.Result;

import java.util.List;
import java.util.Map;

public interface RoleService {

    /**
     * 查询角色
     * @param role
     * @return
     */
    Map<String,Object> doQuery(TRole role);

    /**
     * 新增
     * @param role
     * @return
     */
    Result doAdd(TRole role);

    /**
     * 删除
     * @param id
     * @return
     */
    Result delete(String id);

    /**
     * 查询角色已配置好的菜单
     * @param id
     * @return
     */
    List<TMenu> getMenuByRoleId(String id);

    /**
     * 修改信息
     * @param id
     * @param rName
     * @param menuIds
     * @return
     */
    Result update(String id,String rName,String menuIds);

    /**
     * 根据用户id获取配置的信息
     * @param aid
     * @return
     */
    List<TRole> toConfig(String aid);

    /**
     * 配置
     * @param aid
     * @param roleIds
     * @return
     */
    Result doConfig(String aid,String roleIds);
}
