<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<%
String mBookMarkID = new String(request.getParameter("BookMarkID"));
boolean mResult=false;

DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
if (DbaObj.OpenConnection())
{
  java.sql.PreparedStatement prestmt=null;
  String mSql = "Delete from BookMarks where BookMarkID = "+ mBookMarkID;
  prestmt =DbaObj.Conn.prepareStatement(mSql);;
  prestmt.execute();
  prestmt.close();
  mResult=true;
}
else
{
  mResult=false;
}
DbaObj.CloseConnection() ;

if (mResult)
{
  response.sendRedirect("BookMarkList.jsp");
}

%>
