<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<html>
<head>
<title>签章管理</title>
<link rel='stylesheet' type='text/css' href='../test.css'>
<script language=javascript>
function Check(theForm){
	if (theForm.MarkName.value == ""){
		alert("请输入印签名.");
		theForm.MarkName.focus();
		return (false);
	}
	return (true);
}

function ConfirmDel(FileUrl){
	if (confirm('是否确定删除该印签！')){
		location.href=FileUrl;
	}
}
</Script>
</head>
<body bgcolor="#ffffff">
<div align="center"><font size=4 color="ff0000">签章管理〖修改签章〗</font></div>
<hr size=1>
<br>
<%
String mSignatureID=request.getParameter("SignatureID");
boolean mResult=false;

DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
if (DbaObj.OpenConnection())
{
  String mSql="select * from Signature where SignatureID = " + mSignatureID;
  try
  {
    ResultSet result=DbaObj.ExecuteQuery(mSql) ;
    if (result.next())
    {

%>
<form name="webform" method="post" enctype="multipart/form-data"  action="SignatureEdit.jsp" onsubmit="return Check(this)">
<input type="hidden" name="SignatureID" value="<%=result.getString("SignatureID")%>">
<table border=0  cellspacing='0' cellpadding='0' width=100% align=center class=TBStyle>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>用户名称</td>
  <td class="TDStyle" width="90%"><input type="text" name="UserName" size="50" maxlength="32" class="IptStyle" value="<%=result.getString("UserName")%>"></td>
</tr>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>用户密码</td>
  <td class="TDStyle" width="90%"><input type="text" name="PassWord" size="50" maxlength="32" class="IptStyle" value="<%=result.getString("PassWord")%>"></td>
</tr>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>签章名称</td>
  <td class="TDStyle" width="90%"><input type="text" name="MarkName" size="50" maxlength="32" class="IptStyle" value="<%=result.getString("MarkName")%>"></td>
</tr>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>签章文件</td>
  <td class="TDStyle"><input type="file" name="MarkFile" size="50" maxlength="60" class="IptStyle"></td>
</tr>
<tr>
  <td colspan=2 class="TDTitleStyle" nowrap>
    <input type="submit" name="Edit" value="修 改">
    <input type="button" name="Del" value="删 除" onclick="javascript:ConfirmDel('SignatureDel.jsp?SignatureID=<%=mSignatureID%>');">
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
