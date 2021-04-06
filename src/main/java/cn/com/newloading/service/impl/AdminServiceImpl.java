package cn.com.newloading.service.impl;

import cn.com.newloading.bean.TAdmin;
import cn.com.newloading.dao.TAdminDao;
import cn.com.newloading.service.AdminService;
import cn.com.newloading.utils.Common;
import cn.com.newloading.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {
    @Autowired
    TAdminDao adminDao;
    @Override
    public TAdmin doLogin(String aAcc, String aPwd) {
        return adminDao.doLogin(aAcc,aPwd);
    }

    @Override
    public Result addAdmin(TAdmin admin) {
        int c = adminDao.checkAccIsExist(admin.getaAcc());
        if(c == 0){
            c = adminDao.insertSelective(admin);
            return new Result("A00","操作成功");
        }
        return new Result("A99","该账号存在，换一个试试");
    }

    @Override
    public Result editAdmin(TAdmin admin) {
        int c = adminDao.checkAccIsExist2(admin.getaAcc(),admin.getId());
        if(c == 0){
            c = adminDao.updateByPrimaryKeySelective(admin);
            return new Result("A00","操作成功");
        }
        return new Result("A99","该账号存在，换一个试试");
    }

    @Override
    public List<TAdmin> doQuery(TAdmin admin) {
        return adminDao.doQuery(admin);
    }

    @Override
    public Result resetPwd(String id) {
        TAdmin admin = new TAdmin();
        admin.setId(Long.valueOf(id));
        admin.setaPwd(Common.INIT_A_PWD);
        int i = adminDao.updateByPrimaryKeySelective(admin);
        if(i > 0) return new Result("A00","操作成功");
        else return new Result("A55","操作失败");
    }

    @Override
    public Result delAdmin(String id) {
        int i = adminDao.deleteByPrimaryKey(Long.valueOf(id));
        if(i > 0) return new Result("A00","操作成功");
        else return new Result("A55","操作失败");
    }
}
