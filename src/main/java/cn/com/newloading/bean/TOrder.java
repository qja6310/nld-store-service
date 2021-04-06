package cn.com.newloading.bean;

import java.io.Serializable;
import java.util.Date;

/**
 * t_order
 * @author 
 */
public class TOrder extends BaseBean implements Serializable {
    private Long id;

    /**
     * 用户id
     */
    private Long uId;

    /**
     * 商户id
     */
    private Long mId;

    /**
     * 商品id
     */
    private Long gId;

    /**
     * 订单号
     */
    private String oNumber;

    /**
     * 联系人
     */
    private String conName;

    /**
     * 联系电话
     */
    private String conPhone;

    /**
     * 收货地址
     */
    private String conAddr;

    /**
     * 购买数量
     */
    private Integer count;

    /**
     * 支付金额
     */
    private String payMoney;

    /**
     * 备注
     */
    private String oRemark;

    /**
     * 状态
     */
    private String status;

    /**
     * 创建时间
     */
    private Date cTime;
    private String cfTime;

    private TGoods goods;

    private String mName;//商户名

    private TMerchant merchant;//商户

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

    public Long getmId() {
        return mId;
    }

    public void setmId(Long mId) {
        this.mId = mId;
    }

    public Long getgId() {
        return gId;
    }

    public void setgId(Long gId) {
        this.gId = gId;
    }

    public String getoNumber() {
        return oNumber;
    }

    public void setoNumber(String oNumber) {
        this.oNumber = oNumber;
    }

    public String getConName() {
        return conName;
    }

    public void setConName(String conName) {
        this.conName = conName;
    }

    public String getConPhone() {
        return conPhone;
    }

    public void setConPhone(String conPhone) {
        this.conPhone = conPhone;
    }

    public String getConAddr() {
        return conAddr;
    }

    public void setConAddr(String conAddr) {
        this.conAddr = conAddr;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getPayMoney() {
        return payMoney;
    }

    public void setPayMoney(String payMoney) {
        this.payMoney = payMoney;
    }

    public String getoRemark() {
        return oRemark;
    }

    public void setoRemark(String oRemark) {
        this.oRemark = oRemark;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getcTime() {
        return cTime;
    }

    public void setcTime(Date cTime) {
        this.cTime = cTime;
    }

    public TGoods getGoods() {
        return goods;
    }

    public void setGoods(TGoods goods) {
        this.goods = goods;
    }

    public String getmName() {
        return mName;
    }

    public void setmName(String mName) {
        this.mName = mName;
    }

    public TMerchant getMerchant() {
        return merchant;
    }

    public void setMerchant(TMerchant merchant) {
        this.merchant = merchant;
    }

    public String getCfTime() {
        return cfTime;
    }

    public void setCfTime(String cfTime) {
        this.cfTime = cfTime;
    }
}