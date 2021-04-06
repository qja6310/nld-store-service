package cn.com.newloading.service;

import cn.com.newloading.bean.TGoods;
import cn.com.newloading.bean.TGoodsAuditProgress;
import cn.com.newloading.bean.TGoodsType;
import cn.com.newloading.utils.Result;

import java.util.List;
import java.util.Map;

public interface GoodsService {

	List<TGoods> doQuery(TGoods goods,String mid);

	Result update(TGoods goods);

	Result delete(String id);

	Result submit(TGoods goods);

	Map<String,Object> detail(String gid);

	Result audit(TGoodsAuditProgress progress);

	List<TGoods> index(TGoods goods,String typeIds);

	TGoods purchase(String id);

	List<TGoodsType> types();
}
