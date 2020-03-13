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
<title>模板套红</title>
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
	      	WebOfficeObj.FileName = "KGBrowser.docx";
		    WebOfficeObj.FileType = ".doc";            //FileType:文档类型  .doc  .xls
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

		//模板套红
		function WebUseTemplate(fileName){
			WebOfficeObj.Template = fileName;  //套红模板名称
			WebOfficeObj.WebUseTemplate();
			StatusMsg(WebOfficeObj.Status);
		}
		
		//根据书签名定位书签
		function WebFindBookMarks(){
			//如果非ie浏览器调用HidePlugin隐藏插件避免窗体被遮挡
			WebOfficeObj.HidePlugin(0);
			var mText=window.prompt("请输入定位的书签名称","例如：book1");
			WebOfficeObj.WebFindBookMarks(mText);
			StatusMsg(WebOfficeObj.Status);
			WebOfficeObj.HidePlugin(1);

		}
		
		 //删除书签(不会删除书签对应的值)
		function WebDelBookMarks(){//书签名称，
			//如果非ie浏览器调用HidePlugin隐藏插件避免窗体被遮挡
			WebOfficeObj.HidePlugin(0);
			var mText=window.prompt("请输入删除的书签名称","例如：book1");
			WebOfficeObj.WebDelBookMarks(mText);//删除书签
			StatusMsg(WebOfficeObj.Status);
			WebOfficeObj.HidePlugin(1);
		 }
		 //根据光标添加添加书签名和值
		function WebAddBookMarks(){//书签名称，书签值
			//如果非ie浏览器调用HidePlugin隐藏插件避免窗体被遮挡
			WebOfficeObj.HidePlugin(0);
			var mText=window.prompt("请输入书签名称和书签值，以','隔开。","例如：book1,book2");
			var mValue = mText.split(",");
			BookMarkName = mValue[0];
			BookMarkValue = mValue[1];
			WebOfficeObj.WebAddBookMarks(BookMarkName,BookMarkValue);
			StatusMsg(WebOfficeObj.Status);
			WebOfficeObj.HidePlugin(1);
		}
		//打开书签窗口
		function WebOpenBookMarks(){
			WebOfficeObj.WebOpenBookMarks();
		 }

		 //作用：设置书签值  vbmName:标签名称，vbmValue:标签值   标签名称注意大小写
		function SetBookmarks(){
			try{
			//如果非ie浏览器调用HidePlugin隐藏插件避免窗体被遮挡
				WebOfficeObj.HidePlugin(0);
				var mText=window.prompt("请输入书签名称和书签值，以','隔开。","例如：book1,book2");
				var mValue = mText.split(",");
				BookMarkName = mValue[0];
				BookMarkValue = mValue[1];
				WebOfficeObj.WebSetBookmarks(BookMarkName,BookMarkValue);
				StatusMsg(WebOfficeObj.Status);
				WebOfficeObj.HidePlugin(1);
				return true;
			}catch(e){
				StatusMsg(WebOfficeObj.Status);
				WebOfficeObj.HidePlugin(1);
				return false;
			}
		}
		
		//设置对应书签字体
		function SetBookMarksFont(){
			try{
				//如果非ie浏览器调用HidePlugin隐藏插件避免窗体被遮挡
		    	WebOfficeObj.HidePlugin(1);
				var mText=window.prompt("请输入修改书签","例如：book1");
				WebOfficeObj.SetBookMarksFont(mText,255,24,"宋体",true,true);//书签名称，字体红色，字体大小，字体类型，是否加粗，是否斜体
				StatusMsg(WebOfficeObj.Status);
				WebOfficeObj.HidePlugin(1);
				return true;
			}catch(e){
				StatusMsg(WebOfficeObj.Status);
				WebOfficeObj.HidePlugin(1);
				return false;
			}
		}
		function WebGetBookMarks(){
			try{
				//如果非ie浏览器调用HidePlugin隐藏插件避免窗体被遮挡
		    	WebOfficeObj.HidePlugin(0);
				var mText=window.prompt("请输入获取内容的书签","例如：book1");
				var BookMarksValue = WebOfficeObj.WebGetBookMarks(mText);//书签名称，字体红色，字体大小，字体类型，是否加粗，是否斜体
				WebOfficeObj.Alert("书签内容是：" + BookMarksValue);
				StatusMsg(WebOfficeObj.Status);
				WebOfficeObj.HidePlugin(1);
				return true;
			}catch(e){
				StatusMsg(WebOfficeObj.Status);
				WebOfficeObj.HidePlugin(1);
				return false;
			}
		}
		
		
		//插入远程图片 ：有书签的模式下插入到书签里，没有书签根据光标插入
		function WebInsertImage(BookMark,ImageName,Transparent,ZOrder){
		  WebOfficeObj.WebInsertImage(BookMark,ImageName,Transparent,ZOrder);
		  StatusMsg(WebOfficeObj.Status);
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
		<div style="width: 100%;">
    		<input style="color:Red;" type=button value="模板套红" onclick="WebUseTemplate('模板一.doc')">
  			<input style="color:Red;" type=button value="书签填充" onclick="SetBookmarks()">
			<input style="color:Red;" type=button value="打开书签窗体" onclick="WebOpenBookMarks()">
			<input style="color:Red;" type=button value="添加书签" onclick="WebAddBookMarks()">
			<input style="color:Red;" type=button value="设置书签字体" onclick="SetBookMarksFont()">
			<input style="color:Red;" type=button value="删除书签" onclick="WebDelBookMarks()">
			<input style="color:Red;" type=button value="定位书签" onclick="WebFindBookMarks()">
			<input style="color:Red;" type=button value="获取书签内容" onclick="WebGetBookMarks()">
			<input style="color:Red;" type=button value="插入远程图片"onclick="WebInsertImage('image','aaa.gif',true,5)">
			<input style="color:Red;" type=button value="清理文档底纹"onclick="WebOfficeObj.CleanBackground();"> 
			<input style="color:Red;" id="StatusBar" type="text" name="StatusBar" readonly  style="WIDTH:40%">&nbsp;|←状态信息
		</div>
		<div id="OfficeDiv" style="width: 100%; height: 98%;" ><script src="../../js/iWebOffice2015.js"></script></div>
	</div>
</body>
</html>