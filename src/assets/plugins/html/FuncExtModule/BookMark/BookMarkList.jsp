<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<html>
<head>
<title>标签管理</title>
<link rel='stylesheet' type='text/css' href='../test.css'>
<script language="javascript">
function ConfirmDel(FileUrl){
        if (confirm('是否确定删除该标签！')){
                location.href=FileUrl;
        }
}
</script>
</head>
<body bgcolor="#ffffff">
<div align="center"><font size=4 color=ff0000>标签管理</font></div>
<hr size=1>
<br>
<table border=0  cellspacing='0' cellpadding='0' width=100% align=center class=TBStyle>
        <tr>
                <td colspan=2 class="TDTitleStyle" nowrap>
                  <input type=button name="Add" value="增加标签"  onclick="javascript:location.href='BookMarkAddFrm.jsp'">
                  <input type=button name="Return" value="返 回"  onclick="javascript:location.href='../DocumentList.jsp';">
                </td>
                <td colspan=3 class="TDTitleStyle">&nbsp;</td>
        </tr>
        <tr>
                <td nowrap align=center class="TDTitleStyle" height="26">编号</td>
                <td nowrap align=center class="TDTitleStyle">标签名称</td>
                <td nowrap align=center class="TDTitleStyle">标签说明</td>
                <td nowrap align=center class="TDTitleStyle">标签备注</td>
		<td nowrap align=center class="TDTitleStyle">操作</td>
        </tr>
<%
  DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
  if (DbaObj.OpenConnection())
  {
    try
    {
      ResultSet result=DbaObj.ExecuteQuery("select * from BookMarks order by BookMarkID desc") ;
      while ( result.next() )
      {
        String mBookMarkID=result.getString("BookMarkID");
%>
      <tr>
         <td class="TDStyle"><%=mBookMarkID%>&nbsp;</td>
         <td class="TDStyle"><%=result.getString("BookMarkName")%>&nbsp;</td>
         <td class="TDStyle"><%=result.getString("BookMarkDesc")%>&nbsp;</td>
         <td class="TDStyle"><%=result.getString("BookMarkText")%>&nbsp;</td>
         <td class="TDStyle" width=148 nowrap>
                 <input type="button" name="Edit" value=" 修 改 " onclick="javascript:location.href='BookMarkEditFrm.jsp?BookMarkID=<%=mBookMarkID%>';">
                 <input type="button" name="Del" value=" 删 除 " onclick="javascript:ConfirmDel('BookMarkDel.jsp?BookMarkID=<%=mBookMarkID%>');">
         </td>
	</tr>
<%
      }
      result.close() ;
    }
    catch(SQLException e)
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
