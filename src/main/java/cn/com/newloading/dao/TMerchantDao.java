package cn.com.newloading.dao;


import cn.com.newloading.bean.TMerchant;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TMerchantDao {
    int deleteByPrimaryKey(Long id);

    int insert(TMerchant record);

    int insertSelective(TMerchant record);

    TMerchant selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TMerchant record);

    int updateByPrimaryKey(TMerchant record);

    int checkMerchantCode(@Param("mCode") String mCode);

    int checkMerchantAcc(@Param("mAcc") String mAcc);

    int checkMerchantAcc2(@Param("mAcc") String mAcc,@Param("id") Long id);

    TMerchant doLogin(@Param("mAcc")String mAcc,@Param("mPwd")String mPwd);

    List<TMerchant> doQuery(TMerchant merchant);
}