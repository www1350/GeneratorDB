<#noparse>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">

<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta http-equiv="Content-Style-Type" content="text/css">
        <meta http-equiv="Content-Script-Type" content="text/javascript">
       	<#assign base=springMacroRequestContext.getContextPath()>
		<link rel="stylesheet" href="${base}/css/ui.tabs.css" type="text/css" media="print, projection, screen">
		<link href="${base}/css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${base}/js/jquery.js"></script>
		<script type="text/javascript" src="${base}/js/common_tab.js"></script>
		<script src="${base}/js/ui.tabs.js" type="text/javascript"></script>
        <style type="text/css" media="screen, projection">
            /* Not required for Tabs, just to make this demo look better... */
            body, h1, h2 {
                font-family: "Trebuchet MS", Trebuchet, Verdana, Helvetica, Arial, sans-serif;
            }
            h1 {
                margin: 1em 0 1.5em;
                font-size: 18px;
            }
            h2 {
                margin: 2em 0 1.5em;
                font-size: 16px;
            }
            p {
                margin: 0;
            }
            pre, pre+p, p+p {
                margin: 1em 0 0;
            }
            code {
                font-family: "Courier New", Courier, monospace;
            }
        </style>
    </head>
    <body  height="100%" style="margin:0px;">
        <div id="container-1" height="100%" class="menu3box">
            <ul></ul>
        </div>
    </body>
    
    <script type="text/javascript">
	        $(function() {
				createTab('container-1', false,true);
				<#if menus?? && 0< menus?size>
					<#list menus as menu>
						<#if menu_index == 0 >
							<#assign selectedModule = menu.id/>
						</#if>
						addTab(${menu.id}, '${menu.moduleName}', '${base}${menu.url}?tabId=${menu.id}',false,1);
					</#list>
					selectTab('${selectedModule}');
				</#if>
			});		
		</script>
</html>
</#noparse>