package cn.com.newloading.bean;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

/**
 * t_user
 * @author 
 */
public class TUser implements Serializable {
    private Long id;

    /**
     * 用户名
     */
    private String uName;

    /**
     * 密码
     */
    private String uPwd;

    /**
     * 账号
     */
    private String uAcc;

    /**
     * 身份证号
     */
    private String uIdentify;

    /**
     * 电话
     */
    private String uPhone;

    /**
     * 邮箱
     */
    private String uEmail;

    /**
     * 钱包
     */
    private BigDecimal uWallet;

    private List<TAddress> addressList;

    private static final long serialVersionUID = 1L;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public BigDecimal getuWallet() {
        return uWallet;
    }

    public void setuWallet(BigDecimal uWallet) {
        this.uWallet = uWallet;
    }

    public String getuName() {
        return uName;
    }

    public void setuName(String uName) {
        this.uName = uName;
    }

    public String getuPwd() {
        return uPwd;
    }

    public void setuPwd(String uPwd) {
        this.uPwd = uPwd;
    }

    public String getuAcc() {
        return uAcc;
    }

    public void setuAcc(String uAcc) {
        this.uAcc = uAcc;
    }

    public String getuIdentify() {
        return uIdentify;
    }

    public void setuIdentify(String uIdentify) {
        this.uIdentify = uIdentify;
    }

    public String getuPhone() {
        return uPhone;
    }

    public void setuPhone(String uPhone) {
        this.uPhone = uPhone;
    }

    public String getuEmail() {
        return uEmail;
    }

    public void setuEmail(String uEmail) {
        this.uEmail = uEmail;
    }

    public List<TAddress> getAddressList() {
        return addressList;
    }

    public void setAddressList(List<TAddress> addressList) {
        this.addressList = addressList;
    }
}