package com.absurd;

import com.absurd.generator.util.TemplateUtils;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.junit.Test;

import java.io.*;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

/**
 * Created by wangwenwei on 16/11/19.
 */
public class TemplateUtilsTest {

    @Test
    public  void genTemplate() throws IOException, TemplateException {
        Configuration freemarkerConfig = new Configuration();
        freemarkerConfig.setEncoding(Locale.getDefault(), "utf-8");
        String directoy = Thread.currentThread().getContextClassLoader().getResource("template").getPath();
        File source = new File(directoy);
        freemarkerConfig.setDirectoryForTemplateLoading(source);
        Template mapTemplate = freemarkerConfig.getTemplate("demo.ftl", "utf-8");
        mapTemplate.setEncoding("utf-8");
        File file = new File(directoy+"demo2.txt");
        System.out.println(file.getAbsolutePath());
        if(!file.exists()){
            file.createNewFile();
        }
        Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file),"UTF-8"));

        Map map = new HashMap();
        map.put("tableClassName", "demo");

        mapTemplate.process(map, out);
        out.flush();
        out.close();
    }


}
