<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*" %>
<%!
  public String LoadWordList(){
     String mWordList="";
     mWordList="<select name=WordList style='width:240 px;'>" ;
     mWordList=mWordList + "<option value='ģ��һ.doc'>ģ��һ</option>\r\n";
     mWordList=mWordList + "<option value='ģ���.doc'>ģ���</option>\r\n";
     mWordList=mWordList + "</select>" ;
     return (mWordList);
}
%>
<html>
<head>
<title>ģ���б�ѡ��</title>
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
    <td align="right" nowrap>ģ�����ƣ�</td>
    <td><%=LoadWordList()%></td>
  </tr>
  <tr>
    <td align="right"  nowrap></td>
    <td style="FONT-SIZE: 9pt;COLOR: #3333CC;">ģ���ļ�����DocumentĿ¼�У�ͬʱ���Դ����ݿ��ж�ȡģ��</td>
  </tr>
  </table>
</td>
</tr>
<tr>
<td align=center>
<input type=button value="  ȷ��  " onclick="CheckValue(iForm);">
<input type=button value="  ȡ��  " onclick="window.close();">
</td>
</tr>
</table>
</form>
</body>
</html>