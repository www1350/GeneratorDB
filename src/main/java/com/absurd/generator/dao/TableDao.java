package com.absurd.generator.dao;

import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by wangwenwei on 16/11/18.
 */
@Repository
public class TableDao extends BaseDao{

    public List getTable(){

        //WHERE TABLE_SCHEMA = '数据库名'
        String sql = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE != 'SYSTEM VIEW'  AND TABLE_SCHEMA = (SELECT database())";
        return getJdbcTemplate().queryForList(sql);
    }


    public List getTableColumns(String tableName){
        String sqlColumns =  "select COLUMN_NAME from information_schema.columns where table_name= '" +tableName+"'";
        return getJdbcTemplate().queryForList(sqlColumns);
    }

    public List getTableColumnsAll(String tableName){
        String sqlColumns =  "select * from information_schema.columns where table_name= '" +tableName+"'";
        return getJdbcTemplate().queryForList(sqlColumns);
    }

    public String getTableComment(String tableName){
        String sql = "Select TABLE_COMMENT from INFORMATION_SCHEMA.TABLES where table_name= ?";
        return (String) getJdbcTemplate().queryForObject( sql, new Object[] {tableName}, java.lang.String.class);
    }

    public List getColumnsDataType(String tableName){
        String sqlColumns =  "select DATA_TYPE from information_schema.columns where table_name= '" +tableName+"'";
        return getJdbcTemplate().queryForList(sqlColumns);
    }


}
