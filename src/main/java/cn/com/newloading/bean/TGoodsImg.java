package cn.com.newloading.bean;

import java.io.Serializable;

/**
 * t_goods_img
 * @author 
 */
public class TGoodsImg implements Serializable {
    private Long id;

    /**
     * 商品id
     */
    private Long gId;

    /**
     * 图片地址
     */
    private String imgUrl;

    /**
     * 图片标题
     */
    private String imgTitle;

    private static final long serialVersionUID = 1L;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getgId() {
        return gId;
    }

    public void setgId(Long gId) {
        this.gId = gId;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public String getImgTitle() {
        return imgTitle;
    }

    public void setImgTitle(String imgTitle) {
        this.imgTitle = imgTitle;
    }
}