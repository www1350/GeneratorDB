<?xml version="1.0" encoding="UTF-8"?> 
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="com.lkg.framework.dao.${tableClassName}Dao">

  <resultMap id="${tableName}Map" type="com.lkg.framework.domain.${tableClassName}">
  	<#list list as columnbean>
  		<result property="${columnbean.name}" column="${columnbean.columnName}" jdbcType="${columnbean.jdbcType}" javaType="${columnbean.javaType}" />
  	</#list>
  </resultMap>

  <sql id="${tableName}Select">
    select 
	   	<#list list as columnbean>
	   		<#if columnbean_has_next>
	   			${columnbean.columnName},
	   		<#else>
	   			${columnbean.columnName} 
	   		</#if>
	   	</#list>    			
    from  ${realTableName}	where DEL_FLAG='1' 
  </sql>

  <sql id="${tableName}Where">
	<#list list as columnbean>
		<#if columnbean.name == 'id'>
		<#elseif columnbean.name == 'delFlag'>
		<#elseif columnbean.name == 'createBy'>
		<#elseif columnbean.name == 'createTime'>
		<#elseif columnbean.name == 'updateBy'>
		<#elseif columnbean.name == 'updateTime'>
		<#else>
		<if test="${columnbean.name}!=null and ${columnbean.name}!=''">
			<![CDATA[ and ${columnbean.columnName}  = ${"#"}{${columnbean.name}} ]]>
		</if>
		</#if>
</#list>  
  </sql>

  <select id="getObjById" parameterType="java.lang.String" resultMap="${tableName}Map">
  	<include refid="${tableName}Select"/>
  	<![CDATA[ and id=${"#"}{id}]]> 
  </select>
  
  <select id="listByPage" parameterType="com.lkg.framework.domain.${tableClassName}" resultMap="${tableName}Map">
	<![CDATA[select * from (select rownum as rn, TT.* from ( ]]>
	<include refid="${tableName}Select"/>
	<include refid="${tableName}Where"/>
    <![CDATA[order by CREATE_TIME desc ) TT where rownum <= ${"#"}{end}) where rn >= ${"#"}{start}]]>		
  </select>
 
  <select id="getTotalNum" parameterType="com.lkg.framework.domain.${tableClassName}" resultType="java.lang.Integer">
    <![CDATA[ select count(ID) from ${realTableName} where DEL_FLAG='1']]>
    <include refid="${tableName}Where"/> 
  </select>  
     
  <insert id="saveObj" parameterType="com.lkg.framework.domain.${tableClassName}">
  	<![CDATA[
	  insert into ${realTableName} 
	  	(
			<#list list as columnbean>
    		<#if columnbean_has_next>
    			${columnbean.columnName},
    		<#else>
    			${columnbean.columnName} 
    		</#if>
    	</#list>
		) 
	  values  
	  	(
	  		<#list list as columnbean>
	  			<#if columnbean.name == 'id'>
	  				<#if columnbean_has_next>
		    			STOCKIDSEQUENCE.NEXTVAL,
		    		<#else>
		    			STOCKIDSEQUENCE.NEXTVAL 
		    		</#if>
	  			<#else>
	  				<#if columnbean_has_next>
		    			${"#"}{${columnbean.name},jdbcType=${columnbean.jdbcType}},
		    		<#else>
		    			${"#"}{${columnbean.name},jdbcType=${columnbean.jdbcType}} 
		    		</#if>
	  			</#if>
    	</#list>
    	)
     ]]>	
  </insert>
  
  <update id="updateObj" parameterType="com.lkg.framework.domain.${tableClassName}">
	  <![CDATA[
	    update  ${realTableName} set 
	    	<#list list as columnbean>
    		<#if columnbean_has_next>
    			${columnbean.columnName} = ${"#"}{${columnbean.name},jdbcType=${columnbean.jdbcType}},
    		<#else>
    			${columnbean.columnName} = ${"#"}{${columnbean.name},jdbcType=${columnbean.jdbcType}}
    		</#if>
    	</#list>
    	where ID=${"#"}{id}
	   ]]>
  </update>
  
  <update id="deleteById" parameterType="java.lang.String">
		 <![CDATA[ update ${realTableName} set DEL_FLAG='0' where ID =${"#"}{id} ]]>
	</update>
  
</mapper>