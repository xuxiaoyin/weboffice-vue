<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<%
String mRecordID=request.getParameter("RecordID");

DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
if (DbaObj.OpenConnection())
{
  String mSql="Delete from Template_File where RecordID = '"+ mRecordID + "'";
  DbaObj.ExecuteUpdate(mSql);
}
DbaObj.CloseConnection();

response.sendRedirect("TemplateList.jsp");
%>

