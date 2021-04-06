package cn.com.newloading.service.impl;

import cn.com.newloading.bean.TAdmin;
import cn.com.newloading.bean.TMenu;
import cn.com.newloading.dao.TMenuDao;
import cn.com.newloading.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class SystemServiceImpl implements SystemService {

    @Autowired
    TMenuDao menuDao;

    @Override
    public List<TMenu> getMenuByAdmin(TAdmin admin) {
        List<TMenu> tMenus = menuDao.queryMenu(0, admin.getId());
        if(tMenus != null && tMenus.size() > 0){
            for (TMenu m : tMenus){
                m.setMenus(menuDao.queryMenu(m.getId(), admin.getId()));
            }
            return tMenus;
        }
        return null;
    }
}
