package com.lkg.framework.service;

import java.util.List;
import java.util.Map;

import com.lkg.framework.domain.${tableClassName};

public interface ${tableClassName}Service {
	//保存
	public void saveObj(${tableClassName} ${tableName})throws Exception;
	//编辑
	public void updateObj(${tableClassName} ${tableName})throws Exception;
	//删除单个${tableClassName}对象
	public void deleteById(String id)throws Exception;
	//取出一个${tableClassName}对象
	public ${tableClassName} getObjById(String id)throws Exception;
	//取出${tableClassName}对象列表
	public List<${tableClassName}> listByPage(${tableClassName} query)throws Exception;
	// 得到所有查询记录数
	public Integer getTotalNum(${tableClassName} query)throws Exception;
}
