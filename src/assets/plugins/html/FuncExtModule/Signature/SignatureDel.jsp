<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<%
String mSignatureID = new String(request.getParameter("SignatureID"));
boolean mResult=false;

DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
if (DbaObj.OpenConnection())
{
  String mSql = "Delete from Signature where SignatureID = " + mSignatureID;
  DbaObj.ExecuteUpdate(mSql);
  mResult=true;
}
else
{
  mResult=false;
}
DbaObj.CloseConnection() ;

if (mResult)
{
  response.sendRedirect("SignatureList.jsp");
}

%>
