<%@ page contentType="text/html; charset=gb2312" %>
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
</Script>
</head>
<body bgcolor="#ffffff">
<div align="center"><font size=4 color=ff0000>��ǩ�������ӱ�ǩ��</font></div>
<hr size=1>
<br>
<form name="webform" method="post" action="BookMarkAdd.jsp" onsubmit="return Check(this)">
<table border=0  cellspacing='0' cellpadding='0' width=100% align=center class=TBStyle>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>��ǩ����</td>
  <td class="TDStyle" width="90%"><input type="text" name="BookMarkName" size="50" maxlength="32" class="IptStyle" value=""></td>
</tr>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>��ǩ˵��</td>
  <td class="TDStyle"><input type="text" name="BookMarkDesc" size="50" maxlength="60" class="IptStyle"></td>
</tr>
<tr>
  <td nowrap align=center class="TDTitleStyle" width=64>��ǩ��ע</td>
  <td class="TDStyle"><input type="text" name="BookMarkText" size="50" maxlength="150" class="IptStyle"></td>
</tr>
<tr>
  <td colspan=2 class="TDTitleStyle" nowrap>
    <input type=submit name="Save" value="�� ��">
    <input type=reset name="Reset" value="�� ��">
    <input type=button name="Return" value="�� ��"  onclick="javascript:history.back();">
  </td>
</tr>
</table>
</form>
</body>
</html>
