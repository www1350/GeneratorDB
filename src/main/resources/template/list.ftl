<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<${"#"}import "/common/common.ftl" as common />
<${"#"}assign base=springMacroRequestContext.getContextPath()>
<${"#"}assign listUrl=base+"/site/list.do">
<${"#"}assign deleteUrl=base+"/site/delete.do">
<${"#"}assign addOrEditViewUrl=base+"/site/addOrEdit.do">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${tableComment}</title>
<link href="${"$"}{base}/css/style.css" rel="stylesheet" type="text/css" />
<link href="${"$"}{base}/css/select.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${"$"}{base}/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${"$"}{base}/js/jquery.js"></script>
<script type="text/javascript" src="${"$"}{base}/js/select-ui.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
  $(".click").click(function(){
  	$(".tip").fadeIn(200);
  });
  
  $(".tiptop a").click(function(){
  $(".tip").fadeOut(200);
});
 
  $(".sure").click(function(){
  $(".tip").fadeOut(100);
});

  $(".cancel").click(function(){
  $(".tip").fadeOut(100);
});

});

function addOrEdit(){
	var url = '${"$"}{base}/${tableName}/addOrEdit.do?tabId=${"$"}{tabId}';
	window.location.href=url;
}


function editById(id,view){
	var url = "${"$"}{base}/${tableName}/addOrEdit.do?id="+id+"&tabId=${"$"}{tabId}";
	if(view != undefined){
		url = url +"&view="+view;
	}
	window.location.href=url;
}

function deleteById(id){
	var url = "${"$"}{base}/${tableName}/delete.do?id="+id+"&tabId=${"$"}{tabId}";
	if(confirm('您确定删除吗？')){
		window.location.href=url;
	}else{
		return false;
	}
}

function clearCon(){
	window.location.href = "${"$"}{base}/${tableName}/list.do?tabId=${"$"}{tabId}";
}

function pageQuery(page){
	var url = "${"$"}{base}/${tableName}/list.do?currentPage="+page+"&tabId=${"$"}{tabId}";
	window.location.href=url;
}
</script>
</head>

<body>

 <div class="rightinfo">

  <div id="usual1" class=""> 
	<div id="tab2" class="tabson">
		<form action="${"$"}{base}/${tableName}/list.do?tabId=${"$"}{tabId}" method="post">
		    <ul class="seachform">
		    	<#if list?? && 0< list?size>
			    	<#list list as col>
				    <li>
				      <label>${col.commentValue}</label>
				      <input 
				      	name="${col.name}" 
				      	type="text" 
				      	class="scinput" 
				      	<${"#"}if cond.${col.name}??>value = "${"$"}{cond.${col.name}!}"</${"#"}if>
				      />
				    </li>
				    </#list>
				</#if>
			    <li>
			    	<label>&nbsp;</label>
			    	<input name="" type="submit" class="scbtn" value="查询"/>
			    	<input type="button" class="scbtn" onclick="clearCon();" value="清空" />
			    </li>
		    </ul>
	    </form>
    
    <div class="tools">
    	<ul class="toolbar">
    		<${"#"}if opts["1"]??>
        		<li onclick="addOrEdit();"><span><img src="${"$"}{base}/images/t01.png" /></span>添加</li>
        	</${"#"}if>
        </ul>
    </div>
    
    <table class="tablelist">
    	<thead>
    	<tr>
    		<#if list?? && 0< list?size>
	    		<#list list as col>
	    			<th style="text-align: center;">${col.commentValue}</th>
			    </#list>
			</#if>
        </tr>
        </thead>
        <tbody style="text-align: center;">
	        <${"#"}if page.dataList?? && 0<page.dataList?size>
				<${"#"}list page.dataList as item>
					<tr>
						<#if list?? && 0< list?size>
							<#list list as col>
						    	<td>${"$"}{item.${col.name}!}</td>
						    </#list>
					    </#if>
				        <td>
				        	<a href="javascript:void(0)" onclick="editById('${'$'}{item.id}','1')" class="tablelink">查看</a>
					        <${"#"}if opts["2"]??>
				        		<a href="javascript:void(0)" onclick="editById('${"$"}{item.id}')" class="tablelink">修改</a>
				        	</${"#"}if>
				        	<${"#"}if opts["3"]??>    
				        		<a href="javascript:void(0)" onclick="deleteById('${"$"}{item.id}')" class="tablelink"> 删除</a></td>
				        	</${"#"}if>
			        	</td>
			        </tr> 
				</${"#"}list>
			<${"#"}else>
				<tr>
					<td align="center" colspan="6">没有记录！</td>
				</tr>
			</${"#"}if>
        </tbody>
    </table>
    
   
    <div class="pagin">
<div class="message">共<i class="blue">${"$"}{page.totalCount!}</i>条记录，当前显示第&nbsp;<i class="blue">${"$"}{page.currentPage!}&nbsp;</i>页</div>
        <ul class="paginList">
        <li class="paginItem" onclick="pageQuery('${"$"}{page.currentPage-1}');"><a href="javascript:;"><span class="pagepre"></span></a></li>
        <${"#"}list 1..page.totalPage as item>
        	<${"#"}if item==11 >
        		<li class="paginItem more" onclick="pageQuery('${"$"}{item!}');"><a href="javascript:;">${"$"}{item!}</a></li>
       		<${"#"}elseif 11<item>
        		<li class="paginItem current" onclick="pageQuery('${"$"}{item!}');"><a href="javascript:;">${"$"}{item!}</a></li>
        	<${"#"}elseif item==page.currentPage>
        		<li class="paginItem current"><a href="javascript:;">${"$"}{page.currentPage!}</a></li>
        	<${"#"}else>
	        	 <li class="paginItem" onclick="pageQuery('${"$"}{item!}');"><a href="javascript:;">${"$"}{item!}</a></li>
        	</${"#"}if>
        </${"#"}list>
        <li class="paginItem" onclick="pageQuery('${"$"}{page.currentPage+1}');"><a href="javascript:;"><span class="pagenxt"></span></a></li> 
        </ul>
    </div>
    
    
    <div class="tip">
    	<div class="tiptop"><span>提示信息</span><a></a></div>
        
      <div class="tipinfo">
        <span><img src="${r"${base}"}/images/ticon.png" /></span>
        <div class="tipright">
        <p>是否确认对信息的修改 ？</p>
        <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
        </div>
        </div>
        
        <div class="tipbtn">
        <input name="" type="button"  class="sure" value="确定" />&nbsp;
        <input name="" type="button"  class="cancel" value="取消" />
        </div>
    
    </div>
    
    
    </div>
    
     </div>
    
    <script type="text/javascript">
	${"$"}('.tablelist tbody tr:odd').addClass('odd');
	</script>

 </div>
</body>

</html>
