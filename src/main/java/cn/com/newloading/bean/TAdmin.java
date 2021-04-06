package cn.com.newloading.bean;

import java.io.Serializable;

/**
 * t_admin
 * @author 
 */
public class TAdmin extends BaseBean implements Serializable {
    private Long id;

    /**
     * 管理员姓名
     */
    private String aName;

    /**
     * 账号
     */
    private String aAcc;

    /**
     * 密码
     */
    private String aPwd;

    /**
     * 号码
     */
    private String aPhone;

    /**
     * 邮箱
     */
    private String aEmail;

    /**
     * 超级管理员标识
     */
    private String isSuper;

    private static final long serialVersionUID = 1L;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getaName() {
        return aName;
    }

    public void setaName(String aName) {
        this.aName = aName;
    }

    public String getaAcc() {
        return aAcc;
    }

    public void setaAcc(String aAcc) {
        this.aAcc = aAcc;
    }

    public String getaPwd() {
        return aPwd;
    }

    public void setaPwd(String aPwd) {
        this.aPwd = aPwd;
    }

    public String getaPhone() {
        return aPhone;
    }

    public void setaPhone(String aPhone) {
        this.aPhone = aPhone;
    }

    public String getaEmail() {
        return aEmail;
    }

    public void setaEmail(String aEmail) {
        this.aEmail = aEmail;
    }

    public String getIsSuper() {
        return isSuper;
    }

    public void setIsSuper(String isSuper) {
        this.isSuper = isSuper;
    }
}