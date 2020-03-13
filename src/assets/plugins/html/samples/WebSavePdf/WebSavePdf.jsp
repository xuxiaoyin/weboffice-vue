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
<title>存为pdf</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="renderer" content="webkit" />
<script src="../../js/WebOffice.js"></script>
<script type="text/javascript">
 	var WebOfficeObj = new WebOffice2015(); //创建WebOffice对象
</script>

<script language="javascript">

	  function Load() {
	  	try {
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
	  	} catch (e) {
	  		WebOfficeObj.Alert(e.description);
	  	}
	  }

		//烟枪灰皮肤
		function SetGraySkin(){
			//参数顺序依次为：控件标题栏颜色、自定义菜单开始颜色、自定义工具栏按钮开始颜色、自定义工具栏按钮结束颜色、
			//自定义工具栏按钮边框颜色、自定义工具栏开始颜色、控件标题栏文本颜色（默认值为：0x000000）
			if (!WebOfficeObj.WebSetSkin(0xdbdbdb, 0xeaeaea, 0xeaeaea, 0xdbdbdb, 0xdbdbdb, 0xdbdbdb, 0x000000))
				WebOfficeObj.Alert(WebOfficeObj.Status);
		}

		//设置页面中的状态值
	  function StatusMsg(mValue) {
		  try {
			  document.getElementById('StatusBar').value = mValue;
		  } catch (e) {
			  return false;
		  }
	  }

	 //保存到服务器
	  function WebSavePDF(){
	     WebOfficeObj.Alert("转换PDF需要本地Office支持另存为PDF功能，需要Office2007及更高版本Office");
		 var rid = WebOfficeObj.RecordID = "sample";
		 var PdfName = rid+".pdf"
		  WebOfficeObj.WebSavePDF();
		  StatusMsg(WebOfficeObj.Status + ",文件路径/PDF/" + PdfName);
		  
	  }

	  //保存到本地
	  function SaveAsPDF(){
	  	  WebOfficeObj.Alert("转换PDF需要本地Office支持另存为PDF功能，需要Office2007及更高版本Office");
		  var PdfPath = WebOfficeObj.DownFilePath();
		  var PDFname = "sample.pdf";
		  if(WebOfficeObj.SaveAsPdf(PdfPath + PDFname)){
			  StatusMsg(WebOfficeObj.Status + ",文件路径" + PdfPath + PDFname);
		  }else{
			  StatusMsg(WebOfficeObj.Status);
		  }
		  
	  }
	  
	  function OnUnLoad(){
			WebOfficeObj.WebClose();
	  }
	  
	  function SaveLocalToPDF() {
            var weboffice = document.getElementById('WebOffice')
            //另存为PDF
            var filenamepath;
            var exts = "PDF(*.pdf)|*.pdf;";
            exts += "|PDF文档(*.pdf)|*.pdf";
            exts += "||";

            //if ((window.ActiveXObject!=undefined) || (window.ActiveXObject!=null) ||"ActiveXObject" in window){
            filenamepath = weboffice.FileSystem.FileSaveAs(exts, "默认文件名.pdf");
            var ext = filenamepath.substring(filenamepath.length - 3, filenamepath.length);

            if (filenamepath == "") {
                return true;
            }
            try {
                if (ext == "pdf") {
                    weboffice.ActiveDocument.ExportAsFixedFormat(filenamepath, 17, false, 0, 0, 1, 1, 0, true, true, 1, true, true, true);
                }
                else {
                    weboffice.Save(filenamepath, 0);
                }
            }
            catch (e) {
                this.Status = e.description;
                WebOfficeObj.Alert(e.description);
                return false;
            }
            return true;
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
			<input style="color:Red;" type=button value="WORD转PDF保存到服务器" onclick="WebSavePDF()">
			<input style="color:Red;" type=button value="WORD转PDF保存到本地" onclick="SaveAsPDF()">
			<input style="color:Red;" type=button value="WORD转PDF到本地（有窗口）" onclick="SaveLocalToPDF()">
			<input style="color:Red; width: 50% " id="StatusBar" type="text" name="StatusBar" >&nbsp;|←状态信息
		</div>
		<div id="OfficeDiv" style="width: 100%; height: 98%;" ><script src="../../js/iWebOffice2015.js"></script></div>
	</div>
</body>
</html>