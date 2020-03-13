<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %>
<%
  ResultSet result=null;
  String mSubject=null;
  String mStatus=null;
  String mAuthor=null;
  String mFileName=null;
  String mFileDate=null;
  String mHTMLPath="";

  String mDisabled="";
  String mDisabledSave="";
  String mWord="";
  String mExcel="";

  //�Զ���ȡOfficeServer��OCX�ļ�����URL·��
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName="OfficeServer.jsp";
  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/FuncExtModule/"+mServerName;
  //String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/"+mServerName;//ȡ��OfficeServer�ļ�������URL
  String mHttpUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/";

  String mRecordID=request.getParameter("RecordID");
  String mTemplate=request.getParameter("Template");
  String mFileType=request.getParameter("FileType");
  String mEditType=request.getParameter("EditType");
  String mShowType=request.getParameter("ShowType");
  String mUserName=new String(request.getParameter("UserName").getBytes("8859_1"));

  //���ñ�ų�ʼֵ
  if (mRecordID==null){
     mRecordID="";
  }

  //���ñ༭״̬��ʼֵ
  if (mEditType==null || mEditType==""){
    mEditType="1,1";
  }

  //������ʾģʽ��ʼֵ
  if (mShowType==null || mShowType==""){
    mShowType="1";
  }

  //�����ĵ����ͳ�ʼֵ
  if (mFileType==null || mFileType==""){
    mFileType=".doc";
  }

  //�����û�����ʼֵ
  if (mUserName==null || mUserName==""){
    mUserName="���Ƽ�";
  }

  //����ģ���ʼֵ
  if (mTemplate==null){
    mTemplate="";
  }

  //�����ݿ�
  DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
  if (DbaObj.OpenConnection()){
    String mSql="Select * From Document Where RecordID='"+ mRecordID + "'";
    try{
      result=DbaObj.ExecuteQuery(mSql);
      if (result.next()){
        mRecordID=result.getString("RecordID");
        mTemplate=result.getString("Template");
        mSubject=result.getString("Subject");
        mAuthor=result.getString("Author");
        mFileDate=result.getString("FileDate");
        mStatus=result.getString("Status");
        mFileType=result.getString("FileType");
        mHTMLPath=result.getString("HTMLPath");
      }
      else{
        //ȡ��Ψһֵ(mRecordID)
        java.util.Date dt=new java.util.Date();
        long lg=dt.getTime();
        Long ld=new Long(lg);
        //��ʼ��ֵ
        mRecordID=ld.toString();//��������ĵ��ı�ţ�ͨ���ñ�ţ����������ҵ���������������¼���ĵ�
        mTemplate=mTemplate;
        mSubject="����������";
        mAuthor=mUserName;
        mFileDate=DbaObj.GetDateTime();
        mStatus="DERF";
        mFileType=mFileType;
        mHTMLPath="";
      }
      result.close();
    }
    catch(SQLException e){
      System.out.println(e.toString());
    }
    DbaObj.CloseConnection() ;
  }

  if (mEditType=="0,0"){
    mDisabled="disabled";
    mDisabledSave="disabled";
  }
  else{
    mDisabled="";
  }

  mFileName=mRecordID + mFileType;  //ȡ���������ĵ�����
  if (mFileType.equalsIgnoreCase(".doc") || mFileType.equalsIgnoreCase(".wps")){
    mWord="";
    mExcel="disabled";
  }
  else if (mFileType.compareTo(".xls")==0){
    mWord="disabled";
    mExcel="";
  }
  else{
    mDisabled="disabled";
  }
%>
<html>
<head>
<title>WebOffice 2003��2009������iWebOffice2015ʾ��</title>
<link rel='stylesheet' type='text/css' href='test.css'>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="renderer" content="webkit" />
<script language="javascript" for=WebOffice2015 event="OnCommand(ID, Caption, bCancel)">
  if (ID==1 || ID==101){  
    WebOpenLocal();     //�򿪱����ļ�
  }
  if (ID==2 || ID==102){ 

    WebSaveLocal();     //���汾���ļ�
  }
  if (ID==3 || ID==103){
    SaveDocument();     //�������ĵ��������ϣ����˳���
  }
  if (ID==5 || ID==201){  
    WebOpenSignature(); //ǩ��ӡ��
  }
  if (ID==6 || ID==202){  
    WebShowSignature(); //��֤ǩ��
  }
  if (ID==8 || ID==301){  
    WebSaveVersion();   //����汾
  }
  if (ID==9 || ID==302){  
    WebOpenVersion();   //�򿪰汾
  }
  if (ID==11 || ID==104){
    SaveDocument();     //�������ĵ���������
    webform.submit();   //Ȼ���˳�
  }
  if (ID==13 || ID==501){  
    WebOpenPrint();     //��ӡ�ĵ�
  }
</script>  



<script language="javascript" for=WebOffice2015 event="OnReady()">
    //��ȡiWebOffice2015�ؼ�����WebOffice.FuncExtModule��iWebOffice2015�ؼ���չ�ӿڶ���
	WebOffice = document.getElementById("WebOffice2015");
	webform.WebOffice = WebOffice.FuncExtModule;          //webform.WebOffice��֮ǰ03&09�ؼ�ʹ�õĶ���
	Load();          //����ҳ������꣬�ؼ���û�м��ص����
	
</script>

<script language=javascript>
/*
form������:webform
iWebOffice����:WebOffice
WebObject�ĵ�����ӿڣ��൱�ڣ�
�����Word  �ļ���WebObject ��Word  VBA��ActiveDocument����
�����Excel �ļ���WebObject ��Excel VBA��ActiveSheet����

�磺webform.WebOffice.WebObject
*/


//���ã���ʾ����״̬
function StatusMsg(mString){
  webform.StatusBar.value=mString;
}
//�½�WebOffice
var WebOffice = null;    //����WebOffice������ȫ��ʹ��

//���ã�����iWebOffice
function Load(){
  try{
    
	if ((window.ActiveXObject!=undefined) || (window.ActiveXObject!=null) ||"ActiveXObject" in window){
			//IE����
		} else{
			//��IE����,������Ŀǰֻ֧��IE������������������֧��Hook�����������ó�false������������쳣������
			WebOffice.HookEnabled = false;
			webform.WebOffice = WebOffice.FuncExtModule;  //��ȡiWebOffice2015��չ�ӿڶ���
		}

	
	
	//�������Ա������ã�ʵʼ��iWebOffice
    webform.WebOffice.WebUrl="<%=mServerUrl%>";             //WebUrl:ϵͳ������·������������ļ������������籣�桢���ĵ�����Ҫ�ļ�
    //webform.WebOffice.WebUrl="http://192.168.0.81:8080/iWebOffice2009_Web2015/OfficeServer.jsp";
	//webform.WebOffice.Alert(webform.WebOffice.WebUrl);
	webform.WebOffice.RecordID="<%=mRecordID%>";            //RecordID:���ĵ���¼���
	webform.WebOffice.Template="<%=mTemplate%>";            //Template:ģ����
	webform.WebOffice.FileName="<%=mFileName%>";            //FileName:�ĵ�����
    //webform.WebOffice.Alert(webform.WebOffice.FileName);
	
	webform.WebOffice.FileType="<%=mFileType%>";            //FileType:�ĵ�����  .doc  .xls  .wps
	//webform.WebOffice.Alert(webform.WebOffice.FileType);
	
	webform.WebOffice.UserName="<%=mUserName%>";            //UserName:�����û������ۼ�������Ҫ
    //webform.WebOffice.Alert(webform.WebOffice.UserName);
	webform.WebOffice.EditType="<%=mEditType%>";            //EditType:�༭����  ��ʽһ����ʽ��  <�ο������ĵ�>
                                                            //��һλ����Ϊ0,1,2,3 ����:0���ɱ༭;1���Ա༭,�޺ۼ�;2���Ա༭,�кۼ�,�����޶�;3���Ա༭,�кۼ�,���޶���
                                                            //�ڶ�λ����Ϊ0,1 ����:0������ע,1������ע�����Բο�iWebOffice2009��EditType���ԣ���ϸ�ο�������Ƥ��
    webform.WebOffice.MaxFileSize = 4 * 1024;               //�����ĵ���С���ƣ�Ĭ����8M���������ó�4M��
    webform.WebOffice.Language="CH";                        //Language:������֧����ʾѡ��   CH ���� TW���� ENӢ��
    webform.WebOffice.ShowWindow = true;                  //������ʾ�򿪻򱣴��ĵ��Ľ��ȴ��ڣ�Ĭ�ϲ���ʾ

    webform.WebOffice.PenColor="#FF0000";                   //PenColor:Ĭ����ע��ɫ
    webform.WebOffice.PenWidth="1";                         //PenWidth:Ĭ����ע�ʿ�
    webform.WebOffice.Print="1";                            //Print:Ĭ���Ƿ���Դ�ӡ:1���Դ�ӡ��ע,0�����Դ�ӡ��ע
    
	webform.WebOffice.ShowToolBar="0";                      //ShowToolBar:�Ƿ���ʾ������:1��ʾ,0����ʾ
	
    webform.WebOffice.ShowMenu="1";                         //��������˵���ʾ
    //����Ϊ�Զ���˵���
    webform.WebOffice.AppendMenu("1","�򿪱����ļ�(&L)");
    webform.WebOffice.AppendMenu("2","���汾���ļ�(&S)");
    webform.WebOffice.AppendMenu("3","����Զ���ļ�(&U)");
    webform.WebOffice.AppendMenu("4","-");
    webform.WebOffice.AppendMenu("5","ǩ��ӡ��(&Q)");
    webform.WebOffice.AppendMenu("6","��֤ǩ��(&Y)");
    webform.WebOffice.AppendMenu("7","-");
    webform.WebOffice.AppendMenu("8","����汾(&B)");
    webform.WebOffice.AppendMenu("9","�򿪰汾(&D)");
    webform.WebOffice.AppendMenu("10","-");
    webform.WebOffice.AppendMenu("11","���沢�˳�(&E)");
    webform.WebOffice.AppendMenu("12","-");
    webform.WebOffice.AppendMenu("13","��ӡ�ĵ�(&P)"); 
    //����Ϊ�Զ���˵���
    webform.WebOffice.DisableMenu("��(&M);ѡ��(&O)...");    //��ֹĳ����Щ���˵���
    WebSetRibbonUIXML();                                  //����OFFICE2007��ѡ���ʾ		
	
	
	webform.WebOffice.AllowEmpty = true;

    
	webform.WebOffice.FolderEncrypt=false;                                //����������ʱĿ¼�µ��ļ�
	
	WebOffice.Style.ShowMenuBar = true;
	WebOffice.Style.ShowTitleBar = true;
	
	webform.WebOffice.WebOpen();                            //�򿪸��ĵ�    ����OfficeServer  �����ĵ�OPTION="LOADFILE"    ����ģ��OPTION="LOADTEMPLATE"     <�ο������ĵ�>
    StatusMsg(webform.WebOffice.Status);                    //״̬��Ϣ
  }catch(e){
    webform.WebOffice.Alert(e.description);                                   //��ʾ��������Ϣ
  }
}

	// ���ÿؼ�Ƥ��	���ù���������ʵ�֣�
	function WebSetSkin(titleBarColor/* �ؼ���������ɫ */,
			menuBarStartColor/* �Զ���˵���ʼ��ɫ */,
			menuBarButtonStartColor/* �Զ��幤������ť��ʼ��ɫ */,
			menuBarButtonEndColor/* �Զ��幤������ť������ɫ */,
			menuBarButtonFrameColor/* �Զ��幤������ť�߿���ɫ */,
			CustomToolbarStartColor/* �Զ��幤������ʼ��ɫ */, TitleBarTextColor/* �ؼ��������ı���ɫ */) {
		//this.Status = '';
		var style = WebOffice.Style;
		try {
			style.TitleBarColor = titleBarColor;
			if ((TitleBarTextColor == undefined) || (TitleBarTextColor == '')) // ����Ĭ�ϱ���������ɫ
			{
				style.TitleBarTextColor = 0x000000; // ��ɫ
			} else {
				style.TitleBarTextColor = TitleBarTextColor;
			}
			style.MenuBarStartColor = menuBarStartColor;
			style.MenuBarEndColor = 0xFFFFFF;
			style.MenuBarTextColor = 0x000000;
			style.MenuBarHighlightTextColor = 0x000000;
			style.MenuBarButtonStartColor = menuBarButtonStartColor;
			style.MenuBarButtonEndColor = menuBarButtonEndColor;
			style.MenuBarButtonFrameColor = menuBarButtonFrameColor;
			style.CustomToolbarStartColor = CustomToolbarStartColor;
			style.CustomToolbarEndColor = CustomToolbarStartColor;
			style.Invalidate();
			return true;
		} catch (e) {
			webform.WebOffice.Alert('Ƥ�����ô��󣬴�����ϢΪ��' + e.description);
			return false;
		}
	}

//���ã��˳�iWebOffice
function UnLoad(){
  try{
    if (!webform.WebOffice.WebClose()){
		
      StatusMsg(webform.WebOffice.Status);
    }else{
      StatusMsg("�ر��ĵ�...");
    }
  }catch(e){
    webform.WebOffice.Alert(e.description);
  }
}

//���ã����ĵ�
function LoadDocument(){
  StatusMsg("���ڴ��ĵ�...");
  if (!webform.WebOffice.WebOpen()){  	//�򿪸��ĵ�    ����OfficeServer��OPTION="LOADFILE"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
	 //webform.WebOffice.Alert(webform.WebOffice.Status);
	
  }
}

//���ã������ĵ�
function SaveDocument(){
  //webform.WebOffice.WebSetMsgByName("MyDefine1","�Զ������ֵ1");  //���ñ���MyDefine1="�Զ������ֵ1"�������������ö��  ��WebSave()ʱ��һ���ύ��OfficeServer��
   //webform.WebOffice.Alert(webform.WebOffice.Modify);
  //webform.WebOffice.Alert(webform.WebOffice.WebSave());
 //document.getElementById("FileType").value = webform.WebOffice.FileType; //���ش��ĵ���ʽdocx����������ĵ�����Ϊdocx��ʽ
  //webform.WebOffice.Alert(webform.WebOffice.FileType);
  
  if (!webform.WebOffice.WebSave()){    //����OfficeServer��OPTION="SAVEFILE"  ע��WebSave()�Ǳ��渴�ϸ�ʽ�ļ�������OFFICE���ݺ���д��ע�ĵ�����ֻ�����OFFICE�ĵ���ʽ����ô����WebSave(true)
     StatusMsg(webform.WebOffice.Status);
 //webform.WebOffice.Alert(webform.WebOffice.Status);
     return false;
  }else{
     StatusMsg(webform.WebOffice.Status);
	 //webform.WebOffice.Alert(webform.WebOffice.Status);
     return true;
  }
}


//���ã���ʾ�����غۼ�[���غۼ�ʱ�޸��ĵ�û�кۼ�����]  true��ʾ���غۼ�  false��ʾ��ʾ�ۼ�
function ShowRevision(mValue){
  if (mValue){
     webform.WebOffice.WebShow(true);
     StatusMsg("��ʾ�ۼ�...");
  }else{
     webform.WebOffice.WebShow(false);
     StatusMsg("���غۼ�...");
  }
}


//���ã���ʾ�����غۼ�[���غۼ�ʱ�޸��ĵ��кۼ�����]  true��ʾ���غۼ�  false��ʾ��ʾ�ۼ�
function ShowRevision2(mValue){
  if (mValue){
     webform.WebOffice.WebObject.ShowRevisions=true;   //��ʾ�ۼ�
  }else{
     webform.WebOffice.WebObject.ShowRevisions=false;  //���غۼ�
  }
}


//���ã���ȡ�ۼ�
function WebGetRevisions(){
  var Rev = webform.WebOffice.WebObject.Revisions;		//��ȡ�ۼ�����
  var Text="";

  for (i = 1;i <= Rev.Count;i++){
    Text=Text +"��"+ Rev.Item(i).Author+"��";
    if (Rev.Item(i).Type=="1"){
      Text=Text + '���в��룺'+Rev.Item(i).Range.Text+"\r\n";
    }else if (Rev.Item(i).Type=="2"){
      Text=Text + '����ɾ����'+Rev.Item(i).Range.Text+"\r\n";
    }
	else {
      Text=Text + '���������������������ݣ���'+Rev.Item(i).Range.Text+ '������������'+Rev.Item(i).FormatDescription+"����\r\n";
    }
  }
  webform.WebOffice.Alert("�ۼ����ݣ�\r\n\r\n"+Text);
}

//���ã�ˢ���ĵ�
function WebReFresh(){
  webform.WebOffice.WebReFresh();
  StatusMsg("�ĵ���ˢ��...");
}


//���ã��򿪰汾
function WebOpenVersion(){
  webform.WebOffice.WebOpenVersion();  	//����OfficeServer  �г��汾OPTION="LISTVERSION"     �����汾OPTION="LOADVERSION"   <�ο������ĵ�>
  StatusMsg(webform.WebOffice.Status);
}

//���ã�����汾
function WebSaveVersion(){
  webform.WebOffice.WebSaveVersion();  	//����OfficeServer��OPTION="SAVEVERSION"
  StatusMsg(webform.WebOffice.Status);

}

//���ã����浱ǰ�汾
function WebSaveVersionByFileID(){
  var mText=window.prompt("������汾˵��:","�汾��:V");
  if (mText==null){
     mText="���޸İ汾.";
  }
  webform.WebOffice.WebSaveVersionByFileID(mText);  	//����OfficeServer��OPTION="SAVEVERSION"  ͬʱ��FileIDֵ   <�ο������ĵ�>
  StatusMsg(webform.WebOffice.Status);
}


//���ã����ģ��
function LoadBookmarks(){
  StatusMsg("�������ģ��...");
  webform.WebOffice.WebSetMsgByName("COMMAND", "Hello World!!");
  
  if (!webform.WebOffice.WebLoadBookmarks()){  	//����OfficeServer��OPTION="LOADBOOKMARKS"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//���ã���ǩ����
function WebOpenBookMarks(){
  try{
    webform.WebOffice.WebOpenBookmarks();  	//����OfficeServer��OPTION="LISTBOOKMARKS"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//�����ĵ�����ǩ�����ݿ���
function WebSaveBookMarks(){
  try{
	  webform.WebOffice.WebSetMsgByName("COMMAND", "22111ads");
	webform.WebOffice.WebSaveBookMarks();  	            //����OfficeServer��OPTION="SAVEBOOKMARKS"
    webform.WebOffice.Alert(webform.WebOffice.Status);
	StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
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
  }catch(e){webform.WebOffice.Alert(e.description);}
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
   }catch(e){webform.WebOffice.Alert(e.description);}
}

//���ã�����ͼƬ
function WebOpenPicture(){
  try{
    webform.WebOffice.WebOpenPicture();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//���ã�ǩ��ӡ��
function WebOpenSignature(){
  webform.WebOffice.Alert("�����Ҫ����ȫǩ��,������ý��iSignature����ǩ���������ǩ��:\r\n���ص�ַhttp://www.goldgrid.cn/iSignature/Download.asp\r\n\r\n�������֧���ĵ������Ա�����CA֤�������ǩ��������,\r\n��ͨ����<���ҹ������͹��ұ��ܾ�>˫����֤�İ�ȫ����ǩ�²�Ʒ!");
  try{
    webform.WebOffice.WebOpenSignature();  	//����OfficeServer�� Aǩ���б�OPTION="LOADMARKLIST"    Bǩ�µ���OPTION="LOADMARKIMAGE"    Cȷ��ǩ��OPTION="SAVESIGNATURE"    <�ο������ĵ�>
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//���ã���֤ӡ��A
function WebShowSignature(){
  try{
    webform.WebOffice.WebShowSignature();  	//����OfficeServer��OPTION="LOADSIGNATURE"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//���ã���֤ӡ��B
function WebCheckSignature(){
  try{
    var i=webform.WebOffice.WebCheckSignature();  	//����OfficeServer��OPTION="LOADSIGNATURE"
    webform.WebOffice.Alert("�������"+i+"\r\n ע��: (=-1 �зǷ�ӡ��) (=0 û���κ�ӡ��) (>=1 �ж���Ϸ�ӡ��)");
    StatusMsg(i);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//���ã���Ϊ�����ļ�
function WebSaveLocal(){
  try{
	 //webform.WebOffice.FileName="123����.doc"; 
	 //webform.WebOffice.Alert(webform.WebOffice.FileName);
    webform.WebOffice.WebSaveLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//���ã��򿪱����ļ�
function WebOpenLocal(){
  try{
	//WebOffice.Style.ShowOpenProgress = true; //���ô��ĵ��Ƿ���ʾ������
	
	 
    webform.WebOffice.WebOpenLocal();
	//SetBookmarks("test", "������ǩ����_helloworld");
	document.getElementById("FileType").value = webform.WebOffice.FileType; //���ش��ĵ���ʽdocx����������ĵ�����Ϊdocx��ʽ
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//���ã�����ΪHTML�ĵ�
function WebSaveAsHtml(){
  try{
    if (webform.WebOffice.WebSaveAsHtml())  	//����OfficeServer��OPTION="SAVEASHTML"
    {
      webform.HTMLPath.value="HTML/<%=mRecordID%>.htm";
      window.open("<%=mHttpUrl%>"+ webform.HTMLPath.value);
    }
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}


//���ã�����Ϊ�ĵ�ͼƬ
function WebSaveAsPage(){
  try{
	  var ret = webform.WebOffice.WebSaveImage();
	  webform.WebOffice.Alert(ret);
    if (ret)  	//����OfficeServer��OPTION="SAVEIMAGE"
    {
	  webform.HTMLPath.value="HTMLIMAGE/<%=mRecordID%>.htm"
      window.open("<%=mHttpUrl%>"+ webform.HTMLPath.value);
    }
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}


//���ã��رջ���ʾ���� ����1��ʾ����������  ����2Ϊfalseʱ����ʾ�ر�  �����ƾ��ɲ���VBA������
//����2Ϊtrueʱ����ʾ��ʾ
function WebToolsVisible(ToolName,Visible){
  try{
    webform.WebOffice.WebToolsVisible(ToolName,Visible);
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}


//���ã���ֹ�����ù��� ����1��ʾ����������  ����2��ʾ�������ť�ı��  �����ƺͱ�ž��ɲ���VBA������
//����3Ϊfalseʱ����ʾ��ֹ  ����3Ϊtrueʱ����ʾ����
function WebToolsEnable(ToolName,ToolIndex,Enable){
  try{
    webform.WebOffice.WebToolsEnable(ToolName,ToolIndex,Enable);
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//���ã���������  ����1Ϊtrue��ʾ�����ĵ�  false��ʾ�������
function WebProtect(value){
  try{
    var res = webform.WebOffice.WebSetProtect(value,"");  //""��ʾ����Ϊ��
	//webform.WebOffice.Alert(res);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//���ã��������ֹ��������  ����1Ϊtrue��ʾ������  false��ʾ��ֹ����
function WebEnableCopy(value){
  try{
    webform.WebOffice.CopyType=value;
  }catch(e){webform.WebOffice.Alert(e.description);}
}


//���ã�����Զ�̷�����ͼƬ
function WebInsertImage(){
  try{
    webform.WebOffice.WebInsertImage('Image','GoldgridLogo.jpg',true,4);   //����OfficeServer��OPTION="INSERTIMAGE"  ����1��ʾ��ǩ����  ����2��ʾͼƬ�ļ���  ����3Ϊtrue͸��  false��ʾ��͸��  ����4Ϊ4��ʾ���������Ϸ�  5��ʾ���������·�
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}


//���ã����ط������ļ�������
function WebGetFile(){
  if (webform.WebOffice.WebGetFile("c:\\WebGetFile.doc","DownLoad.doc")){   //����OfficeServer��OPTION="GETFILE"  ����1��ʾ����·��  ����2��ʾ�������ļ�����
    StatusMsg(webform.WebOffice.Status);
  }else{
    StatusMsg(webform.WebOffice.Status);
  }
  webform.WebOffice.Alert(webform.WebOffice.Status+"\r\n"+"�ļ�����c:\\WebGetFile.doc");
}


//���ã��ϴ������ļ���������
function WebPutFile(){
  var mLocalFile=webform.WebOffice.WebOpenLocalDialog();
  if (mLocalFile!=""){
    webform.WebOffice.Alert(mLocalFile);
    if (webform.WebOffice.WebPutFile(mLocalFile,"Test.doc")){   //����OfficeServer��OPTION="PUTFILE"  ����1��ʾ����·���������κθ�ʽ�ļ�  ����2��ʾ�������ļ�����
      StatusMsg(webform.WebOffice.Status);
    }else{
      StatusMsg(webform.WebOffice.Status);
    }
    webform.WebOffice.Alert(webform.WebOffice.Status);
  }
}


//���ã���Զ���ļ�
function WebDownLoadFile(){
  mResult=webform.WebOffice.WebDownLoadFile("http://192.168.0.81:8080/iWebOffice2009/Document/Test.doc","c:\\abc.doc");
  if (mResult){
    webform.WebOffice.WebOpenLocalFile("c:\\abc.doc");
    webform.WebOffice.Alert("�ɹ�");
  }else{
    webform.WebOffice.Alert("ʧ��");
  }
}

//���ã�ȡ�÷�������ʱ�䣬���ñ���ʱ��  [V6.0.1.5����֧��]
function WebDateTime(){
  mResult=webform.WebOffice.WebDateTime(true);   //����OfficeServer��OPTION="DATETIME"   true��ʾ���ز����ñ���ʱ��Ϊ������ʱ�䣻false��ʾ�����ط�����ʱ��
  webform.WebOffice.Alert("��ʾ���Ѿ����ñ���ʱ��Ϊ "+mResult);    //�ù�����Ҫ�����ںۼ�����ʱ��ȡ������ʱ��
}


//���ã�������ɼ����
function WebSetWordTable(){
  var mText="",mName="",iColumns,iCells,iTable;
  //����COMMANDΪWORDTABLE
  webform.WebOffice.WebSetMsgByName("COMMAND","WORDTABLE");   //���ñ���COMMAND="WORDTABLE"����WebSendMessage()ʱ��һ���ύ��OfficeServer��
  //���͵���������
  //���û�д���
  if (webform.WebOffice.WebSendMessage()){                //����OfficeServer��OPTION="SENDMESSAGE"
	iColumns = webform.WebOffice.WebGetMsgByName("COLUMNS");  //ȡ����
	iCells = webform.WebOffice.WebGetMsgByName("CELLS");      //ȡ����
	iTable=webform.WebOffice.WebObject.Tables.Add(webform.WebOffice.WebObject.Application.Selection.Range,iCells,iColumns);   //���ɱ��
	for (var i=1; i<=iColumns; i++)
	{
   	  for (var j=1; j<=iCells; j++)
	  {
		mName=i.toString()+j.toString();
		mText=webform.WebOffice.WebGetMsgByName(mName);	 //ȡ��OfficeServer�еı������
		iTable.Columns(i).Cells(j).Range.Text=mText;   	//��䵥Ԫֵ
	   }
	}
   }
   StatusMsg(webform.WebOffice.Status);
}


//���ã���ȡ�ĵ�Txt����
function WebGetWordContent(){
  try{
    webform.WebOffice.Alert(webform.WebOffice.WebObject.Content.Text);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//���ã�дWord����
function WebSetWordContent(){
  var mText=window.prompt("����������:","��������");
  if (mText==null){
     return (false);
  }
  else
  {
     //����Ϊ��ʾѡ�е��ı�
     //webform.WebOffice.Alert(webform.WebOffice.WebObject.Application.Selection.Range.Text);
     //����Ϊ�ڵ�ǰ���������ı�
     webform.WebOffice.WebObject.Application.Selection.Range.Text= mText+"\n";
     //����Ϊ�ڵ�һ�κ�����ı�
     //webform.WebOffice.WebObject.Application.ActiveDocument.Range(1).Text=(mText);
  }
}


//���ã���ӡ�ڰ��ĵ�
function WebWordPrintBlackAndWhile(){
   var i,n;

   //ͼƬ��ڰ�
   i=0;
   n=webform.WebOffice.WebObject.Shapes.Count;
   for (var i=1; i<=n; i++)
   {
      webform.WebOffice.WebObject.Shapes.Item(i).PictureFormat.ColorType=3;
   }
   i=0;
   n=webform.WebOffice.WebObject.InlineShapes.Count;
   for (var i=1; i<=n; i++)
   {
      webform.WebOffice.WebObject.InlineShapes.Item(i).PictureFormat.ColorType=3;
   }

   //���ֱ�ڰ�
   webform.WebOffice.WebObject.Application.Selection.WholeStory();
   webform.WebOffice.WebObject.Application.Selection.Range.Font.Color = 0;
}

//���ã���Excel���
function WebGetExcelContent(){
    webform.WebOffice.WebObject.Application.Sheets(1).Select;
    webform.WebOffice.WebObject.Application.Range("C5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "126";
    webform.WebOffice.WebObject.Application.Range("C6").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "446";
    webform.WebOffice.WebObject.Application.Range("C7").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "556";
    webform.WebOffice.WebObject.Application.Range("C5:C8").Select;
    webform.WebOffice.WebObject.Application.Range("C8").Activate;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "=SUM(R[-3]C:R[-1]C)";
    webform.WebOffice.WebObject.Application.Range("D8").Select;
    webform.WebOffice.Alert(webform.WebOffice.WebObject.Application.Range("C8").Text);
}


//���ã�����������Ԫ
function WebSheetsLock(){
    webform.WebOffice.WebObject.Application.Sheets(1).Select;

    webform.WebOffice.WebObject.Application.Range("A1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "��Ʒ";

    webform.WebOffice.WebObject.Application.Range("B1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "�۸�";
    webform.WebOffice.WebObject.Application.Range("C1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "��ϸ˵��";
    webform.WebOffice.WebObject.Application.Range("D1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "���";
    webform.WebOffice.WebObject.Application.Range("A2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "��ǩ";
    webform.WebOffice.WebObject.Application.Range("A3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "ë��";
    webform.WebOffice.WebObject.Application.Range("A4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "�ֱ�";
    webform.WebOffice.WebObject.Application.Range("A5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "����";

    webform.WebOffice.WebObject.Application.Range("B2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "0.5";
    webform.WebOffice.WebObject.Application.Range("C2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "ӣ��";
    webform.WebOffice.WebObject.Application.Range("D2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "300";

    webform.WebOffice.WebObject.Application.Range("B3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "2";
    webform.WebOffice.WebObject.Application.Range("C3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "�Ǻ�";
    webform.WebOffice.WebObject.Application.Range("D3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "50";

    webform.WebOffice.WebObject.Application.Range("B4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "3";
    webform.WebOffice.WebObject.Application.Range("C4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "��ɫ";
    webform.WebOffice.WebObject.Application.Range("D4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "90";

    webform.WebOffice.WebObject.Application.Range("B5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "1";
    webform.WebOffice.WebObject.Application.Range("C5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "20cm";
    webform.WebOffice.WebObject.Application.Range("D5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "40";


    //����������
    webform.WebOffice.WebObject.Application.Range("B2:D5").Select;
    webform.WebOffice.WebObject.Application.Selection.Locked = false;
    webform.WebOffice.WebObject.Application.Selection.FormulaHidden = false;
    webform.WebOffice.WebObject.Application.ActiveSheet.Protect(true,true,true);

    webform.WebOffice.Alert("�Ѿ�����������ֻ��B2-D5��Ԫ������޸ġ�");
}

//���ã�VBA�׺�
function WebInsertVBA(){

	//����
	var object=webform.WebOffice.WebObject;
	var myl=object.Shapes.AddLine(100,60,305,60)
	myl.Line.ForeColor=255;
	myl.Line.Weight=2;
	var myl1=object.Shapes.AddLine(326,60,520,60)
	myl1.Line.ForeColor=255;
	myl1.Line.Weight=2;

	//object.Shapes.AddLine(200,200,450,200).Line.ForeColor=6;
   	var myRange=webform.WebOffice.WebObject.Range(0,0);
	myRange.Select();

	var mtext="��";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
   	var myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
   	myRange.ParagraphFormat.LineSpacingRule =1.5;
   	myRange.font.ColorIndex=6;
   	myRange.ParagraphFormat.Alignment=1;
   	myRange=webform.WebOffice.WebObject.Range(0,0);
	myRange.Select();
	mtext="���[��������]��������";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
	myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	myRange.ParagraphFormat.LineSpacingRule =1.5;
	myRange.ParagraphFormat.Alignment=1;
	myRange.font.ColorIndex=1;

	mtext="�����������ļ�";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
	myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	myRange.ParagraphFormat.LineSpacingRule =1.5;

	//myRange.Select();
	myRange.Font.ColorIndex=6;
	myRange.Font.Name="����_GB2312";
	myRange.font.Bold=true;
	myRange.Font.Size=50;
	myRange.ParagraphFormat.Alignment=1;

	//myRange=myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	webform.WebOffice.WebObject.PageSetup.LeftMargin=70;
	webform.WebOffice.WebObject.PageSetup.RightMargin=70;
	webform.WebOffice.WebObject.PageSetup.TopMargin=70;
	webform.WebOffice.WebObject.PageSetup.BottomMargin=70;
}

//���ã�ģ���׺칦��
function WebUseTemplate(){
  var mDialogUrl = "Template/TemplateForm.htm";
  var mObject = new Object();
  mObject.Template = "";
  window.showModalDialog(mDialogUrl, mObject, "dialogHeight:200px; dialogWidth:360px;center:yes;scroll:no;status:no;");

  //�ж��û��Ƿ�ѡ��ģ��
  if (mObject.Template==""){
    StatusMsg("ȡ������ģ��");
    return false;
  }else{
    if(WebAcceptAllRevisions()==false){                         //������ĺۼ���Ŀ����Ϊ�˱���ۼ�״̬�³��������쳣���⡣
      StatusMsg("������ĺۼ�ʧ�ܣ��׺���ֹ");
      return false;      
    }
    SaveDocument();                                             //���浱ǰ�༭���ĵ�
    webform.WebOffice.WebSetMsgByName("COMMAND","INSERTFILE");  //���ñ���COMMAND="INSERTFILE"����WebLoadTemplate()ʱ��һ���ύ��OfficeServer��     <�ο������ĵ�>
    webform.WebOffice.Template=mObject.Template;                //ȫ�ֱ���Template��ֵ����ʾ����ȡ������Ŀ¼��ģ�壬���ȡ���ݿ���ģ�壬TemplateֵΪ���ݿ��е�ģ���ţ����Ͼ���벻��Ҫ����Template="1050560363767"��ģ������Ϊ��Word����ģ�塱��ע��ģ������Ҫ��ǩContent�����ִ�Сд�����������޸�
    webform.WebOffice.EditType="1";                             //����Ϊ�������ۼ���״̬
    if (webform.WebOffice.WebLoadTemplate()){                   //����OfficeServer��OPTION="LOADTEMPLATE"
      //SetBookmarks("Title","�����м���з���������֪ͨ_HelloWorld");     //���ģ������������Ϣ������⣬����ʣ��ĺţ����ͻ��ص�
      if (webform.WebOffice.WebInsertFile()){                   //��乫������   ����OfficeServer��OPTION="INSERTFILE"
        StatusMsg("ģ���׺�ɹ�");
        return true;
      }else{
        StatusMsg(webform.WebOffice.Status);
        return false;
      }
    }else{
      StatusMsg(webform.WebOffice.Status);
      return false;
    }
  }
}

//���ã����涨���ļ�
function WebUpdateFile(){
  if (webform.WebOffice.WebUpdateFile()){                //����OfficeServer��OPTION="UPDATEFILE"������WebSave()��WebSaveVersion()����
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}



//��ӡ��������
function WebCopysCtrlPrint(){
  var mCopies,objPrint;
  objPrint = webform.WebOffice.WebObject.Application.Dialogs(88);     //��ӡ���öԻ���
  if (objPrint.Display==-1){
    mCopies=objPrint.NumCopies;    //ȡ����Ҫ��ӡ����
    webform.WebOffice.WebSetMsgByName("COMMAND","COPIES");
    webform.WebOffice.WebSetMsgByName("OFFICEPRINTS",mCopies.toString());   //���ñ���OFFICEPRINTS��ֵ����WebSendMessage()ʱ��һ���ύ��OfficeServer��
    webform.WebOffice.WebSendMessage();                               //����OfficeServer��OPTION="SENDMESSAGE"
    if (webform.WebOffice.Status=="1") {
      webform.WebOffice.Alert("���������ӡ��ע����ʵ���������ĵ���ӡ����2��");
      objPrint.Execute;
    }else{
      webform.WebOffice.Alert("�ѳ�������Ĵ�ӡ����");
      return false;
    }
  }
}


//���ã�����Text
function WebInportText(){
    var mText;
    webform.WebOffice.WebSetMsgByName("COMMAND","INPORTTEXT");  //���ñ���COMMAND="INPORTTEXT"����WebSendMessage()ʱ��һ���ύ��OfficeServer��
    if (webform.WebOffice.WebSendMessage()){                    //����OfficeServer��OPTION="SENDMESSAGE"
      mText=webform.WebOffice.WebGetMsgByName("CONTENT");       //ȡ��OfficeServer���ݵı���CONTENTֵ
      webform.WebOffice.WebObject.Application.Selection.Range.Text=mText;
      webform.WebOffice.Alert("�����ı��ɹ�");
    }
    StatusMsg(webform.WebOffice.Status);
}


//���ã�����Text
function WebExportText(){
    var mText=webform.WebOffice.WebObject.Content.Text;
    webform.WebOffice.WebSetMsgByName("COMMAND","EXPORTTEXT");  //���ñ���COMMAND="EXPORTTEXT"����WebSendMessage()ʱ��һ���ύ��OfficeServer��
    webform.WebOffice.WebSetMsgByName("CONTENT",mText);         //���ñ���CONTENT="mText"����WebSendMessage()ʱ��һ���ύ��OfficeServer�У�������ʵ��ȫ�ļ������ܣ���WORD��TEXT���ݽ��м���
    if (webform.WebOffice.WebSendMessage()){                    //����OfficeServer��OPTION="SENDMESSAGE"
      webform.WebOffice.Alert("�����ı��ɹ�");
    }
    StatusMsg(webform.WebOffice.Status);
}


//���ã���ȡ�ĵ�ҳ��
function WebDocumentPageCount(){
  var intPageTotal = webform.WebOffice.WebObject.Application.ActiveDocument.BuiltInDocumentProperties(14);
  webform.WebOffice.Alert("�ĵ�ҳ������"+intPageTotal);
}

//���ã���ȡ�ĵ��ֽڴ�С
function WebLocalFileSize(){
  var intPageTotal = webform.WebOffice.WebLocalFileSize();
  webform.WebOffice.Alert("�ĵ��ֽڴ�С��"+intPageTotal);
}

//���ã�ǩ�������ļ�����
function WebSignatureAtReadonly(){
  webform.WebOffice.WebSetProtect(false,"");                  //����ĵ�����
  webform.WebOffice.WebSetRevision(false,false,false,false);  //�����ĵ��ۼ�������״̬  ����1:����ʾ�ۼ�  ����2:�������ۼ�  ����3:����ӡʱ�кۼ�  ����4:���Ժۼ�������
  try{
    webform.WebOffice.WebOpenSignature();                     //����OfficeServer�� Aǩ���б�OPTION="LOADMARKLIST"    Bǩ�µ���OPTION="LOADMARKIMAGE"    Cȷ��ǩ��OPTION="SAVESIGNATURE"    <�ο������ĵ�>    �ĵ���Ҫ�����ǩManager�����������޸ı�ǩ����
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
  webform.WebOffice.WebSetProtect(true,"");                   //�����ĵ�
}

//���ã��ͻ��˺ͷ���������Ϣ��Ϣ����
function WebSendInformation(){
  var info = window.prompt("������Ҫ��������������ҳ���ϵ�����:","��������");
  if (info==null){return false}

  webform.WebOffice.WebSetMsgByName("COMMAND","SELFINFO");		//���ñ���COMMAND="SELFINFO"�������ڷ����������жϣ��Խ��봦���Զ���������ݵĴ��롣
  webform.WebOffice.WebSetMsgByName("TESTINFO",info);			//�Զ����һ������"TESTINFO"����info��������Ϣ���õ���Ϣ���У��Ա㴫����̨��
  if (webform.WebOffice.WebSendMessage()){						//���̨����Ϣ��������OfficeServer��OPTION="SENDMESSAGE"��
    info = webform.WebOffice.WebGetMsgByName("RETURNINFO");		//��������ɹ������ܷ������˷��ص���Ϣ��
	webform.WebOffice.Alert(info);
  }
  else{
    StatusMsg(webform.WebOffice.Status);
  }
}

//�жϱ༭��
function GetEditer(){
  if(webform.WebOffice.WebApplication(".doc")){     //WORD
    webform.WebOffice.Alert("����WORD�༭��");
  }
  if(webform.WebOffice.WebApplication(".xls")){     //EXCEL
    webform.WebOffice.Alert("����EXCEL�༭��");
  }
  if(webform.WebOffice.WebApplication(".wps")){     //��ɽWPS
    webform.WebOffice.Alert("����WPS�༭��");
  }
  if(webform.WebOffice.WebApplication(".et")){      //��ɽ���
    webform.WebOffice.Alert("����ET�༭��");
  }
  //������������".ppt"��".vso"......
}

//����OFFICE2007��ѡ���ʾ
function WebSetRibbonUIXML(){
	//webform.WebOffice.Alert("1111");
  webform.WebOffice.RibbonUIXML = '' +
  '<customUI xmlns="http://schemas.microsoft.com/office/2009/07/customui">' +
  '  <ribbon startFromScratch="false">'+                    //����ʾ����ѡ����� false��ʾѡ���true����ʾѡ�
  '    <tabs>'+
  '      <tab idMso="TabReviewWord" visible="false">' +     //�ر���ͼ������
  '      </tab>'+
  '      <tab idMso="TabInsert" visible="false">' +         //�رղ��빤����
  '      </tab>'+
  '      <tab idMso="TabHome" visible="false">' +           //�رտ�ʼ������
  '      </tab>'+
  '    </tabs>' +
  '  </ribbon>' +
  '</customUI>';

/*
    ��õ�����ѡ�����
    ѡ�����      idMso��Excel��      idMso��Word��       idMso��Access��
    ��ʼ            TabHome             TabHome             TabHomeAccess
    ����            TabInsert           TabInsert           ��none��
    ҳ�沼��        TabPageLayoutExcel  TabPageLayoutWord   ��none��
    ��ʽ            TabFormulas         ��none��            ��none��
    ����            TabData             ��none��            ��none��
    ��ͼ            TabReview           TabReviewWord       ��none��
    ����            ��none��            ��none��            TabCreate
    �ⲿ����        ��none��            ��none��            TabExternalData
    ���ݿ⹤��      ��none��            ��none��            TabDatabaseTools
*/

/*
    iWebOffice�ؼ���RibbonUIXML���ԣ��ǻ���OFFICE2007��RibbonX��Ӧ�á�����RibbonX��������ϣ���Ҫ�Լ����в�ѯ��
*/
//webform.WebOffice.Alert("22222");
}

//��ȡע���ʮ���ƣ�
function WebReadRegString(){
  try{
    webform.WebOffice.WebOpenKey('HKEY_CURRENT_USER', 'Software\\Microsoft\\Office\\12.0\\Common\\Toolbars');    //��ע���
    var Content = webform.WebOffice.WebReadString('AddNewString');                                          //��ȡע���
    webform.WebOffice.WebCloseKey();                                                                        //�ر�ע���
    webform.WebOffice.Alert(Content);
  }
  catch(e){
    webform.WebOffice.Alert(e.description);
    webform.WebOffice.WebCloseKey();
  } 
} 

//д��ע���ʮ���ƣ�
function WebWriteRegString(){
  try{
    webform.WebOffice.WebOpenKey('HKEY_CURRENT_USER', 'Software\\Microsoft\\Office\\12.0\\Common\\Toolbars');    //��ע���
    var result = webform.WebOffice.WebWriteString('AddNewString','1234');                                   //д��ע���
    webform.WebOffice.WebCloseKey();                                                                        //�ر�ע���
    if (result) {
      webform.WebOffice.Alert("д��ע���ɹ���");
    }else{
      webform.WebOffice.Alert("д��ע���ʧ�ܣ�");
    }
  }
  catch(e){
    webform.WebOffice.Alert("д��ע���ʧ�ܣ�ԭ��"+e.description);
    webform.WebOffice.WebCloseKey();
  } 
} 

//��ȡע���ʮ�����ƣ�
function WebReadRegInteger(){
  try{
    webform.WebOffice.WebOpenKey('HKEY_CURRENT_USER', 'Software\\Microsoft\\Office\\12.0\\Common\\Toolbars');    //��ע���
    var Content = webform.WebOffice.WebReadInteger('AddNewInteger');                                        //��ȡע���
    webform.WebOffice.WebCloseKey();                                                                        //�ر�ע���
    webform.WebOffice.Alert(Content);
  }
  catch(e){
    webform.WebOffice.Alert(e.description);
    webform.WebOffice.WebCloseKey();
  } 
}

//д��ע���ʮ�����ƣ�
function WebWriteRegInteger(){
  try{
    webform.WebOffice.WebOpenKey('HKEY_CURRENT_USER', 'Software\\Microsoft\\Office\\12.0\\Common\\Toolbars');    //��ע���
    var result = webform.WebOffice.WebWriteInteger('AddNewInteger',5678);                                   //д��ע���
    webform.WebOffice.WebCloseKey();                                                                        //�ر�ע���
    if (result) {
      webform.WebOffice.Alert("д��ע���ɹ���");
    }else{
      webform.WebOffice.Alert("д��ע���ʧ�ܣ�");
    }
  }
  catch(e){
    webform.WebOffice.Alert(e.description);
    webform.WebOffice.WebCloseKey();
  } 
} 

//�����ĵ���ȫ���ۼ�
function WebAcceptAllRevisions(){
  webform.WebOffice.WebObject.Application.ActiveDocument.AcceptAllRevisions();
  var mCount = webform.WebOffice.WebObject.Application.ActiveDocument.Revisions.Count;
  if(mCount>0){
    return false;
  }else{
    return true;
  }
}

//�򿪵ķ������ϵ��ĵ����޸�
function WebOpenAndRepair(){
  webform.WebOffice.WebRepairMode = true;   //���޸�ģʽ
  webform.WebOffice.WebOpen();              //�ص��ղŴ򿪵ķ������ϵ��ĵ�
  StatusMsg(webform.WebOffice.Status);
  webform.WebOffice.WebRepairMode = false;  //�ر��޸�ģʽ
}

//�򿪱����ϵ��ĵ����޸�
function WebOpenLocalAndRepair(){
  webform.WebOffice.WebRepairMode = true;   //���޸�ģʽ
  webform.WebOffice.WebOpenLocal();         //�򿪱����ϵ��ĵ�
  StatusMsg(webform.WebOffice.Status);
  webform.WebOffice.WebRepairMode = false;  //�ر��޸�ģʽ
}

//����iWebOffice2015�ؼ����Ի�ȡ�ؼ��汾��
function Get2015Version(){
	//webform.WebOffice.Alert(WebOffice);
	webform.WebOffice.Alert(WebOffice.Version);
	//webform.WebOffice.Alert(webform.WebLocalFileSize);
}
//��ʾ�������Զ��幤����
function ShowCustomToolbar(){
	WebOffice.Style.ShowCustomToolbar = !WebOffice.Style.ShowCustomToolbar;
}

function OnReady(){
 //��ȡiWebOffice2015�ؼ�����WebOffice.FuncExtModule��iWebOffice2015�ؼ���չ�ӿڶ���
	WebOffice = document.getElementById('WebOffice2015');
	setTimeout(function(){Load();}, 500); //��Ҫ��һ����ʱ��iWebOffice2015���ܻ�ȡFuncExtModule��չ�ӿڶ���
}
//�˵�����Ŧ����¼�
function OnCommand(ID, Caption, bCancel)
{
	if (ID==1 || ID==101){  
    WebOpenLocal();     //�򿪱����ļ�
  }
  if (ID==2 || ID==102){  
    WebSaveLocal();     //���汾���ļ�
  }
  if (ID==3 || ID==103){
    SaveDocument();     //�������ĵ��������ϣ����˳���
  }
  if (ID==5 || ID==201){  
    WebOpenSignature(); //ǩ��ӡ��
  }
  if (ID==6 || ID==202){  
    WebShowSignature(); //��֤ǩ��
  }
  if (ID==8 || ID==301){  
    WebSaveVersion();   //����汾
  }
  if (ID==9 || ID==302){  
    WebOpenVersion();   //�򿪰汾
  }
  if (ID==11 || ID==104){
    SaveDocument();     //�������ĵ���������
    webform.submit();   //Ȼ���˳�
  }
  if (ID==13 || ID==501){  
    WebOpenPrint();     //��ӡ�ĵ�
  }
}

</script>
</head>
<body bgcolor="#ffffff"  onUnload="UnLoad()">  <!--�������˳�iWebOffice-->
  <form name="webform" method="post" action="DocumentSave.jsp" onSubmit="return SaveDocument();">  <!--����iWebOffice���ύ����Ϣ-->
    <input type="hidden" name="RecordID" value="<%=mRecordID%>">
    <input type="hidden" name="Template" value="<%=mTemplate%>">
    <input id="FileType" type="hidden" name="FileType" value="<%=mFileType%>">
    <input type="hidden" name="EditType" value="<%=mEditType%>">
    <input type="hidden" name="HTMLPath" value="<%=mHTMLPath%>">
    <table border=0 cellspacing='0' cellpadding='0' width=100% height=100% align=center class=TBStyle>
      <tr>
        <td height="24" align=center class="TDTitleStyle">������</td>
        <td class="TDStyle">&nbsp;<input type="text" name="Subject" value="<%=mSubject%>" class="IptStyle" onBlur="SetBookmarks('Caption',this.value);" style="WIDTH:75%" title="�˴���һ���Զ����ñ�ǩ�Ĺ��ܣ����롰���⡱���ݹ���ƿ����ĵ��С�Caption����ǩ�����ݻ��Զ��޸ġ�">&nbsp;|������������</td>
        <td width="400" rowspan="4" class="TDTitleStyle" align="center"><input type="submit"  value="�����ĵ�">&nbsp;<input type=button onClick="history.back()" value="�����б�"><br><br>ע�⣺ֻ�н��С������ĵ����������Ĳ�������Ч��</td>
      </tr>
      <tr>
        <td height="24" align=center class="TDTitleStyle">������</td>
        <td class="TDStyle">&nbsp;<input type=text name=Author value="<%=mAuthor%>" class="IptStyle"  style="WIDTH:75%">&nbsp;|������������</td>
      </tr>
      <tr>
        <td height="24" align=center class="TDTitleStyle">ʱ����</td>
        <td class="TDStyle">&nbsp;<input type=text name=FileDate value="<%=mFileDate%>" readonly class="IptStyleBlack" style="WIDTH:75%">&nbsp;|���༭ʱ��</td>
      </tr>
      <tr>
        <td height="24" align=center class="TDTitleStyle">״��̬</td>
        <td class="TDStyle">&nbsp;<input type=text name=StatusBar readonly class="IptStyleBlack" style="WIDTH:75%">&nbsp;|��״̬��Ϣ</td>
      </tr>
      <tr width="100" height="28">
        <td align="center" class="TDTitleMiddleStyle">
          <font color="#FF0000"><b>�������б��</b></font>
	    </td>
        <td  id = "OfficeDiv" height="100%" colspan="2" rowspan="12" align="right" valign="top" class="TDStyle" hegith="90%" style="height: 90%">
          <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
            <tr>
              <td height="98%" valign="top">
                <!--����iWebPicture��ע��汾�ţ�����������-->
			    <script src="iWebOffice2015.js"></script>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr width="100">
        <td align="center" valign=top class="TDTitleStyle" width="100" height="90%">
		  <input type=button class=SideButton value="����Ƥ��" onclick='WebSetSkin(0xfdd6e5, 0xfdd8e6, 0xfdd8e6, 0xfdd6e5, 0xfdd6e5, 0xfdd6e5, 0x000000)'>
          <input type=button class=SideButton value="�ĵ��˸�" onclick='webform.WebOffice.ShowType=0;'>
          <input type=button class=SideButton value="�½��ļ�" onclick='webform.WebOffice.CreateFile();'>
          <input type=button class=SideButton value="ȫ����ʾ" onclick='webform.WebOffice.FullSize();'>
          <input type=button class=SideButton value="�رչ�����" onClick="webform.WebOffice.ShowToolBar=0">
          <input type=button class=SideButton value="�򿪹�����" onClick="webform.WebOffice.ShowToolBar=1">
          <input type=button class=SideButton value="��ʾ�汾" onClick="webform.WebOffice.Alert('��ǰ�ؼ��汾Ϊ��'+webform.WebOffice.VersionEx()+webform.WebOffice.Version());">
		  <input type=button class=SideButton value="��ʾ�汾" onClick="Get2015Version()">
		  <input type=button class=SideButton value="��ʾ�����ع�����" onClick="ShowCustomToolbar()">
	    </td>
      </tr>
      <tr width="100">
        <td align="center" class="TDTitleMiddleStyle" height="28">
          <font color="#FF0000"><b>����ͨ���ܡ�</b></font>
	    </td>
      </tr>
      <tr width="100">
        <td align="center" valign=top class="TDTitleStyle" width="100">
          <input type=button class=SideButton value="��ʾ�ۼ�"   onClick="ShowRevision(true)">
          <input type=button class=SideButton value="���غۼ�" <%=mDisabled%> <%=mWord%> onClick="ShowRevision(false)">
          <input type=button class=SideButton value="��ȡ�ۼ�"  onClick="WebGetRevisions()">
          <input type=button class=SideButton value="����ۼ�" <%=mDisabled%> <%=mWord%> onClick="WebAcceptAllRevisions()">
          <input type=button class=SideButton value="�����ĵ�" <%=mDisabled%> onClick="WebProtect(true)">
          <input type=button class=SideButton value="�������" <%=mDisabled%> onClick="WebProtect(false)">
          <input type=button class=SideButton value="������" <%=mDisabled%> onClick="WebEnableCopy(true)">
          <input type=button class=SideButton value="��ֹ����" <%=mDisabled%> onClick="WebEnableCopy(false)">
          <input type=button class=SideButton value="ҳ������" <%=mDisabled%> <%=mWord%> onClick="WebOpenPageSetup()">
          <input type=button class=SideButton value="��ӡ�ĵ�" <%=mDisabled%> <%=mWord%> onClick="WebOpenPrint()">
          <input type=button class=SideButton value="����ͼƬ" <%=mDisabled%> <%=mWord%> onClick="WebOpenPicture()">
          <input type=button class=SideButton value="�ص��ĵ�" <%=mDisabled%> <%=mWord%> onClick="LoadDocument()">
          <input type=button class=SideButton value="ˢ���ĵ�" <%=mDisabled%> <%=mWord%> onClick="WebReFresh()">
          <input type=button class=SideButton value="�򿪱����ļ�" <%=mDisabled%> onClick="WebOpenLocal()">
          <input type=button class=SideButton value="��Ϊ�����ļ�" <%=mDisabled%> onClick="WebSaveLocal()">
          <input type=button class=SideButton value="�жϱ༭��" onClick="GetEditer()">
          <input type=button class=SideButton value="д��ע���" onClick="WebWriteRegString()">
          <input type=button class=SideButton value="��ȡע���" onClick="WebReadRegString()">
          <input type=button class=SideButton value="д��ע���16" onClick="WebWriteRegInteger()">
          <input type=button class=SideButton value="��ȡע���16" onClick="WebReadRegInteger()">
	    </td>
      </tr>
      <tr width="100">
        <td align="center" class="TDTitleMiddleStyle" height="28">
          <font color="#FF0000"><b>���������ܡ�</b></font>
	    </td>
      </tr>
      <tr width="100">
        <td align="center" valign=top class="TDTitleStyle" width="100">
          <input type=button class=SideButton value="ǩ��ӡ��" <%=mDisabled%> onClick="WebOpenSignature()">
          <input type=button class=SideButton value="ǩ�������ļ�" <%=mDisabled%>  onclick="WebSignatureAtReadonly();">
          <input type=button class=SideButton value="��֤ǩ��[A]" <%=mDisabled%>  onclick="WebShowSignature()">
          <input type=button class=SideButton value="��֤ǩ��[B]" <%=mDisabled%>  onclick="WebCheckSignature()">
          <input type=button class=SideButton value="ӡ�²�ɫ" onClick="webform.WebOffice.SignatureColor(true);">
          <input type=button class=SideButton value="ӡ�ºڰ�" onClick="webform.WebOffice.SignatureColor(false);">
          <input type=button class=SideButton value="�򿪱�ǩ" <%=mDisabled%>  <%=mWord%>  onclick="WebOpenBookMarks()">
		  <input type=button class=SideButton value="��ǩ����" <%=mDisabled%>  <%=mWord%>  onclick="WebSaveBookMarks()">
          <input type=button class=SideButton value="���ģ���ǩ" <%=mDisabled%>  <%=mWord%>  onclick="LoadBookmarks()">
          <input type=button class=SideButton value="����汾" <%=mDisabled%>  onclick="WebSaveVersion()">
          <input type=button class=SideButton value="�򿪰汾" <%=mDisabled%>  onclick="WebOpenVersion()">
          <input type=button class=SideButton value="���浱ǰ�汾" <%=mDisabled%>  onclick="WebSaveVersionByFileID()">
          <input type=button class=SideButton value="���涨��汾" <%=mDisabled%>  onclick="WebUpdateFile()">
          <input type=button class=SideButton value="��ΪHTML" <%=mDisabled%>  onclick="WebSaveAsHtml()">
          <input type=button class=SideButton value="��ΪHTMLͼƬ" <%=mDisabled%>  <%=mWord%>  onclick="WebSaveAsPage()">
          <input type=button class=SideButton value="ģ���׺�" <%=mDisabled%>  <%=mWord%> onClick="WebUseTemplate()">
          <input type=button class=SideButton value="VBA�׺춨��" <%=mDisabled%>  <%=mWord%>  onclick="WebInsertVBA();">
          <input type=button class=SideButton value="��ӡ���ƹ���" <%=mDisabled%> <%=mWord%>  onClick="WebCopysCtrlPrint()">
          <input type=button class=SideButton value="������������" <%=mDisabled%>  <%=mWord%>  onclick="WebInportText();">
          <input type=button class=SideButton value="�����ĵ�����" <%=mDisabled%>  <%=mWord%>  onclick="WebExportText();">
          <input type=button class=SideButton value="����Զ�̱��" <%=mDisabled%>  <%=mWord%>  onclick="WebSetWordTable()">
          <input type=button class=SideButton value="����Զ��ͼƬ" <%=mDisabled%>  <%=mWord%>  onclick="WebInsertImage()">
          <input type=button class=SideButton value="���ط������ļ�" <%=mDisabled%> <%=mWord%> onClick="WebGetFile()">
          <input type=button class=SideButton value="�ϴ��ļ���������" <%=mDisabled%> <%=mWord%> onClick="WebPutFile()">
          <input type=button class=SideButton value="��Զ���ļ�"  <%=mDisabled%> <%=mWord%>  onclick="WebDownLoadFile()">
          <input type=button class=SideButton value="���ñ���ʱ��"  <%=mDisabled%>  onclick="WebDateTime()">
          <input type=button class=SideButton value="��Ϣ����"  <%=mDisabled%>  onclick="WebSendInformation()">
    	</td>
      </tr>
      <tr width="100">
        <td align="center" class="TDTitleMiddleStyle" height="28">
          <font color="#FF0000"><b>��VBA���á�</b></font>
    	</td>
      </tr>
      <tr width="100">
        <td align="center" valign=top class="TDTitleStyle" width="100">
          <input type=button class=SideButton value="ȡWord����" <%=mDisabled%>  <%=mWord%>  onclick="WebGetWordContent()">
      <input type=button class=SideButton value="дWord����" <%=mDisabled%>  <%=mWord%>  onclick="WebSetWordContent()">
          <input type=button class=SideButton value="WORD��ֹ�϶�" <%=mDisabled%> <%=mWord%> onClick="webform.WebOffice.WebObject.Application.Options.AllowDragAndDrop=false;">  <!--false��ֹ�϶�  true�����϶�-->
          <input type=button class=SideButton value="��ӡ�ڰ�" <%=mDisabled%> <%=mWord%> onClick="WebWordPrintBlackAndWhile();">
          <input type=button class=SideButton value="����ҳü" <%=mDisabled%> <%=mWord%> onClick="webform.WebOffice.WebObject.ActiveWindow.ActivePane.View.SeekView=9;">
          <input type=button class=SideButton value="����ҳ��" <%=mDisabled%> <%=mWord%> onClick="webform.WebOffice.WebObject.Application.Dialogs(294).Show();">
          <input type=button class=SideButton value="��Excel���" <%=mDisabled%>  <%=mExcel%> onClick="WebGetExcelContent()">
          <input type=button class=SideButton value="����������" <%=mDisabled%>   <%=mExcel%> onClick="WebSheetsLock()">
          <input type=button class=SideButton value="EXCEL��ֹ�϶�" <%=mDisabled%> <%=mExcel%> onClick="webform.WebOffice.WebObject.Application.CellDragAndDrop=false;">  <!--false��ֹ�϶�  true�����϶�-->
          <input type=button class=SideButton value="�ĵ�ҳ��" <%=mDisabled%>  <%=mWord%>  onclick="WebDocumentPageCount()">
		  <input type=button class=SideButton value="�ĵ��ֽ���" onclick="WebLocalFileSize()">
      </tr>
      <tr width="100">
        <td align="center" class="TDTitleMiddleStyle" height="28">
          <font color="#FF0000"><b>�����������ơ�</b></font>
	    </td>
      </tr>
      <tr width="100">
        <td align="center" valign=top class="TDTitleStyle" width="100">      
          <input type=button class=SideButton value="�رճ��ù���" <%=mDisabled%>  onclick="WebToolsVisible('Standard',false)">
          <input type=button class=SideButton value="�򿪳��ù���" <%=mDisabled%>  onclick="WebToolsVisible('Standard',true)">
          <input type=button class=SideButton value="�رո�ʽ����" <%=mDisabled%>  onclick="WebToolsVisible('Formatting',false)">
          <input type=button class=SideButton value="�򿪸�ʽ����" <%=mDisabled%>  onclick="WebToolsVisible('Formatting',true)">
          <input type=button class=SideButton value="�رմ�ӡ��ť" <%=mDisabled%>  onclick="WebToolsEnable('Standard',2521,false);">
          <input type=button class=SideButton value="�򿪴�ӡ��ť" <%=mDisabled%>  onclick="WebToolsEnable('Standard',2521,true);">
          <input type=button class=SideButton value="�ر��ĵ�" <%=mDisabled%>  onclick="webform.WebOffice.WebClose();">
      </tr>
      <tr width="100">
        <td align="center" class="TDTitleMiddleStyle" height="28">
          <font color="#FF0000"><b>���������á�</b></font>
	    </td>
      </tr>
    </table>
  </form>
</body>
</html>