<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<%
String mRecordID=request.getParameter("RecordID");
String mFileName=new String(request.getParameter("FileName").getBytes("8859_1"));
String mDescript=new String(request.getParameter("Descript").getBytes("8859_1"));

DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
if (DbaObj.OpenConnection())
{
  String mSql="Update Template_File Set FileName = '"+ mFileName +"',Descript = '"+ mDescript +"' Where RecordID='"+ mRecordID +"'";
  DbaObj.ExecuteUpdate(mSql);
}
DbaObj.CloseConnection();

response.sendRedirect("TemplateList.jsp");
%>
