package cn.com.newloading.dao;

import cn.com.newloading.bean.UserWalletRecord;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserWalletRecordDao {
    int deleteByPrimaryKey(Long id);

    int insert(UserWalletRecord record);

    int insertSelective(UserWalletRecord record);

    UserWalletRecord selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(UserWalletRecord record);

    int updateByPrimaryKey(UserWalletRecord record);

    List<UserWalletRecord> queryByUid(@Param("uid") Long uid);
}