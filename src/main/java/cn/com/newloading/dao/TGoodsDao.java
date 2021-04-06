package cn.com.newloading.dao;


import cn.com.newloading.bean.TGoods;
import cn.com.newloading.bean.TGoodsType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TGoodsDao {
    int deleteByPrimaryKey(Long id);

    int insert(TGoods record);

    int insertSelective(TGoods record);

    TGoods selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TGoods record);

    int updateByPrimaryKey(TGoods record);

    List<TGoods> doQueryForMerchant(TGoods goods);

    List<TGoods> doQueryForAdmin(TGoods goods);

    List<TGoods> doQueryForUser(TGoods goods);

    List<TGoodsType> queryType();
}