<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>

<%
request.setCharacterEncoding("utf-8");
//获取index.jsp页面传递过来参数的值
System.out.println("Word2.jsp --- session = " + session.getId());
String userName=(String)session.getAttribute("userName");
//获取index.jsp用？传递过来的id的值
String  id=request.getParameter("id");
System.out.println("id=" + id);
String id2 = URLDecoder.decode(id,"utf-8");
System.out.println("id2=" + id2);

String mHttpUrlName=request.getRequestURI();
String mScriptName=request.getServletPath();
String mServerName="OfficeServer";
String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName));//+"/"+mServerName;//取得OfficeServer文件的完整URL

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<style>
html, body
{
    height: 100%;
}
</style>
  <head>
      <title>获取index.jsp页面传递过来的参数</title>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <script src="../../../js/WebOffice.js"></script>
      <script language="javascript">
	
		var WebOfficeObj = new WebOffice2015(); //创建WebOffice对象
	    // 初始化控件打开文件之前的一些设置
	    function Load()
		{
			try
			{
		    	WebOfficeObj.ServerUrl = "<%=mServerUrl%>";
				WebOfficeObj.SaveServlet = "/OfficeServer";	
				WebOfficeObj.UserName = "演示人";            // 用户名
		      	WebOfficeObj.FileName = "Sample.doc";       //  被打开的文件名
			    WebOfficeObj.FileType = ".doc";            //   文件类型  .doc  .xls
			    WebOfficeObj.ShowMenu = 0;                   // 不显示菜单
			    WebOfficeObj.ShowToolBar = 0;                // 不显示工具条
	   		    WebOfficeObj.WebOpen();                      // 打开文件
			}
			catch(e){
 	     		alert(e.description);
 	    	}
		}
	
		// 保存到文件服务器
		function SaveDocument()
		{
			if (WebOfficeObj.WebSave()){    // 保存文件
		    	WebOfficeObj.WebClose();    // 关闭文件
		    	window.close();             // 关闭浏览器窗口
	  		}else{
	  			alert(WebOfficeObj.Status);
	    	}
		}
		
		function ReturnList()
		{
			WebOfficeObj.WebClose();
			window.close();
		}
		
		function OnBeforeKGBrowserClosed()
		{
			var ask = confirm("是否真的需要关闭？")
			if(ask == true)
				WebOfficeObj.WebClose();
			return ask;
		}
	</script>

<script language="javascript" for="WebOffice" event="OnReady()">
	// 初始化WebOfficeObj类
   WebOfficeObj.setObj(document.getElementById('WebOffice'));//给2015对象赋值
   Load();
</script>
  </head>
<body KGBrowser="金格科技iWebOffice2015智能文档中间件[演示版];V5.0S0xGAAEAAAAAAAAAEAAAAJgBAACgAQAALAAAAIWn3VJ3L1Xg41FVPifR0C1loqUNUsgPFzc+E3YSMVUm7h2L8qmC3BeJTL0GxQJW9AdMrrFVvJeQ5oQMNLYexUw1BrQIcHbNzVe7zOqDA/LUe5bLivMurPHWklKcCS2r7E4cvNCOQ8fOqE5SkT3/wzOF5HWbc1dNMOjDbsIKcrAbLO3fv5eVVsnUoz2gx/aP6SBoqFoCcPxY/d50ECoib5LbFVsUnG+97dTLHz3L92jAlcJauty/qxVTN5DbmAUzWlQeyJIfLdrwReIXDq7kCUEZ76gzel2cNlvrto34TNgFm8eZurtMKK3Phv+9JL0bNtkbJxWBCC0FUwU4Rjj72zv9GikiVHoJqMR3NP5slIkzaBDhKZCy/em1v4Hbg7kB3PtMn/CEM1U9MHQ/I+rGLbBoES+CIiVTve11LU7J4ygGuBzYe0LEgiyHDzTqocCMidzOb1d5KS7V/OlP72WONx7OWm5hhAeLJs1+I6lmRhTre/wh9CUuPLGaLkg3qiAMyp+PnbR+QZPETwI2FuuOpNmZIsKbYEjAnR6nm99gAcvDylSHQeQ5XJqi8IJb59ps8w==" onbeforeunload="OnUnLoad()" onUnload="OnUnLoad();">
	     
		      (1)获取index.jsp用session传递过来的userName的值：</br>
			    &nbsp;&nbsp;&nbsp;代码：String userName=(String)session.getAttribute("userName");</br>
			    &nbsp;&nbsp;&nbsp;输出：UserName=<%=userName %></br></br>
		 
		
		     (2)获取index.jsp用？传递过来的id的值：</br>
			   &nbsp;&nbsp;&nbsp;代码：String  id= request.getParameter("id");</br>
			   &nbsp;&nbsp;&nbsp;输出：id=<%=id2 %></br>
		 
	<div style="width: 100%; height: 100%">
		<div style="width: 100%;">
			<input style="color:Red;" type=button value="保存文档到服务器" onclick="SaveDocument()">
			<input type=button onClick="ReturnList()" value="返回列表">
		</div>
		<div style="width: 100%; height: 98%;" >
		<script src="../../../js/iWebOffice2015.js">  <!-- 这个代码把iWebOffice2015控件放置到网页中 -->
		</script>
		</div>
	</div> 

</body>
</html>
