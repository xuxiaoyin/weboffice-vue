<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %>
<%
  //自动获取OfficeServer和OCX文件完整URL路径
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName="OfficeServer";
  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/"+mServerName;//取得OfficeServer文件的完整URL
%>

<html>
<head>
<title>iWebOffice2015技术白皮书</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="../js/WebOffice.js"></script>
<script type="text/javascript">
 	var WebOfficeObject = new WebOffice2015(); //创建WebOffice对象
</script>

<script language="javascript">
	  function Load()
		{
			try
			{
			  WebOfficeObject.WebUrl = "<%=mServerUrl%>";
	      WebOfficeObject.FileName = "iWebOffice2015_API.doc";
		    WebOfficeObject.FileType = ".doc";
			  if(WebOfficeObject.WebOpen())
			  {
			  	//隐藏Office工具栏
			  	WebOfficeObject.ShowToolBars(false);
			  	//隐藏Office状态栏
			  	WebOfficeObject.ShowStatusBar(false);
			  	//隐藏控件菜单栏
			  	WebOfficeObject.ShowMenuBar(false);
			  	//锁定文档
			  	WebOfficeObject.WebSetProtect(true, '123456');
			  }
			}
			catch(e){
 	     	alert(e.description);
 	    }
		}
</script>

<!--以下是多浏览器的事件方法 -->
<script>
function OnReady(){
 WebOfficeObj.setObj(document.getElementById('WebOffice'));//给2015对象赋值
 //Load();//避免页面加载完，控件还没有加载情况
 window.onload = function(){Load();} //IE和谷歌可以直接调用Load方法，火狐要在页面加载完后去调用
}
</script>

<script language="javascript" for=WebOffice event="OnReady()">
	 WebOfficeObject.setObj(document.getElementById('WebOffice'));
   Load();//避免页面加载完，控件还没有加载情况
</script>
</head>

<body onUnload="WebOfficeObject.WebClose()">
	<form name="webform" method="post">  <!--保存iWebOffice后提交表单信息-->
		<script src="../js/iWebOffice2015.js"></script>
	</form>
</body>
</html>