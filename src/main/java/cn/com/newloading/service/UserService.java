package cn.com.newloading.service;

import cn.com.newloading.bean.TUser;
import cn.com.newloading.utils.Result;

public interface UserService {

	/**
	 * 用户注册
	 * @param user
	 * @param addrJsonStr
	 * @return
	 */
	Result doRegister(TUser user, String addrJsonStr);

	/**
	 * 用户登陆
	 * @param uAcc
	 * @param uPwd
	 * @return
	 */
	TUser doLogin(String uAcc, String uPwd);

	/**
	 * 获取用户信息
	 * @param id
	 * @return
	 */
	TUser getUser(String id);

	/**
	 * 修改用户信息
	 * @param user
	 * @param addrJsonStr
	 * @return
	 */
	Result doEdit(TUser user,String addrJsonStr);
	
}
