package cn.com.newloading.dao;


import cn.com.newloading.bean.TAddress;

import java.util.List;

public interface TAddressDao {
    int deleteByPrimaryKey(Long id);

    int insert(TAddress record);

    int insertSelective(TAddress record);

    TAddress selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TAddress record);

    int updateByPrimaryKey(TAddress record);

    int deleteByUserId(Long uid);

    List<TAddress> queryAddrByUid(Long uid);
}