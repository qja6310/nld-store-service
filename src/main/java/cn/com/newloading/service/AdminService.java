package cn.com.newloading.service;

import cn.com.newloading.bean.TAdmin;
import cn.com.newloading.utils.Result;

import java.util.List;

public interface AdminService {

    TAdmin doLogin(String aAcc,String aPwd);

    Result addAdmin(TAdmin admin);

    /**
     * 编辑用户
     * @param admin
     * @return
     */
    Result editAdmin(TAdmin admin);

    /**
     * 条件分页查询用户
     * @param admin
     * @return
     */
    List<TAdmin> doQuery(TAdmin admin);

    /**
     * 重置密码
     * @param id
     * @return
     */
    Result resetPwd(String id);

    /**
     * 删除管理员
     * @param id
     * @return
     */
    Result delAdmin(String id);
}
