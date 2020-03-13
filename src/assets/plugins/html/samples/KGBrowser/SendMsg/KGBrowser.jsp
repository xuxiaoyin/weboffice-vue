<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %>
<%
	String  parent_uuid=request.getParameter("parent_uuid");
	System.out.println("KGBrowser.jsp --- parent_uuid = " + parent_uuid);
  //自动获取OfficeServer和OCX文件完整URL路径
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
<title>在线打开/保存Word文档</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="../../../js/jquery-1.11.2.min.js"></script>
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
	
		
		function ReturnList()
		{
			WebOfficeObj.WebClose();
			strMsg = '{"action":"ReturnList","func":""}';
			SendMsgToParent(strMsg);
			window.close();
		}
		
		function OnBeforeKGBrowserClosed()
		{
			WebOfficeObj.WebClose();
			return true;
		}
		function SendMsg()
		{
			strMsg = '{"action":"CallParentFunc","func":"updateCount(4);"}'; //func对应的值就是返回信息
			SendMsgToParent(strMsg);
		}
		function SendMsgToParent(strMsg) 
		{
			strUrl = 'http://127.0.0.1:9588/SendMsg?targetid=' + '<%=parent_uuid%>' + '$msg=';
			strUrl += strMsg;
			$.ajax({
				type: "get",
				async: false,
				url: strUrl,
				jsonp: "hookback",
				dataType: "jsonp",
				success: function(data)
				{	
					var jsonobj = eval(data);
				},
				error: function(a,b,c)
				{
				}
			});
        }
</script>

<script language="javascript" for="WebOffice" event="OnReady()">
	// 初始化WebOfficeObj类
   WebOfficeObj.setObj(document.getElementById('WebOffice'));//给2015对象赋值
   Load();
</script>

</head>

<body KGBrowser="金格科技iWebOffice2015智能文档中间件[演示版];V5.0S0xGAAEAAAAAAAAAEAAAAJgBAACgAQAALAAAAIWn3VJ3L1Xg41FVPifR0C1loqUNUsgPFzc+E3YSMVUm7h2L8qmC3BeJTL0GxQJW9AdMrrFVvJeQ5oQMNLYexUw1BrQIcHbNzVe7zOqDA/LUe5bLivMurPHWklKcCS2r7E4cvNCOQ8fOqE5SkT3/wzOF5HWbc1dNMOjDbsIKcrAbLO3fv5eVVsnUoz2gx/aP6SBoqFoCcPxY/d50ECoib5LbFVsUnG+97dTLHz3L92jAlcJauty/qxVTN5DbmAUzWlQeyJIfLdrwReIXDq7kCUEZ76gzel2cNlvrto34TNgFm8eZurtMKK3Phv+9JL0bNtkbJxWBCC0FUwU4Rjj72zv9GikiVHoJqMR3NP5slIkzaBDhKZCy/em1v4Hbg7kB3PtMn/CEM1U9MHQ/I+rGLbBoES+CIiVTve11LU7J4ygGuBzYe0LEgiyHDzTqocCMidzOb1d5KS7V/OlP72WONx7OWm5hhAeLJs1+I6lmRhTre/wh9CUuPLGaLkg3qiAMyp+PnbR+QZPETwI2FuuOpNmZIsKbYEjAnR6nm99gAcvDylSHQeQ5XJqi8IJb59ps8w==" onbeforeunload="OnUnLoad()" onUnload="OnUnLoad();">
	<div style="width: 100%; height: 100%">
		<div style="width: 100%;">
			<input type="button" value="给父窗口传递信息" onclick="SendMsg();" />
			<input type=button onClick="ReturnList()" value="返回列表">
		</div>
		<div style="width: 100%; height: 98%;" >
		<script src="../../../js/iWebOffice2015.js">  <!-- 这个代码把iWebOffice2015控件放置到网页中 -->
		</script>
		</div>
	</div>
</body>

</html>
