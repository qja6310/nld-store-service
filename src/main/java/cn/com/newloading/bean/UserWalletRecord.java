package cn.com.newloading.bean;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * user_wallet_record
 * @author 
 */
public class UserWalletRecord implements Serializable {
    private Long id;

    /**
     * 用户id
     */
    private Long uid;

    /**
     * 类型  10-充值   40-提现  50-消费  60-退款
     */
    private String type;

    /**
     * 交易金额
     */
    private BigDecimal money;

    /**
     * 余额
     */
    private BigDecimal yue;

    /**
     * 银行卡号
     */
    private String cardNo;

    /**
     * 操作时间
     */
    private Date opreateTime;

    /**
     * 说明描述
     */
    private String uwrRemark;

    private static final long serialVersionUID = 1L;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUid() {
        return uid;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public BigDecimal getMoney() {
        return money;
    }

    public void setMoney(BigDecimal money) {
        this.money = money;
    }

    public String getCardNo() {
        return cardNo;
    }

    public void setCardNo(String cardNo) {
        this.cardNo = cardNo;
    }

    public Date getOpreateTime() {
        return opreateTime;
    }

    public void setOpreateTime(Date opreateTime) {
        this.opreateTime = opreateTime;
    }

    public String getUwrRemark() {
        return uwrRemark;
    }

    public void setUwrRemark(String uwrRemark) {
        this.uwrRemark = uwrRemark;
    }

    public BigDecimal getYue() {
        return yue;
    }

    public void setYue(BigDecimal yue) {
        this.yue = yue;
    }
}