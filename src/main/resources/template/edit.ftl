<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<${"#"}assign base=springMacroRequestContext.getContextPath()>
<${"#"}import "/common/common.ftl" as common />
<script type="text/javascript" src="${"$"}{base}/js/My97DatePicker/WdatePicker.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新增/编辑${tableComment}</title>
<link href="${"$"}{base}/css/style.css" rel="stylesheet" type="text/css" />
<link href="${"$"}{base}/css/select.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${"$"}{base}/js/jquery.js"></script>
<script type="text/javascript" src="${"$"}{base}/js/pub/ajax.js"></script>
<script type="text/javascript" src="${"$"}{base}/js/pub/common.js"></script>

<script type="text/javascript">

	function submitForm(form){
		var form = document.getElementById(form);
		form.submit();
	}

	function backToList(){
		window.location.href = "${"$"}{base}/${tableName}/list.do?tabId=${"$"}{tabId}";
	}
</script>
</head>
<body>


    <div class="formbody">
    <div class="formbody">
    
    <div class="formtitle"><span>${tableComment}信息</span>
    	<${'#'}if view == '0'>
	    <a class="hraddbtn" onclick="submitForm('form');"><img src="${"$"}{base}/images/iadd.png">保存</a>
	    </${'#'}if>
	    <a class="hraddbtn" onclick="backToList();"><img src="${"$"}{base}/images/idel.png">取消</a>
    </div>
    <form id="form" action="${"$"}{base}/${tableName}/saveOrUpdate.do?tabId=${"$"}{tabId}" method="post">
	    <input id="id" type="hidden" name="id" <${"#"}if ${tableName}.id??> value="${"$"}{${tableName}.id!}"</${"#"}if> />
	    <table class="hrtb">
	    	<#if list?? && 0< list?size>
		    	<#list list as col>
		    		<#if col_index  == 0>
		    			<tr>
		    		</#if>
		    		<td width="106" class="color right">${col.commentValue}</td>
				    <td colspan="3">
				      	<input 
				      		style="width:200px;"
				      		id="${col.name}"
				    		name="${col.name}" 
				    		<${'#'}if view == '1'>
				    		disabled="disabled"
				    		</${'#'}if>
				    		type="text" 
				    		class="dfinput" 
				    		<${"#"}if ${tableName}.${col.name}??>value = "${"$"}{${tableName}.${col.name}!}"</${"#"}if> 
				    		/>
				    	<font style="color: red;">
					    	<${"#"}if checkModel.checkOK>
					    	<${"#"}else>
					    		${"$"}{checkModel.greateErrMsg("${col.name}")!}
					    	</${"#"}if>
				    	</font>
				      </td>
	    			<#if col_index == list?size - 1>
	    				</tr>
	    			<#else>
	    				<#if col_index % 2 == 0>
			    			</tr><tr>
			    		</#if>
	    			</#if>
			    </#list>
		    </#if>
		</table>
	</form>
</body>
</html>
