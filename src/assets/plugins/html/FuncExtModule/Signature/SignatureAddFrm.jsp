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
</Script>
</head>
<body bgcolor="#ffffff">
<div align="center"><font size=4 color="ff0000">签章管理〖增加签章〗</font></div>
<hr size=1>
<br>
<form name="webform" method="post" enctype="multipart/form-data" action="SignatureAdd.jsp" onsubmit="return Check(this)">
<table border=0  cellspacing='0' cellpadding='0' width=100% align=center class=TBStyle>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>用户名称</td>
  <td class="TDStyle" width="90%"><input type="text" name="UserName" size="50" maxlength="32" class="IptStyle" value=""></td>
</tr>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>用户密码</td>
  <td class="TDStyle" width="90%"><input type="text" name="PassWord" size="50" maxlength="32" class="IptStyle" value=""></td>
</tr>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>签章名称</td>
  <td class="TDStyle" width="90%"><input type="text" name="MarkName" size="50" maxlength="32" class="IptStyle" value=""></td>
</tr>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>签章文件</td>
  <td class="TDStyle"><input type="file" name="MarkFile" size="50" maxlength="60" class="IptStyle"></td>
</tr>
<tr>
  <td colspan=2 class="TDTitleStyle" nowrap>
    <input type=submit name="Save" value="保 存">
    <input type=reset name="Reset" value="重 填">
    <input type=button name="Return" value="返 回"  onclick="javascript:history.back();">
  </td>
</tr>
</table>
</form>
</body>
</html>
