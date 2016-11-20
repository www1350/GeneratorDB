package com.absurd.framework.service;

import java.util.List;
import java.util.Map;

import com.absurd.framework.domain.${tableClassName};

public interface ${tableClassName}Service {
	//保存
	public void save${tableClassName}(${tableClassName} ${tableName})throws Exception;
	//编辑
	public void update${tableClassName}(${tableClassName} ${tableName})throws Exception;
	//删除单个${tableClassName}对象
	public void delete${tableClassName}(String id)throws Exception;
	//取出一个${tableClassName}对象
	public ${tableClassName} get${tableClassName}(String id)throws Exception;
	//取出${tableClassName}对象列表
	public List<${tableClassName}> list${tableClassName}(${tableClassName} query)throws Exception;
	// 得到所有查询记录数
	public Integer get${tableClassName}TotalNum(${tableClassName} query)throws Exception;
}
