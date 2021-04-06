package cn.com.newloading.service;

import cn.com.newloading.bean.TAdmin;
import cn.com.newloading.bean.TMenu;

import java.util.List;

public interface SystemService {

    /**
     * 根据用户获取菜单
     * @param admin
     * @return
     */
    List<TMenu> getMenuByAdmin(TAdmin admin);

}
