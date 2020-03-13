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
<title>文档内容操作</title>
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
	      	WebOfficeObj.FileName = "sampleTwo.doc";
		    WebOfficeObj.FileType = ".doc";            //FileType:文档类型  .doc  .xls
		    WebOfficeObj.ShowWindow = false;					//显示/隐藏进度条
		    WebOfficeObj.EditType = "2";				//设置加载文档类型 0 锁定文档，1无痕迹模式，2带痕迹模式
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
 		function StatusMsg(mValue){
 	   	try{
	   		document.getElementById('StatusBar').value = mValue;
	   	}catch(e){
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
	//获取文档页数
	function WebDocumentPageCount(){
	    if (WebOfficeObj.FileType==".doc"||WebOfficeObj.FileType==".docx"){
		/* var intPageTotal = WebOfficeObj.WebObject.ActiveDocument.Application.ActiveDocument.BuiltInDocumentProperties.Item(14);
		intPageTotal = WebOfficeObj.blnIE()?intPageTotal:intPageTotal.Value(); */
			if(WebOfficeObj.blnIE()){
				var intPageTotal = WebOfficeObj.WebObject.ActiveDocument.BuiltInDocumentProperties.Item(14);
			}else{
				var intPageTotal = WebOfficeObj.WebObject.ActiveDocument.BuiltInDocumentProperties.Item(14).Value();
			}
			WebOfficeObj.Alert("文档页总数："+intPageTotal);
	    }
	    if (WebOfficeObj.FileType==".wps"){
	    	
			var intPageTotal = WebOfficeObj.WebObject.ActiveDocument.PagesCount();
			WebOfficeObj.Alert("文档页总数："+intPageTotal);
	    }
	}

	//插入页码
	function WebPageCode(){
		WebOfficeObj.WebPageCode();
	}


	//写Word内容
	function WebSetWordContent(){
	 //如果非ie浏览器调用HidePlugin隐藏插件避免窗体被遮挡
		WebOfficeObj.HidePlugin(0)
	  var mText=window.prompt("请输入内容:","测试内容");
	  if (mText==null){
	     return (false);
	  }else{
	     WebOfficeObj.WebObject.ActiveDocument.Application.Selection.Range.Text= mText+"\n";
	  }
	   WebOfficeObj.HidePlugin(1);
	}

	//取Word内容
	function WebGetWordContent(){
	  try{
	    WebOfficeObj.Alert(WebOfficeObj.WebObject.ActiveDocument.Content.Text);
	  }catch(e){WebOfficeObj.Alert(e.description);}
	}

	//页眉插入文字
	function PageHeader(){
		WebOfficeObj.WebObject.ActiveDocument.ActiveWindow.ActivePane.View.SeekView = 9;
		var selection = WebOfficeObj.WebObject.ActiveDocument.Application.Selection;
		selection.TypeText("插入页眉的内容");
		WebOfficeObj.WebObject.ActiveDocument.ActiveWindow.ActivePane.View.SeekView = 0
	}

	//页脚插入文字
	function PageFooter(){
		WebOfficeObj.WebObject.ActiveDocument.ActiveWindow.ActivePane.View.SeekView = 10;
		var selection = WebOfficeObj.WebObject.ActiveDocument.Application.Selection;
		selection.TypeText("插入页脚的内容");
		WebOfficeObj.WebObject.ActiveDocument.ActiveWindow.ActivePane.View.SeekView = 0
	}
	
	//隐藏/显示痕迹
	function ShowRevision(Boolean){
	if (Boolean){
		 WebOfficeObj.WebShow(true);
		 StatusMsg("显示痕迹...");
	  }else{
		 WebOfficeObj.WebShow(false);
		 StatusMsg("隐藏痕迹...");
	  }
	}

	//清理痕迹
	function ClearRevisions(){
		WebOfficeObj.ClearRevisions();
		 StatusMsg("清理痕迹...");
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
	
	//作用：获取痕迹
    function WebGetRevisions() {
        var Rev = WebOfficeObj.WebObject.ActiveDocument.Revisions; 	//获取痕迹对象
        var Text = "";

        for (i = 1; i <= Rev.Count; i++) {
            Text = Text + "“" + Rev.Item(i).Author + "”";
            if (Rev.Item(i).Type == "1") {
                Text = Text + '进行插入：' + Rev.Item(i).Range.Text + "\r\n";
            } else if (Rev.Item(i).Type == "2") {
                Text = Text + '进行删除：' + Rev.Item(i).Range.Text + "\r\n";
            }
            else {
                Text = Text + '进行其他操作，操作内容：“' + Rev.Item(i).Range.Text + '”；操作：“' + Rev.Item(i).FormatDescription + "”。\r\n";
            }
        }
        WebOfficeObj.Alert("痕迹内容：\r\n\r\n" + Text);
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
			<input style="color:Red;" type=button value="显示痕迹" onclick="ShowRevision(true)">
			<input style="color:Red;" type=button value="隐藏痕迹" onclick="ShowRevision(false)">
			<input style="color:Red;" type=button value="清除痕迹" onclick="ClearRevisions()">
			<input style="color:Red;" type=button value="获取痕迹" onclick="WebGetRevisions()">
			<input style="color:Red;" type=button value="页眉插入文字" onclick="PageHeader()">
			<input style="color:Red;" type=button value="页脚插入文字" onclick="PageFooter()">
			<input style="color:Red;" type=button value="插入页码" onclick="WebPageCode()">
			<input style="color:Red;" type=button value="文档页数" onclick="WebDocumentPageCount()">
			<input style="color:Red;" type=button value="删除文档链接" onclick="WebOfficeObj.HyperDelete()">
			<input style="color: Red;" type="button" value="开启修订隐藏痕迹" onclick="WebOfficeObj.WebSetRevision(false,true,true,true)">
            <input style="color: Red;" type="button" value="打印文档" onclick="WebOfficeObj.WebOpenPrint()">
			<input style="color:Red;" id="StatusBar" type="text" name="StatusBar" readonly  style="WIDTH:40%">&nbsp;|←状态信息
		</div>
		<div id="OfficeDiv" style="width: 100%; height: 98%;" ><script src="../../js/iWebOffice2015.js"></script></div>
	</div>
</body>
</html>