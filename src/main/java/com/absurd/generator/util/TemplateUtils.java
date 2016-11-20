package com.absurd.generator.util;

import java.io.File;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import freemarker.template.Configuration;
import freemarker.template.Template;


public class TemplateUtils {
	
	//模板缓冲存储
	private static Map<String,Object> templateMap = new HashMap<String,Object>();
	//java数据类型/jdbc type/mysql数据类型之间的转换关系
	private static Map<String,String> jdbcTypeMap = new HashMap<String,String>();
	
	public static Map<String,Object> getTemplateMap(){
		return TemplateUtils.templateMap;
	}
	
	public static Map<String,String> getJdbcTypeMap(){
		return TemplateUtils.jdbcTypeMap;
	}
	
	static {
		try{
			Properties p = new Properties();
			InputStream inStream = TemplateUtils.class.getClassLoader().getResourceAsStream("config.properties");
			p.load(inStream);
			String template = (String)p.get("template");
			String templatePath = (String)p.get("templatePath");
			String targetPath = (String)p.get("targetPath");
			String packagePath = (String)p.get("packagePath");
			String tablePrefix = (String)p.get("tablePrefix");
			p.clear();
			//生成文件放置位置
			TemplateUtils.templateMap.put("targetPath", targetPath);
			//文件包位置
			TemplateUtils.templateMap.put("packagePath", packagePath);
			//表前缀
			TemplateUtils.templateMap.put("tablePrefix",tablePrefix);

			inStream.close();
			
			Configuration freemarkerConfig = new Configuration();
			freemarkerConfig.setEncoding(Locale.getDefault(), "utf-8");
			String directoy = Thread.currentThread().getContextClassLoader().getResource(templatePath).getPath();

			File source = new File(directoy);
			freemarkerConfig.setDirectoryForTemplateLoading(source);
			
			String[] templates = template.split(",");
			for(String templateStr : templates){
				Template mapTemplate = freemarkerConfig.getTemplate(templateStr, "utf-8");
				mapTemplate.setEncoding("utf-8");
				TemplateUtils.templateMap.put(templateStr, mapTemplate);
			}
			
			InputStream inStreamJDBC = TemplateUtils.class.getClassLoader().getResourceAsStream("jdbcType.properties");
			p.load(inStreamJDBC);
			
			TemplateUtils.jdbcTypeMap.put("BLOB", p.getProperty("BLOB"));
			TemplateUtils.jdbcTypeMap.put("CHAR", p.getProperty("CHAR"));
			TemplateUtils.jdbcTypeMap.put("TEXT", p.getProperty("TEXT"));
			TemplateUtils.jdbcTypeMap.put("INT", p.getProperty("INT"));
			TemplateUtils.jdbcTypeMap.put("MEDIUMINT", p.getProperty("MEDIUMINT"));
			TemplateUtils.jdbcTypeMap.put("BOOLEAN", p.getProperty("BOOLEAN"));
			TemplateUtils.jdbcTypeMap.put("VARCHAR", p.getProperty("VARCHAR"));
			TemplateUtils.jdbcTypeMap.put("TINYINT", p.getProperty("TINYINT"));
			TemplateUtils.jdbcTypeMap.put("SMALLINT", p.getProperty("SMALLINT"));
			TemplateUtils.jdbcTypeMap.put("BIT", p.getProperty("BIT"));
			TemplateUtils.jdbcTypeMap.put("DATE", p.getProperty("DATE"));
			TemplateUtils.jdbcTypeMap.put("DOUBLE", p.getProperty("DOUBLE"));
			TemplateUtils.jdbcTypeMap.put("LONG", p.getProperty("LONG"));
			TemplateUtils.jdbcTypeMap.put("TIMESTAMP", p.getProperty("TIMESTAMP"));

			inStreamJDBC.close();
			p.clear();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
