package cn.com.newloading.service.impl;

import cn.com.newloading.bean.TAddress;
import cn.com.newloading.bean.TUser;
import cn.com.newloading.bean.UserWalletRecord;
import cn.com.newloading.dao.TAddressDao;
import cn.com.newloading.dao.TUserDao;
import cn.com.newloading.dao.UserWalletRecordDao;
import cn.com.newloading.service.UserService;
import cn.com.newloading.utils.Result;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private TUserDao userDao;
	@Autowired
	private TAddressDao addrDao;
	@Autowired
	private UserWalletRecordDao recordDao;

	@Override
	public Result doRegister(TUser user, String addrJsonStr) {
		//校验账号是否存在，登录账号需唯一
		user.setuWallet(BigDecimal.ZERO);
		int c = userDao.checkAccIsExist(user.getuAcc());
		if(c == 0){
			user.setuWallet(BigDecimal.ZERO);
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

	@Override
	public Map<String, Object> wallet(String uid) {
		Map<String,Object> map = new HashMap<>();
		TUser user = userDao.selectByPrimaryKey(Long.valueOf(uid));
		map.put("yue",user.getuWallet());
		List<UserWalletRecord> records = recordDao.queryByUid(Long.valueOf(uid));
		map.put("records",records);
		return map;
	}

	@Override
	public Result recharge(UserWalletRecord record) {
		TUser user = userDao.selectByPrimaryKey(record.getUid());
		double m = user.getuWallet().doubleValue() + record.getMoney().doubleValue();
		BigDecimal yue = BigDecimal.valueOf(m);
		//修改用户钱包
		userDao.recharge(yue,user.getId());
		//插入账单
		record.setYue(yue);
		record.setOpreateTime(new Date());
		record.setType("10");
		int i = recordDao.insertSelective(record);
		if(i > 0) return new Result("U00","操作成功");
		return new Result("U99","操作失败");
	}

	@Override
	public Result tx(UserWalletRecord record) {
		TUser user = userDao.selectByPrimaryKey(record.getUid());
		double m = user.getuWallet().doubleValue() - record.getMoney().doubleValue();
		if(m < 0.0) return new Result("U88","您的余额不足");
		BigDecimal yue = BigDecimal.valueOf(m);
		//修改用户钱包
		userDao.recharge(yue,user.getId());
		record.setYue(yue);
		record.setOpreateTime(new Date());
		record.setType("40");
		int i = recordDao.insertSelective(record);
		if(i > 0) return new Result("U00","操作成功");
		return new Result("U99","操作失败");
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
