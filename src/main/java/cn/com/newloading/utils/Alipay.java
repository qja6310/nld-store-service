package cn.com.newloading.utils;

public class Alipay {
    private String orderNo;//订单号
    private String orderMoney;//订单金额
    private String objName;//项目名称
    private String remark;//描述
    public Alipay(){

    }
    public Alipay(String orderNo, String orderMoney, String objName){
        this.orderNo = orderNo;
        this.orderMoney = orderMoney;
        this.objName = objName;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getOrderMoney() {
        return orderMoney;
    }

    public void setOrderMoney(String orderMoney) {
        this.orderMoney = orderMoney;
    }

    public String getObjName() {
        return objName;
    }

    public void setObjName(String objName) {
        this.objName = objName;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
