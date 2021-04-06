package cn.com.newloading.controller;

import cn.com.newloading.bean.TShoppingCar;
import cn.com.newloading.service.TrolleyService;
import cn.com.newloading.utils.Result;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/trolley")
public class TrolleyController extends BaseController {

    @Autowired
    TrolleyService trolleyService;

    @RequestMapping("/join")
    @ResponseBody
    public Result join(HttpServletRequest request){
        JSONObject jsonObject = (JSONObject) getParams(request);
        TShoppingCar car = new TShoppingCar();
        car.setCount(Integer.valueOf(jsonObject.getString("count")));
        car.setgId(Long.valueOf(jsonObject.getString("gid")));
        car.setuId(Long.valueOf(jsonObject.getString("uid")));
        return trolleyService.join(car);
    }

    @RequestMapping("/list")
    public String list(HttpServletRequest request, Model model){
        String uid = request.getParameter("uid");
        List<TShoppingCar> list = trolleyService.list(uid);
        model.addAttribute("pcList",list);
        return "trolley/list";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Result delete(HttpServletRequest request){
        String tid = (String) getParams(request);
        return trolleyService.delete(tid);
    }
}
