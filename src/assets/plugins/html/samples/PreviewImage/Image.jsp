<%@ page contentType="text/html; charset=utf-8" %>
<%@page import="iweboffice.preview.words.Document"%>
<%@page import="com.kinggrid.office.demo.common.*"%>
<%@page import="com.kinggrid.office.demo.utils.Base64Util"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.kinggrid.office.demo.model.Settings"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String webpath = request.getSession().getServletContext().getRealPath("/");
String fileName=request.getParameter("fileName");
String fileType = request.getParameter("fileType");
String wordPath = "Document\\" + fileName + fileType;
String filepath = webpath + wordPath;
Log.WriteLog("["+filepath+"]");
long start = System.currentTimeMillis();
Document d = Document.getInstance(filepath); //获取转图片文档路径
d.setResolution(Settings.resolution); //设置图片清晰度int参数
int count = d.getPageCount();
//加一个同步锁，防止同时转换
synchronized(this){

if(!Common.IsFileExist(webpath + "Document\\word\\img\\"+fileName+"\\log.log"))
{
	BufferRecordHandle brh = BufferRecordHandle.CreateHandle(webpath + "Document\\word\\img\\"+fileName+"\\log.log", BufferRecordHandle.eWrite);
	brh.AddMainKey("Main");
	String mMD5 = Common.GetMD5HashFromFile(filepath);
	brh.AddSubKey("Main", "MD5", mMD5);
	brh.Flush();
	for(int i = 0; i < count; ++i)
	{
		d.saveToIMG(webpath + "Document\\word\\img\\"+fileName+"/"+i+".png", i);
	}
}
else
{
	BufferRecordHandle brh = BufferRecordHandle.CreateHandle(webpath + "Document\\word\\img\\"+fileName+"/log.log", BufferRecordHandle.eRead);
	String mMD5 = Common.GetMD5HashFromFile(filepath);
	String mOldMD5 = brh.GetValue("Main", "MD5");
	if(!mMD5.equals(mOldMD5))
	{
		brh = BufferRecordHandle.CreateHandle(webpath + "Document\\word\\img\\"+fileName+"/log.log", BufferRecordHandle.eWrite);
		brh.AddMainKey("Main");
		brh.AddSubKey("Main", "MD5", mMD5);
		brh.Flush();
		for(int i = 0; i < count; ++i)
		{
			d.saveToIMG(webpath + "Document\\word\\img\\"+fileName+"/"+i+".png", i);
		}
	}
}
}
long end = System.currentTimeMillis();
Log.WriteLog("打开IMG时间(毫秒)", end-start);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>office示例</title>
  <!-- 自定义样式 主要目的用它作用于iframe的样式 -->
  <link rel="stylesheet" href="<%=path%>/layui/style/normal.css">
</head>
<script type="text/javascript" src="../../js/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
	
</script>
<body class="layui-bg-gray">
  <div style="width: 100%;text-align: center; " >
		<input style="color:Red;  font-size: 15px" type="button" value="在线编辑" onclick="window.open('Image_Word.jsp?fileName=<%=fileName%>&fileType=<%=fileType%>')"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
		<input style="color:Red; font-size: 15px" type="button" value="退出预览" onclick="window.opener.location.reload();window.close()"/>
  </div>
  <div class="div-bg" >
  <%for(int i=0;i<count;i++){ %>
    <img class="imgpage" alt="第<%=i+1 %>页" src="<%=path%>/word/img?filename=<%=fileName %>&filetype=<%=fileType %>&pageno=<%=i%>"><br />
  <%} %>
  </div>

</body>
</html>