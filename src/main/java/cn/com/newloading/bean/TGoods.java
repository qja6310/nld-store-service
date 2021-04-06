package cn.com.newloading.bean;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

/**
 * t_goods
 * @author 
 */
public class TGoods extends BaseBean implements Serializable {
    private Long id;

    /**
     * 商户id
     */
    private Long mId;

    /**
     * 标题
     */
    private String gTitle;

    /**
     * 详情
     */
    private String gDetail;

    /**
     * 单价
     */
    private BigDecimal gPrice;

    /**
     * 库存
     */
    private Integer gInventory;

    /**
     * 状态
     */
    private String status;

    /**
     * 作者
     */
    private String gAuthor;

    /**
     * 出版社
     */
    private String gPress;

    /**
     * 类别
     */
    private Long gType;

    private String mid;//商户id

    private String mName;//商家

    private String mCode;//商家编码

    private String imgPath;//图片路径

    private String imgTitle;//图片标题

    private List<TGoodsImg> imgList;

    private String typeIds;

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

    public String getgTitle() {
        return gTitle;
    }

    public void setgTitle(String gTitle) {
        this.gTitle = gTitle;
    }

    public String getgDetail() {
        return gDetail;
    }

    public void setgDetail(String gDetail) {
        this.gDetail = gDetail;
    }

    public BigDecimal getgPrice() {
        return gPrice;
    }

    public void setgPrice(BigDecimal gPrice) {
        this.gPrice = gPrice;
    }

    public Integer getgInventory() {
        return gInventory;
    }

    public void setgInventory(Integer gInventory) {
        this.gInventory = gInventory;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getgAuthor() {
        return gAuthor;
    }

    public void setgAuthor(String gAuthor) {
        this.gAuthor = gAuthor;
    }

    public String getgPress() {
        return gPress;
    }

    public void setgPress(String gPress) {
        this.gPress = gPress;
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

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getImgTitle() {
        return imgTitle;
    }

    public void setImgTitle(String imgTitle) {
        this.imgTitle = imgTitle;
    }

    public String getMid() {
        return mid;
    }

    public void setMid(String mid) {
        this.mid = mid;
    }

    public List<TGoodsImg> getImgList() {
        return imgList;
    }

    public void setImgList(List<TGoodsImg> imgList) {
        this.imgList = imgList;
    }

    public Long getgType() {
        return gType;
    }

    public void setgType(Long gType) {
        this.gType = gType;
    }

    public String getTypeIds() {
        return typeIds;
    }

    public void setTypeIds(String typeIds) {
        this.typeIds = typeIds;
    }
}