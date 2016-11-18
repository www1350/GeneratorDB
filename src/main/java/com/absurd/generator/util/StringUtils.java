package com.absurd.generator.util;

public class StringUtils {

	/**
	 * 将表名和字段名转换为相对应的java文件名和属性名
	 * 比如 T_AD_MODULES 转换为 tAdModules；而USERS转换为users
	 * @param str
	 * @return str
	 */
	public static String toLowerCase(String str){
		StringBuffer sbf = new StringBuffer();
		if(null == str || 1 > str.length()){
			return "";
		}
		str = str.toLowerCase();
		if(str.startsWith("t_")){
			str = str.substring(2, str.length());
		}
		if(str.indexOf("_") > -1){
			String strs[] = str.split("_");
			for(int i=0;i<strs.length;i++){
				if(0==i){
					sbf.append(strs[i]);
				}else{
					if(2 > strs[i].length()){
						sbf.append(strs[i].toUpperCase());
					}else{
						sbf.append(strs[i].substring(0,1).toUpperCase()+strs[i].substring(1));
					}
				}
			}
			str = sbf.toString();
		}
		return str;
	}
	
	public static String toClassCase(String str){
		StringBuffer sbf = new StringBuffer();
		if(null == str || 1 > str.length()){
			return "";
		}
		str = str.toLowerCase();
		if(str.startsWith("t_")){
			str = str.substring(2, str.length());
		}
		if(str.indexOf("_")> -1){
			String strs[] = str.split("_");
			for(int i=0;i<strs.length;i++){
				if(2 > strs[i].length()){
					sbf.append(strs[i].toUpperCase());
				}else{
					sbf.append(strs[i].substring(0,1).toUpperCase()+strs[i].substring(1));
				}
			}
			str = sbf.toString();
		}
		else{
			str = str.substring(0,1).toUpperCase() + str.substring(1);
		}
		return str;
	}
}
