<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>iWebOffice2015产品示例</title>
	<link rel="stylesheet" href="css/main.css" />
</head>
<script type="text/javascript" language="javascript">
function getURL(){  
    var curWwwPath = window.document.location.href;  
    //获取主机地址之后的目录，如： cis/website/meun.htm  
    var pathName = window.document.location.pathname;  
    var pos = curWwwPath.indexOf(pathName); //获取主机地址，如： http://localhost:8080  
    var localhostPaht = curWwwPath.substring(0, pos); //获取带"/"的项目名，如：/cis  
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);  
    var rootPath = localhostPaht + projectName;  
    return rootPath;  
}

</script>
<body>
<jsp:include page="./header.jsp"/>
<div class="container">
<!-- banner开始 -->
<div class="banner">
	<div class="banner_center"></div>
</div>
<!-- banner结束 -->
<!-- 主体开始 -->
		<!-- <div class="main" style="text-align: center; width: 49%;float: left;"><a style="color:blue;font-size: 25px"  href="KGRepairToolsSetup.exe">点击下载修复工具</a></div><div class="main" style="text-align: center; width: 49%;float: left;"><a style="color:blue;font-size: 25px"  href="iWebOffice2015.msi">iWebOffice2015插件下载</a><ul></div> -->
<div class="main">
	<div class="goods">
		<ul>
			<li>
				<div style="float: left; margin: 35px 0px 35px 40px;">
					<img src="images/iWebOffice2015.png" alt="" width="250" height="150" />
				</div>			
				<div style="float: left; margin-left: 30px; margin-right: 30px; width:700px;">
					<h2 style="margin-top: 60px; font-size: 20px; color: #4c4c4c; font-weight: 600;">
						 <a  style="font-size: 20px;color: blue;" href="./indexpages/iWebOffice.html" target="_blank">iWebOffice2015示例（无数据库版）</a>
					</h2>
					<div style="font-size: 16px; color: #949494;">
						<p style="word-break:break-all;">该示例主要演示iWebOffice2015产品中的常见功能，包含有：在线打开、保存Word、</p>
						<p style="word-break:break-all;">Excel、PPT、PDF文档、套红、多浏览器支持、界面自定义UI、文档内容操作等功能。</p>
					</div>
				</div>
				
				
				<a href="http://www.kinggrid.com:8080/iWebOffice2015/KGRepairToolsSetup.exe" style="margin-top: 70px; float:left;display: block;width: 130px;height: 25px;background:#FFffff;font-size: 12px;color: #6c6c6c;font-weight: 500;line-height: 25px;text-align: center;border: 1px solid #cccccc;">修复工具下载</a>
				<a href="iWebOffice2015.msi" style="margin-top: 10px; float:left;display: block;width: 130px;height: 25px;background:#FFffff;font-size: 12px;color: #6c6c6c;font-weight: 500;line-height: 25px;text-align: center;border: 1px solid #cccccc;">iWebOffice2015下载</a>
				<a href="./EnvironmentalNotes.html" target="_blank" style="margin-top: 10px; float:left;display: block;width: 130px;height: 25px;background:#FFffff;font-size: 12px;color: #6c6c6c;font-weight: 500;line-height: 25px;text-align: center;border: 1px solid #cccccc;">环境支持说明</a>
				
			</li>
			<li>
				<div style="float: left; margin: 35px 0px 35px 40px;">
					<img src="images/iWebOffice2015_db.png" alt="" width="250" height="150" />
				</div>			
				<div style="float: left; margin-left: 30px; margin-right: 30px; width:700px;">
					<h2 style="margin-top: 60px; font-size: 20px; color: #4c4c4c; font-weight: 600;">
					 	<a  style="font-size: 20px;color: blue;" href="./indexpages/iWebOfficeDataBase.html" target="_blank">iWebOffice2015示例（数据库版）</a>
					</h2>
					<div style="font-size: 16px; color: #949494;">
						<p style="word-break:break-all;">该示例主要演示iWebOffice2015在Oracle、MySQL、SqlServer等数据库中，对文档进行打开</p>
						<p style="word-break:break-all;">和保存操作，<a style="color: red; font-size: 16px;" target="_blank" href="./indexpages/iWebOffice.html"  >常用功能请参考《iWebOffice2015示例（无数据库版） 》</a></p>
					</div>
				</div>
				<!-- 
				<a href="./package/金格签章.zip" download="金格签章.zip" style="margin-top: 80px; float:left;display: block;width: 130px;height: 25px;background:#FFffff;font-size: 12px;color: #6c6c6c;font-weight: 500;line-height: 25px;text-align: center;border: 1px solid #cccccc;">产品试用(WIN平台)</a>
				<a href="./download.jsp" target="_blank" style="margin-top: 10px; float:left;display: block;width: 130px;height: 25px;background:#FFffff;font-size: 12px;color: #6c6c6c;font-weight: 500;line-height: 25px;text-align: center;border: 1px solid #cccccc;">产品试用(国产平台)</a>
				 -->
			</li>
			<li>
				<div style="float: left; margin: 35px 0px 35px 40px;">
					<img src="images/upgrade.png" alt="" width="250" height="150" />
				</div>			
				<div style="float: left; margin-left: 30px; margin-right: 30px; width:700px;">
					<h2 style="margin-top: 60px; font-size: 20px; color: #4c4c4c; font-weight: 600;">
						<a  style="font-size: 20px;color: blue;" href="./FuncExtModule/DocumentList.jsp" target="_blank">iWebOffice 2003、2009升级到iWebOffice2015示例</a>
					</h2>
					<div style="font-size: 16px; color: #949494;">
						<p style="word-break:break-all;">该示例主要演示在原有iWebOffice2003、2009产品的基础上，如何快速升级到iWebOffice2015。</p>
					</div>
				</div>
				<!--
				<a href="./package/金格云签章.zip" download="iSignature_OFD_API服务器中间件.zip" style="margin-top: 80px; float:left;display: block;width: 130px;height: 25px;background:#FFffff;font-size: 12px;color: #6c6c6c;font-weight: 500;line-height: 25px;text-align: center;border: 1px solid #cccccc;">产品试用(全平台)</a>
				-->
			</li>
<!-- 		<li>  -->
<!-- 				<div style="float: left; margin: 35px 0px 35px 40px;"> -->
<!-- 					<img src="images/spring.png" alt="" width="250" height="150" /> -->
<!-- 				</div>			 -->
<!-- 				<div style="float: left; margin-left: 30px; margin-right: 30px; width:700px;" > -->
<!-- 					<h2 style="margin-top: 60px; font-size: 20px; color: #4c4c4c; font-weight: 600;"> -->
<!-- 						<a  style="font-size: 20px;color: blue;" href="./indexpages/iWebOfficeSpringMvc.html" target="_blank">iWebOffice2015 SpringMVC示例</a> -->
<!-- 					</h2> -->
<!-- 					<div style="font-size: 16px; color: #949494;"> -->
<!-- 						<p style="word-break:break-all;">该示例主要演示iWebOffice2015如何在SpringMVC框架中进行在线打开和保存文档操作。</p><p><a style="color: red; font-size: 16px;" target="_blank" href="./indexpages/iWebOffice.html"  >常用功能请参考《iWebOffice2015示例（无数据库版） 》</a></p>						 -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<a href="./package/文档转换中间件.zip" download="转换服务.zip" style="margin-top: 80px; float:left;display: block;width: 130px;height: 25px;background:#FFffff;font-size: 12px;color: #6c6c6c;font-weight: 500;line-height: 25px;text-align: center;border: 1px solid #cccccc;">产品试用(全平台)</a>
				 -->
<!-- 			</li>  -->
		</ul>
	</div>
</div>
<!-- 主体结束 -->
</div>
<jsp:include page="./footer.jsp"/>
</body>
</html>