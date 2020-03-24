<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<%
  String mRecordID=request.getParameter("RecordID");
  if (mRecordID==null) mRecordID="";
  String mSubject=new String(request.getParameter("Subject").getBytes("8859_1"));
  String mAuthor=new String(request.getParameter("Author").getBytes("8859_1"));
  String mFileDate=new String(request.getParameter("FileDate").getBytes("8859_1"));
  String mFileType="pdf";
  String mStatus="READ";

DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
if (DbaObj.OpenConnection())
{
  String mysql="SELECT RecordID from  Document Where RecordID='" + mRecordID + "'";
  try
  {
    ResultSet result=DbaObj.ExecuteQuery(mysql) ;
    if (result.next())
    {
      mysql="update Document set RecordID=?,Subject=?,Author=?,FileDate=?,FileType=?,Status=? where RecordID='"+mRecordID+"'";
    }
    else
    {
      mysql="insert into Document (RecordID,Subject,Author,FileDate,FileType,Status) values (?,?,?,?,?,?)";
    }
    result.close();
  }
  catch(Exception e)
  {
      System.out.println(e.toString());
  }
  java.sql.PreparedStatement prestmt=null;
  try
  {
      prestmt=DbaObj.Conn.prepareStatement(mysql);
      prestmt.setString(1,mRecordID);
      prestmt.setString(2,mSubject);
      prestmt.setString(3,mAuthor);
      prestmt.setString(4,mFileDate);
      prestmt.setString(5,mFileType);
      prestmt.setString(6,"READ");
      
      DbaObj.Conn.setAutoCommit(false) ;
      prestmt.executeUpdate();
      DbaObj.Conn.commit();

  }
  catch(Exception e)
  {
      System.out.println(e.toString());
  }
  finally
  {
      prestmt.close();
  }
  DbaObj.CloseConnection() ;
}
else
{
  out.println("OpenDatabase Error") ;
}
response.sendRedirect("DocumentList.jsp");
%>
