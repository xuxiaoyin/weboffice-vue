<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*" %>
<%!
  public String LoadWordList(){
     String mWordList="";
     mWordList="<select name=WordList style='width:240 px;'>" ;
     mWordList=mWordList + "<option value='模板一.doc'>模板一</option>\r\n";
     mWordList=mWordList + "<option value='模板二.doc'>模板二</option>\r\n";
     mWordList=mWordList + "</select>" ;
     return (mWordList);
}
%>
<html>
<head>
<title>模板列表选择</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel='stylesheet' type='text/css' href='../test.css'>
<script language="javascript">
function CheckValue(theForm)
{
  var mObject = window.dialogArguments;
  mObject.Template=theForm.WordList.value;
  window.close();
  return;
}
</SCRIPT>
</head>
<body bgcolor="menu">
<form name="iForm">
<table border=0  cellspacing='0' cellpadding='0' width=100% height=100% align="center">
<tr>
<td align="center">
  <table border=0  cellspacing='0' cellpadding='0'>
  <tr>
    <td align="right" nowrap>模版名称：</td>
    <td><%=LoadWordList()%></td>
  </tr>
  <tr>
    <td align="right"  nowrap></td>
    <td style="FONT-SIZE: 9pt;COLOR: #3333CC;">模板文件放在Document目录中，同时可以从数据库中读取模板</td>
  </tr>
  </table>
</td>
</tr>
<tr>
<td align=center>
<input type=button value="  确定  " onclick="CheckValue(iForm);">
<input type=button value="  取消  " onclick="window.close();">
</td>
</tr>
</table>
</form>
</body>
</html>