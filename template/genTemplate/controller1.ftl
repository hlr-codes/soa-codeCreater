package com.minstone.kpi.web.api;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import springfox.documentation.annotations.ApiIgnore;
import org.apache.commons.lang3.StringEscapeUtils;
import com.alibaba.fastjson.JSONObject;
import com.minstone.common.web.BaseController;
import ${paramMap.packageName}.model.${table.modelName};
import ${paramMap.packageName}.service.I${table.modelName}Api;
import com.minstone.kpi.core.MyPageInfo;
import com.minstone.kpi.core.PageHelper;
import com.minstone.kpi.core.PageResultBean;
import com.minstone.kpi.core.ResultBean;
import com.minstone.kpi.core.exception.DataParseException;
import com.minstone.kpi.core.util.Request2ModelUtil;
import com.minstone.common.utils.StringUtils;

/**
 * ${table.comment}控制层
 * 
 * @copyright 广州明动软件股份有限公司 Copyright (c) ${.now?string("yyyy")}  
 * @since ${.now?string("yyyy-MM-dd")} 
 * @author ${paramMap.author}
 * @version 1.0
 * 
 */
@ApiIgnore
@Controller
@RequestMapping(value = "<#noparse>${adminPath}</#noparse>/${table.modelName?uncap_first}")
public class ${table.modelName}Controller  extends BaseController <#noparse>{</#noparse>
	@Autowired private I${table.modelName}Api api;
	
	/**
	 * 接口（获取单个）-------------
	 * @param request
	 * @return
	 * @author ${paramMap.author}
	 */
	@RequestMapping(value="/getOne")
	@ResponseBody
	public ResultBean<${table.modelName}> getOne(HttpServletRequest request) {
		String code = request.getParameter("code");
		if(StringUtils.isNotEmpty(code)){
			${table.modelName} entity = new ${table.modelName}();
			entity.setCode(code);
			${table.modelName} result = api.get(entity);
			return new ResultBean<${table.modelName}>(result);
		}
		throw new DataParseException("参数错误");
	}
	/**
	 * 接口（保存单个）-------------
	 * @param request
	 * @return
	 * @author ${paramMap.author}
	 */
	@RequestMapping(value="/save")
	@ResponseBody
	public ResultBean<String> save(HttpServletRequest request) {
		${table.modelName} entity = Request2ModelUtil.newCovert(${table.modelName}.class, request);
		boolean flag = api.saveOrUpdate(entity);
		if(flag){
			return new ResultBean<String>();
		}
		throw new DataParseException("保存失败");
	}
	
	/**
	 * 接口(支持分页和非分页)-------------
	 * @param request
	 * @return
	 * @author ${paramMap.author}
	 */
	@RequestMapping(value="/getList")
	@ResponseBody
	public ResultBean<?> getList(HttpServletRequest request,MyPageInfo page) {
		if(page!= null && page.isPage()){
			com.github.pagehelper.PageInfo<${table.modelName}> pageData = api.findPage(new PageHelper<${table.modelName}>().createPageInfo(page), new ${table.modelName}());
			return new PageResultBean<List<${table.modelName}>>(pageData.getList(),pageData);
		}
		else{
			List<${table.modelName}> list = api.findList(new ${table.modelName}());
			return new ResultBean<List<${table.modelName}>>(list);
		}
	}

	/**
	 * 参考接口（保存多个）-------------
	 * @param request
	 * @return
	 * @author ${paramMap.author}
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/saveMore")
	@ResponseBody
	public ResultBean<String> saveMore(HttpServletRequest request) {
		String data = request.getParameter("data");
		data = StringEscapeUtils.unescapeHtml4(data);
		List<Map> list = new ArrayList<Map>();  
        list = JSONObject.parseArray(data, Map.class);  
		for(Map map : list){
			${table.modelName} entity = Request2ModelUtil.newCovertObj(${table.modelName}.class, map);
			boolean flag = api.saveOrUpdate(entity);
			if(!flag){
				throw new DataParseException("保存失败");
			}
		}
		return new ResultBean<String>();
	}
	
	/**
	 * 参考接口（删除多个）-------------
	 * @param request
	 * @return
	 * @author ${paramMap.author}
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/delete")
	@ResponseBody
	public ResultBean<Boolean> delete(HttpServletRequest request){
		boolean result = false;
		String codes = request.getParameter("code");
		if(StringUtils.isEmpty(codes)){
			throw new DataParseException("删除失败，code参数值为空");
		}
		else{
			${table.modelName} entity = new ${table.modelName}();
			entity.setCode(codes);
			result = api.deleteAll(entity);
			return new ResultBean<Boolean>(result);
		}
		
	}
<#noparse>}</#noparse>
