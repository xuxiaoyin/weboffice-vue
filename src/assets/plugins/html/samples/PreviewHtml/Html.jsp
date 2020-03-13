<%@page import="com.kinggrid.office.demo.common.*"%>
<%@page import="com.kinggrid.office.demo.utils.Base64Util"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String fileName=request.getParameter("fileName");
String fileType=request.getParameter("fileType");
String webpath = request.getSession().getServletContext().getRealPath("/");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>Excel文档预览</title>
  <link rel="stylesheet" href="<%=path%>/layui/css/layui.css">
  <!-- 自定义样式 主要目的用它作用于iframe的样式 -->
  <link rel="stylesheet" href="<%=path%>/layui/style/iframe.css">
  <link rel="stylesheet" href="<%=path%>/layui/style/normal.css">
  <style type="text/css">
  	.center-div{
  		vertical-align: middle;
		display: table-cell;  /*只支持IE8+及现代浏览器，与position:absolute;或float:left;属性尽量不一起用*/
		text-align: center;
  	}
  </style>
<script type="text/javascript" src="../js/jquery-1.11.2.min.js"></script>  
<script type="text/javascript" src="../js/KGBrowser.js"></script>
  <script type="text/javascript">
 	//弹窗应用主要功能 弹窗应用跳转
	var KGBrowser = new KGBrowser();
   	function StartBrowserBeforeCheck(url){
	    strOptions = '$skin=1$tabshow=1$cookie=' + document.cookie; //金格浏览器配置一般不用动
   		KGBrowser.openWindow(url + "?parent_uuid=" + KGBrowser.getUUID(),strOptions, false); //跳转路径传值
    	Window_Close();
    }
    
	function Window_Close()
	{	
		setTimeout("window.location.reload();", 1000);
		setTimeout("window.close();",1000);
	}
  </script>
</head>
<body>
 <div style="width: 100%;text-align: center; " >
		<input style="color:Red;  font-size: 15px" type="button" value="在线编辑" onclick="window.open('Html_Word.jsp?fileName=<%=fileName%>&fileType=<%=fileType%>')"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<input style="color:Red; font-size: 15px" type="button" value="退出预览" onclick="window.opener.location.reload();window.close()"/>
  </div>
  <iframe id="mainiframe" width="100%" height="700px" src="<%=path%>/excel/html?fileName=<%=fileName %>&fileType=<%=fileType %>" onload="changeFrameHeight()" frameborder="0" scrolling="auto"></iframe>

<script src="<%=path%>/layui/layui.js"></script>
<script>
//JavaScript代码区域
layui.use('element', function(){
  var element = layui.element;
  
});

</script>
</body>
</html>