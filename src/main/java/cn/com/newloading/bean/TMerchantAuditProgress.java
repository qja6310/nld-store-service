package cn.com.newloading.bean;

import java.io.Serializable;
import java.util.Date;

/**
 * t_merchant_audit_progress
 * @author 
 */
public class TMerchantAuditProgress implements Serializable {
    private Long id;

    /**
     * 商户id
     */
    private Long mId;

    /**
     * 进度状态
     */
    private String status;

    /**
     * 审批意见
     */
    private String auditOpinion;

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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAuditOpinion() {
        return auditOpinion;
    }

    public void setAuditOpinion(String auditOpinion) {
        this.auditOpinion = auditOpinion;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
    }
}