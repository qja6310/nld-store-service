package cn.com.newloading.bean;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * withdraw_deposit_record
 * @author 
 */
public class WithdrawDepositRecord implements Serializable {
    private Long id;

    /**
     * 商户id
     */
    private Long mId;

    /**
     * 金额
     */
    private BigDecimal money;

    /**
     * 银行卡号
     */
    private String cardNo;

    /**
     * 操作时间
     */
    private Date operateTime;

    private static final long serialVersionUID = 1L;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getmId() {
        return mId;
    }

    public void setmId(Long mId) {
        this.mId = mId;
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

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
    }
}