package cn.com.newloading.bean;

import java.io.Serializable;

/**
 * t_role
 * @author 
 */
public class TRole implements Serializable {
    private Long id;

    /**
     * 角色名
     */
    private String rName;

    /**
     * 角色编号
     */
    private String rCode;

    private String checked;

    private static final long serialVersionUID = 1L;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getrName() {
        return rName;
    }

    public void setrName(String rName) {
        this.rName = rName;
    }

    public String getrCode() {
        return rCode;
    }

    public void setrCode(String rCode) {
        this.rCode = rCode;
    }

    public String getChecked() {
        return checked;
    }

    public void setChecked(String checked) {
        this.checked = checked;
    }
}