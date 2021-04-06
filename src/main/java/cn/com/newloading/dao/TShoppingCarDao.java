package cn.com.newloading.dao;


import cn.com.newloading.bean.TShoppingCar;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TShoppingCarDao {
    int deleteByPrimaryKey(Long id);

    int insert(TShoppingCar record);

    int insertSelective(TShoppingCar record);

    TShoppingCar selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TShoppingCar record);

    int updateByPrimaryKey(TShoppingCar record);

    List<TShoppingCar> queryTrolleyByUid(@Param("uid") Long uid);
}