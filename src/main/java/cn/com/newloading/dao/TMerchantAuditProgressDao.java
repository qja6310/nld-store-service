package cn.com.newloading.dao;

import cn.com.newloading.bean.TMerchantAuditProgress;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TMerchantAuditProgressDao {
    int deleteByPrimaryKey(Long id);

    int insert(TMerchantAuditProgress record);

    int insertSelective(TMerchantAuditProgress record);

    TMerchantAuditProgress selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TMerchantAuditProgress record);

    int updateByPrimaryKey(TMerchantAuditProgress record);

    List<TMerchantAuditProgress> queryProgress(@Param("mId") Long mId);
}