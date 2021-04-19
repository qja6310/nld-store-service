package cn.com.newloading.dao;

import cn.com.newloading.bean.TUser;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;

public interface TUserDao {
    int deleteByPrimaryKey(Integer id);

    int insert(TUser record);

    int insertSelective(TUser record);

    TUser selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TUser record);

    int updateByPrimaryKey(TUser record);

    int checkAccIsExist(String uAcc);

    int checkAccIsExist2(@Param("uAcc")String uAcc,@Param("id")Long id);

    TUser doLogin(@Param("uAcc") String uAcc, @Param("uPwd") String uPwd);

    int recharge(@Param("money") BigDecimal money,@Param("uid") Long uid);
}