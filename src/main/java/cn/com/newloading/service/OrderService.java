package cn.com.newloading.service;

import cn.com.newloading.bean.TOrder;
import cn.com.newloading.utils.Result;

import java.util.List;
import java.util.Map;

public interface OrderService {

    TOrder createOrder(TOrder order);

    Result updateStatus(String id,String status,String msg);

    Map<String,Object> detail(String oid);

    List<TOrder> list(TOrder order);

    TOrder getOrder(String oid);

    Map<String,Object> sales(Long mid,int year);

    Result nldpay(TOrder order);

}
