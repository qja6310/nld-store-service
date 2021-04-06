package cn.com.newloading.service;

import cn.com.newloading.bean.TShoppingCar;
import cn.com.newloading.utils.Result;

import java.util.List;

public interface TrolleyService {

    Result join(TShoppingCar car);

    List<TShoppingCar> list(String uid);

    Result delete(String tid);
}
