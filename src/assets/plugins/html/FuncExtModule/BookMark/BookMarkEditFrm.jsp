<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<html>
<head>
<title>标签管理</title>
<link rel='stylesheet' type='text/css' href='../test.css'>
<script language=javascript>
function Check(theForm){
	if (theForm.BookMarkName.value == ""){
		alert("请输入标签名.");
		theForm.BookMarkName.focus();
		return (false);
	}
	return (true);
}

function ConfirmDel(FileUrl){
	if (confirm('是否确定删除该标签！')){
		location.href=FileUrl;
	}
}
</Script>
</head>
<body bgcolor="#ffffff">
<div align="center"><font size=4 color="ff0000">标签管理〖修改标签〗</font></div>
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
  <td nowrap align=center class="TDTitleStyle" width=64>标签名称</td>
  <td class="TDStyle" width="90%"><input type="text" name="BookMarkName" size="50" maxlength="32" class="IptStyle" value="<%=result.getString("BookMarkName")%>"></td>
</tr>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>标签说明</td>
  <td class="TDStyle"><input type="text" name="BookMarkDesc" size="50" maxlength="60" class="IptStyle" value="<%=result.getString("BookMarkDesc")%>"></td>
</tr>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>标签备注</td>
  <td class="TDStyle"><input type="text" name="BookMarkText" size="50" maxlength="150" class="IptStyle" value="<%=result.getString("BookMarkText")%>"></td>
</tr>
<tr>
  <td colspan=2 class="TDTitleStyle" nowrap>
    <input type="submit" name="Edit" value="修 改">
    <input type="button" name="Del" value="删 除" onclick="javascript:ConfirmDel('BookMarkDel.asp?BookMarkID=<%=mBookMarkID%>');">
    <input type="reset" name="Reset" value="重 填">
    <input type="button" name="Return" value="返 回"  onclick="javascript:history.back();">
  </td>
</tr>
</table>
</form>
<%
    }
    else
    {
       out.write("数据库中不存在该标签。<input type='button' value='返 回' onclick='javascript:history.back();'");
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
