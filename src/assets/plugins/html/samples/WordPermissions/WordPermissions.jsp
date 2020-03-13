<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %>
<%
  //自动获取OfficeServer和OCX文件完整URL路径
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName="OfficeServer";
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
<title>文档防护</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="renderer" content="webkit" />
<script src="../../js/WebOffice.js"></script>


<script type="text/javascript">
 	var WebOfficeObj = new WebOffice2015(); //创建WebOffice对象
</script>

<script language="javascript">
	  function Load()
		{
			try
			{
			  WebOfficeObj.ServerUrl = "<%=mServerUrl%>";
			  WebOfficeObj.UserName = "演示人";
	      WebOfficeObj.FileName = "sample.doc";
		    WebOfficeObj.FileType = ".doc";            //FileType:文档类型  .doc  .xls
		    WebOfficeObj.ShowWindow = false;					//显示/隐藏进度条
		    WebOfficeObj.EditType = "1";				//设置加载文档类型 0 锁定文档，1无痕迹模式，2带痕迹模式
		    WebOfficeObj.ShowMenu = 0;
		    WebOfficeObj.ShowToolBar = 0;
		    WebOfficeObj.SetCaption(WebOfficeObj.UserName + "正在编辑文档");
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
		//锁定/解锁文档
		function WebSetProtect(Boolean, PassWord){
			WebOfficeObj.WebSetProtect(Boolean,PassWord);
			StatusMsg(WebOfficeObj.Status);
		}

		//允许/禁止拷贝文档
		function WebEnableCopy(Boolean){
			WebOfficeObj.WebEnableCopy(Boolean);
			StatusMsg(WebOfficeObj.Status);
		}
		
		//添加区域保护
	    function WebAreaProtect() {
	    //如果非ie浏览器调用HidePlugin隐藏插件避免窗体被遮挡
	    	WebOfficeObj.HidePlugin(0);
	        var mText = window.prompt("文档里需要先设置保护的书签，示例文档默认添加了KingGrid的书签，请输入书签名称", "KingGrid", "");
	        if (mText != null){WebOfficeObj.WebAreaProtect(mText)};
	        WebOfficeObj.HidePlugin(1);
	    }
	    //取消区域保护
	    function WebAreaUnProtect() {
    		//如果非ie浏览器调用HidePlugin隐藏插件避免窗体被遮挡
	    	WebOfficeObj.HidePlugin(0);
	        var mText = window.prompt("需要和保护的书签对应，示例文档默认添加了KingGrid的书签，请输入书签名称", "KingGrid", "");
	        //显示HidePlugin隐藏的插件
	        if (mText != null){WebOfficeObj.WebAreaUnprotect(mText)};
			WebOfficeObj.HidePlugin(1);
	    }
		
		function OnUnLoad(){
			WebOfficeObj.WebClose();
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
</script>

<!--以下是多浏览器的事件方法 -->
<script>
function OnReady(){
 WebOfficeObj.setObj(document.getElementById('WebOffice'));//给2015对象赋值
 //Load();//避免页面加载完，控件还没有加载情况
 setTimeout(function(){Load();}, 500);
}
</script>

<script language="javascript" for=WebOffice event="OnReady()">
	 WebOfficeObj.setObj(document.getElementById('WebOffice'));
   Load();//避免页面加载完，控件还没有加载情况
</script>
</head>

<body onUnload="OnUnLoad();" onbeforeunload="OnUnLoad();">
	<div style="width: 100%; height: 100%">
		<div style="width: 100%; ">
			<input style="color:Red;" type=button value="锁定文档" onclick="WebSetProtect(true, '123456')">
			<input style="color:Red;" type=button value="解锁文档" onclick="WebSetProtect(false, '123456')">
			<input style="color:Red;" type=button value="添加区域保护" onclick="WebAreaProtect()">
			<input style="color:Red;" type=button value="解除区域保护" onclick="WebAreaUnProtect()">
			<input style="color:Red;" type=button value="禁止拷贝" onclick="WebEnableCopy(false)">
			<input style="color:Red;" type=button value="允许拷贝" onclick="WebEnableCopy(true)">
			<input style="color:Red;" type=button value="添加文字水印" onclick="WebOfficeObj.AddWaterMark('WaterMarkObjectName')">
			<input style="color:Red;" type=button value="添加图片水印" onclick="WebOfficeObj.AddGraphicWaterMark('WaterMarkObjectName')">
			<input style="color:Red;" type=button value="删除水印" onclick="WebOfficeObj.DelWaterMark('WaterMarkObjectName')">
			<input style="color:Red;" id="StatusBar" type="text" name="StatusBar" readonly  style="WIDTH:40%">&nbsp;|←状态信息
		</div>
		<div id="OfficeDiv" style="width: 100%; height: 98%;" ><script src="../../js/iWebOffice2015.js"></script></div>
	</div>
</body>
</html>