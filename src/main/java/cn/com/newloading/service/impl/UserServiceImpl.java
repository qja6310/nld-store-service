package cn.com.newloading.service.impl;

import cn.com.newloading.bean.TAddress;
import cn.com.newloading.bean.TUser;
import cn.com.newloading.dao.TAddressDao;
import cn.com.newloading.dao.TUserDao;
import cn.com.newloading.service.UserService;
import cn.com.newloading.utils.Result;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private TUserDao userDao;
	@Autowired
	private TAddressDao addrDao;

	@Override
	public Result doRegister(TUser user, String addrJsonStr) {
		//校验账号是否存在，登录账号需唯一
		int c = userDao.checkAccIsExist(user.getuAcc());
		if(c == 0){
			userDao.insertSelective(user);//插入注册
			addAddr(addrJsonStr,user.getId());
			return new Result("U00","注册成功");
		}else{
			return new Result("U99","账号已存在，建议换一个");
		}
	}

	@Override
	public TUser doLogin(String account, String password) {
		return userDao.doLogin(account, password);
	}

	@Override
	public TUser getUser(String id) {
		TUser user = userDao.selectByPrimaryKey(Long.valueOf(id));
		user.setAddressList(addrDao.queryAddrByUid(user.getId()));
		return user;
	}

	@Override
	public Result doEdit(TUser user, String addrJsonStr) {
		//检查信息是否重复
		int c = userDao.checkAccIsExist2(user.getuAcc(),user.getId());
		if(c > 0) return new Result("U99","账号已存在，建议换一个");
 		//修改用户信息
		int i = userDao.updateByPrimaryKeySelective(user);
		if(i > 0) {
			//修改用户收货地址
			addrDao.deleteByUserId(user.getId());
			addAddr(addrJsonStr, user.getId());
			return new Result("U00","操作成功");
		}
		return new Result("U77","发生异常，请重试");
	}

	/**
	 * 添加用户收货地址
	 * @param addrJsonStr
	 * @param uid
	 */
	private void addAddr(String addrJsonStr,Long uid){
		if(!StringUtils.isEmpty(addrJsonStr)){
			JSONArray jsonArray = JSONArray.parseArray(addrJsonStr);
			for(int i = 0;i < jsonArray.size();i++){
				JSONObject obj = jsonArray.getJSONObject(i);
				TAddress addr = new TAddress();
				addr.setConName(obj.getString("conName"));
				addr.setConPhone(obj.getString("conPhone"));
				addr.setDetailAddr(obj.getString("detailAddr"));
				addr.setuId(uid);
				addrDao.insertSelective(addr);
			}
		}
	}

}
