package cn.com.newloading.service.impl;

import cn.com.newloading.bean.TGoods;
import cn.com.newloading.bean.TGoodsImg;
import cn.com.newloading.bean.TShoppingCar;
import cn.com.newloading.dao.TGoodsDao;
import cn.com.newloading.dao.TGoodsImgDao;
import cn.com.newloading.dao.TShoppingCarDao;
import cn.com.newloading.service.TrolleyService;
import cn.com.newloading.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class TrolleyServiceImpl implements TrolleyService {

    @Autowired
    TGoodsDao goodsDao;
    @Autowired
    TShoppingCarDao carDao;
    @Autowired
    TGoodsImgDao imgDao;

    @Override
    public Result join(TShoppingCar car) {
        //计算支付金额
        TGoods goods = goodsDao.selectByPrimaryKey(Long.valueOf(car.getgId()));
        if(goods == null || !"70".equals(goods.getStatus())){
            return new Result("C99","该商品已下架");
        }
        double price = goods.getgPrice().doubleValue();
        Integer c = Integer.valueOf(car.getCount());
        double payMoney = c * price;
        car.setPaymoney(String.valueOf(payMoney));
        int r = carDao.insertSelective(car);
        if(r > 0)return new Result("C00","已加入购物车");
        return new Result("C77","操作失败");
    }

    @Override
    public List<TShoppingCar> list(String uid) {
        List<TShoppingCar> cars = carDao.queryTrolleyByUid(Long.valueOf(uid));
        //商品图片
        for(TShoppingCar c : cars){
            List<TGoodsImg> imgs = imgDao.queryImgByGid(c.getGoods().getId());
            c.getGoods().setImgPath(imgs.get(0).getImgUrl());
            c.getGoods().setImgTitle(imgs.get(0).getImgTitle());
        }
        return cars;
    }

    @Override
    public Result delete(String tid) {
        int r = carDao.deleteByPrimaryKey(Long.valueOf(tid));
        if(r > 0) return new Result("C00","操作成功");
        return new Result("C77","操作失败");
    }
}
