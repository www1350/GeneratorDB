package com.absurd.framework.dao;

import com.absurd.framework.common.util.BaseDao;
import com.absurd.framework.domain.${tableClassName};

/**
 * 持久层Dao接口
 */
public interface ${tableClassName}Dao extends BaseDao<${tableClassName},String>{
 void delete${tableClassName}(Integer id) throws Exception;
 void update${tableClassName}(${tableClassName} ${tableName}) throws Exception;
 ${tableClassName} get${tableClassName}(Integer id) throws Exception;
 List<${tableClassName}> list${tableClassName}(Map queryMap) throws Exception;
Integer get${tableClassName}TotalNum(Map queryMap)throws Exception;
void save${tableClassName}(${tableClassName} ${tableName}) throws Exception ;
}