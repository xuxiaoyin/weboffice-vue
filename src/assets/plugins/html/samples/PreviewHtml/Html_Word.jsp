<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %>
<%
  //自动获取OfficeServer和OCX文件完整URL路径
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName));//取得OfficeServer文件的完整URL
  String mFileType = request.getParameter("fileType");
  String iFileName = request.getParameter("fileName");
  String mFileName = iFileName + mFileType;
  System.out.println("mImageWord= " + mFileType + mFileName); 
%>
<html>

<head>
<title>在线打开/保存Word文档</title>
<meta name="renderer" content="webkit" /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
    html, body
    {
        height: 100%;
    }
</style>
<script src="../../js/WebOffice.js"></script>
<script type="text/javascript">
 	var WebOfficeObj = new WebOffice2015(); //创建WebOffice对象
</script>

<script language="javascript">
		//URL地址打开文档
		function Load()
		{
			try
			{
			WebOfficeObj.ServerUrl = "<%=mServerUrl%>"; //服务器地址
		    WebOfficeObj.ShowMenu = 0;
		    WebOfficeObj.ShowToolBar = 0;
		    SetGraySkin();			//设置控件皮肤
			  if(WebOfficeObj.WebOpen2("\\Document\\"+"<%= mFileName%>"))  // 文件在服务器上的相对路径 FileName
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
			WebOfficeObj.FileName = "<%=mFileName%>";
			WebOfficeObj.FileType = "<%=mFileType%>";
		  if (WebOfficeObj.WebSave()){    //交互OfficeServer的OPTION="SAVEFILE"
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
		
</script>

<script language="javascript" for="WebOffice" event="OnReady()">
   WebOfficeObj.setObj(document.getElementById('WebOffice'));//给2015对象赋值
   Load();//避免页面加载完，控件还没有加载情况
</script>

<!--以下是多浏览器的事件方法 -->
<script type="text/javascript">
function OnReady(){
 WebOfficeObj.setObj(document.getElementById('WebOffice'));//给2015对象赋值
 //Load();//避免页面加载完，控件还没有加载情况
 setTimeout(function(){Load();}, 500);
}
</script>

</head>
<body onUnload="OnUnLoad();" onbeforeunload="OnUnLoad();">
	<div style="width: 100%; height: 100%">
		<div style="width: 100%;text-align: center;">
			<input style="color:Red;" type=button value="保存文档到服务器" onclick="SaveDocument();">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
			<input style="color:Red; font-size: 15px" type="button" value="返回列表" onclick="window.opener.location.reload();window.close();;"/>
		</div>
		<div id="OfficeDiv" style="width: 100%; height: 98%;" ><script src="../../js/iWebOffice2015.js"></script></div>
	</div>
</body>
</html>