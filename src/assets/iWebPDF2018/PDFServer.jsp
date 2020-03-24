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

  //��ӡ����
  private String mOfficePrints;
  private int mCopies;

  //�Զ�����Ϣ����
  private String mInfo;

  private DBstep.iMsgServer2000 MsgObj;
  private DBstep.iDBManager2000 DbaObj;

  // ************* �ĵ���ģ��������    ��ʼ  *******************************

  //�����ĵ������ĵ����ݱ�����mFileBody��Ա���д��
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

  //�����ĵ�������ĵ����ڣ��򸲸ǣ������ڣ������
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
          prestmt.setString(9, mDescript); //"ͨ�ð汾"
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

// *************��������д��������    ��ʼ  *******************************
//ȡ�ÿͻ��˷��������ݰ�
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

//���ʹ��������ݰ�
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

// *************��������д��������    ����  *******************************

  public void ExecuteRun(HttpServletRequest request,
                         HttpServletResponse response) {
    DbaObj = new DBstep.iDBManager2000(); //�������ݿ����
    MsgObj = new DBstep.iMsgServer2000(); //������Ϣ������

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

    mFilePath = request.getSession().getServletContext().getRealPath("");	//ȡ�÷�����·��

    System.out.println("ReadPackage");

    try {
      if (request.getMethod().equalsIgnoreCase("POST")) {
        //MsgObj.MsgVariant(ReadPackage(request));                              //�ϰ汾��̨��������ݰ���ʽ���°�ؼ�Ҳ���ݣ�
        MsgObj.Load(request);                                                   //8.1.0.2���̨�����������ӿڣ�Ч�ʸ���

        System.out.println("DBstep:"+MsgObj.GetMsgByName("DBSTEP"));
        if (MsgObj.GetMsgByName("DBSTEP").equalsIgnoreCase("DBSTEP")) {		//����ǺϷ�����Ϣ��
          mOption = MsgObj.GetMsgByName("OPTION");				//ȡ�ò�����Ϣ
          mUserName = MsgObj.GetMsgByName("USERNAME");				//ȡ��ϵͳ�û�
          System.out.println("mOption:"+mOption);						//��ӡ��������Ϣ

          if (mOption.equalsIgnoreCase("LOADFILE")) {				//����Ĵ���Ϊ�򿪷��������ݿ�����ļ�
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//ȡ���ĵ����
            mFileName = MsgObj.GetMsgByName("FILENAME");			//ȡ���ĵ�����
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//ȡ���ĵ�����
            MsgObj.MsgTextClear();						//����ı���Ϣ
            //if (MsgObj.MsgFileLoad(mFilePath+"\\"+mFileName))			//���ļ��е����ĵ�
            if (LoadFile()) {							//�����ݿ�����ĵ�
              MsgObj.MsgFileBody(mFileBody);					//���ļ���Ϣ���
              MsgObj.SetMsgByName("STATUS", "�򿪳ɹ�!");			//����״̬��Ϣ
              MsgObj.MsgError("");						//���������Ϣ
            }
            else {
              MsgObj.MsgError("��ʧ��!");					//���ô�����Ϣ
            }
          }

          else if (mOption.equalsIgnoreCase("SAVEFILE")) {			//����Ĵ���Ϊ�����ļ��ڷ����������ݿ���
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//ȡ���ĵ����
            mFileName = MsgObj.GetMsgByName("FILENAME");			//ȡ���ĵ�����
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//ȡ���ĵ�����
            //mMyDefine1=MsgObj.GetMsgByName("MyDefine1");			//ȡ�ÿͻ��˴��ݱ���ֵ MyDefine1="�Զ������ֵ1"
            mFileSize = MsgObj.MsgFileSize();					//ȡ���ĵ���С
            mFileDate = DbaObj.GetDateTime();					//ȡ���ĵ�ʱ��
            mFileBody = MsgObj.MsgFileBody();					//ȡ���ĵ�����
            mFilePath = "";							//�������Ϊ�ļ�������д�ļ�·��
            mUserName = mUserName;						//ȡ�ñ����û�����
            mDescript = "ͨ�ð汾";						//�汾˵��
            MsgObj.MsgTextClear();      //����ı���Ϣ
            //if (MsgObj.MsgFileSave(mFilePath+"\\"+mFileName))			//�����ĵ����ݵ��ļ�����
            System.out.println(mFileBody.length);
            if (SaveFile()) {       //�����ĵ����ݵ����ݿ���
            System.out.println("bbbbb");
            MsgObj.SetMsgByName("STATUS", "����ɹ�!");			//����״̬��Ϣ
              MsgObj.MsgError("");						//���������Ϣ
            }
            else {
              MsgObj.MsgError("����ʧ��!");					//���ô�����Ϣ
            }
            MsgObj.MsgFileClear();						//����ĵ�����
          }

          else if (mOption.equalsIgnoreCase("INSERTFILE")) {			//����Ĵ���Ϊ�����ļ�
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//ȡ���ĵ����
            mFileName = MsgObj.GetMsgByName("FILENAME");			//ȡ���ĵ�����
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//ȡ���ĵ�����
            MsgObj.MsgTextClear();
            if (LoadFile()) {							//�����ĵ�
              MsgObj.MsgFileBody(mFileBody);					//���ļ���Ϣ���
              MsgObj.SetMsgByName("POSITION", "Content");			//���ò����λ��[��ǩ]
              MsgObj.SetMsgByName("STATUS", "�����ļ��ɹ�!");			//����״̬��Ϣ
              MsgObj.MsgError("");						//���������Ϣ
            }
            else {
              MsgObj.MsgError("�����ļ��ɹ�!");					//���ô�����Ϣ
            }
          }

          else if (mOption.equalsIgnoreCase("DATETIME")) {			//����Ĵ���Ϊ����ȡ�÷�����ʱ��
            MsgObj.MsgTextClear();						//����ı���Ϣ
            MsgObj.SetMsgByName("DATETIME", DbaObj.GetDateTime());		//��׼���ڸ�ʽ�ִ����� 2005-8-16 10:20:35
            //MsgObj.SetMsgByName("DATETIME","2006-01-01 10:24:24");		//��׼���ڸ�ʽ�ִ����� 2005-8-16 10:20:35
          }

          else if (mOption.equalsIgnoreCase("SENDMESSAGE")) {			//����Ĵ���ΪWebҳ��������Ϣ[��չ�ӿ�]
            mRecordID = MsgObj.GetMsgByName("RECORDID");			//ȡ���ĵ����
            mFileName = MsgObj.GetMsgByName("FILENAME");			//ȡ���ĵ�����
            mFileType = MsgObj.GetMsgByName("FILETYPE");			//ȡ���ĵ�����
            mCommand = MsgObj.GetMsgByName("COMMAND");				//ȡ�ò������� InportText or ExportText
            mContent = MsgObj.GetMsgByName("CONTENT");				//ȡ���ı���Ϣ Content
            mOfficePrints = MsgObj.GetMsgByName("OFFICEPRINTS");		//ȡ��Office�ĵ��Ĵ�ӡ����
            mInfo = MsgObj.GetMsgByName("TESTINFO");				//ȡ�ÿͻ��˴������Զ�����Ϣ

            MsgObj.MsgTextClear();
            MsgObj.MsgFileClear();
            System.out.println("COMMAND:"+mCommand);

            if (mCommand.equalsIgnoreCase("SELFINFO")) {
              mInfo = "���������յ��ͻ��˴�������Ϣ����" + mInfo + "�� | ";
              //��Ϸ��ظ��ͻ��˵���Ϣ
              mInfo = mInfo + "�������˷��ص�ǰ������ʱ�䣺" + DbaObj.GetDateTime();
              MsgObj.SetMsgByName("RETURNINFO", mInfo);				//�����ص���Ϣ���õ���Ϣ����
            }
            else {
              MsgObj.MsgError("�ͻ���Web�������ݰ�����û�к��ʵĴ�����![" + mCommand + "]");
              MsgObj.MsgTextClear();
              MsgObj.MsgFileClear();
            }
          }
        }
        else {
          System.out.println("�ͻ��˷������ݰ�����!");
          MsgObj.MsgError("�ͻ��˷������ݰ�����!");
          MsgObj.MsgTextClear();
          MsgObj.MsgFileClear();
        }
      }
      else {
        MsgObj.MsgError("��ʹ��Post����");
        MsgObj.MsgTextClear();
        MsgObj.MsgFileClear();
      }
      System.out.println("SendPackage");
      System.out.println("");
      //SendPackage(response);                                                  //�ϰ��̨�෵����Ϣ�����ݷ������°�ؼ�Ҳ���ݣ�
      MsgObj.Send(response);                                                    //8.1.0.2�°��̨�������Ĺ��ܽӿڣ�Ч�ʸ���
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