package com.lht.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.ec.Module;

public class ${tableName}Validator implements Validator {

	public boolean supports(Class clazz) {
		return ${tableClassName}.class.equals(clazz);
	}

	public void validate(Object target, Errors errors) {
		${tableClassName} ${tableName} = (${tableClassName}) target;
		<#list list as columnbean>
			<#if columnbean.javaType == "String">
				if(${tableName}.get${columnbean.columnClassName}()==null || ${tableName}.get${columnbean.columnClassName}().length() == 0){
					errors.rejectValue("${columnbean.name}", "${columnbean.name} null error", null, "不能为空");
					return;
				}else{
					if(${tableName}.get${columnbean.columnClassName}().length() > ${columnbean.length} || ${tableName}.get${columnbean.columnClassName}().length() < 1){
						errors.rejectValue("${columnbean.name}", "${columnbean.name} too large error", null, "长度不能大于${columnbean.length}或者小于1");
						return;
					}
				}
			</#if>
		</#list>
	}
}
