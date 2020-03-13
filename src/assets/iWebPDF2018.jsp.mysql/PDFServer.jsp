<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="DBstep.iMsgServer2000.*" %>
<%@ page import="DBstep.iDBManager2000" %>
<%!
public class iWebOffice {
  private int mFileSize;
  private byte[] mFileBody;
  private String mFileName;
  private String mFileType;
  private String mFileDate;
  private String mFileID;

  private String mRecordID;
  private String mTemplate;
  private String mDateTime;
  private String mOption;
  private String mMarkName;
  private String mPassword;
  private String mMarkList;
  private String mBookmark;
  private String mDescript;
  private String mHostName;
  private String mMarkGuid;
  private String mCommand;
  private String mContent;
  private String mHtmlName;
  private String mDirectory;
  private String mFilePath;

  private String mUserName;
  private int mColumns;
  private int mCells;
  private String mMyDefine1;
  private String mLocalFile;
  private String mRemoteFile;
  private String mLabelName;
  private String mImageName;
  private String mTableContent;

  private String Sql;

  //打印控制
  private String mOfficePrints;
  private int mCopies;

  //自定义信息传递
  private String mInfo;

  private DBstep.iMsgServer2000 MsgObj;
  private DBstep.iDBManager2000 DbaObj;

  // ************* 文档、模板管理代码    开始  *******************************

  //调出文档，将文档内容保存在mFileBody里，以便进行打包
  private boolean LoadFile() {
    boolean mResult = false;
    String Sql = "SELECT FileBody,FileSize FROM Document_File WHERE RecordID='" +
        mRecordID + "'";
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {
            try {
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

  //保存文档，如果文档存在，则覆盖，不存在，则添加
  private boolean SaveFile() {
    boolean mResult = false;
    int iFileId = -1;
    String Sql = "SELECT * FROM Document_File WHERE RecordID='" + mRecordID +
        "'";

    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {
            System.out.println("sdfd");
            Sql = "update Document_File set RecordID=?,FileName=?,FileType=?,FileSize=?,FileDate=?,FileBody=?,FilePath=?,UserName=?,Descript=? WHERE RecordID='" +
                mRecordID + "'";
          }
          else {
            System.out.println("adfdse");
            Sql = "insert into Document_File (RecordID,FileName,FileType,FileSize,FileDate,FileBody,FilePath,UserName,Descript) values (?,?,?,?,?,?,?,?,? )";
          }
          result.close();
        }
        catch (SQLException e) {
          System.out.println(e.toString());
          mResult = false;
        }
        System.out.println(Sql);
        java.sql.PreparedStatement prestmt = null;
        try {
          prestmt = DbaObj.Conn.prepareStatement(Sql);
          prestmt.setString(1, mRecordID);
          prestmt.setString(2, mFileName);
          prestmt.setString(3, mFileType);
          prestmt.setInt(4, mFileSize);
          prestmt.setString(5, mFileDate);
          prestmt.setBytes(6, mFileBody);
          prestmt.setString(7, mFilePath);
          prestmt.setString(8, mUserName);
          prestmt.setString(9, mDescript); //"通用版本"
          DbaObj.Conn.setAutoCommit(false);
          prestmt.execute();
          DbaObj.Conn.commit();
          prestmt.close();
          mResult = true;
        }
        catch (SQLException e) {
          System.out.println(e.toString());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
    return (mResult);
  }

// *************接收流、写回流代码    开始  *******************************
//取得客户端发来的数据包
  private byte[] ReadPackage(HttpServletRequest request) {
    byte mStream[] = null;
    int totalRead = 0;
    int readBytes = 0;
    int totalBytes = 0;
    try {
      totalBytes = request.getContentLength();
      mStream = new byte[totalBytes];
      while (totalRead < totalBytes) {
        request.getInputStream();
        readBytes = request.getInputStream().read(mStream, totalRead,
                                                  totalBytes - totalRead);
        totalRead += readBytes;
        continue;
      }
    }
    catch (Exception e) {
      System.out.println(e.toString());
    }
    return (mStream);
  }

//发送处理后的数据包
  private void SendPackage(HttpServletResponse response) {
    try {
      ServletOutputStream OutBinarry = response.getOutputStream();
      OutBinarry.write(MsgObj.MsgVariant());
      OutBinarry.flush();
      OutBinarry.close();
    }
    catch (IOException e) {
      System.out.println(e.toString());
    }
  }

// *************接收流、写回流代码    结束  *******************************

  public void ExecuteRun(HttpServletRequest request,
                         HttpServletResponse response) {
    DbaObj = new DBstep.iDBManager2000(); //创建数据库对象
    MsgObj = new DBstep.iMsgServer2000(); //创建信息包对象

    mOption = "";
    mRecordID = "";
    mTemplate = "";
    mFileBody = null;
    mFileName = "";
    mFileType = "";
    mFileSize = 0;
    mFileID = "";
    mDateTime = "";
    mMarkName = "";
    mPassword = "";
    mMarkList = "";
    mBookmark = "";
    mMarkGuid = "";
    mDescript = "";
    mCommand = "";
    mContent = "";
    mLabelName = "";
    mImageName = "";
    mTableContent = "";
    mMyDefine1 = "";

    mFilePath = request.getSession().getServletContext().getRealPath("");	//取得服务器路径

    System.out.println("ReadPackage");

    try {
      if (request.getMethod().equalsIgnoreCase("POST")) {
        //MsgObj.MsgVariant(ReadPackage(request));                              //老版本后台类解析数据包方式（新版控件也兼容）
        MsgObj.Load(request);                                                   //8.1.0.2版后台类新增解析接口，效率更高

        System.out.println("DBstep:"+MsgObj.GetMsgByName("DBSTEP"));
        if (MsgObj.GetMsgByName("DBSTEP").equalsIgnoreCase("DBSTEP")) {		//如果是合法的信息包
          mOption = MsgObj.GetMsgByName("OPTION");				//取得操作信息
          mUserName = MsgObj.GetMsgByName("USERNAME");				//取得系统用户
          System.out.println("mOption:"+mOption);						//打印出调试信息

          if (mOption.equalsIgnoreCase("LOADFILE")) {				//下面的代码为打开服务器数据库里的文件
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//取得文档编号
            mFileName = MsgObj.GetMsgByName("FILENAME");			//取得文档名称
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//取得文档类型
            MsgObj.MsgTextClear();						//清除文本信息
            //if (MsgObj.MsgFileLoad(mFilePath+"\\"+mFileName))			//从文件夹调入文档
            if (LoadFile()) {							//从数据库调入文档
              MsgObj.MsgFileBody(mFileBody);					//将文件信息打包
              MsgObj.SetMsgByName("STATUS", "打开成功!");			//设置状态信息
              MsgObj.MsgError("");						//清除错误信息
            }
            else {
              MsgObj.MsgError("打开失败!");					//设置错误信息
            }
          }

          else if (mOption.equalsIgnoreCase("SAVEFILE")) {			//下面的代码为保存文件在服务器的数据库里
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//取得文档编号
            mFileName = MsgObj.GetMsgByName("FILENAME");			//取得文档名称
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//取得文档类型
            //mMyDefine1=MsgObj.GetMsgByName("MyDefine1");			//取得客户端传递变量值 MyDefine1="自定义变量值1"
            mFileSize = MsgObj.MsgFileSize();					//取得文档大小
            mFileDate = DbaObj.GetDateTime();					//取得文档时间
            mFileBody = MsgObj.MsgFileBody();					//取得文档内容
            mFilePath = "";							//如果保存为文件，则填写文件路径
            mUserName = mUserName;						//取得保存用户名称
            mDescript = "通用版本";						//版本说明
            MsgObj.MsgTextClear();      //清除文本信息
            //if (MsgObj.MsgFileSave(mFilePath+"\\"+mFileName))			//保存文档内容到文件夹中
            System.out.println(mFileBody.length);
            if (SaveFile()) {       //保存文档内容到数据库中
            System.out.println("bbbbb");
            MsgObj.SetMsgByName("STATUS", "保存成功!");			//设置状态信息
              MsgObj.MsgError("");						//清除错误信息
            }
            else {
              MsgObj.MsgError("保存失败!");					//设置错误信息
            }
            MsgObj.MsgFileClear();						//清除文档内容
          }

          else if (mOption.equalsIgnoreCase("INSERTFILE")) {			//下面的代码为插入文件
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//取得文档编号
            mFileName = MsgObj.GetMsgByName("FILENAME");			//取得文档名称
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//取得文档类型
            MsgObj.MsgTextClear();
            if (LoadFile()) {							//调入文档
              MsgObj.MsgFileBody(mFileBody);					//将文件信息打包
              MsgObj.SetMsgByName("POSITION", "Content");			//设置插入的位置[书签]
              MsgObj.SetMsgByName("STATUS", "插入文件成功!");			//设置状态信息
              MsgObj.MsgError("");						//清除错误信息
            }
            else {
              MsgObj.MsgError("插入文件成功!");					//设置错误信息
            }
          }

          else if (mOption.equalsIgnoreCase("DATETIME")) {			//下面的代码为请求取得服务器时间
            MsgObj.MsgTextClear();						//清除文本信息
            MsgObj.SetMsgByName("DATETIME", DbaObj.GetDateTime());		//标准日期格式字串，如 2005-8-16 10:20:35
            //MsgObj.SetMsgByName("DATETIME","2006-01-01 10:24:24");		//标准日期格式字串，如 2005-8-16 10:20:35
          }

          else if (mOption.equalsIgnoreCase("SENDMESSAGE")) {			//下面的代码为Web页面请求信息[扩展接口]
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//取得文档编号
            mFileName = MsgObj.GetMsgByName("FILENAME");			//取得文档名称
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//取得文档类型
            mCommand = MsgObj.GetMsgByName("COMMAND");				//取得操作类型 InportText or ExportText
            mContent = MsgObj.GetMsgByName("CONTENT");				//取得文本信息 Content
            mOfficePrints = MsgObj.GetMsgByName("OFFICEPRINTS");		//取得Office文档的打印次数
            mInfo = MsgObj.GetMsgByName("TESTINFO");				//取得客户端传来的自定义信息

            MsgObj.MsgTextClear();
            MsgObj.MsgFileClear();
            System.out.println("COMMAND:"+mCommand);

            if (mCommand.equalsIgnoreCase("SELFINFO")) {
              mInfo = "服务器端收到客户端传来的信息：“" + mInfo + "” | ";
              //组合返回给客户端的信息
              mInfo = mInfo + "服务器端发回当前服务器时间：" + DbaObj.GetDateTime();
              MsgObj.SetMsgByName("RETURNINFO", mInfo);				//将返回的信息设置到信息包中
            }
            else {
              MsgObj.MsgError("客户端Web发送数据包命令没有合适的处理函数![" + mCommand + "]");
              MsgObj.MsgTextClear();
              MsgObj.MsgFileClear();
            }
          }
        }
        else {
          System.out.println("客户端发送数据包错误!");
          MsgObj.MsgError("客户端发送数据包错误!");
          MsgObj.MsgTextClear();
          MsgObj.MsgFileClear();
        }
      }
      else {
        MsgObj.MsgError("请使用Post方法");
        MsgObj.MsgTextClear();
        MsgObj.MsgFileClear();
      }
      System.out.println("SendPackage");
      System.out.println("");
      //SendPackage(response);                                                  //老版后台类返回信息包数据方法（新版控件也兼容）
      MsgObj.Send(response);                                                    //8.1.0.2新版后台类新增的功能接口，效率更高
    }
    catch (Exception e) {
      System.out.println(e.toString());
    }
  }
}
%>
<%
iWebOffice officeServer = new iWebOffice();
officeServer.ExecuteRun(request,response);
out.clear();
out = pageContext.pushBody();
%>