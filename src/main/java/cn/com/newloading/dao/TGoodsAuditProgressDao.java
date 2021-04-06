package cn.com.newloading.dao;


import cn.com.newloading.bean.TGoodsAuditProgress;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TGoodsAuditProgressDao {
    int deleteByPrimaryKey(Long id);

    int insert(TGoodsAuditProgress record);

    int insertSelective(TGoodsAuditProgress record);

    TGoodsAuditProgress selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TGoodsAuditProgress record);

    int updateByPrimaryKey(TGoodsAuditProgress record);

    List<TGoodsAuditProgress> queryProgressByGid(@Param("gid") Long gid);
}