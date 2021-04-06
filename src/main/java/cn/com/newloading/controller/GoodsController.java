package cn.com.newloading.controller;

import javax.servlet.http.HttpServletRequest;

import cn.com.newloading.bean.TGoods;
import cn.com.newloading.bean.TGoodsAuditProgress;
import cn.com.newloading.bean.TGoodsType;
import cn.com.newloading.utils.Common;
import cn.com.newloading.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;

import cn.com.newloading.service.GoodsService;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/goods")
public class GoodsController extends BaseController{

	@Autowired
	private GoodsService goodsService;

	/**
	 * 商品首页
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/index")
	public String index(HttpServletRequest request,Model model){
		String keyword = request.getParameter("keyword");
		String mid = request.getParameter("mid");
		String typeIds = request.getParameter("typeIds");
		model.addAttribute("keyword",keyword);
		model.addAttribute("typeIds",typeIds);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("keyword",keyword);
		jsonObject.put("mid",mid);
		TGoods goods = getQueryCondition(jsonObject);
		goods.setStatus("70");//只查询上架商品
		goods.setPage(Common.PAGE);
		goods.setLimit(Common.GOODS_INDEX_LIMIT);
		goods.setBegin((Common.PAGE - 1) * Common.GOODS_INDEX_LIMIT);
		List<TGoods> goodsList = goodsService.index(goods,typeIds);
		model.addAttribute("goodsList",goodsList);
		model.addAttribute("page",goods.getPage());
		List<TGoodsType> types = goodsService.types();
		if(!Common.isBlank(typeIds)){//选中的复选框
			String[] typeArr = typeIds.split(",");
			for(int i = 0;i < typeArr.length;i++){
				for (int j = 0;j < types.size();j++){
					if(typeArr[i].equals(String.valueOf(types.get(j).getId()))){
						types.get(j).setChecked("1");
					}
				}
			}
		}
		model.addAttribute("types",types);
		request.getSession().setAttribute("url","/goods/index");
		return "goods/index";
	}

	@RequestMapping("/user/doQuery")
	@ResponseBody
	public Result doQueryForUser(HttpServletRequest request){
		JSONObject jsonObject = (JSONObject) getParams(request);
		String typeIds = jsonObject.getString("typeIds");
		TGoods goods = getQueryCondition(jsonObject);
		goods.setPage(Integer.valueOf(jsonObject.getString("page")));
		goods.setLimit(Common.GOODS_INDEX_LIMIT);
		goods.setBegin(goods.getPage() * Common.GOODS_INDEX_LIMIT);
		List<TGoods> goodsList = goodsService.index(goods,typeIds);
		return new Result("G00","成功",goodsList);
	}

	@RequestMapping("/toAdd")
	public String toAdd(HttpServletRequest request,Model model){
		String mid = request.getParameter("mid");
		List<TGoodsType> types = goodsService.types();
		model.addAttribute("types",types);
		model.addAttribute("mid",mid);
		return "goods/add";
	}

	@RequestMapping("/submit")
	@ResponseBody
	public Result submit(HttpServletRequest request){
		TGoods goods = getGoods(request);
		return goodsService.submit(goods);
	}
	
	@RequestMapping("/manage")
	public String manage(HttpServletRequest request, Model model) {
		TGoods goods = getQueryCondition(request);
		goods.setPage(Common.PAGE);
		goods.setLimit(Common.LIMIT);
		goods.setBegin((Common.PAGE - 1) * Common.LIMIT);
		String mid  = request.getParameter("mid");
		goods.setmId(Common.isBlank(mid) ? null : Long.valueOf(mid));
		String r;
		if(!Common.isBlank(mid)) r = "m";
		else r = "a";
		model.addAttribute("r",r);
		List<TGoods> goodsList = goodsService.doQuery(goods,r);
		model.addAttribute("goodsList",goodsList);
		model.addAttribute("keyword",goods.getgTitle());
		model.addAttribute("mid",mid);
		model.addAttribute("status",goods.getStatus());
		model.addAttribute("type",goods.getgType());
		model.addAttribute("page",Common.PAGE);
		List<TGoodsType> types = goodsService.types();
		model.addAttribute("types",types);
		return "goods/manage";
	}
	
	@RequestMapping("/doQuery")
	@ResponseBody
	public Result doQuery(HttpServletRequest request) {
		JSONObject jsonObject = (JSONObject) getParams(request);
		TGoods goods = getQueryCondition(jsonObject);
		String mid  = jsonObject.getString("mid");
		goods.setmId(Common.isBlank(mid) ? null : Long.valueOf(mid));
		String r = jsonObject.getString("roleFlag");
		String page = jsonObject.getString("page");
		goods.setPage(Integer.valueOf(page));
		goods.setLimit(Common.LIMIT);
		goods.setBegin(goods.getPage() * Common.LIMIT);
		List<TGoods> goodsList = goodsService.doQuery(goods,r);
		return new Result("G00","成功",goodsList);
	}

	/**
	 * 获取查询参数
	 * @param obj
	 * @return
	 */
	private TGoods getQueryCondition(Object obj){
		TGoods goods = new TGoods();
		String keyword = null;
		String status = null;
		String mid = null;
		String type = null;
		if(obj == null){
			return goods;
		}else if(obj instanceof HttpServletRequest){
			HttpServletRequest request = (HttpServletRequest) obj;
			keyword = request.getParameter("keyword");
			status = request.getParameter("status");
			mid = request.getParameter("mid");
			type = request.getParameter("type");
		}else if(obj instanceof  JSONObject){
			JSONObject jsonObject = (JSONObject) obj;
			keyword = jsonObject.getString("keyword");
			status = jsonObject.getString("status");
			mid = jsonObject.getString("mid");
			type = jsonObject.getString("type");
		}else if(obj instanceof String){
			keyword = (String) obj;
		}else{
			return goods;
		}
		goods.setmId(Common.isBlank(mid) ? null : Long.valueOf(mid));
		if(!Common.isBlank(keyword)){
			goods.setgAuthor(keyword);
			goods.setgDetail(keyword);
			goods.setgTitle(keyword);
			goods.setgPress(keyword);
		}
		if(!Common.isBlank(status)) goods.setStatus(status);
		if(!Common.isBlank(type)) goods.setgType(Long.valueOf(type));
		return goods;
	}

	@RequestMapping("/edit")
	public String edit(HttpServletRequest request,Model model){
		String mid = request.getParameter("mid");
		if(Common.isBlank(mid)) model.addAttribute("r","a");
		else{
			model.addAttribute("r","m");
			model.addAttribute("mid",mid);
		}
		String id = request.getParameter("id");
		Map<String, Object> map = goodsService.detail(id);
		List<TGoodsType> types = goodsService.types();
		model.addAttribute("types",types);
		model.addAttribute("goods",map.get("goods"));
		model.addAttribute("imgs",map.get("imgs"));
		model.addAttribute("progressList",map.get("progressList"));
		model.addAttribute("imgCount",map.get("imgCount"));
		model.addAttribute("flag",request.getParameter("flag"));
		return "goods/edit";
	}

	@RequestMapping("/update")
	@ResponseBody
	public Result update(HttpServletRequest request){
		TGoods goods = getGoods(request);
		return goodsService.update(goods);
	}

	/**
	 * 前端传参进来获取一个goods参数
	 * @param request
	 * @return
	 */
	private TGoods getGoods(HttpServletRequest request){
		JSONObject jsonObject = (JSONObject) getParams(request);
		TGoods goods = new TGoods();
		String id = jsonObject.getString("id");
		String mid = jsonObject.getString("mid");
		goods.setId(Common.isBlank(id) ? null : Long.valueOf(id));
		goods.setgTitle(jsonObject.getString("gTitle"));
		goods.setmId(Common.isBlank(mid) ? null : Long.valueOf(mid));
		goods.setgDetail(jsonObject.getString("gDetail"));
		goods.setStatus(jsonObject.getString("status"));
		goods.setgAuthor(jsonObject.getString("gAuthor"));
		goods.setgPress(jsonObject.getString("gPress"));
		if(jsonObject.getString("gInventory") != null)
			goods.setgInventory(Integer.valueOf(jsonObject.getString("gInventory")));
		if(jsonObject.getString("gPrice") != null)
			goods.setgPrice(BigDecimal.valueOf(Double.valueOf(jsonObject.getString("gPrice"))));
		//图片对象
		goods.setImgPath(jsonObject.getString("imgPath"));
		goods.setImgTitle(jsonObject.getString("imgTitle"));
		goods.setgType(Long.valueOf(jsonObject.getString("gType")));
		return goods;
	}

	@RequestMapping("/delete")
	@ResponseBody
	public Result delete(HttpServletRequest request){
		String id = (String) getParams(request);
		return goodsService.delete(id);
	}

	@RequestMapping("/audit")
	@ResponseBody
	public Result audit(HttpServletRequest request){
		JSONObject jsonObject = (JSONObject) getParams(request);
		TGoodsAuditProgress progress = new TGoodsAuditProgress();
		progress.setgId(Long.valueOf(jsonObject.getString("gid")));
		progress.setStatus(jsonObject.getString("status"));
		progress.setAuditOpinion(jsonObject.getString("auditOpinion"));
		return goodsService.audit(progress);
	}

	/**
	 * 购买商品页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/purchase")
	public String purchase(HttpServletRequest request,Model model){
		String id = request.getParameter("id");
		String count = request.getParameter("count");
		if(Common.isBlank(count)) count = "1";
		model.addAttribute("count",count);
		TGoods goods = goodsService.purchase(id);
		model.addAttribute("goods",goods);
		return "goods/purchase";
	}
}
