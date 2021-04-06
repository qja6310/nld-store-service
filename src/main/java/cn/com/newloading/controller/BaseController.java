package cn.com.newloading.controller;

import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;

public class BaseController {

    Logger logger = LoggerFactory.getLogger(getClass());

    /**
     * 前端获取参数
     * @param jsonStr
     * @return
     */
    public Object getParams(String jsonStr){
        try {
            JSONObject jsonObject = JSONObject.parseObject(jsonStr);
            return jsonObject;
        }catch (Exception e){
            logger.error("转json失败");
            return jsonStr;
        }
    }

    /**
     * 前端获取参数
     * @param request
     * @return
     */
    public Object getParams(HttpServletRequest request){
        String jsonStr = request.getParameter("params");
        try {
            JSONObject jsonObject = JSONObject.parseObject(jsonStr);
            return jsonObject;
        }catch (Exception e){
            logger.error("转json失败");
            return jsonStr;
        }
    }

    /**
     * 参数
     * @param request
     * @param model
     * @param paramName
     * @return
     */
    public String params(HttpServletRequest request, Model model, String paramName){
        String parameVal = request.getParameter(paramName);
        model.addAttribute(paramName,parameVal);
        return StringUtils.isEmpty(parameVal) ? null : parameVal;
    }
}
