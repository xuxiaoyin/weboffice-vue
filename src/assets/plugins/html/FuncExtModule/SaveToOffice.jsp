<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="DBstep.iMsgServer2000.*" %>
<%@ page import="DBstep.iDBManager2000.*" %>
<%!
 private byte[] mFileBody;
 private String mFileName;
 private String mFilePath;
 private String Sql;

 private DBstep.iMsgServer2000 MsgObj;
 private DBstep.iDBManager2000 DbaObj ;


 //调出文档，将文档内容保存在mFileBody里，以便进行打包
  private boolean LoadFile()
  {
    boolean mResult = false;
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {
            try {
              mFileName = result.getString("FileName");
              mFileBody = result.getBytes("FileBody");
              if (result.wasNull()) {
                mFileBody = null;
              }
              mResult = true;
            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
          result.close();
        }
        catch (SQLException e) {
          System.out.println(e.getMessage());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
    return (mResult);
  }

%>

<%
  String mRecordID=request.getParameter("RecordID");      //1141208427234
  if (mRecordID==null)
  {
    Sql = "SELECT top 1 FileName,FileBody FROM Document_File";  //取得第一条记录
  }else{
    Sql = "SELECT FileName,FileBody FROM Document_File WHERE RecordID='" + mRecordID + "'";
  }
  mFileBody=null;
  mFileName="";

  mFilePath=application.getRealPath("") ;  //取得服务器路径
  DbaObj=new DBstep.iDBManager2000();      //创建信息包对象
  MsgObj=new DBstep.iMsgServer2000();      //创建数据库对象

  try
  {
	if (LoadFile())					        //调入文档
	{
	  MsgObj.MsgFileBody(mFileBody);			//将文件信息打包
	  mFileBody=MsgObj.ToDocument(MsgObj.MsgFileBody());    //通过iMsgServer200 将pgf文件流转化为普通Office文件流
	  MsgObj.MsgFileBody(mFileBody);			//设置文件内容流
	  MsgObj.MsgFileSave(mFilePath+"/"+mFileName);		//保存doc文件
          out.println("成功：在服务器生成OFFICE文档"+mFilePath+"/"+mFileName);
	}
	else
	{
          out.println("失败：在服务器生成OFFICE文档");
	}
        MsgObj.MsgFileClear();
  }
  catch(IOException e)
  {
    out.println("操作异常");
    System.out.println(e.toString());
  }
%>