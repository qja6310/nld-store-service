package cn.com.newloading.dao;


import cn.com.newloading.bean.WithdrawDepositRecord;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WithdrawDepositRecordDao {
    int deleteByPrimaryKey(Long id);

    int insert(WithdrawDepositRecord record);

    int insertSelective(WithdrawDepositRecord record);

    WithdrawDepositRecord selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(WithdrawDepositRecord record);

    int updateByPrimaryKey(WithdrawDepositRecord record);

    List<WithdrawDepositRecord> queryByMid(@Param("mid") Long mid);
}