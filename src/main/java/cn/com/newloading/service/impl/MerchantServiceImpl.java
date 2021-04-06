package cn.com.newloading.service.impl;

import cn.com.newloading.bean.TMerchant;
import cn.com.newloading.bean.TMerchantAuditProgress;
import cn.com.newloading.bean.TUser;
import cn.com.newloading.bean.WithdrawDepositRecord;
import cn.com.newloading.dao.TMerchantAuditProgressDao;
import cn.com.newloading.dao.TMerchantDao;
import cn.com.newloading.dao.WithdrawDepositRecordDao;
import cn.com.newloading.service.MerchantService;
import cn.com.newloading.utils.RandomCode;
import cn.com.newloading.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class MerchantServiceImpl implements MerchantService {

    @Autowired
    TMerchantDao tMerchantDao;
    @Autowired
    TMerchantAuditProgressDao progressDao;
    @Autowired
    WithdrawDepositRecordDao recordDao;

    @Override
    public Result doRegister(TMerchant merchant) {
        /** 查询账号是否存在 */
        int c = tMerchantDao.checkMerchantAcc(merchant.getmAcc());
        if(c > 0){
            return new Result("M99","账号已存在，换一个试试");
        }
        /** id为空，说明是新增，不为空说明是审核不通过，重新提交的 */
        if(merchant.getId() == null){
            //生成商户编码
            merchant.setmCode(getMerchantCode());
            merchant.setStatus("30");//待审核
            merchant.setmWallet(BigDecimal.ZERO);
            int i = tMerchantDao.insertSelective(merchant);
            if(i == 1){
                //插入商户审核进度表
                TMerchantAuditProgress progress = new TMerchantAuditProgress();
                progress.setmId(merchant.getId());
                progress.setStatus(merchant.getStatus());
                progress.setAuditOpinion("材料提交成功");
                progress.setOperateTime(new Date());
                progressDao.insertSelective(progress);
                return new Result("M00","材料提交成功,等待审核");
            }else{
                return new Result("M99","操作失败！");
            }
        }else{
            merchant.setStatus("30");
            int i = tMerchantDao.updateByPrimaryKeySelective(merchant);
            if(i == 1){
                //插入商户审核进度表
                TMerchantAuditProgress progress = new TMerchantAuditProgress();
                progress.setmId(merchant.getId());
                progress.setStatus("30");
                progress.setAuditOpinion("材料提交成功,等待审核");
                progress.setOperateTime(new Date());
                progressDao.insertSelective(progress);
                return new Result("M00","提交成功");
            }else{
                return new Result("M99","操作失败！");
            }
        }
    }

    @Override
    public TMerchant doLogin(String mAcc, String mPwd) {
        return tMerchantDao.doLogin(mAcc,mPwd);
    }

    @Override
    public TMerchant getMerchant(String id) {
        return tMerchantDao.selectByPrimaryKey(Long.valueOf(id));
    }

    @Override
    public Result doEdit(TMerchant merchant) {
        /** 查询账号是否存在 */
        int c = tMerchantDao.checkMerchantAcc2(merchant.getmAcc(),merchant.getId());
        if(c > 0){
            return new Result("M99","账号已存在，换一个试试");
        }
        int i = tMerchantDao.updateByPrimaryKeySelective(merchant);
        if(i > 0){
            return new Result("M00","操作成功！");
        }
        return new Result("M77","操作失败！");
    }

    @Override
    public Map<String, Object> doQueryProgress(String mAcc, String mPwd) {
        TMerchant tMerchant = tMerchantDao.doLogin(mAcc, mPwd);
        if(tMerchant == null){
            return null;
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("merchant",tMerchant);
        List<TMerchantAuditProgress> pList = progressDao.queryProgress(tMerchant.getId());
        map.put("pList",pList);
        return map;
    }

    @Override
    public List<TMerchant> doQuery(TMerchant merchant) {
        return tMerchantDao.doQuery(merchant);
    }

    @Override
    public Result audit(String id,String status, String auditOpinion) {
        //修改商户状态
        TMerchant merchant = new TMerchant();
        merchant.setId(Long.valueOf(id));
        merchant.setStatus(status);
        int i = tMerchantDao.updateByPrimaryKeySelective(merchant);
        if(i > 0){
            TMerchantAuditProgress progress = new TMerchantAuditProgress();
            progress.setmId(Long.valueOf(id));
            progress.setStatus(status);
            progress.setAuditOpinion(auditOpinion);
            progress.setOperateTime(new Date());
            progressDao.insertSelective(progress);
            return new Result("M00","操作成功！");
        }
        return new Result("M66","操作失败");
    }

    @Override
    public Map<String, Object> toWallet(String id) {
        Map<String,Object> map = new HashMap<>();
        //获取商户余额
        TMerchant merchant = tMerchantDao.selectByPrimaryKey(Long.valueOf(id));
        String yue = merchant.getmWallet().toString();
        map.put("yue",yue);
        //获取所有的提现记录
        List<WithdrawDepositRecord> records = recordDao.queryByMid(Long.valueOf(id));
        map.put("records",records);
        return map;
    }

    @Override
    public Result withdraw(WithdrawDepositRecord record) {
        /** 减少余额 */
        TMerchant merchant = tMerchantDao.selectByPrimaryKey(record.getmId());
        TMerchant m = new TMerchant();
        m.setId(merchant.getId());
        double v = merchant.getmWallet().doubleValue();
        double n = record.getMoney().doubleValue();
        double r = v - n;
        m.setmWallet(BigDecimal.valueOf(r));
        int i = tMerchantDao.updateByPrimaryKeySelective(m);
        if(i > 0){
            //插入记录表
            record.setOperateTime(new Date());
            recordDao.insertSelective(record);
            return new Result("M00","操作成功！");
        }
        return new Result("M99","操作失败！");
    }

    /**
     * 获取商户编码
     * @return
     */
    private String getMerchantCode(){
        String code = null;
        while (true){
            code = RandomCode.generateCode();
            int i = tMerchantDao.checkMerchantCode(code);
            if(i == 0){
                return code;
            }
        }
    }
}
