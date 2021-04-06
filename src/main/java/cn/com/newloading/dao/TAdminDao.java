package cn.com.newloading.dao;

import cn.com.newloading.bean.TAdmin;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TAdminDao {
    int deleteByPrimaryKey(Long id);

    int insert(TAdmin record);

    int insertSelective(TAdmin record);

    TAdmin selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TAdmin record);

    int updateByPrimaryKey(TAdmin record);

    TAdmin doLogin(@Param("aAcc") String aAcc, @Param("aPwd")String aPwd);

    int checkAccIsExist(@Param("aAcc") String aAcc);

    int checkAccIsExist2(@Param("aAcc") String aAcc,@Param("id") Long id);

    List<TAdmin> doQuery(TAdmin admin);
}