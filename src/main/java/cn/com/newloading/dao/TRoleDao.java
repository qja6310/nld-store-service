package cn.com.newloading.dao;

import cn.com.newloading.bean.TRole;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TRoleDao {
    int deleteByPrimaryKey(Long id);

    int insert(TRole record);

    int insertSelective(TRole record);

    TRole selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TRole record);

    int updateByPrimaryKey(TRole record);

    List<TRole> doQuery(TRole role);

    Integer chenckRoleUsed(@Param("rid") Long rid);

    int deleteMenuByRoleId(@Param("rid")Long rid);

    int insertRoleMenu(@Param("rid")Long rid,@Param("mid") Long mid);

    int checkReleCode(@Param("rCode") String rCode);

    List<Long> getRoleByAid(@Param("aid") Long aid);

    int deleteRoleByAid(@Param("aid") Long aid);

    int insertAdminRole(@Param("aid") Long aid,@Param("rid") Long rid);
}