<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="DBstep.iFileUpLoad2000.*" %>
<%@ page import="DBstep.iDBManager2000.*" %>
<html>
<%!
boolean mResult;
DBstep.iFileUpLoad2000 FileObj;
DBstep.iDBManager2000 DbaObj;
String mUserName;
String mMarkType;
String mMarkPath;
int mMarkSize;
int iSignatureID;
private byte[] mMarkBody;
PreparedStatement prestmt;

%>
<head>
<title>签章管理</title>
<link rel='stylesheet' type='text/css' href='../test.css'>
</head>
<body bgcolor="#ffffff">
<div align="center"><font size=4 color="ff0000">签章管理〖签章保存〗</font></div>
<hr size=1>
<br>
<%
FileObj = new DBstep.iFileUpLoad2000(request);
DbaObj=new DBstep.iDBManager2000();

String mUserName=FileObj.Request("UserName");
String mPassword=FileObj.Request("Password");
String mMarkName=FileObj.Request("MarkName");


if (FileObj.FileName("MarkFile").equalsIgnoreCase("")) {
  mMarkSize=0;
}
else {
  mMarkSize=FileObj.FileSize("MarkFile");
  mMarkType=new String(FileObj.ExtName("MarkFile").getBytes("gb2312"));
  mMarkBody=FileObj.FileBody("MarkFile") ;
}

if (DbaObj.OpenConnection())
{
  String mSql="select MarkName from Signature where MarkName='" + mMarkName + "'";
  try
  {
    ResultSet result=DbaObj.ExecuteQuery(mSql) ;
    if (result.next())
    {
      out.write("保存失败，数据库中已存在相同的印签〖" + mMarkName + "〗<input type='button' value='返 回' onclick='javascript:history.back();'");
      mResult = false;
    }
    else
    {
      //mSql="Insert Into Signature (UserName,Password,MarkName,MarkSize,MarkType,MarkBody) values (?,?,?,?,?,?)";
      //mSql="Insert Into Signature (UserName,Password,MarkName,MarkSize,MarkType) values ('"+mUserName+"','"+mPassword+"','"+mMarkName+"','"+mMarkSize+"','"+mMarkType+"')";
      //System.out.println(mSql);
      //DbaObj.ExecuteUpdate(mSql);
      mResult = true;
    }
    result.close();
  }
  catch(Exception e)
  {
    System.out.println(e.toString());
    mResult=false;
  }

  if (mResult)
  {
    mSql="Insert Into Signature (UserName,Password,MarkName,MarkSize,MarkType,MarkBody) values (?,?,?,?,?,?)";
    java.sql.PreparedStatement prestmt=null;
    try
    {
      prestmt =DbaObj.Conn.prepareStatement(mSql);
      prestmt.setString(1, mUserName);
      prestmt.setString(2, mPassword);
      prestmt.setString(3, mMarkName);
      prestmt.setInt(4, mMarkSize);
      prestmt.setString (5 ,mMarkType);
      prestmt.setBytes(6, mMarkBody);
      prestmt.execute();
      prestmt.close();
      mMarkBody=null;
      mResult=true;
    }
    catch(SQLException e)
    {
      System.out.println(e.toString());
      mResult=false;
    }
  }
  DbaObj.CloseConnection() ;
}

if (mResult)
{
  response.sendRedirect("SignatureList.jsp");
}
%>
</body>
</html>
