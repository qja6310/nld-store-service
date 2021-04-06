package cn.com.newloading.bean;

import java.io.Serializable;
import java.util.Date;

/**
 * t_order_progress
 * @author 
 */
public class TOrderProgress implements Serializable {
    private Long id;

    /**
     * 订单id
     */
    private Long oId;

    /**
     * 状态
     */
    private String status;

    /**
     * 说明
     */
    private String opRemark;

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

    public Long getoId() {
        return oId;
    }

    public void setoId(Long oId) {
        this.oId = oId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOpRemark() {
        return opRemark;
    }

    public void setOpRemark(String opRemark) {
        this.opRemark = opRemark;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
    }
}