package com.absurd.framework.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.absurd.framework.dao.${tableClassName}Dao;
import com.absurd.framework.domain.${tableClassName};

public class ${tableClassName}DaoImpl extends SqlMapClientDaoSupport implements ${tableClassName}Dao {
	
	/**
	 * 删除
	 */
	public void delete${tableClassName}(Integer id) throws Exception {
		try {
			this.getSqlMapClientTemplate().delete("${tableName}.delete${tableClassName}ById", id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}
	/**
	 * 编辑
	 */
	public void update${tableClassName}(${tableClassName} ${tableName}) throws Exception {
		try{
			this.getSqlMapClientTemplate().update("${tableName}.update${tableClassName}", ${tableName});
		}catch(Exception e){
			e.printStackTrace();
			throw e;
		}

	}
	/**
	 * 获得
	 */
	public ${tableClassName} get${tableClassName}(Integer id) throws Exception{
		try {
			return (${tableClassName})this.getSqlMapClientTemplate().queryForObject("${tableName}.get${tableClassName}ById", id);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 获取所有
	 */
	public List<${tableClassName}> list${tableClassName}(Map queryMap) throws Exception {
		try {
			return this.getSqlMapClientTemplate().queryForList("${tableName}.list${tableClassName}ByPage", queryMap);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	// 得到所有查询记录数
	public Integer get${tableClassName}TotalNum(Map queryMap)throws Exception{
		try {
			return (Integer)this.getSqlMapClientTemplate().queryForObject("${tableName}.get${tableClassName}TotalNum", queryMap);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}	
	}	
	
	/**
	 * 增加
	 */
	public void save${tableClassName}(${tableClassName} ${tableName}) throws Exception {
		try {
			this.getSqlMapClientTemplate().insert("${tableName}.save${tableClassName}", ${tableName});
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}