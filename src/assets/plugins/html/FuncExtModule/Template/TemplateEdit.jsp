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


  //取得模式
  if (mEditType==null)
  {
    mEditType="2,1";		//2 起草
  }
  //取得类型
  if ( mFileType==null)
  {
    mFileType=".doc";	// 默认为.doc文档
  }
  //取得用户名
  if (mUserName==null)
  {
    mUserName="金格科技";
  }

  //取得模板
  if ( mRecordID==null)
  {
    mRecordID="";	// 默认没有模板
  }

  //打开数据库
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
	//取得唯一值(mRecordID)
        java.util.Date dt=new java.util.Date();
        long lg=dt.getTime();
        Long ld=new Long(lg);
	//初始化值
        mRecordID=ld.toString();
        mFileName="公文模版"+mFileType;
        mFileType=mFileType;
        mDescript="发文公文模版";
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
<title>模板管理</title>
<link rel='stylesheet' type='text/css' href='../test.css'>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript" for=WebOffice2015 event="OnCommand(vIndex, Caption, bCancel)">
   if (vIndex==1){  //打开本地文件
      WebOpenLocal();
   }
   if (vIndex==2){  //保存本地文件
      WebSaveLocal();
   }
   if (vIndex==4){  //保存并退出
     SaveDocument();    //保存正文
     webform.submit();  //提交表单
   }
   if (vIndex==6){  //打印文档
      WebOpenPrint();
   }
</script>

<script language="javascript" for=WebOffice2015 event="OnReady()">
    //获取iWebOffice2015控件对象，WebOffice.FuncExtModule是iWebOffice2015控件扩展接口对象
	WebOffice = document.getElementById("WebOffice2015");
	webform.WebOffice = WebOffice.FuncExtModule;          //webform.WebOffice是之前03&09控件使用的对象
	Load();          //避免页面加载完，控件还没有加载的情况
</script>

<script language=javascript>

//作用：显示操作状态
function StatusMsg(mString){
  StatusBar.innerText=mString;
}

//作用：载入iWebOffice
function Load(){
  try{

  //以下属性必须设置，实始化iWebOffice
  webform.WebOffice.WebUrl="<%=mServerUrl%>";	//WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
  webform.WebOffice.RecordID="<%=mRecordID%>";	//RecordID:本文档记录编号
  webform.WebOffice.Template="<%=mRecordID%>";	//Template:模板编号
  webform.WebOffice.FileName="<%=mFileName%>";	//FileName:文档名称
  webform.WebOffice.FileType="<%=mFileType%>";	//FileType:文档类型  .doc  .xls  .wps
  webform.WebOffice.EditType="<%=mEditType%>";	//EditType:编辑类型  方式一、方式二  <参考技术文档>
  webform.WebOffice.UserName="<%=mUserName%>";	//UserName:操作用户名

  //以下属性可以不要
  webform.WebOffice.ShowToolBar="0";		//ShowToolBar:是否显示工具栏:1显示,0不显示
  webform.WebOffice.ShowMenu="1";		//ShowMenu:1 显示菜单  0 隐藏菜单
  webform.WebOffice.AppendMenu("1","打开本地文件(&L)");
  webform.WebOffice.AppendMenu("2","保存本地文件(&S)");
  webform.WebOffice.AppendMenu("3","-");
  webform.WebOffice.AppendMenu("4","保存并退出(&E)");
  webform.WebOffice.AppendMenu("5","-");
  webform.WebOffice.AppendMenu("6","打印文档(&P)");
  webform.WebOffice.DisableMenu("宏(&M);选项(&O)...");      //禁止菜单

  webform.WebOffice.WebOpen();			//打开该文档    交互OfficeServer的OPTION="LOADTEMPLATE"
  webform.WebOffice.ShowType=1;			//文档显示方式  1:表示文字批注  2:表示手写批注  0:表示文档核稿
  StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//作用：退出iWebOffice
function UnLoad(){
  try{
  if (!webform.WebOffice.WebClose()){
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg("关闭文档...");
  }
  }catch(e){}
}


//作用：打开文档
function LoadDocument(){
  StatusMsg("正在打开文档...");
  if (!webform.WebOffice.WebLoadTemplate()){  //交互OfficeServer的OPTION="LOADTEMPLATE"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}


//作用：刷新文档
function WebReFresh(){
  webform.WebOffice.WebReFresh();
  StatusMsg("文档已刷新...");
}


//作用：保存文档
function SaveDocument(){
  webform.WebOffice.WebClearMessage();            //清空iWebOffice变量
  if ("<%=mFileType%>"==".doc"){
    if (!webform.WebOffice.WebSaveBookMarks()){    //交互OfficeServer的OPTION="SAVEBOOKMARKS"
      StatusMsg(webform.WebOffice.Status);
      return false;
    }
  }
  //webform.WebOffice.WebSetMsgByName("MyDefine1","自定义变量值1");  //设置变量MyDefine1="自定义变量值1"，变量可以设置多个  在WebSaveTemplate()时，一起提交到OfficeServer中
  if (!webform.WebOffice.WebSaveTemplate(true)){    //交互OfficeServer的OPTION="SAVETEMPLATE"，参数true表示保存OFFICE文档
     StatusMsg(webform.WebOffice.Status);
     return false;
  }else{
     StatusMsg(webform.WebOffice.Status);
     return true;
  }
}

//作用：填充模板
function LoadBookmarks(){
  StatusMsg("正在填充模扳...");
  if (!webform.WebOffice.WebLoadBookmarks()){    //交互OfficeServer的OPTION="LOADBOOKMARKS"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//作用：设置书签值  vbmName:标签名称，vbmValue:标签值   标签名称注意大小写
function SetBookmarks(vbmName,vbmValue){
  if (!webform.WebOffice.WebSetBookmarks(vbmName,vbmValue)){
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//作用：根据标签名称获取标签值  vbmName:标签名称
function GetBookmarks(vbmName){
  var vbmValue;
  vbmValue=webform.WebOffice.WebGetBookmarks(vbmName);
  return vbmValue;
}

//作用：打印文档
function WebOpenPrint(){
  try{
    webform.WebOffice.WebOpenPrint();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//作用：页面设置
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

//作用：标签管理
function WebOpenBookMarks(){
  try{
    webform.WebOffice.WebOpenBookmarks();    //交互OfficeServer的OPTION="LISTBOOKMARKS"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//作用：存为本地文件
function WebSaveLocal(){
  try{
    webform.WebOffice.WebSaveLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//作用：打开本地文件
function WebOpenLocal(){
  try{
    webform.WebOffice.WebOpenLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}
</script>
</head>
<body bgcolor="#ffffff"  onunload="UnLoad()"> <!--引导和退出iWebOffice-->

<form name="webform" method="post" action="TemplateSave.jsp" onsubmit="return SaveDocument();"> <!--保存iWebOffice后提交表单信息-->
<input type="hidden" name="RecordID" value="<%=mRecordID%>">

<table border=0  cellspacing='0' cellpadding='0' width=100% height=100% align=center class=TBStyle>
<tr>
  <td align="right" class="TDTitleStyle" width=64>模版名</td>
  <td class="TDStyle"><input type="text" name="FileName" value="<%=mFileName%>" class="IptStyle" ></td>
</tr>

<tr>
  <td align=right class="TDTitleStyle" width=64>说明</td>
  <td class="TDStyle"><input type="text" name="Descript" value="<%=mDescript%>" class="IptStyle" ></td>
</tr>

<tr>
  <!--td align=right valign=top  class="TDTitleStyle" width=64>内容</td-->
  <td align=right valign=top  class="TDTitleStyle" width=64 height=90% >
                 <input type=button value="打印文档"  onclick="WebOpenPrint()">
                 <input type=button value="定义标签"  onclick="WebOpenBookMarks()">
                 <input type=button value="填充模版"  onclick="LoadBookmarks()">
                 <input type=button value="重调文档"  onclick="LoadDocument()">
                 <input type=button value="刷新文档"  onclick="WebReFresh()">
                 <input type=button value="打开文件"  onclick="WebOpenLocal()">
                 <input type=button value="保存文件"  onclick="WebSaveLocal()">
  </td>

  <td class="TDStyle"  height=90%>
        <table border=0 cellspacing='0' cellpadding='0' width='100%' height='100%' >
        <tr>
          <td bgcolor="menu">
            <!--调用iWebOffice，注意版本号，可用于升级-->
            <script src="../iWebOffice2015.js"></script>
          </td>
        </tr>
        <tr>
          <td bgcolor=menu height='20'>
		<div id=StatusBar>状态栏</div>
          </td>
        </tr>
        </table>
  </td>
</tr>
</table>

<input type=submit value="  保存  ">
<input type=reset value="  清除  ">
<input type=button value="  返回  " onclick="history.back()"> 注意：只有选择《保存》后，所做的操作才有效！
</form>

</body>
</html>
