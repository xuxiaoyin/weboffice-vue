<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<html>
<head>
<title>��ǩ����</title>
<link rel='stylesheet' type='text/css' href='../test.css'>
<script language=javascript>
function Check(theForm){
	if (theForm.BookMarkName.value == ""){
		alert("�������ǩ��.");
		theForm.BookMarkName.focus();
		return (false);
	}
	return (true);
}

function ConfirmDel(FileUrl){
	if (confirm('�Ƿ�ȷ��ɾ���ñ�ǩ��')){
		location.href=FileUrl;
	}
}
</Script>
</head>
<body bgcolor="#ffffff">
<div align="center"><font size=4 color="ff0000">��ǩ�����޸ı�ǩ��</font></div>
<hr size=1>
<br>
<%
String mBookMarkID=request.getParameter("BookMarkID");
boolean mResult=false;

DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
if (DbaObj.OpenConnection())
{
  String mSql="select * from BookMarks where BookMarkID = " + mBookMarkID;
  try
  {
    ResultSet result=DbaObj.ExecuteQuery(mSql) ;
    if (result.next())
    {

%>
<form name="webform" method="post" action="BookMarkEdit.jsp" onsubmit="return Check(this)">
<input type="hidden" name="BookMarkID" value="<%=mBookMarkID%>">
<table border=0  cellspacing='0' cellpadding='0' width=100% align=center class=TBStyle>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>��ǩ����</td>
  <td class="TDStyle" width="90%"><input type="text" name="BookMarkName" size="50" maxlength="32" class="IptStyle" value="<%=result.getString("BookMarkName")%>"></td>
</tr>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>��ǩ˵��</td>
  <td class="TDStyle"><input type="text" name="BookMarkDesc" size="50" maxlength="60" class="IptStyle" value="<%=result.getString("BookMarkDesc")%>"></td>
</tr>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>��ǩ��ע</td>
  <td class="TDStyle"><input type="text" name="BookMarkText" size="50" maxlength="150" class="IptStyle" value="<%=result.getString("BookMarkText")%>"></td>
</tr>
<tr>
  <td colspan=2 class="TDTitleStyle" nowrap>
    <input type="submit" name="Edit" value="�� ��">
    <input type="button" name="Del" value="ɾ ��" onclick="javascript:ConfirmDel('BookMarkDel.asp?BookMarkID=<%=mBookMarkID%>');">
    <input type="reset" name="Reset" value="�� ��">
    <input type="button" name="Return" value="�� ��"  onclick="javascript:history.back();">
  </td>
</tr>
</table>
</form>
<%
    }
    else
    {
       out.write("���ݿ��в����ڸñ�ǩ��<input type='button' value='�� ��' onclick='javascript:history.back();'");
    }
    result.close();
  }
  catch(Exception e)
  {
      System.out.println(e.toString());
  }
  DbaObj.CloseConnection() ;
}
%>
</body>
</html>
