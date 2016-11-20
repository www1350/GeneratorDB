package com.absurd.framework.service.impl;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import com.absurd.framework.dao.${tableClassName}Dao;
import com.absurd.framework.domain.${tableClassName};
import com.absurd.framework.service.${tableClassName}Service;

@Service
public class ${tableClassName}ServiceImpl implements ${tableClassName}Service {

	@Autowired
	private ${tableClassName}Dao ${tableName}Dao;
	
	/**
	 * 删除一个${tableClassName}对象
	 */
	public void delete${tableClassName}(String id) throws Exception {
		this.${tableName}Dao.delete${tableClassName}(id);
	}
	
	/**
	 * 编辑${tableClassName}对象
	 */
	public void update${tableClassName}(${tableClassName} ${tableName}) throws Exception {
		this.${tableName}Dao.update${tableClassName}(${tableName});
	}
	
	/**
	 * 得到一个${tableClassName}对象
	 */
	public ${tableClassName} get${tableClassName}(String id) throws Exception {
		return this.${tableName}Dao.get${tableClassName}(id);
	}
	
	/**
	 * ${tableClassName}对象列表，带分页
	 */
	public List<${tableClassName}> list${tableClassName}(${tableClassName} query) throws Exception {
		return this.${tableName}Dao.list${tableClassName}(query);
	}
	/**
	* 得到所有查询记录数
	*/
	public Integer get${tableClassName}TotalNum(${tableClassName} query)throws Exception{
		return this.${tableName}Dao.get${tableClassName}TotalNum(query);
	}
	/**
	 * 增加一个${tableClassName}对象
	 */
	public void save${tableClassName}(${tableClassName} ${tableName}) throws Exception {
		this.${tableName}Dao.save${tableClassName}(${tableName});
	}

}
