package cn.com.newloading.service.impl;

import cn.com.newloading.bean.TGoods;
import cn.com.newloading.bean.TGoodsImg;
import cn.com.newloading.bean.TMerchant;
import cn.com.newloading.bean.TOrder;
import cn.com.newloading.bean.TOrderProgress;
import cn.com.newloading.dao.TGoodsDao;
import cn.com.newloading.dao.TGoodsImgDao;
import cn.com.newloading.dao.TMerchantDao;
import cn.com.newloading.dao.TOrderDao;
import cn.com.newloading.dao.TOrderProgressDao;
import cn.com.newloading.service.OrderService;
import cn.com.newloading.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    TOrderDao orderDao;
    @Autowired
    TOrderProgressDao progressDao;
    @Autowired
    TMerchantDao merchantDao;
    @Autowired
    TGoodsDao goodsDao;
    @Autowired
    TGoodsImgDao imgDao;

    @Override
    public TOrder createOrder(TOrder order) {
        order.setStatus("10");//待支付
        order.setcTime(new Date());//创建时间
        order.setoNumber(getOrderNumber());
        int r = orderDao.insertSelective(order);
        //插入订单流程表
        TOrderProgress progress = new TOrderProgress();
        progress.setoId(order.getId());
        progress.setStatus("10");
        progress.setOpRemark("下单成功，待付款");
        progress.setOperateTime(new Date());
        progressDao.insertSelective(progress);
        return order;
    }

    @Override
    public Result updateStatus(String id,String status,String msg) {
        TOrder o = orderDao.selectByPrimaryKey(Long.valueOf(id));
        if("60".equals(status) && !"50".equals(o.getStatus())){//如果是签收的话，那前提是已发货
            return new Result("O99","商家未发货，当前状态不可修改");
        }
        if("50".equals(status) && !"30".equals(o.getStatus())){//未付款不发货
            return new Result("O99","当前状态没有支付，不可发货");
        }
        //如果是已发货状态的话，需要减少库存
        if("50".equals(status)){
            TGoods goods = goodsDao.selectByPrimaryKey(o.getgId());
            //库存不足不可发货
            if(goods.getgInventory() < o.getCount()) return new Result("O99","当前库存已不足，请先补货");
            //修改库存
            TGoods g = new TGoods();
            g.setId(goods.getId());
            g.setgInventory(goods.getgInventory() - o.getCount());
            goodsDao.updateByPrimaryKeySelective(g);
        }else if("60".equals(status)){//如果是已收货状态，将钱要转入商户钱包
            TMerchant merchant = merchantDao.selectByPrimaryKey(o.getmId());
            TMerchant m = new TMerchant();
            m.setId(merchant.getId());
            double v = merchant.getmWallet().doubleValue();
            double n = Double.valueOf(o.getPayMoney());
            double r = v + n;
            m.setmWallet(BigDecimal.valueOf(r));
            merchantDao.updateByPrimaryKeySelective(m);
        }


        TOrder order = new TOrder();
        order.setId(Long.valueOf(id));
        order.setStatus(status);
        int i = orderDao.updateByPrimaryKeySelective(order);
        if(i == 0) return new Result("O99","操作失败");
        //插入订单流程表
        TOrderProgress progress = new TOrderProgress();
        progress.setoId(order.getId());
        progress.setStatus(status);
        progress.setOpRemark(msg);
        progress.setOperateTime(new Date());
        progressDao.insertSelective(progress);
        return new Result("O00","操作成功");
    }

    @Override
    public Map<String,Object> detail(String oid) {
        TOrder order = orderDao.selectByPrimaryKey(Long.valueOf(oid));
        TMerchant merchant = merchantDao.selectByPrimaryKey(order.getmId());
        List<TOrderProgress> progressList = progressDao.queryByOid(order.getId());
        TGoods goods = goodsDao.selectByPrimaryKey(order.getgId());
        /** 主图 */
        List<TGoodsImg> imgs = imgDao.queryImgByGid(goods.getId());
        goods.setImgTitle(imgs.get(0).getImgTitle());
        goods.setImgPath(imgs.get(0).getImgUrl());

        Map<String,Object> map = new HashMap<>();
        map.put("order",order);
        map.put("merchant",merchant);
        map.put("progressList",progressList);
        map.put("goods",goods);
        return map;
    }

    @Override
    public List<TOrder> list(TOrder order) {
        return orderDao.query(order);
    }

    @Override
    public TOrder getOrder(String oid) {
        return orderDao.selectByPrimaryKey(Long.valueOf(oid));
    }

    @Override
    public Map<String, Object> sales(Long mid, int year) {
        Map<String, Object> res = new HashMap<>();
        //统计12个月的交易量
        String sum = "";
        String count = "";
        int[] month = new int[12];
        for(int i = 1;i <= 12;i++){
            HashMap<String, String> map = orderDao.sales(mid, year, i);
            sum += String.valueOf(map.get("sum")) + ",";
            count += String.valueOf(map.get("count")) + ",";
            month[i - 1] = i;
        }
        sum = sum.substring(0,sum.length() - 1);
        count = count.substring(0,count.length() - 1);
        res.put("sum",sum);
        res.put("count",count);
        res.put("cje",sum.split(","));
        res.put("ddl",count.split(","));
        res.put("month",month);
        return res;
    }

    private String getOrderNumber(){
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        return formatter.format(new Date());
    }
}
