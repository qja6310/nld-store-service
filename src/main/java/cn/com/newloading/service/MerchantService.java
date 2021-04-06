package cn.com.newloading.service;

import cn.com.newloading.bean.TMerchant;
import cn.com.newloading.bean.WithdrawDepositRecord;
import cn.com.newloading.utils.Result;

import java.util.List;
import java.util.Map;

public interface MerchantService {

    /**
     * 注册商户信息
     * @param merchant
     * @return
     */
    Result doRegister(TMerchant merchant);

    /**
     * 商户登陆
     * @param mAcc
     * @param mPwd
     * @return
     */
    TMerchant doLogin(String mAcc, String mPwd);

    /**
     * 获取商户信息
     * @param id
     * @return
     */
    TMerchant getMerchant(String id);

    /**
     * 修改商户信息
     * @param merchant
     * @return
     */
    Result doEdit(TMerchant merchant);

    /**
     * 查询审批进度
     * @param mAcc
     * @param mPwd
     * @return
     */
    Map<String,Object> doQueryProgress(String mAcc,String mPwd);

    /**
     * 商户查询
     * @param merchant
     * @return
     */
    List<TMerchant> doQuery(TMerchant merchant);

    /**
     * 审核
     * @param id
     * @param auditOpinion
     * @return
     */
    Result audit(String id,String status,String auditOpinion);

    /**
     * 前往钱包
     * @param id
     * @return
     */
    Map<String,Object> toWallet(String id);

    /**
     * 提现
     * @param record
     * @return
     */
    Result withdraw(WithdrawDepositRecord record);
}
