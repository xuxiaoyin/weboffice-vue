<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %>
<%
  //自动获取OfficeServer和OCX文件完整URL路径
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName));//取得OfficeServer文件的完整URL
%>

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
<script src="../../../js/WebOffice.js"></script>


<script type="text/javascript">
 	var WebOfficeObj = new WebOffice2015(); //创建WebOffice对象
</script>

<script language="javascript">
	  // 金格MultiPart方式在线打开文档
	  function Load()
		{
			try
			{
			WebOfficeObj.ServerUrl = "<%=mServerUrl%>";
			WebOfficeObj.UserName = "演示人";
	      	WebOfficeObj.FileName = "sample.doc";
		    WebOfficeObj.FileType = ".doc";             //FileType:文档类型  .doc  .xls
		    WebOfficeObj.ShowWindow = true;				//true显示进度条//false隐藏进度条
		    WebOfficeObj.EditType = "1";				//设置加载文档类型 0 锁定文档，1无痕迹模式，2带痕迹模式
		    WebOfficeObj.ShowMenu = 0;
		    WebOfficeObj.ShowToolBar = 0;
		   // WebOfficeObj.SetCaption(WebOfficeObj.UserName + "正在编辑文档");
		    SetGraySkin();			//设置控件皮肤
		
			  if(WebOfficeObj.WebOpen())
			  {
			  	StatusMsg(WebOfficeObj.Status);
			  }
			}
			catch(e){
 	     	StatusMsg(e.description);
 	    }
		}
		
		//URL地址打开文档
		function LoadURL()
		{
			try
			{
			WebOfficeObj.ServerUrl = "<%=mServerUrl%>"; //服务器地址
		    WebOfficeObj.ShowMenu = 0;
		    WebOfficeObj.ShowToolBar = 0;
		    SetGraySkin();			//设置控件皮肤
			  if(WebOfficeObj.WebOpen2("/Document/sample.doc"))  // 文件在服务器上的相对路径 FileName
			  {
			  	StatusMsg(WebOfficeObj.Status);
			  }
			}
			catch(e){
 	     	StatusMsg(e.description);
 	    }
		}
		
		//服务端Servlet方式打开文档
		function LoadServlet()
		{
			try
			{
			WebOfficeObj.ServerUrl = "<%=mServerUrl%>";               // 用来保存文件的Server
			var downloadLink = "<%=mServerUrl%>" + "/FileDownload?FileName=" + "/Document/sample.doc";
		    WebOfficeObj.ShowMenu = 0;
		    WebOfficeObj.ShowToolBar = 0;
		    SetGraySkin();			//设置控件皮肤
			  if(WebOfficeObj.WebOpen3(downloadLink))  // 文件在服务器上的相对路径 FileName
			  {
			  	StatusMsg(WebOfficeObj.Status);
			  }
			}
			catch(e){
 	     	StatusMsg(e.description);
 	    }
		}
		
		//保存文档
		function SaveDocument()
		{
			WebOfficeObj.FileName = "sample.doc";
			WebOfficeObj.FileType = ".doc";
		  if (WebOfficeObj.WebSave()){    //交互OfficeServer的OPTION="SAVEFILE"
		    WebOfficeObj.WebClose();
		    window.close();
	  	}else{
	  		alert(WebOfficeObj.Status);
	     	StatusMsg(WebOfficeObj.Status);
	  	}
		}

	 	//设置页面中的状态值
 		 function StatusMsg(mValue) {
		  try {
			  document.getElementById('StatusBar').value = mValue;
		  } catch (e) {
			  return false;
		  }
		 }
		
		//烟枪灰皮肤
 		function SetGraySkin(){
 			//参数顺序依次为：控件标题栏颜色、自定义菜单开始颜色、自定义工具栏按钮开始颜色、自定义工具栏按钮结束颜色、
 			//自定义工具栏按钮边框颜色、自定义工具栏开始颜色、控件标题栏文本颜色（默认值为：0x000000）
 			if (!WebOfficeObj.WebSetSkin(0xdbdbdb, 0xeaeaea, 0xeaeaea, 0xdbdbdb, 0xdbdbdb, 0xdbdbdb, 0x000000))
 				alert(WebOfficeObj.Status);
		}
		
		function OnUnLoad(){
			WebOfficeObj.WebClose();
		}
		
		//前后台交互，key在后台接收
		function SendMessage()
		{
		  var info = window.prompt("请输入要传到服务器处理页面上的内容:","参数内容");
		  if (info==null){return false}
			WebOfficeObj.WebSetMsgByName("TESTINFO",info);  //USERNAME在后获取
			if(WebOfficeObj.WebSendMessage()){  		// 交互信息为INPORTTEXT
			  alert(WebOfficeObj.WebGetMsgByName("RETURNINFO")); //USERNAME值为对应后台的key
			}else{
		        alert("客户端Web发送数据包命令没有合适的处理函数");
		        }
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
   WebOfficeObj.setObj(document.getElementById('WebOffice'));//给2015对象赋值
   Load();//避免页面加载完，控件还没有加载情况
</script>

<!--以下是多浏览器的事件方法 -->
<script>
function OnReady(){
 WebOfficeObj.setObj(document.getElementById('WebOffice'));//给2015对象赋值
 //Load();//避免页面加载完，控件还没有加载情况
 window.onload = function(){Load();} //IE和谷歌可以直接调用Load方法，火狐要在页面加载完后去调用
}
</script>

</head>
<body KGBrowser="金格科技iWebOffice2015智能文档中间件[演示版];V5.0S0xGAAEAAAAAAAAAEAAAAJgBAACgAQAALAAAAIWn3VJ3L1Xg41FVPifR0C1loqUNUsgPFzc+E3YSMVUm7h2L8qmC3BeJTL0GxQJW9AdMrrFVvJeQ5oQMNLYexUw1BrQIcHbNzVe7zOqDA/LUe5bLivMurPHWklKcCS2r7E4cvNCOQ8fOqE5SkT3/wzOF5HWbc1dNMOjDbsIKcrAbLO3fv5eVVsnUoz2gx/aP6SBoqFoCcPxY/d50ECoib5LbFVsUnG+97dTLHz3L92jAlcJauty/qxVTN5DbmAUzWlQeyJIfLdrwReIXDq7kCUEZ76gzel2cNlvrto34TNgFm8eZurtMKK3Phv+9JL0bNtkbJxWBCC0FUwU4Rjj72zv9GikiVHoJqMR3NP5slIkzaBDhKZCy/em1v4Hbg7kB3PtMn/CEM1U9MHQ/I+rGLbBoES+CIiVTve11LU7J4ygGuBzYe0LEgiyHDzTqocCMidzOb1d5KS7V/OlP72WONx7OWm5hhAeLJs1+I6lmRhTre/wh9CUuPLGaLkg3qiAMyp+PnbR+QZPETwI2FuuOpNmZIsKbYEjAnR6nm99gAcvDylSHQeQ5XJqi8IJb59ps8w==" onUnload="OnUnLoad();" onbeforeunload="OnUnLoad();">
	<div style="width: 100%; height: 100%">
		<div style="width: 100%;">
			<!-- 以MultiPart方式下载文档,设置文件处理Servelet，打开和保存都用这个Servelet处理 -->
			<input style="color:Red;" type=button value="MultiPart方式打开文档" onclick="OnUnLoad();Load()">
			<!-- URL地址打开文档，WebOpen2的参数是文件在服务器上的相对路径 -->
			<input style="color:Red;" type=button value="URL地址打开文档" onclick="OnUnLoad();LoadURL()">
			<!-- 服务端Servlet打开文档，WebOpen3的参数是文件在服务器上的相对路径 -->
			<input style="color:Red;" type=button value="服务端Servlet打开文档" onclick="OnUnLoad();LoadServlet()">
			<input style="color:Red;" type=button value="保存文档到服务器" onclick="SaveDocument();">
			<input style="color:Red;" type=button value="打开本地文档(有窗口)" onclick="WebOfficeObj.WebOpenLocal()">
			<input style="color:Red;" type=button value="保存本地文档(有窗口)" onclick="WebOfficeObj.WebSaveLocal()">
			<input style="color:Red;" type=button value="前后台交互信息" onclick="SendMessage()">
			<input style="color:Red;" id="StatusBar" type="text" name="StatusBar" readonly  style="WIDTH:40%">&nbsp;|←状态信息
		</div>
		<div style="width: 100%; height: 98%;" ><script src="../../../js/iWebOffice2015.js"></script></object></div>
	</div>
</body>
</html>