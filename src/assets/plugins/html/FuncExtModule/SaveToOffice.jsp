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


 //�����ĵ������ĵ����ݱ�����mFileBody��Ա���д��
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
    Sql = "SELECT top 1 FileName,FileBody FROM Document_File";  //ȡ�õ�һ����¼
  }else{
    Sql = "SELECT FileName,FileBody FROM Document_File WHERE RecordID='" + mRecordID + "'";
  }
  mFileBody=null;
  mFileName="";

  mFilePath=application.getRealPath("") ;  //ȡ�÷�����·��
  DbaObj=new DBstep.iDBManager2000();      //������Ϣ������
  MsgObj=new DBstep.iMsgServer2000();      //�������ݿ����

  try
  {
	if (LoadFile())					        //�����ĵ�
	{
	  MsgObj.MsgFileBody(mFileBody);			//���ļ���Ϣ���
	  mFileBody=MsgObj.ToDocument(MsgObj.MsgFileBody());    //ͨ��iMsgServer200 ��pgf�ļ���ת��Ϊ��ͨOffice�ļ���
	  MsgObj.MsgFileBody(mFileBody);			//�����ļ�������
	  MsgObj.MsgFileSave(mFilePath+"/"+mFileName);		//����doc�ļ�
          out.println("�ɹ����ڷ���������OFFICE�ĵ�"+mFilePath+"/"+mFileName);
	}
	else
	{
          out.println("ʧ�ܣ��ڷ���������OFFICE�ĵ�");
	}
        MsgObj.MsgFileClear();
  }
  catch(IOException e)
  {
    out.println("�����쳣");
    System.out.println(e.toString());
  }
%>