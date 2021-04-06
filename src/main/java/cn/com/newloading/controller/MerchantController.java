package cn.com.newloading.controller;

import cn.com.newloading.bean.TAdmin;
import cn.com.newloading.bean.TMerchant;
import cn.com.newloading.bean.TMerchantAuditProgress;
import cn.com.newloading.bean.TUser;
import cn.com.newloading.bean.WithdrawDepositRecord;
import cn.com.newloading.service.MerchantService;
import cn.com.newloading.utils.Common;
import cn.com.newloading.utils.Result;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * 商户控制类
 */
@Controller
@RequestMapping("/merchant")
public class MerchantController extends BaseController {

    @Autowired
    MerchantService merchantService;

    /**
     * 注册页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/register")
    public String register(HttpServletRequest request, Model model){
        return "merchant/register";
    }

    /**
     * 注册业务
     * @param request
     * @return
     */
    @RequestMapping("/doRegister")
    @ResponseBody
    public Result doRegister(HttpServletRequest request){
        TMerchant merchant = new TMerchant();
        //商户基础信息
        String idStr = request.getParameter("id");
        merchant.setId(idStr == null ? null : Long.valueOf(idStr));
        merchant.setmName(request.getParameter("mName"));
        merchant.setmAcc(request.getParameter("mAcc"));
        merchant.setmPwd(request.getParameter("mPwd"));
        merchant.setmAddr(request.getParameter("mAddr"));
        merchant.setmEmail(request.getParameter("mEmail"));
        merchant.setmPhone(request.getParameter("mPhone"));
        merchant.setmBossIdentity(request.getParameter("mBossIdentity"));
        merchant.setmBossName(request.getParameter("mBossName"));
        merchant.setmBossPhone(request.getParameter("mBossPhone"));
        merchant.setmBossEmail(request.getParameter("mBossEmail"));
        return merchantService.doRegister(merchant);
    }

    /**
     * 登录页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/login")
    public String login(HttpServletRequest request, Model model){
        return "merchant/login";
    }

    /**
     * 登录动作
     * @param request
     * @return
     */
    @RequestMapping("/doLogin")
    @ResponseBody
    public Result doLogin(HttpServletRequest request){
        String mAcc = request.getParameter("mAcc");
        String mPwd = request.getParameter("mPwd");
        TMerchant tMerchant = merchantService.doLogin(mAcc, mPwd);
        if(tMerchant == null){
            return new Result("M88","账号或密码错误，登录失败!");
        }else if("30".equals(tMerchant.getStatus())){
            return new Result("M88","该商户还没审核通过");
        }else if("60".equals(tMerchant.getStatus())){
            return new Result("M88","该商户审核不通过");
        }else if("40".equals(tMerchant.getStatus())){
            return new Result("M88","该商户已被加入黑名单，请联系管理员");
        }else{
            request.getSession().setAttribute("merchant",tMerchant);
            return new Result("M00","登录成功");
        }
    }

    /**
     * 编辑页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/edit")
    public String edit(HttpServletRequest request,Model model){
        String id = request.getParameter("id");
        TMerchant merchant = merchantService.getMerchant(id);
        model.addAttribute("merchant",merchant);
        return "merchant/edit";
    }

    /**
     * 编辑动作
     * @param request
     * @return
     */
    @RequestMapping("/doEdit")
    @ResponseBody
    public Result doEdit(HttpServletRequest request){
        JSONObject jsonObject = (JSONObject) getParams(request);
        TMerchant merchant = new TMerchant();
        //商户基础信息
        merchant.setId(Long.valueOf(jsonObject.getString("id")));
        merchant.setmName(jsonObject.getString("mName"));
        merchant.setmAcc(jsonObject.getString("mAcc"));
        merchant.setmPwd(jsonObject.getString("mPwd"));
        merchant.setmAddr(jsonObject.getString("mAddr"));
        merchant.setmEmail(jsonObject.getString("mEmail"));
        merchant.setmPhone(jsonObject.getString("mPhone"));
        merchant.setmBossIdentity(jsonObject.getString("mBossIdentity"));
        merchant.setmBossName(jsonObject.getString("mBossName"));
        merchant.setmBossPhone(jsonObject.getString("mBossPhone"));
        merchant.setmEmail(jsonObject.getString("mBossEmail"));
        Result result = merchantService.doEdit(merchant);
        //修改信息成功，刷新session中的信息
        if("M00".equals(result.getCode())){
            request.getSession().setAttribute("merchant",merchant);
        }
        return result;
    }

    /**
     * 进度查看页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/progress")
    public String progress(HttpServletRequest request, Model model){
        String mAcc = request.getParameter("mAcc");
        String mPwd = request.getParameter("mPwd");
        if(StringUtils.isEmpty(mAcc) || StringUtils.isEmpty(mPwd)){
            return "merchant/progress";
        }
        Map<String, Object> map = merchantService.doQueryProgress(mAcc, mPwd);
        if(map == null){
            model.addAttribute("msg","账号或密码错误");
            return "merchant/progress";
        }
        TMerchant merchant = (TMerchant) map.get("merchant");
        List<TMerchantAuditProgress> pList = (List<TMerchantAuditProgress>) map.get("pList");
        model.addAttribute("merchant",merchant);
        model.addAttribute("pList",pList);
        return "merchant/progress";
    }

    /**
     * 查询进度
     * @param request
     * @return
     */
    @RequestMapping("/doQueryProgress")
    @ResponseBody
    public Result doQueryProgress(HttpServletRequest request){
        String mAcc = request.getParameter("mAcc");
        String mPwd = request.getParameter("mPwd");
        Map<String, Object> map = merchantService.doQueryProgress(mAcc, mPwd);
        if(map == null){
            return new Result("M88","账号或密码错误");
        }
        return new Result("M00","成功",map);
    }

    @RequestMapping("/manage")
    public String manage(HttpServletRequest request, Model model){
        TMerchant merchant = new TMerchant();
        merchant.setPage(Common.PAGE);
        merchant.setLimit(Common.LIMIT);
        merchant.setBegin((Common.PAGE - 1) * Common.LIMIT);
        merchant.setmName(params(request,model,"mName"));
        merchant.setmAcc(params(request,model,"mAcc"));
        merchant.setmCode(params(request,model,"mCode"));
        merchant.setmAddr(params(request,model,"mAddr"));
        merchant.setmEmail(params(request,model,"mEmail"));
        merchant.setmPhone(params(request,model,"mPhone"));
        List<TMerchant> merchants = merchantService.doQuery(merchant);
        model.addAttribute("merchants",merchants);
        model.addAttribute("page",Common.PAGE);
        model.addAttribute("limit",Common.LIMIT);
        return "merchant/manage";
    }

    @RequestMapping("/doQuery")
    @ResponseBody
    public Result doQuery(HttpServletRequest request){
        String params = (String)request.getParameter("params");
        JSONObject parem = (JSONObject) getParams(params);
        TMerchant merchant = new TMerchant();
        String page = parem.getString("page");
        merchant.setPage(Integer.valueOf(page));
        merchant.setLimit(Common.LIMIT);
        merchant.setBegin(merchant.getPage() * Common.LIMIT);
        merchant.setmName(StringUtils.isEmpty(parem.getString("mName")) ? null : parem.getString("mName"));
        merchant.setmCode(StringUtils.isEmpty(parem.getString("mCode")) ? null : parem.getString("mCode"));
        merchant.setmAddr(StringUtils.isEmpty(parem.getString("mAddr")) ? null : parem.getString("mAddr"));
        merchant.setmEmail(StringUtils.isEmpty(parem.getString("mEmail")) ? null : parem.getString("mEmail"));
        merchant.setmPhone(StringUtils.isEmpty(parem.getString("mPhone")) ? null : parem.getString("mPhone"));
        List<TMerchant> merchants = merchantService.doQuery(merchant);
        return new Result("M00","成功",merchants);
    }

    /**
     * 进度查看页面
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/detail")
    public String detail(HttpServletRequest request, Model model){
        String id = request.getParameter("id");
        String tp = request.getParameter("tp");
        TMerchant m = merchantService.getMerchant(id);
        Map<String, Object> map = merchantService.doQueryProgress(m.getmAcc(), m.getmPwd());
        TMerchant merchant = (TMerchant) map.get("merchant");
        List<TMerchantAuditProgress> pList = (List<TMerchantAuditProgress>) map.get("pList");
        model.addAttribute("merchant",merchant);
        model.addAttribute("pList",pList);
        model.addAttribute("tp",tp);
        return "merchant/detail";
    }

    @RequestMapping("/audit")
    @ResponseBody
    public Result audit(HttpServletRequest request){
        JSONObject jsonObject = (JSONObject) getParams(request);
        String id = jsonObject.getString("id");
        String auditOpinion = jsonObject.getString("auditOpinion");
        String status = jsonObject.getString("status");
        TAdmin admin = (TAdmin) request.getSession().getAttribute("admin");
        if(admin == null){
            return new Result("ERR9999","非法操作");
        }
        return merchantService.audit(id,status,auditOpinion);
    }

    @RequestMapping("/blacklist")
    @ResponseBody
    public Result blacklist(HttpServletRequest request){
        JSONObject jsonObject = (JSONObject) getParams(request);
        String id = jsonObject.getString("id");
        String status = jsonObject.getString("status");
        String auditOpinion;
        if("40".equals(status)) auditOpinion = "该商户已拉进黑名单";
        else auditOpinion = "该商户已拉出黑名单";
        TAdmin admin = (TAdmin) request.getSession().getAttribute("admin");
        if(admin == null){
            return new Result("ERR9999","非法操作");
        }
        return merchantService.audit(id,status,auditOpinion);
    }

    @RequestMapping("/wallet")
    public String wallet(HttpServletRequest request,Model model){
        String id = request.getParameter("id");
        TMerchant merchant = (TMerchant) request.getSession().getAttribute("merchant");
        if(merchant == null || !String.valueOf(merchant.getId()).equals(id)){
            return "merchant/login";
        }
        Map<String, Object> map = merchantService.toWallet(id);
        model.addAttribute("yue",map.get("yue"));
        model.addAttribute("records",map.get("records"));
        model.addAttribute("mid",id);
        return "merchant/wallet";
    }

    @RequestMapping("/withdraw")
    @ResponseBody
    public Result withdraw(HttpServletRequest request){
        JSONObject jsonObject = (JSONObject) getParams(request);
        WithdrawDepositRecord record = new WithdrawDepositRecord();
        record.setCardNo(jsonObject.getString("cardNo"));
        record.setMoney(BigDecimal.valueOf(Double.valueOf(jsonObject.getString("money"))));
        record.setmId(Long.valueOf(jsonObject.getString("mid")));
        return merchantService.withdraw(record);
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request){
        request.getSession().removeAttribute("merchant");
        return "merchant/login";
    }
}
