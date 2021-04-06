package cn.com.newloading.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.com.newloading.bean.TGoods;
import cn.com.newloading.bean.TGoodsAuditProgress;
import cn.com.newloading.bean.TGoodsImg;
import cn.com.newloading.bean.TGoodsType;
import cn.com.newloading.dao.TGoodsAuditProgressDao;
import cn.com.newloading.dao.TGoodsDao;
import cn.com.newloading.dao.TGoodsImgDao;
import cn.com.newloading.utils.Common;
import cn.com.newloading.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.com.newloading.service.GoodsService;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class GoogsServiceImpl implements GoodsService {

	@Autowired
	TGoodsDao goodsDao;
	@Autowired
	TGoodsImgDao imgDao;
	@Autowired
	TGoodsAuditProgressDao progressDao;

	@Override
	public List<TGoods> doQuery(TGoods goods,String r) {
		if("a".equals(r)) return goodsDao.doQueryForAdmin(goods);//管理员查询
		if("m".equals(r)) return goodsDao.doQueryForMerchant(goods);//商户查询
		return goodsDao.doQueryForMerchant(goods);
	}

	@Override
	public Result update(TGoods goods) {
		int r = goodsDao.updateByPrimaryKeySelective(goods);
		if(r == 0) return new Result("G99","操作失败");
		//插入图片路径
		if(!Common.isBlank(goods.getImgPath())){
			imgDao.deleteByGid(goods.getId());
			String[] pathArr = goods.getImgPath().split(",");//图片路径
			String[] titleArr = goods.getImgTitle().split(",");//图片标题
			int len = pathArr.length;
			for(int i = 0;i < len;i++){
				TGoodsImg img = new TGoodsImg();
				img.setgId(goods.getId());
				img.setImgTitle(titleArr[i]);
				img.setImgUrl(pathArr[i]);
				imgDao.insertSelective(img);
			}
		}
		return new Result("G00","操作成功");
	}

	@Override
	public Result delete(String id) {
		int i = goodsDao.deleteByPrimaryKey(Long.valueOf(id));
		if(i > 0) return new Result("G00","操作成功");
		return new Result("G77","操作失败");
	}

	@Override
	public Result submit(TGoods goods) {
		goods.setStatus("30");
		if(goods.getId() == null){
			int r = goodsDao.insertSelective(goods);
			if(r == 0) return new Result("G99","操作失败");
			//插入图片路径
			if(!Common.isBlank(goods.getImgPath())){
				String[] pathArr = goods.getImgPath().split(",");//图片路径
				String[] titleArr = goods.getImgTitle().split(",");//图片标题
				int len = pathArr.length;
				for(int i = 0;i < len;i++){
					TGoodsImg img = new TGoodsImg();
					img.setgId(goods.getId());
					img.setImgTitle(titleArr[i]);
					img.setImgUrl(pathArr[i]);
					imgDao.insertSelective(img);
				}
			}
		}else{
			Result result = update(goods);
			if(!"G00".equals(result.getCode()))return result;
		}
		//插入审批流程表
		TGoodsAuditProgress progress = new TGoodsAuditProgress();
		progress.setgId(goods.getId());
		progress.setOperateTime(new Date());
		progress.setStatus("30");
		progress.setAuditOpinion("材料提交成功,等待审核");
		progressDao.insertSelective(progress);
		return new Result("G00","操作成功");
	}

	@Override
	public Map<String, Object> detail(String gid) {
		//获取商品对象
		TGoods goods = goodsDao.selectByPrimaryKey(Long.valueOf(gid));
		//商品图片
		List<TGoodsImg> imgs = imgDao.queryImgByGid(Long.valueOf(gid));
		//审批进度
		List<TGoodsAuditProgress> progressList = progressDao.queryProgressByGid(Long.valueOf(gid));
		Map<String,Object> map = new HashMap<>();
		map.put("goods",goods);
		map.put("imgs",imgs);
		map.put("progressList",progressList);
		map.put("imgCount",Common.IMGCOUNT - imgs.size());
		return map;
	}

	@Override
	public Result audit(TGoodsAuditProgress progress) {
		TGoods goods = new TGoods();
		goods.setId(progress.getgId());
		goods.setStatus(progress.getStatus());
		int i = goodsDao.updateByPrimaryKeySelective(goods);
		if(i == 0) return new Result("G77","操作失败");
		progress.setOperateTime(new Date());
		progressDao.insertSelective(progress);
		return new Result("G00","操作成功");
	}

	@Override
	public List<TGoods> index(TGoods goods,String typeIds) {
		if(!Common.isBlank(typeIds)) goods.setTypeIds(typeIds);
		List<TGoods> goodsList = goodsDao.doQueryForUser(goods);
		for(TGoods g : goodsList){
			/** 主图 */
			List<TGoodsImg> imgs = imgDao.queryImgByGid(g.getId());
			g.setImgTitle(imgs.get(0).getImgTitle());
			g.setImgPath(imgs.get(0).getImgUrl());
			if(g.getgTitle().length() > 10){
				g.setgTitle(g.getgTitle().substring(0,10) + "...");
			}
		}
		return goodsList;
	}

	@Override
	public TGoods purchase(String id) {
		TGoods goods = goodsDao.selectByPrimaryKey(Long.valueOf(id));
		goods.setImgList(imgDao.queryImgByGid(goods.getId()));
		return goods;
	}

	@Override
	public List<TGoodsType> types() {
		return goodsDao.queryType();
	}
}
