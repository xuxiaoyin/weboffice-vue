<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %>
<%
  ResultSet result=null;

  String mDescript="";
  String mFileName="";

  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName="OfficeServer.jsp";
  //String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/"+mServerName;
  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/FuncExtModule/"+mServerName;
  String mRecordID=request.getParameter("RecordID");
  String mFileType=request.getParameter("FileType");
  String mEditType="1,1";
  String mUserName="Administrator";


  //ȡ��ģʽ
  if (mEditType==null)
  {
    mEditType="2,1";		//2 ���
  }
  //ȡ������
  if ( mFileType==null)
  {
    mFileType=".doc";	// Ĭ��Ϊ.doc�ĵ�
  }
  //ȡ���û���
  if (mUserName==null)
  {
    mUserName="���Ƽ�";
  }

  //ȡ��ģ��
  if ( mRecordID==null)
  {
    mRecordID="";	// Ĭ��û��ģ��
  }

  //�����ݿ�
  DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
  if (DbaObj.OpenConnection())
  {
    String mSql="Select * From Template_File Where RecordID='"+ mRecordID + "'";
    try
    {
      result=DbaObj.ExecuteQuery(mSql);
      if (result.next())
      {
        mRecordID=result.getString("RecordID");
        mFileName=result.getString("FileName");
        mFileType=result.getString("FileType");
        mDescript=result.getString("Descript");
      }
      else
      {
	//ȡ��Ψһֵ(mRecordID)
        java.util.Date dt=new java.util.Date();
        long lg=dt.getTime();
        Long ld=new Long(lg);
	//��ʼ��ֵ
        mRecordID=ld.toString();
        mFileName="����ģ��"+mFileType;
        mFileType=mFileType;
        mDescript="���Ĺ���ģ��";
      }
      result.close();
    }
    catch(Exception e)
    {
      System.out.println(e.toString());
    }
    DbaObj.CloseConnection() ;
  }

%>

<html>
<head>
<title>ģ�����</title>
<link rel='stylesheet' type='text/css' href='../test.css'>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript" for=WebOffice2015 event="OnCommand(vIndex, Caption, bCancel)">
   if (vIndex==1){  //�򿪱����ļ�
      WebOpenLocal();
   }
   if (vIndex==2){  //���汾���ļ�
      WebSaveLocal();
   }
   if (vIndex==4){  //���沢�˳�
     SaveDocument();    //��������
     webform.submit();  //�ύ��
   }
   if (vIndex==6){  //��ӡ�ĵ�
      WebOpenPrint();
   }
</script>

<script language="javascript" for=WebOffice2015 event="OnReady()">
    //��ȡiWebOffice2015�ؼ�����WebOffice.FuncExtModule��iWebOffice2015�ؼ���չ�ӿڶ���
	WebOffice = document.getElementById("WebOffice2015");
	webform.WebOffice = WebOffice.FuncExtModule;          //webform.WebOffice��֮ǰ03&09�ؼ�ʹ�õĶ���
	Load();          //����ҳ������꣬�ؼ���û�м��ص����
</script>

<script language=javascript>

//���ã���ʾ����״̬
function StatusMsg(mString){
  StatusBar.innerText=mString;
}

//���ã�����iWebOffice
function Load(){
  try{

  //�������Ա������ã�ʵʼ��iWebOffice
  webform.WebOffice.WebUrl="<%=mServerUrl%>";	//WebUrl:ϵͳ������·������������ļ������������籣�桢���ĵ�����Ҫ�ļ�
  webform.WebOffice.RecordID="<%=mRecordID%>";	//RecordID:���ĵ���¼���
  webform.WebOffice.Template="<%=mRecordID%>";	//Template:ģ����
  webform.WebOffice.FileName="<%=mFileName%>";	//FileName:�ĵ�����
  webform.WebOffice.FileType="<%=mFileType%>";	//FileType:�ĵ�����  .doc  .xls  .wps
  webform.WebOffice.EditType="<%=mEditType%>";	//EditType:�༭����  ��ʽһ����ʽ��  <�ο������ĵ�>
  webform.WebOffice.UserName="<%=mUserName%>";	//UserName:�����û���

  //�������Կ��Բ�Ҫ
  webform.WebOffice.ShowToolBar="0";		//ShowToolBar:�Ƿ���ʾ������:1��ʾ,0����ʾ
  webform.WebOffice.ShowMenu="1";		//ShowMenu:1 ��ʾ�˵�  0 ���ز˵�
  webform.WebOffice.AppendMenu("1","�򿪱����ļ�(&L)");
  webform.WebOffice.AppendMenu("2","���汾���ļ�(&S)");
  webform.WebOffice.AppendMenu("3","-");
  webform.WebOffice.AppendMenu("4","���沢�˳�(&E)");
  webform.WebOffice.AppendMenu("5","-");
  webform.WebOffice.AppendMenu("6","��ӡ�ĵ�(&P)");
  webform.WebOffice.DisableMenu("��(&M);ѡ��(&O)...");      //��ֹ�˵�

  webform.WebOffice.WebOpen();			//�򿪸��ĵ�    ����OfficeServer��OPTION="LOADTEMPLATE"
  webform.WebOffice.ShowType=1;			//�ĵ���ʾ��ʽ  1:��ʾ������ע  2:��ʾ��д��ע  0:��ʾ�ĵ��˸�
  StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//���ã��˳�iWebOffice
function UnLoad(){
  try{
  if (!webform.WebOffice.WebClose()){
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg("�ر��ĵ�...");
  }
  }catch(e){}
}


//���ã����ĵ�
function LoadDocument(){
  StatusMsg("���ڴ��ĵ�...");
  if (!webform.WebOffice.WebLoadTemplate()){  //����OfficeServer��OPTION="LOADTEMPLATE"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}


//���ã�ˢ���ĵ�
function WebReFresh(){
  webform.WebOffice.WebReFresh();
  StatusMsg("�ĵ���ˢ��...");
}


//���ã������ĵ�
function SaveDocument(){
  webform.WebOffice.WebClearMessage();            //���iWebOffice����
  if ("<%=mFileType%>"==".doc"){
    if (!webform.WebOffice.WebSaveBookMarks()){    //����OfficeServer��OPTION="SAVEBOOKMARKS"
      StatusMsg(webform.WebOffice.Status);
      return false;
    }
  }
  //webform.WebOffice.WebSetMsgByName("MyDefine1","�Զ������ֵ1");  //���ñ���MyDefine1="�Զ������ֵ1"�������������ö��  ��WebSaveTemplate()ʱ��һ���ύ��OfficeServer��
  if (!webform.WebOffice.WebSaveTemplate(true)){    //����OfficeServer��OPTION="SAVETEMPLATE"������true��ʾ����OFFICE�ĵ�
     StatusMsg(webform.WebOffice.Status);
     return false;
  }else{
     StatusMsg(webform.WebOffice.Status);
     return true;
  }
}

//���ã����ģ��
function LoadBookmarks(){
  StatusMsg("�������ģ��...");
  if (!webform.WebOffice.WebLoadBookmarks()){    //����OfficeServer��OPTION="LOADBOOKMARKS"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//���ã�������ǩֵ  vbmName:��ǩ���ƣ�vbmValue:��ǩֵ   ��ǩ����ע���Сд
function SetBookmarks(vbmName,vbmValue){
  if (!webform.WebOffice.WebSetBookmarks(vbmName,vbmValue)){
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//���ã����ݱ�ǩ���ƻ�ȡ��ǩֵ  vbmName:��ǩ����
function GetBookmarks(vbmName){
  var vbmValue;
  vbmValue=webform.WebOffice.WebGetBookmarks(vbmName);
  return vbmValue;
}

//���ã���ӡ�ĵ�
function WebOpenPrint(){
  try{
    webform.WebOffice.WebOpenPrint();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//���ã�ҳ������
function WebOpenPageSetup(){
   try{
	if (webform.WebOffice.FileType==".doc"){
	  webform.WebOffice.WebObject.Application.Dialogs(178).Show();
	}
	if(webform.WebOffice.FileType==".xls"){
	  webform.WebOffice.WebObject.Application.Dialogs(7).Show();
	}
   }catch(e){

   }
}

//���ã���ǩ����
function WebOpenBookMarks(){
  try{
    webform.WebOffice.WebOpenBookmarks();    //����OfficeServer��OPTION="LISTBOOKMARKS"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//���ã���Ϊ�����ļ�
function WebSaveLocal(){
  try{
    webform.WebOffice.WebSaveLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//���ã��򿪱����ļ�
function WebOpenLocal(){
  try{
    webform.WebOffice.WebOpenLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}
</script>
</head>
<body bgcolor="#ffffff"  onunload="UnLoad()"> <!--�������˳�iWebOffice-->

<form name="webform" method="post" action="TemplateSave.jsp" onsubmit="return SaveDocument();"> <!--����iWebOffice���ύ����Ϣ-->
<input type="hidden" name="RecordID" value="<%=mRecordID%>">

<table border=0  cellspacing='0' cellpadding='0' width=100% height=100% align=center class=TBStyle>
<tr>
  <td align="right" class="TDTitleStyle" width=64>ģ����</td>
  <td class="TDStyle"><input type="text" name="FileName" value="<%=mFileName%>" class="IptStyle" ></td>
</tr>

<tr>
  <td align=right class="TDTitleStyle" width=64>˵��</td>
  <td class="TDStyle"><input type="text" name="Descript" value="<%=mDescript%>" class="IptStyle" ></td>
</tr>

<tr>
  <!--td align=right valign=top  class="TDTitleStyle" width=64>����</td-->
  <td align=right valign=top  class="TDTitleStyle" width=64 height=90% >
                 <input type=button value="��ӡ�ĵ�"  onclick="WebOpenPrint()">
                 <input type=button value="�����ǩ"  onclick="WebOpenBookMarks()">
                 <input type=button value="���ģ��"  onclick="LoadBookmarks()">
                 <input type=button value="�ص��ĵ�"  onclick="LoadDocument()">
                 <input type=button value="ˢ���ĵ�"  onclick="WebReFresh()">
                 <input type=button value="���ļ�"  onclick="WebOpenLocal()">
                 <input type=button value="�����ļ�"  onclick="WebSaveLocal()">
  </td>

  <td class="TDStyle"  height=90%>
        <table border=0 cellspacing='0' cellpadding='0' width='100%' height='100%' >
        <tr>
          <td bgcolor="menu">
            <!--����iWebOffice��ע��汾�ţ�����������-->
            <script src="../iWebOffice2015.js"></script>
          </td>
        </tr>
        <tr>
          <td bgcolor=menu height='20'>
		<div id=StatusBar>״̬��</div>
          </td>
        </tr>
        </table>
  </td>
</tr>
</table>

<input type=submit value="  ����  ">
<input type=reset value="  ���  ">
<input type=button value="  ����  " onclick="history.back()"> ע�⣺ֻ��ѡ�񡶱��桷�������Ĳ�������Ч��
</form>

</body>
</html>
