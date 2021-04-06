package cn.com.newloading.dao;

import cn.com.newloading.bean.TDict;
import org.apache.ibatis.annotations.Param;

public interface TDictDao {
    int deleteByPrimaryKey(Long id);

    int insert(TDict record);

    int insertSelective(TDict record);

    TDict selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TDict record);

    int updateByPrimaryKey(TDict record);

    TDict queryByKey(@Param("code") String code,@Param("key") String key);
}