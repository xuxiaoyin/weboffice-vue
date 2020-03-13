<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<html>
<head>
<title>模板管理</title>
<link rel='stylesheet' type='text/css' href='../test.css'>
<script language="javascript">
function ConfirmDel(FileUrl){
	if (confirm('是否确定删除该模板！')){
		location.href=FileUrl;
	}
}
</script>
</head>
<body bgcolor="#ffffff">
<div align="center"><font size=4 color=ff0000>模板管理</font></div>
<hr size=1>
<br>
<table border=0  cellspacing='0' cellpadding='0' width=100% align=center class=TBStyle>
	<tr>
		<td colspan=4 class="TDTitleStyle" nowrap>
		  <input type=button name="AddDocTemplate" value="新建word模板"  onclick="javascript:location.href='TemplateEdit.jsp?FileType=.doc';">
		  <input type=button name="AddXslTemplate" value="新建excel模板" onclick="javascript:location.href='TemplateEdit.jsp?FileType=.xls';">
		  <input type=button name="AddXslTemplate" value="新建wps模板" onclick="javascript:location.href='TemplateEdit.jsp?FileType=.wps';">
		  <input type=button name="AddDocTemplate" value="新建金山表格模板"  onclick="javascript:location.href='TemplateEdit.jsp?FileType=.et';">
		  <input type=button name="AddXslTemplate" value="新建ppt模板" onclick="javascript:location.href='TemplateEdit.jsp?FileType=.ppt';">
		  <input type=button name="AddXslTemplate" value="新建visio模板" onclick="javascript:location.href='TemplateEdit.jsp?FileType=.vsd';">
		  <input type=button name="Return" value="返 回"  onclick="javascript:location.href='../DocumentList.jsp';">
		</td>
		<td colspan=2 class="TDTitleStyle">&nbsp;</td>
	</tr>
	<tr>
		<td nowrap align=center class="TDTitleStyle" height="26">编号</td>
		<td nowrap align=center class="TDTitleStyle">模板名称</td>
		<td nowrap align=center class="TDTitleStyle">模板类型</td>
		<td nowrap align=center class="TDTitleStyle">模板说明</td>
		<td nowrap align=center class="TDTitleStyle">操作</td>
	</tr>
<%
  DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
  if (DbaObj.OpenConnection())
  {
    try
    {
      ResultSet result=DbaObj.ExecuteQuery("Select RecordID,FileName,FileType,Descript From Template_File order by TemplateID desc") ;
      while ( result.next() )
      {
        String mRecordID=result.getString("RecordID");
        String mFileName=result.getString("FileName");
        String mFileType=result.getString("FileType");
        String mDescript=result.getString("Descript");
%>
	<tr>
		<td class="TDStyle"><%=mRecordID%>&nbsp;</td>
		<td class="TDStyle"><%=mFileName%>&nbsp;</td>
		<td class="TDStyle"><%=mFileType%>&nbsp;</td>
		<td class="TDStyle"><%=mDescript%>&nbsp;</td>
		<td class="TDStyle" width=148 nowrap>
			<input type=button onclick="javascript:location.href='TemplateEdit.jsp?RecordID=<%=mRecordID%>&FileType=<%=mFileType%>';" name="Edit" value=" 修 改 ">
			<input type=button onclick="javascript:ConfirmDel('TemplateDel.jsp?RecordID=<%=mRecordID%>');" name="Del" value=" 删 除 ">
		</td>
	</tr>
<%
      }
      result.close() ;
    }
    catch(Exception e)
    {
      System.out.println(e.toString());
    }
    DbaObj.CloseConnection() ;
  }
  else
  {
    out.println("OpenDatabase Error") ;
  }
%>
</table>
</body>
</html>
