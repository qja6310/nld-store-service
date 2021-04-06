package cn.com.newloading.bean;

import java.io.Serializable;
import java.util.List;

/**
 * t_menu
 * @author 
 */
public class TMenu implements Serializable {
    private Integer id;

    /**
     * 菜单名
     */
    private String menuname;

    /**
     * 创建时间
     */
    private String createtime;

    /**
     * 状态
     */
    private String status;

    /**
     * 序号
     */
    private Integer serialnumber;

    /**
     * 父id
     */
    private Integer pid;

    /**
     * 路径
     */
    private String path;

    private List<TMenu> menus;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMenuname() {
        return menuname;
    }

    public void setMenuname(String menuname) {
        this.menuname = menuname;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getSerialnumber() {
        return serialnumber;
    }

    public void setSerialnumber(Integer serialnumber) {
        this.serialnumber = serialnumber;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public List<TMenu> getMenus() {
        return menus;
    }

    public void setMenus(List<TMenu> menus) {
        this.menus = menus;
    }
}