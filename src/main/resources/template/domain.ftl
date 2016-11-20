package com.absurd.framework.domain;

import java.util.Date;
import com.absurd.framework.common.vo.PageVo;

/**
 * 
 */
public class ${tableClassName} extends PageVo{
	<#list list as columnbean>
		private ${columnbean.javaType} ${columnbean.name};
	</#list>
	<#list list as columnbean>
		public ${columnbean.javaType} get${columnbean.columnClassName}() {
			return ${columnbean.name};
		}
		public void set${columnbean.columnClassName}(${columnbean.javaType} ${columnbean.name}) {
			this.${columnbean.name} = ${columnbean.name};
		}
	</#list>
}
