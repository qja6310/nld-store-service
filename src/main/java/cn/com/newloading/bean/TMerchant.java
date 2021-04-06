package cn.com.newloading.bean;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * t_merchant
 * @author 
 */
public class TMerchant extends BaseBean implements Serializable {
    private Long id;

    /**
     * 商户名
     */
    private String mName;

    /**
     * 商户编号
     */
    private String mCode;

    /**
     * 商户账号
     */
    private String mAcc;

    /**
     * 商品密码
     */
    private String mPwd;

    /**
     * 商户地址
     */
    private String mAddr;

    /**
     * 商户邮箱
     */
    private String mEmail;

    /**
     * 商户号码
     */
    private String mPhone;

    /**
     * 商户状态
     */
    private String status;

    /**
     * 商户老板身份证号
     */
    private String mBossIdentity;

    /**
     * 商户老板
     */
    private String mBossName;

    /**
     * 老板电话
     */
    private String mBossPhone;

    /**
     * 老板邮箱
     */
    private String mBossEmail;

    /**
     * 钱包
     */
    private BigDecimal mWallet;

    private static final long serialVersionUID = 1L;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getmName() {
        return mName;
    }

    public void setmName(String mName) {
        this.mName = mName;
    }

    public String getmCode() {
        return mCode;
    }

    public void setmCode(String mCode) {
        this.mCode = mCode;
    }

    public String getmAcc() {
        return mAcc;
    }

    public void setmAcc(String mAcc) {
        this.mAcc = mAcc;
    }

    public String getmPwd() {
        return mPwd;
    }

    public void setmPwd(String mPwd) {
        this.mPwd = mPwd;
    }

    public String getmAddr() {
        return mAddr;
    }

    public void setmAddr(String mAddr) {
        this.mAddr = mAddr;
    }

    public String getmEmail() {
        return mEmail;
    }

    public void setmEmail(String mEmail) {
        this.mEmail = mEmail;
    }

    public String getmPhone() {
        return mPhone;
    }

    public void setmPhone(String mPhone) {
        this.mPhone = mPhone;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getmBossIdentity() {
        return mBossIdentity;
    }

    public void setmBossIdentity(String mBossIdentity) {
        this.mBossIdentity = mBossIdentity;
    }

    public String getmBossName() {
        return mBossName;
    }

    public void setmBossName(String mBossName) {
        this.mBossName = mBossName;
    }

    public String getmBossPhone() {
        return mBossPhone;
    }

    public void setmBossPhone(String mBossPhone) {
        this.mBossPhone = mBossPhone;
    }

    public String getmBossEmail() {
        return mBossEmail;
    }

    public void setmBossEmail(String mBossEmail) {
        this.mBossEmail = mBossEmail;
    }

    public BigDecimal getmWallet() {
        return mWallet;
    }

    public void setmWallet(BigDecimal mWallet) {
        this.mWallet = mWallet;
    }
}