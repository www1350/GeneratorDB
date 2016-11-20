package com.absurd.generator;

import com.absurd.generator.bean.ColumnBean;
import com.absurd.generator.dao.TableDao;
import com.absurd.generator.util.FilterUtils;
import com.absurd.generator.util.StringUtils;
import com.absurd.generator.util.TemplateUtils;
import freemarker.template.Template;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class GenerateProcess {

	@Autowired
	private TableDao tableDao;
	
	private String daoPath;
	private String servicePath;
	private String controllerPath;
	private String daoImplPath;
	private String serviceImplPath;
	private String domainPath;
	private String pagePath;
	private String sqlMapPath;
	
	/**
	 * 处理过程
	 */
	public void process() throws Exception {
		//处理路径
		String targetPath = (String)TemplateUtils.getTemplateMap().get("targetPath");
		File srcFile = new File(targetPath + File.separator + "src");
		System.out.println(targetPath + File.separator + "src");
		if (!srcFile.exists()) {
			srcFile.mkdir();
		}
		File pageFile = new File(targetPath + File.separator + "WebRoot"
				+ File.separator + "WEB-INF" + File.separator + "pages");
		if (!pageFile.exists()) {
			pageFile.mkdirs();
		}
		pagePath = pageFile.getPath();
		
		String str = (String)TemplateUtils.getTemplateMap().get("packagePath");
		String packagePath="";
		if(0 < str.indexOf(".")){
			StringBuffer sbf = new StringBuffer();
			String [] strs = str.split("\\.");
			for(int i=0;i<strs.length;i++){
				sbf.append(strs[i] + File.separator);
			}
			packagePath = sbf.toString();
		}
		packagePath = targetPath + File.separator + "src" + File.separator + packagePath;
		
		daoPath = packagePath + File.separator + "dao";
		File daoFile = new File(daoPath);
		if(!daoFile.exists()){
			daoFile.mkdirs();
		}
		
		servicePath = packagePath + File.separator + "service";
		File serviceFile = new File(servicePath);
		if(!serviceFile.exists()){
			serviceFile.mkdirs();
		}
		
		controllerPath = packagePath + File.separator + "controller";
		File controllerFile = new File(controllerPath);
		if(!controllerFile.exists()){
			controllerFile.mkdirs();
		}
		
		daoImplPath = daoPath + File.separator + "impl";
		File daoImplFile = new File(daoImplPath);
		if(!daoImplFile.exists()){
			daoImplFile.mkdirs();
		}
		
		serviceImplPath = servicePath + File.separator + "impl";
		File serviceImplFile = new File(serviceImplPath);
		if(!serviceImplFile.exists()){
			serviceImplFile.mkdirs();
		}
		
		domainPath = packagePath + File.separator + "domain";
		File domainFile = new File(domainPath);
		if(!domainFile.exists()){
			domainFile.mkdirs();
		}
		
		sqlMapPath = packagePath + File.separator + "sqlmap";
		File sqlMapFile = new File(sqlMapPath);
		if(!sqlMapFile.exists()){
			sqlMapFile.mkdirs();
		}
		//去掉系统表
		List<Map<String, Object>> tableList = FilterUtils.filterTableName(tableDao.getTable(),(String)TemplateUtils.getTemplateMap().get("tablePrefix"));
		if(CollectionUtils.isEmpty(tableList)) return;
		for(Map<String, Object> tableMap:tableList) {
			String tableName =(String) tableMap.get("TABLE_NAME");
			List listColumn = this.doTransition(tableDao.getTableColumnsAll(tableName));
			gernerateOneTable(listColumn, tableName);
		}
	}
	
	public void gernerateOneTable(List listColumn,String tableName)throws Exception{
		this.generate(listColumn, tableName,daoPath,"dao.ftl");
		this.generate(listColumn, tableName,servicePath,"service.ftl");
		this.generate(listColumn, tableName,controllerPath,"controller.ftl");
		this.generate(listColumn, tableName,daoImplPath,"daoImpl.ftl");
		this.generate(listColumn, tableName,serviceImplPath,"serviceImpl.ftl");
		this.generate(listColumn, tableName,domainPath,"domain.ftl");
		this.generate(listColumn, tableName,sqlMapPath,"sqlmap.ftl");
		this.generate(listColumn, tableName,pagePath,"list.ftl");
		this.generate(listColumn, tableName,pagePath,"edit.ftl");
		this.generate(listColumn, tableName,pagePath,"page.ftl");
	}

	public void generate(List listColumn, String tableName,String path,String templateType) throws Exception{
		String tableComment = "";
		String realTableName = tableName;
		String destPath="";
		String tableClassName = StringUtils.toClassCase(tableName);
		tableName = StringUtils.toLowerCase(tableName);
		tableComment = tableDao.getTableComment(realTableName.toUpperCase());
		
		if(tableComment == null || tableComment.equals("")){
			tableComment = tableName;
		}
		
		if(-1 < templateType.indexOf("sqlmap")){
			destPath = path + File.separator + tableClassName + ".xml";
		}else if(-1 < templateType.indexOf("html")){
			destPath = path + File.separator + tableClassName + ".html";
		}else{
			if("dao.ftl".equals(templateType)){
				destPath = path + File.separator + tableClassName + "Dao.java";
			}
			if("service.ftl".equals(templateType)){
				destPath = path + File.separator + tableClassName + "Service.java";
			}
			if("controller.ftl".equals(templateType)){
				destPath = path + File.separator + tableClassName + "Controller.java";
			}
			if("daoImpl.ftl".equals(templateType)){
				destPath = path + File.separator + tableClassName + "DaoImpl.java";
			}
			if("serviceImpl.ftl".equals(templateType)){
				destPath = path + File.separator + tableClassName + "ServiceImpl.java";
			}
			if("domain.ftl".equals(templateType)){
				destPath = path + File.separator + tableClassName + ".java";
			}
			if("list.ftl".equals(templateType)){
				destPath = path + File.separator + tableName ;
				
				File pageFile = new File(destPath);
				if (!pageFile.exists()) {
					pageFile.mkdirs();
				}
				destPath = destPath + File.separator + "list.ftl";
			}
			
			if("edit.ftl".equals(templateType)){
				destPath = path + File.separator + tableName ;
				
				File pageFile = new File(destPath);
				if (!pageFile.exists()) {
					pageFile.mkdirs();
				}
				destPath = destPath + File.separator + "edit.ftl";
			}
			
			if("page.ftl".equals(templateType)){
				destPath = path + File.separator + tableName ;
				
				File pageFile = new File(destPath);
				if (!pageFile.exists()) {
					pageFile.mkdirs();
				}
				destPath = destPath + File.separator + tableName +".ftl";
			}
		}
		Template template = (Template) TemplateUtils.getTemplateMap().get(templateType);
		template.setEncoding("UTF-8");
		File file = new File(destPath);
		System.out.println(file.getAbsolutePath());
		if(!file.exists()){
			file.createNewFile();
		}
		
		try{
			Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file),"UTF-8"));
			
			Map map = new HashMap();
			map.put("list", listColumn);
			map.put("tableName", tableName);
			map.put("tableComment", tableComment);
			map.put("tableClassName", tableClassName);
			map.put("realTableName", realTableName);

			template.process(map, out);
			out.flush();
			out.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	/**
	 * 获取表字段，转化
	 * 
	 * @param list
	 * @return
	 * @throws Exception
	 */
	public List<ColumnBean> doTransition(List<Map<String, Object>> list)
			throws Exception {
		List<ColumnBean> columnBeanList = new ArrayList<ColumnBean>();
		for (Object obj : list) {
			HashMap<String, Object> mapColumn = (HashMap) obj;
			ColumnBean cb = new ColumnBean();
			cb.setTableName((String) mapColumn.get("TABLE_NAME"));
			cb.setName((String) mapColumn.get("COLUMN_NAME"));
			cb.setColumnName((String) mapColumn.get("COLUMN_NAME"));
			cb.setColumnClassName(StringUtils.makeFirstUpper((String) mapColumn.get("COLUMN_NAME")));
//			BigDecimal dataScale = (BigDecimal)mapColumn.get("NUMERIC_SCALE");
			String type =((String) mapColumn.get("DATA_TYPE")).toUpperCase();
			String columnType =(String) mapColumn.get("COLUMN_TYPE");
			Map<String,Integer>  columnTypeMap = 	StringUtils.extraTypeLenth(columnType);
			Map map = TemplateUtils.getJdbcTypeMap();
			if(map.containsKey(type.toUpperCase())){
				String str = (String)map.get(type);
				String[] strs = str.split("/");
				cb.setJdbcType(strs[1]);
				cb.setJavaType(strs[0]);
			}else{
				System.out.println("Unknown mysql datatype： "+type);
				cb.setJavaType("");
				cb.setJdbcType("");
			}
			cb.setType(type);
			if(columnTypeMap!=null )
			cb.setLength(columnTypeMap.get("length"));

		String character =	(String) mapColumn.get("IS_NULLABLE");
			if("YES".equals(character)){
				cb.setNullAble(true);
			}else{
				cb.setNullAble(false);
			}

			String comments = (String) mapColumn.get("COLUMN_COMMENT");
			cb.setCommentValue(comments);
			if(columnTypeMap!=null )
				cb.setScale(columnTypeMap.get("scala"));

			columnBeanList.add(cb);
		}
		return columnBeanList;
	}
}
