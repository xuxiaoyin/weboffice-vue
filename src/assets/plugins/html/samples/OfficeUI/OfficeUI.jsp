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
<title>OfficeUI</title>
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
			WebOfficeObj.ShowMenu = 0; //设置是否显示整个菜单 "1": 显示菜单 "0": 不显示菜单
			WebOfficeObj.ShowToolBar = 0; 
			WebOfficeObj.SetCaption(WebOfficeObj.UserName + "正在编辑文档");
		    SetGraySkin();
			if(WebOfficeObj.WebOpen())
		    {
			  StatusMsg(WebOfficeObj.Status);
		    }
			}
			catch(e){
 	     	WebOfficeObj.Alert(e.description);
 	    }
		}


 		//设置页面中的状态值
 		function StatusMsg(mValue){
 	   	try{
	   		document.getElementById('StatusBar').innerHTML = mValue;
	   	}catch(e){
	     	return false;
	   	}
		}
		
		//显示/隐藏Office工具栏
 		function OfficeToolBar(mValue){
 	   	WebOfficeObj.ShowToolBars(mValue);
		}


		//显示/隐藏状态栏
		function OfficeStatusBar(mValue){
			WebOfficeObj.ShowStatusBar(mValue);
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
		
		//禁用Office审阅里的按钮
		function ModifyReview(){
			WebOfficeObj.Alert("禁用Office审阅工具栏里的，新建批注，删除批注,修订，接受，拒绝，审阅窗格，显示标记按钮。需要office2007以上的版本");
			WebOfficeObj.ModifyReview();
		}
		//禁用Office快速工具栏按钮
		function OfficeFastUI(){
			WebOfficeObj.Alert("禁用Office快速工具栏按钮包括，打印预览，保存,快速保存，新建，打开，打印，撤销，刷新等常用按钮.需要office2007以上的版本");
			WebOfficeObj.OfficeFastUI();
		}
		
		//隐藏Office工具栏里的按钮
		function WebSetRibbonUIXML(){
			WebOfficeObj.Alert("隐藏Office工具栏选项包括，插入选项，审阅选项，开始选项.需要office2007以上的版本");
			WebOfficeObj.WebSetRibbonUIXML();
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
		
		//设置选中文字段落参数
		function ParagraphSettings(){
			WebOfficeObj.WebObject.ActiveDocument.Application.Selection.WholeStory(); //选中全文		
			WebOfficeObj.ParagraphSettings();//设置选择内容段落样式
		}
		//设置选中文字体参数
		function WordFontSet(){
			WebOfficeObj.WebObject.ActiveDocument.Application.Selection.WholeStory(); //选中全文		
			WebOfficeObj.WordFontSet();//设置选择内容的字体
		}
</script>

<!--office小图标设置可用  -->
<script language="javascript" for="WebOffice" event="OnOLECommand(OLEFlag, bCancel)">
    if (OLEFlag == 1) {
        WebOfficeObj.CreateFile();
    }
    else if (OLEFlag == 2) {
        WebOfficeObj.WebOpenLocal();
        
    }
    else if (OLEFlag == 4) {
        WebOfficeObj.WebSaveLocal();
    }
    else if (OLEFlag == 8) {
        WebOfficeObj.obj.ShowDialog(3);
    }
    else if (OLEFlag == 16) {
        WebOfficeObj.WebOpenPrint();
    }
    else if (OLEFlag == 32) {
        WebOfficeObj.obj.ShowDialog(5);
    }
    else if (OLEFlag == 64) {
        WebOfficeObj.obj.ShowDialog(6);
    }
    else if (OLEFlag == 128) {
        WebOfficeObj.obj.PrintPreview();
    }
</script>

<!--  响应菜单事件  -->
<script language="javascript" for="WebOffice" event="OnCommand(ID, Caption, bCancel)">
	switch(ID){
	    case 1: WebOfficeObj.WebOpenLocal(); break;//打开本地文件
	    case 2: WebOfficeObj.WebSaveLocal(); break;//另存本地文件
		case 3: WebOfficeObj.CreateFile(); break;//新建文档
			case 4: WebOfficeObj.PrintPreview(); break;//启用
			case 5: WebOfficeObj.PrintPreviewExit(); WebOfficeObj.ShowField(); break;//启用
			default: ; return;
	}
</script>
<script language="javascript">
function OnCommand(ID, Caption, bCancel){
   switch(ID){
	    case 1: WebOfficeObj.WebOpenLocal(); break;//打开本地文件
	    case 2: WebOfficeObj.WebSaveLocal(); break;//另存本地文件
		case 3: WebOfficeObj.CreateFile(); break;//新建文档
		case 4: WebOfficeObj.PrintPreview(); break;//启用
		case 5: WebOfficeObj.PrintPreviewExit(); WebOfficeObj.ShowField(); break;//启用
		default: ; return;
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
  			<input style="color:Red;" type=button value="显示Office工具栏" onclick="OfficeToolBar('true');">
	  		<input style="color:Red;" type=button value="隐藏Office工具栏" onclick="OfficeToolBar('false');">
	  		<input style="color:Red;" type=button value="显示Office状态栏" onclick="OfficeStatusBar('true');">
	  		<input style="color:Red;" type=button value="隐藏Office状态栏" onclick="OfficeStatusBar('false');">
	  		<input style="color:Red;" type=button value="禁用Office审阅里的按钮" onclick="ModifyReview();">
	  		<input style="color:Red;" type=button value="禁用Office快速工具栏按钮" onclick="OfficeFastUI();">
	  		<input style="color:Red;" type=button value="隐藏Office工具栏里的按钮" onclick="WebSetRibbonUIXML()">  <!--详细内容可以看js方法  -->
	  		<!-- 由于内容太多详细情况看WebOffice.js的方法,设置文档段落参数，如行距，间距，缩进，等段落里所有设置  -->
	  		<input style="color:Red;" type=button value="设置段落参数" onclick="ParagraphSettings()">
	  		<!--由于内容太多详细情况看WebOffice.js的方法，设置文档字体参数  -->
			<input style="color:Red;" type=button value="设置字体参数" onclick="WordFontSet()"><!--设置文档字体参数  -->
		</div>
		<div id="OfficeDiv" style="width: 100%; height: 98%;" ><script src="../../js/iWebOffice2015.js"></script></div>
	</div>
</body>
</html>