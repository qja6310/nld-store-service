package cn.com.newloading.dao;

import cn.com.newloading.bean.TOrder;
import org.apache.ibatis.annotations.Param;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface TOrderDao {
    int deleteByPrimaryKey(Long id);

    int insert(TOrder record);

    int insertSelective(TOrder record);

    TOrder selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TOrder record);

    int updateByPrimaryKey(TOrder record);

    List<TOrder> query(TOrder record);

    HashMap<String,String> sales(@Param("mid") Long mid, @Param("year")int year, @Param("month")int month);
}