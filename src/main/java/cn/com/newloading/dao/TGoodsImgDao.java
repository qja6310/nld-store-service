package cn.com.newloading.dao;

import cn.com.newloading.bean.TGoodsImg;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TGoodsImgDao {
    int deleteByPrimaryKey(Long id);

    int deleteByGid(Long gid);

    int insert(TGoodsImg record);

    int insertSelective(TGoodsImg record);

    TGoodsImg selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(TGoodsImg record);

    int updateByPrimaryKey(TGoodsImg record);

    List<TGoodsImg> queryImgByGid(@Param("gid") Long gid);

}