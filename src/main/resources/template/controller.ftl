package com.absurd.framework.web.controller;

import java.util.Map;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.absurd.framework.common.vo.PageView;
import com.absurd.framework.domain.${tableClassName};
import com.absurd.framework.domain.AdmModule;
import com.absurd.framework.domain.AdmUser;
import com.absurd.framework.service.${tableClassName}Service;
import com.absurd.framework.service.AdmUserAuthService;
import com.absurd.framework.util.SessionUtil;
import com.absurd.web.common.check.CheckModel;
import com.absurd.web.common.check.CheckUtil;
import com.absurd.web.common.util.ParamUtil;
import com.absurd.web.controller.BaseController;
import com.absurd.web.util.JsonUtil;

@Controller
public class ${tableClassName}Controller extends BaseController{
	private String listUrl = "/${tableName}/list.do";
	private String editUrl = "/${tableName}/edit.ftl";
	private String admSiteUrl = "/${tableName}/${tableName}.ftl";
	private String lookupUrl = "/${tableName}/lookupUrl.ftl";
	
	@Autowired
	private ${tableClassName}Service ${tableName}Service;

	@Autowired
	private AdmUserAuthService admUserAuthService;
	
	
	@RequestMapping("${tableName}/${tableName}.do")
	public ModelAndView ${tableName}(HttpServletRequest request,HttpServletResponse response){
		ModelAndView mav = new ModelAndView();
		try {
			//  加载当前二级模块下的三级模块列表
			String tabId = ParamUtil.getString(request, "tabId");
			List<AdmModule> menus = admUserAuthService.getThirdLevelModuleAuthById(request,tabId);
			
			mav.addObject("menus", menus);
			mav.setViewName(admSiteUrl);
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("message", loadFailureMessage);
			mav.setViewName(failureUrl);
		}
		return mav;
	}
	/**
	 * 首页查询的List
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	 @RequestMapping("${tableName}/list.do")	
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response){
		${tableClassName} ${tableName} = new ${tableClassName}();
		ModelAndView mav = new ModelAndView();
		PageView pageInfo = null;
		
		if(validation(request, ${tableName})){
			try {
				Integer total = ${tableName}Service.get${tableClassName}TotalNum(${tableName});//总数
				Integer total = ${tableName}Service.get${tableClassName}TotalNum(${tableName});//总数

				pageInfo = new PageView(request.getParameter("currentPage"),total);//分页
				${tableName}.setStart(pageInfo.getStart());
				${tableName}.setEnd(pageInfo.getEnd());
				if(total.intValue() > 0){
					List<${tableClassName}> list = ${tableName}Service.list${tableClassName}(${tableName});
					pageInfo.setDataList(list);
				}
				
				//  加载操作点列表
				String tabId = ParamUtil.getString(request, "tabId");
				Map<String,String> opts = admUserAuthService.getOperationsByRoleAndModuleId(request,tabId);
				mav.addObject("tabId",tabId);
				mav.addObject("opts", opts);
				mav.addObject("cond",${tableName});
				mav.addObject("page",pageInfo);
				mav.setViewName("/${tableName}/list.ftl");
			} catch (Exception e) {
				e.printStackTrace();
				mav.addObject("message",loadFailureMessage);
				mav.setViewName(failureUrl);
			}
		}
		return mav;
	}
	
	/**
	 * 进入新增或者更新页面
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	 @RequestMapping("${tableName}/addOrEdit.do")	
	public ModelAndView addOrEdit(HttpServletRequest request, HttpServletResponse response) {
		String id = ParamUtil.getString(request, "id", "");
		String view = ParamUtil.getString(request, "view", "0");
		ModelAndView mav = new ModelAndView();
		${tableClassName} ${tableName} = new ${tableClassName}();
		try {
			if(!"".equals(id)){
				${tableName} = ${tableName}Service.get${tableClassName}(id);
			}
			if(${tableName} == null){
				mav.addObject("message", "${tableComment}不存在");
				mav.setViewName(failureUrl);
				return mav;
			}
			
			String tabId = ParamUtil.getString(request, "tabId");
			mav.addObject("tabId",tabId);
			mav.setViewName(editUrl);
			mav.addObject("view",view);
			mav.addObject("${tableName}",${tableName});
			mav.addObject("checkModel",getCheckModel());//生成页面js校验参数
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("message",failureMessage);
			mav.setViewName(failureUrl);
		}
		return mav;
	}

	/**
	 * 做新增或者更新操作
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	 @RequestMapping("${tableName}/saveOrUpdate.do")	
	public ModelAndView saveOrUpdate(HttpServletRequest request, HttpServletResponse response) {
		String tabId = ParamUtil.getString(request, "tabId");
		ModelAndView mav = new ModelAndView();
		try {
			ParamUtil.printParameters(request);//参数打印，调试用
			String id = ParamUtil.getString(request, "id", "");
			AdmUser user = SessionUtil.getLoginUser(request);
			//错误信息返回到界面
			CheckModel checkModel = CheckUtil.validateInputs(getCheckModel(),getParamMap(request));//后台数据校验
			if(!checkModel.isCheckOK()){
				//后台检查失败
				mav.setViewName(editUrl);
				${tableClassName} ${tableName} = new ${tableClassName}();
				validation(request, ${tableName});//封装数据
				mav.addObject("${tableName}",${tableName});//用户添的数据原封返回
				mav.addObject("tabId", tabId);
				mav.addObject("view","0");
				mav.addObject("checkModel",checkModel);//包含错误信息
				return mav;
			}
			
			if("".equals(id)){
				//新增
				${tableClassName} ${tableName} = new ${tableClassName}();
				if(validation(request, ${tableName})){
					${tableName}.setCreateBy(user.getId());//当前用户主键
					${tableName}.setCreateTime(new java.sql.Timestamp(new java.util.Date().getTime()));
					${tableName}.setDelFlag("1");
					${tableName}Service.save${tableClassName}(${tableName});
				}
			}else{
				//更新
				${tableClassName} ${tableName} = ${tableName}Service.get${tableClassName}(id);
				if(validation(request, ${tableName})){
					${tableName}.setUpdateBy(user.getId());//当前用户主键
					${tableName}.setUpdateTime(new java.sql.Timestamp(new java.util.Date().getTime()));
					${tableName}Service.update${tableClassName}(${tableName});
				}
			}
			
			response.sendRedirect(request.getContextPath()+ listUrl + "?tabId=" + tabId);
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("message",failureMessage);
			mav.setViewName(failureUrl);
		}
		return mav;
	}
	
	/**
	 * 根据主键删除
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	 @RequestMapping("${tableName}/delete.do")	
	public ModelAndView delete(HttpServletRequest request, HttpServletResponse response){
		ModelAndView mav = new ModelAndView();
		try {
			String id = ParamUtil.getString(request, "id", "");
			if(!"".equals(id)){
				${tableName}Service.delete${tableClassName}(id);//删除
			}else{
				mav.addObject("message","参数错误");
				mav.setViewName(failureUrl);
			}
			String tabId = ParamUtil.getString(request, "tabId");
			response.sendRedirect(request.getContextPath()+ listUrl + "?tabId="+tabId);
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("message",failureMessage);
			mav.setViewName(failureUrl);
		}
		return mav;
	}
	
	/**
	 * 生成校验对象//TODO 优化
	 * @return
	 */
	private CheckModel getCheckModel(){
		CheckModel checkModel = new CheckModel();
		<#list list as columnbean>
		<#if columnbean.name == 'id'>
		<#elseif columnbean.name == 'delFlag'>
		<#elseif columnbean.name == 'createBy'>
		<#elseif columnbean.name == 'createTime'>
		<#elseif columnbean.name == 'updateBy'>
		<#elseif columnbean.name == 'updateTime'>
		<#else>
			checkModel.addColumnCheck("${columnbean.name}","<#if columnbean.javaType == 'java.lang.Integer'>desType=NUMBER;<#elseif columnbean.javaType == 'java.math.BigDecimal'>desType=NUMBER;<#elseif columnbean.javaType == 'java.util.Date'>desType=DATE;</#if><#if (columnbean.scale >0)>scale=${columnbean.scale};</#if>des=${columnbean.commentValue};<#if columnbean.length != 0><#if columnbean.javaType == 'java.util.Date'>maxLength=10;<#else>maxLength=${columnbean.length};</#if></#if><#if columnbean.nullAble == false>isRequired=1<#else>isRequired=0</#if>");
		</#if>
		</#list>
		return checkModel;
	}
}