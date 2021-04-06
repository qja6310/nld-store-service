package cn.com.newloading.dao;


import cn.com.newloading.bean.TMenu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TMenuDao {
    int deleteByPrimaryKey(Integer id);

    int insert(TMenu record);

    int insertSelective(TMenu record);

    TMenu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(TMenu record);

    int updateByPrimaryKey(TMenu record);

    List<TMenu> queryMenu(@Param("pid") Integer pid, @Param("aId")Long aId);

    List<TMenu> queryAllMenuByPid(@Param("pid") Integer pid);

    List<TMenu> queryMenuByRoleId(@Param("rid") Long rid);
}