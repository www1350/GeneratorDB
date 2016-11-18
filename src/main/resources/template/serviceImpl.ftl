package com.lkg.framework.service.impl;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.lkg.framework.dao.${tableClassName}Dao;
import com.lkg.framework.domain.${tableClassName};
import com.lkg.framework.service.${tableClassName}Service;

@Service
public class ${tableClassName}ServiceImpl implements ${tableClassName}Service {

	@Autowired
	private ${tableClassName}Dao ${tableName}Dao;
	
	/**
	 * 删除一个${tableClassName}对象
	 */
	public void deleteById(String id) throws Exception {
		this.${tableName}Dao.deleteById(id);
	}
	
	/**
	 * 编辑${tableClassName}对象
	 */
	public void updateObj(${tableClassName} ${tableName}) throws Exception {
		this.${tableName}Dao.updateObj(${tableName});
	}
	
	/**
	 * 得到一个${tableClassName}对象
	 */
	public ${tableClassName} getObjById(String id) throws Exception {
		return this.${tableName}Dao.getObjById(id);
	}
	
	/**
	 * ${tableClassName}对象列表，带分页
	 */
	public List<${tableClassName}> listByPage(${tableClassName} query) throws Exception {
		return this.${tableName}Dao.listByPage(query);
	}
	/**
	* 得到所有查询记录数
	*/
	public Integer getTotalNum(${tableClassName} query)throws Exception{
		return this.${tableName}Dao.getTotalNum(query);
	}
	/**
	 * 增加一个${tableClassName}对象
	 */
	public void saveObj(${tableClassName} ${tableName}) throws Exception {
		this.${tableName}Dao.saveObj(${tableName});
	}

}
