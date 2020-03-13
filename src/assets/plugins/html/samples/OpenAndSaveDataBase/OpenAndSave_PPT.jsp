<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %>
<%
  //自动获取OfficeServer和OCX文件完整URL路径
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName="OfficeServer";
  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName));//取得OfficeServer文件的完整URL
  String mSessionID = request.getSession().getId();
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
<meta name="renderer" content="webkit" />
<script src="../../js/WebOffice.js"></script>


<script type="text/javascript">
 	var WebOfficeObj = new WebOffice2015(); //创建WebOffice对象
</script>

<script language="javascript">
	//有进度条打开文档
	  function Load()
		{
			try
			{
			WebOfficeObj.ServerUrl = "<%=mServerUrl%>";
			WebOfficeObj.UserName = "演示人";
	      	WebOfficeObj.FileName = "iWebOffice2015.pptx";
		    WebOfficeObj.FileType = ".pptx";            //FileType:文档类型  .doc  .xls
		    WebOfficeObj.ShowWindow = true;					//true显示进度条//false隐藏进度条
		    WebOfficeObj.obj.Style.ShowOpenProgress = true; //开启、关闭打开文档时的进度条
		    WebOfficeObj.EditType = "1";				//设置加载文档类型 0 锁定文档，1无痕迹模式，2带痕迹模式
			WebOfficeObj.RecordID = "12345567892015";  //文档存数据库id，唯一标识
		    WebOfficeObj.DataBase = "MYSQL"; //启用数据库打开保存数据
		    WebOfficeObj.ShowMenu = 0;
		    WebOfficeObj.ShowToolBar = 0;
		   // WebOfficeObj.SetCaption(WebOfficeObj.UserName + "正在编辑文档");
		    SetGraySkin();			//设置控件皮肤
			  if (browser == "chrome"){
			    	// 下载文件时访问OfficeServer与其他网页页面session保持一致的说明 （开始）
					// 为了让/OfficeServer这个Servlet和浏览器的其他页面保持session一致，需要在访问OfficeServer之前把其他页面的cookie发送到服务端去，通过调用
					// INetSetCookie方法，参数是服务器url和cookie值
					var MyCookie = "JSESSIONID=" + "<%=mSessionID%>";
					WebOfficeObj.INetSetCookie(WebOfficeObj.ServerUrl, MyCookie);
			    	//WebOfficeObj.INetSetCookie(WebOfficeObj.ServerUrl, document.cookie); 
					// 但如果浏览器设置了禁止cookie，那么document.cookie则获取不到有效cookie值，这时候可以通过在客户端创建一个
				    // 跟cookie内容值一样的字符串，再把这个字符串当成cookie发送给服务器，也能实现session保持一致
				    // 创建的字符串是这样的形式：JSESSIONID=XXXXXXXXXXXXXXXXXXXXXX,
				    // XXXX...XXX是服务端的sessionid，可以通过jsp变量的形式发送给客户端
				    // varMyCookie = "JSESSIONID=" + "<%=mSessionID%>";	
				    // WebOfficeObj.INetSetCookie(WebOfficeObj.ServerUrl, varMyCookie);	
				    // 下载文件时访问OfficeServer与其他网页页面session保持一致的说明 （结束）
				}		
			  if(WebOfficeObj.WebOpen())
			  {
			  	StatusMsg(WebOfficeObj.Status);
			  }
			}
			catch(e){
 	     	StatusMsg(e.description);
 	    }
		}
		//无进度条打开文档
		function LoadNoShowProgress()
		{
			try
			{
			WebOfficeObj.WebUrl = "<%=mServerUrl%>";
			WebOfficeObj.UserName = "演示人";
			WebOfficeObj.RecordID = "12345567892015";
	      	WebOfficeObj.FileName = "iWebOffice2015.pptx";
		    WebOfficeObj.FileType = ".pptx";            //FileType:文档类型  .doc  .xls
		    WebOfficeObj.ShowWindow = false;					//true显示进度条//false隐藏进度条
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
		
		//保存文档
		function SaveDocument()
		{
		  if (WebOfficeObj.WebSave()){    //交互OfficeServer的OPTION="SAVEFILE"
		    WebOfficeObj.WebClose();
		    window.close();
	  	}else{
	  		WebOfficeObj.Alert(WebOfficeObj.Status);
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
 				WebOfficeObj.Alert(WebOfficeObj.Status);
		}
		
		function OnUnLoad(){
			WebOfficeObj.WebClose();
		}
		
		//前后台交互，key在后台接收
		function SendMessage()
		{
		//如果非ie浏览器调用HidePlugin隐藏插件避免窗体被遮挡
			WebOfficeObj.HidePlugin(0);
		  var info = window.prompt("请输入要传到服务器处理页面上的内容:","参数内容");
		  if (info==null){return false}
			WebOfficeObj.WebSetMsgByName("TESTINFO",info);  //USERNAME在后获取
			if(WebOfficeObj.WebSendMessage()){  		// 交互信息为INPORTTEXT
			  WebOfficeObj.Alert(WebOfficeObj.WebGetMsgByName("RETURNINFO")); //USERNAME值为对应后台的key
			}else{
		        WebOfficeObj.Alert("客户端Web发送数据包命令没有合适的处理函数");
		        }
		        //如果非ie浏览器调用HidePlugin隐藏插件避免窗体被遮挡
			WebOfficeObj.HidePlugin(1);
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
 setTimeout(function(){Load();}, 500);
}
</script>

</head>
<body onUnload="OnUnLoad();" onbeforeunload="OnUnLoad();">
	<div style="width: 100%; height: 100%">
		<div style="width: 100%;">
			<input style="color:Red;" type=button value="无进度条打开文档" onclick="OnUnLoad();LoadNoShowProgress()">
			<input style="color:Red;" type=button value="有进度条打开文档" onclick="OnUnLoad();Load()">
			<input style="color:Red;" type=button value="保存文档到服务器" onclick="SaveDocument()">
			<input style="color:Red;" type=button value="打开本地文档(有窗口)" onclick="WebOfficeObj.WebOpenLocal()">
			<input style="color:Red;" type=button value="保存本地文档(有窗口)" onclick="WebOfficeObj.WebSaveLocal()">
			<input style="color:Red;" type=button value="前后台交互信息" onclick="SendMessage()">
			<input style="color:Red;" id="StatusBar" type="text" name="StatusBar" readonly  style="WIDTH:40%">&nbsp;|←状态信息
		</div>
		<div id="OfficeDiv" style="width: 100%; height: 98%;" ><script src="../../js/iWebOffice2015.js"></script></div>
	</div>
</body>
</html>