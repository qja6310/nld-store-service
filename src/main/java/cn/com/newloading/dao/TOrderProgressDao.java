package cn.com.newloading.dao;

import cn.com.newloading.bean.TOrderProgress;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TOrderProgressDao {
    int deleteByPrimaryKey(Long id);

    int insert(TOrderProgress record);

    int insertSelective(TOrderProgress record);

    TOrderProgress selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TOrderProgress record);

    int updateByPrimaryKey(TOrderProgress record);

    List<TOrderProgress> queryByOid(@Param("oid") Long oid);
}