package cn.com.newloading.bean;

import java.io.Serializable;

/**
 * t_shopping_car
 * @author 
 */
public class TShoppingCar implements Serializable {
    private Long id;

    /**
     * 用户id
     */
    private Long uId;

    /**
     * 商品id
     */
    private Long gId;

    /**
     * 购买数量
     */
    private Integer count;

    /**
     * 支付金额
     */
    private String paymoney;

    private TGoods goods;

    private static final long serialVersionUID = 1L;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getuId() {
        return uId;
    }

    public void setuId(Long uId) {
        this.uId = uId;
    }

    public Long getgId() {
        return gId;
    }

    public void setgId(Long gId) {
        this.gId = gId;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getPaymoney() {
        return paymoney;
    }

    public void setPaymoney(String paymoney) {
        this.paymoney = paymoney;
    }

    public TGoods getGoods() {
        return goods;
    }

    public void setGoods(TGoods goods) {
        this.goods = goods;
    }
}