package cn.com.newloading.bean;

import java.io.Serializable;

/**
 * t_address
 * @author 
 */
public class TAddress implements Serializable {
    private Long id;

    /**
     * 用户id
     */
    private Long uId;

    /**
     * 详细地址
     */
    private String detailAddr;

    /**
     * 联系人
     */
    private String conName;

    /**
     * 联系人电话
     */
    private String conPhone;

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

    public String getDetailAddr() {
        return detailAddr;
    }

    public void setDetailAddr(String detailAddr) {
        this.detailAddr = detailAddr;
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
}