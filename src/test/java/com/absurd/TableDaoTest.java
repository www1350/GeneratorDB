package com.absurd;

import com.absurd.generator.config.Application;
import com.absurd.generator.dao.TableDao;
import com.absurd.generator.util.FilterUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.util.Assert;

import java.util.List;
import java.util.Map;

/**
 * Created by wangwenwei on 16/11/19.
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = Application.class)
public class TableDaoTest {
    @Autowired
    private TableDao tableDao;

    @Test
    public void getTableTest(){
      List<Map<String, Object>> tableName =  tableDao.getTable();
        Assert.notEmpty(tableName);
        System.out.printf(""+FilterUtils.filterTableName(tableName,"t_"));
    }

    @Test
    public void getTableColumnsTest(){
        List<Map<String, Object>> columList = tableDao.getTableColumns("t_user");
        Assert.notEmpty(columList);
        System.out.printf(""+columList);
    }

    @Test
    public void getTableColumnsAllTest(){
        List<Map<String, Object>> columList = tableDao.getTableColumnsAll("t_user");
        Assert.notEmpty(columList);
        System.out.printf(""+columList);
    }

    @Test
    public void getTableCommentTest(){
        String commonList = tableDao.getTableComment("t_user");
        Assert.notNull(commonList);
        System.out.printf(""+commonList);
    }

    @Test
    public void getColumnsDataTypeTest(){
        List<Map<String, Object>> columList = tableDao.getColumnsDataType("t_user");
        Assert.notEmpty(columList);
        System.out.printf(""+columList);

    }

}
