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

  //自动获取OfficeServer和OCX文件完整URL路径
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName="OfficeServer.jsp";
  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/FuncExtModule/"+mServerName;
  //String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/"+mServerName;//取得OfficeServer文件的完整URL
  String mHttpUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/";

  String mRecordID=request.getParameter("RecordID");
  String mTemplate=request.getParameter("Template");
  String mFileType=request.getParameter("FileType");
  String mEditType=request.getParameter("EditType");
  String mShowType=request.getParameter("ShowType");
  String mUserName=new String(request.getParameter("UserName").getBytes("8859_1"));

  //设置编号初始值
  if (mRecordID==null){
     mRecordID="";
  }

  //设置编辑状态初始值
  if (mEditType==null || mEditType==""){
    mEditType="1,1";
  }

  //设置显示模式初始值
  if (mShowType==null || mShowType==""){
    mShowType="1";
  }

  //设置文档类型初始值
  if (mFileType==null || mFileType==""){
    mFileType=".doc";
  }

  //设置用户名初始值
  if (mUserName==null || mUserName==""){
    mUserName="金格科技";
  }

  //设置模板初始值
  if (mTemplate==null){
    mTemplate="";
  }

  //打开数据库
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
        //取得唯一值(mRecordID)
        java.util.Date dt=new java.util.Date();
        long lg=dt.getTime();
        Long ld=new Long(lg);
        //初始化值
        mRecordID=ld.toString();//保存的是文档的编号，通过该编号，可以在里找到所有属于这条纪录的文档
        mTemplate=mTemplate;
        mSubject="请输入主题";
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

  mFileName=mRecordID + mFileType;  //取得完整的文档名称
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
<title>WebOffice 2003、2009升级到iWebOffice2015示例</title>
<link rel='stylesheet' type='text/css' href='test.css'>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="renderer" content="webkit" />
<script language="javascript" for=WebOffice2015 event="OnCommand(ID, Caption, bCancel)">
  if (ID==1 || ID==101){  
    WebOpenLocal();     //打开本地文件
  }
  if (ID==2 || ID==102){ 

    WebSaveLocal();     //保存本地文件
  }
  if (ID==3 || ID==103){
    SaveDocument();     //保存正文到服务器上（不退出）
  }
  if (ID==5 || ID==201){  
    WebOpenSignature(); //签名印章
  }
  if (ID==6 || ID==202){  
    WebShowSignature(); //验证签章
  }
  if (ID==8 || ID==301){  
    WebSaveVersion();   //保存版本
  }
  if (ID==9 || ID==302){  
    WebOpenVersion();   //打开版本
  }
  if (ID==11 || ID==104){
    SaveDocument();     //保存正文到服务器上
    webform.submit();   //然后退出
  }
  if (ID==13 || ID==501){  
    WebOpenPrint();     //打印文档
  }
</script>  



<script language="javascript" for=WebOffice2015 event="OnReady()">
    //获取iWebOffice2015控件对象，WebOffice.FuncExtModule是iWebOffice2015控件扩展接口对象
	WebOffice = document.getElementById("WebOffice2015");
	webform.WebOffice = WebOffice.FuncExtModule;          //webform.WebOffice是之前03&09控件使用的对象
	Load();          //避免页面加载完，控件还没有加载的情况
	
</script>

<script language=javascript>
/*
form表单名称:webform
iWebOffice名称:WebOffice
WebObject文档对象接口，相当于：
如果是Word  文件，WebObject 是Word  VBA的ActiveDocument对象
如果是Excel 文件，WebObject 是Excel VBA的ActiveSheet对象

如：webform.WebOffice.WebObject
*/


//作用：显示操作状态
function StatusMsg(mString){
  webform.StatusBar.value=mString;
}
//新建WebOffice
var WebOffice = null;    //定义WebOffice变量，全局使用

//作用：载入iWebOffice
function Load(){
  try{
    
	if ((window.ActiveXObject!=undefined) || (window.ActiveXObject!=null) ||"ActiveXObject" in window){
			//IE调用
		} else{
			//非IE调用,该属性目前只支持IE浏览器，其它浏览器不支持Hook，所以须设置成false，否则会引起异常崩溃。
			WebOffice.HookEnabled = false;
			webform.WebOffice = WebOffice.FuncExtModule;  //获取iWebOffice2015扩展接口对象
		}

	
	
	//以下属性必须设置，实始化iWebOffice
    webform.WebOffice.WebUrl="<%=mServerUrl%>";             //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
    //webform.WebOffice.WebUrl="http://192.168.0.81:8080/iWebOffice2009_Web2015/OfficeServer.jsp";
	//webform.WebOffice.Alert(webform.WebOffice.WebUrl);
	webform.WebOffice.RecordID="<%=mRecordID%>";            //RecordID:本文档记录编号
	webform.WebOffice.Template="<%=mTemplate%>";            //Template:模板编号
	webform.WebOffice.FileName="<%=mFileName%>";            //FileName:文档名称
    //webform.WebOffice.Alert(webform.WebOffice.FileName);
	
	webform.WebOffice.FileType="<%=mFileType%>";            //FileType:文档类型  .doc  .xls  .wps
	//webform.WebOffice.Alert(webform.WebOffice.FileType);
	
	webform.WebOffice.UserName="<%=mUserName%>";            //UserName:操作用户名，痕迹保留需要
    //webform.WebOffice.Alert(webform.WebOffice.UserName);
	webform.WebOffice.EditType="<%=mEditType%>";            //EditType:编辑类型  方式一、方式二  <参考技术文档>
                                                            //第一位可以为0,1,2,3 其中:0不可编辑;1可以编辑,无痕迹;2可以编辑,有痕迹,不能修订;3可以编辑,有痕迹,能修订；
                                                            //第二位可以为0,1 其中:0不可批注,1可以批注。可以参考iWebOffice2009的EditType属性，详细参考技术白皮书
    webform.WebOffice.MaxFileSize = 4 * 1024;               //最大的文档大小控制，默认是8M，现在设置成4M。
    webform.WebOffice.Language="CH";                        //Language:多语言支持显示选择   CH 简体 TW繁体 EN英文
    webform.WebOffice.ShowWindow = true;                  //控制显示打开或保存文档的进度窗口，默认不显示

    webform.WebOffice.PenColor="#FF0000";                   //PenColor:默认批注颜色
    webform.WebOffice.PenWidth="1";                         //PenWidth:默认批注笔宽
    webform.WebOffice.Print="1";                            //Print:默认是否可以打印:1可以打印批注,0不可以打印批注
    
	webform.WebOffice.ShowToolBar="0";                      //ShowToolBar:是否显示工具栏:1显示,0不显示
	
    webform.WebOffice.ShowMenu="1";                         //控制整体菜单显示
    //以下为自定义菜单↓
    webform.WebOffice.AppendMenu("1","打开本地文件(&L)");
    webform.WebOffice.AppendMenu("2","保存本地文件(&S)");
    webform.WebOffice.AppendMenu("3","保存远程文件(&U)");
    webform.WebOffice.AppendMenu("4","-");
    webform.WebOffice.AppendMenu("5","签名印章(&Q)");
    webform.WebOffice.AppendMenu("6","验证签章(&Y)");
    webform.WebOffice.AppendMenu("7","-");
    webform.WebOffice.AppendMenu("8","保存版本(&B)");
    webform.WebOffice.AppendMenu("9","打开版本(&D)");
    webform.WebOffice.AppendMenu("10","-");
    webform.WebOffice.AppendMenu("11","保存并退出(&E)");
    webform.WebOffice.AppendMenu("12","-");
    webform.WebOffice.AppendMenu("13","打印文档(&P)"); 
    //以上为自定义菜单↑
    webform.WebOffice.DisableMenu("宏(&M);选项(&O)...");    //禁止某个（些）菜单项
    WebSetRibbonUIXML();                                  //控制OFFICE2007的选项卡显示		
	
	
	webform.WebOffice.AllowEmpty = true;

    
	webform.WebOffice.FolderEncrypt=false;                                //用于隐藏临时目录下的文件
	
	WebOffice.Style.ShowMenuBar = true;
	WebOffice.Style.ShowTitleBar = true;
	
	webform.WebOffice.WebOpen();                            //打开该文档    交互OfficeServer  调出文档OPTION="LOADFILE"    调出模板OPTION="LOADTEMPLATE"     <参考技术文档>
    StatusMsg(webform.WebOffice.Status);                    //状态信息
  }catch(e){
    webform.WebOffice.Alert(e.description);                                   //显示出错误信息
  }
}

	// 设置控件皮肤	（该功能已完整实现）
	function WebSetSkin(titleBarColor/* 控件标题栏颜色 */,
			menuBarStartColor/* 自定义菜单开始颜色 */,
			menuBarButtonStartColor/* 自定义工具栏按钮开始颜色 */,
			menuBarButtonEndColor/* 自定义工具栏按钮结束颜色 */,
			menuBarButtonFrameColor/* 自定义工具栏按钮边框颜色 */,
			CustomToolbarStartColor/* 自定义工具栏开始颜色 */, TitleBarTextColor/* 控件标题栏文本颜色 */) {
		//this.Status = '';
		var style = WebOffice.Style;
		try {
			style.TitleBarColor = titleBarColor;
			if ((TitleBarTextColor == undefined) || (TitleBarTextColor == '')) // 设置默认标题文字颜色
			{
				style.TitleBarTextColor = 0x000000; // 黑色
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
			webform.WebOffice.Alert('皮肤设置错误，错误信息为：' + e.description);
			return false;
		}
	}

//作用：退出iWebOffice
function UnLoad(){
  try{
    if (!webform.WebOffice.WebClose()){
		
      StatusMsg(webform.WebOffice.Status);
    }else{
      StatusMsg("关闭文档...");
    }
  }catch(e){
    webform.WebOffice.Alert(e.description);
  }
}

//作用：打开文档
function LoadDocument(){
  StatusMsg("正在打开文档...");
  if (!webform.WebOffice.WebOpen()){  	//打开该文档    交互OfficeServer的OPTION="LOADFILE"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
	 //webform.WebOffice.Alert(webform.WebOffice.Status);
	
  }
}

//作用：保存文档
function SaveDocument(){
  //webform.WebOffice.WebSetMsgByName("MyDefine1","自定义变量值1");  //设置变量MyDefine1="自定义变量值1"，变量可以设置多个  在WebSave()时，一起提交到OfficeServer中
   //webform.WebOffice.Alert(webform.WebOffice.Modify);
  //webform.WebOffice.Alert(webform.WebOffice.WebSave());
 //document.getElementById("FileType").value = webform.WebOffice.FileType; //本地打开文档格式docx，则服务器文档保存为docx格式
  //webform.WebOffice.Alert(webform.WebOffice.FileType);
  
  if (!webform.WebOffice.WebSave()){    //交互OfficeServer的OPTION="SAVEFILE"  注：WebSave()是保存复合格式文件，包括OFFICE内容和手写批注文档；如只保存成OFFICE文档格式，那么就设WebSave(true)
     StatusMsg(webform.WebOffice.Status);
 //webform.WebOffice.Alert(webform.WebOffice.Status);
     return false;
  }else{
     StatusMsg(webform.WebOffice.Status);
	 //webform.WebOffice.Alert(webform.WebOffice.Status);
     return true;
  }
}


//作用：显示或隐藏痕迹[隐藏痕迹时修改文档没有痕迹保留]  true表示隐藏痕迹  false表示显示痕迹
function ShowRevision(mValue){
  if (mValue){
     webform.WebOffice.WebShow(true);
     StatusMsg("显示痕迹...");
  }else{
     webform.WebOffice.WebShow(false);
     StatusMsg("隐藏痕迹...");
  }
}


//作用：显示或隐藏痕迹[隐藏痕迹时修改文档有痕迹保留]  true表示隐藏痕迹  false表示显示痕迹
function ShowRevision2(mValue){
  if (mValue){
     webform.WebOffice.WebObject.ShowRevisions=true;   //显示痕迹
  }else{
     webform.WebOffice.WebObject.ShowRevisions=false;  //隐藏痕迹
  }
}


//作用：获取痕迹
function WebGetRevisions(){
  var Rev = webform.WebOffice.WebObject.Revisions;		//获取痕迹对象
  var Text="";

  for (i = 1;i <= Rev.Count;i++){
    Text=Text +"“"+ Rev.Item(i).Author+"”";
    if (Rev.Item(i).Type=="1"){
      Text=Text + '进行插入：'+Rev.Item(i).Range.Text+"\r\n";
    }else if (Rev.Item(i).Type=="2"){
      Text=Text + '进行删除：'+Rev.Item(i).Range.Text+"\r\n";
    }
	else {
      Text=Text + '进行其他操作，操作内容：“'+Rev.Item(i).Range.Text+ '”；操作：“'+Rev.Item(i).FormatDescription+"”。\r\n";
    }
  }
  webform.WebOffice.Alert("痕迹内容：\r\n\r\n"+Text);
}

//作用：刷新文档
function WebReFresh(){
  webform.WebOffice.WebReFresh();
  StatusMsg("文档已刷新...");
}


//作用：打开版本
function WebOpenVersion(){
  webform.WebOffice.WebOpenVersion();  	//交互OfficeServer  列出版本OPTION="LISTVERSION"     调出版本OPTION="LOADVERSION"   <参考技术文档>
  StatusMsg(webform.WebOffice.Status);
}

//作用：保存版本
function WebSaveVersion(){
  webform.WebOffice.WebSaveVersion();  	//交互OfficeServer的OPTION="SAVEVERSION"
  StatusMsg(webform.WebOffice.Status);

}

//作用：保存当前版本
function WebSaveVersionByFileID(){
  var mText=window.prompt("请输入版本说明:","版本号:V");
  if (mText==null){
     mText="已修改版本.";
  }
  webform.WebOffice.WebSaveVersionByFileID(mText);  	//交互OfficeServer的OPTION="SAVEVERSION"  同时带FileID值   <参考技术文档>
  StatusMsg(webform.WebOffice.Status);
}


//作用：填充模板
function LoadBookmarks(){
  StatusMsg("正在填充模扳...");
  webform.WebOffice.WebSetMsgByName("COMMAND", "Hello World!!");
  
  if (!webform.WebOffice.WebLoadBookmarks()){  	//交互OfficeServer的OPTION="LOADBOOKMARKS"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//作用：标签管理
function WebOpenBookMarks(){
  try{
    webform.WebOffice.WebOpenBookmarks();  	//交互OfficeServer的OPTION="LISTBOOKMARKS"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//保存文档中书签到数据库中
function WebSaveBookMarks(){
  try{
	  webform.WebOffice.WebSetMsgByName("COMMAND", "22111ads");
	webform.WebOffice.WebSaveBookMarks();  	            //交互OfficeServer的OPTION="SAVEBOOKMARKS"
    webform.WebOffice.Alert(webform.WebOffice.Status);
	StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
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
  }catch(e){webform.WebOffice.Alert(e.description);}
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
   }catch(e){webform.WebOffice.Alert(e.description);}
}

//作用：插入图片
function WebOpenPicture(){
  try{
    webform.WebOffice.WebOpenPicture();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//作用：签名印章
function WebOpenSignature(){
  webform.WebOffice.Alert("如果你要更安全签章,建议采用金格iSignature电子签章软件进行签章:\r\n下载地址http://www.goldgrid.cn/iSignature/Download.asp\r\n\r\n该软件是支持文档完整性保护、CA证书和数字签名技术的,\r\n是通过了<国家公安部和国家保密局>双重认证的安全电子签章产品!");
  try{
    webform.WebOffice.WebOpenSignature();  	//交互OfficeServer的 A签章列表OPTION="LOADMARKLIST"    B签章调出OPTION="LOADMARKIMAGE"    C确定签章OPTION="SAVESIGNATURE"    <参考技术文档>
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//作用：验证印章A
function WebShowSignature(){
  try{
    webform.WebOffice.WebShowSignature();  	//交互OfficeServer的OPTION="LOADSIGNATURE"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//作用：验证印章B
function WebCheckSignature(){
  try{
    var i=webform.WebOffice.WebCheckSignature();  	//交互OfficeServer的OPTION="LOADSIGNATURE"
    webform.WebOffice.Alert("检测结果："+i+"\r\n 注释: (=-1 有非法印章) (=0 没有任何印章) (>=1 有多个合法印章)");
    StatusMsg(i);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//作用：存为本地文件
function WebSaveLocal(){
  try{
	 //webform.WebOffice.FileName="123测试.doc"; 
	 //webform.WebOffice.Alert(webform.WebOffice.FileName);
    webform.WebOffice.WebSaveLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//作用：打开本地文件
function WebOpenLocal(){
  try{
	//WebOffice.Style.ShowOpenProgress = true; //设置打开文档是否显示进度条
	
	 
    webform.WebOffice.WebOpenLocal();
	//SetBookmarks("test", "设置书签内容_helloworld");
	document.getElementById("FileType").value = webform.WebOffice.FileType; //本地打开文档格式docx，则服务器文档保存为docx格式
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//作用：保存为HTML文档
function WebSaveAsHtml(){
  try{
    if (webform.WebOffice.WebSaveAsHtml())  	//交互OfficeServer的OPTION="SAVEASHTML"
    {
      webform.HTMLPath.value="HTML/<%=mRecordID%>.htm";
      window.open("<%=mHttpUrl%>"+ webform.HTMLPath.value);
    }
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}


//作用：保存为文档图片
function WebSaveAsPage(){
  try{
	  var ret = webform.WebOffice.WebSaveImage();
	  webform.WebOffice.Alert(ret);
    if (ret)  	//交互OfficeServer的OPTION="SAVEIMAGE"
    {
	  webform.HTMLPath.value="HTMLIMAGE/<%=mRecordID%>.htm"
      window.open("<%=mHttpUrl%>"+ webform.HTMLPath.value);
    }
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}


//作用：关闭或显示工具 参数1表示工具条名称  参数2为false时，表示关闭  （名称均可查找VBA帮助）
//参数2为true时，表示显示
function WebToolsVisible(ToolName,Visible){
  try{
    webform.WebOffice.WebToolsVisible(ToolName,Visible);
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}


//作用：禁止或启用工具 参数1表示工具条名称  参数2表示工具条铵钮的编号  （名称和编号均可查找VBA帮助）
//参数3为false时，表示禁止  参数3为true时，表示启用
function WebToolsEnable(ToolName,ToolIndex,Enable){
  try{
    webform.WebOffice.WebToolsEnable(ToolName,ToolIndex,Enable);
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//作用：保护与解除  参数1为true表示保护文档  false表示解除保护
function WebProtect(value){
  try{
    var res = webform.WebOffice.WebSetProtect(value,"");  //""表示密码为空
	//webform.WebOffice.Alert(res);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//作用：允许与禁止拷贝功能  参数1为true表示允许拷贝  false表示禁止拷贝
function WebEnableCopy(value){
  try{
    webform.WebOffice.CopyType=value;
  }catch(e){webform.WebOffice.Alert(e.description);}
}


//作用：插入远程服务器图片
function WebInsertImage(){
  try{
    webform.WebOffice.WebInsertImage('Image','GoldgridLogo.jpg',true,4);   //交互OfficeServer的OPTION="INSERTIMAGE"  参数1表示标签名称  参数2表示图片文件名  参数3为true透明  false表示不透明  参数4为4表示浮于文字上方  5表示衬于文字下方
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
}


//作用：下载服务器文件到本地
function WebGetFile(){
  if (webform.WebOffice.WebGetFile("c:\\WebGetFile.doc","DownLoad.doc")){   //交互OfficeServer的OPTION="GETFILE"  参数1表示本地路径  参数2表示服务器文件名称
    StatusMsg(webform.WebOffice.Status);
  }else{
    StatusMsg(webform.WebOffice.Status);
  }
  webform.WebOffice.Alert(webform.WebOffice.Status+"\r\n"+"文件放在c:\\WebGetFile.doc");
}


//作用：上传本地文件到服务器
function WebPutFile(){
  var mLocalFile=webform.WebOffice.WebOpenLocalDialog();
  if (mLocalFile!=""){
    webform.WebOffice.Alert(mLocalFile);
    if (webform.WebOffice.WebPutFile(mLocalFile,"Test.doc")){   //交互OfficeServer的OPTION="PUTFILE"  参数1表示本地路径，可以任何格式文件  参数2表示服务器文件名称
      StatusMsg(webform.WebOffice.Status);
    }else{
      StatusMsg(webform.WebOffice.Status);
    }
    webform.WebOffice.Alert(webform.WebOffice.Status);
  }
}


//作用：打开远程文件
function WebDownLoadFile(){
  mResult=webform.WebOffice.WebDownLoadFile("http://192.168.0.81:8080/iWebOffice2009/Document/Test.doc","c:\\abc.doc");
  if (mResult){
    webform.WebOffice.WebOpenLocalFile("c:\\abc.doc");
    webform.WebOffice.Alert("成功");
  }else{
    webform.WebOffice.Alert("失败");
  }
}

//作用：取得服务器端时间，设置本地时间  [V6.0.1.5以上支持]
function WebDateTime(){
  mResult=webform.WebOffice.WebDateTime(true);   //交互OfficeServer的OPTION="DATETIME"   true表示返回并设置本地时间为服务器时间；false表示仅返回服务器时间
  webform.WebOffice.Alert("提示：已经设置本地时间为 "+mResult);    //该功能主要用于在痕迹保留时读取服务器时间
}


//作用：表格生成及填充
function WebSetWordTable(){
  var mText="",mName="",iColumns,iCells,iTable;
  //设置COMMAND为WORDTABLE
  webform.WebOffice.WebSetMsgByName("COMMAND","WORDTABLE");   //设置变量COMMAND="WORDTABLE"，在WebSendMessage()时，一起提交到OfficeServer中
  //发送到服务器上
  //如果没有错误
  if (webform.WebOffice.WebSendMessage()){                //交互OfficeServer的OPTION="SENDMESSAGE"
	iColumns = webform.WebOffice.WebGetMsgByName("COLUMNS");  //取得列
	iCells = webform.WebOffice.WebGetMsgByName("CELLS");      //取得行
	iTable=webform.WebOffice.WebObject.Tables.Add(webform.WebOffice.WebObject.Application.Selection.Range,iCells,iColumns);   //生成表格
	for (var i=1; i<=iColumns; i++)
	{
   	  for (var j=1; j<=iCells; j++)
	  {
		mName=i.toString()+j.toString();
		mText=webform.WebOffice.WebGetMsgByName(mName);	 //取得OfficeServer中的表格内容
		iTable.Columns(i).Cells(j).Range.Text=mText;   	//填充单元值
	   }
	}
   }
   StatusMsg(webform.WebOffice.Status);
}


//作用：获取文档Txt正文
function WebGetWordContent(){
  try{
    webform.WebOffice.Alert(webform.WebOffice.WebObject.Content.Text);
  }catch(e){webform.WebOffice.Alert(e.description);}
}

//作用：写Word内容
function WebSetWordContent(){
  var mText=window.prompt("请输入内容:","测试内容");
  if (mText==null){
     return (false);
  }
  else
  {
     //下面为显示选中的文本
     //webform.WebOffice.Alert(webform.WebOffice.WebObject.Application.Selection.Range.Text);
     //下面为在当前光标出插入文本
     webform.WebOffice.WebObject.Application.Selection.Range.Text= mText+"\n";
     //下面为在第一段后插入文本
     //webform.WebOffice.WebObject.Application.ActiveDocument.Range(1).Text=(mText);
  }
}


//作用：打印黑白文档
function WebWordPrintBlackAndWhile(){
   var i,n;

   //图片变黑白
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

   //文字变黑白
   webform.WebOffice.WebObject.Application.Selection.WholeStory();
   webform.WebOffice.WebObject.Application.Selection.Range.Font.Color = 0;
}

//作用：用Excel求和
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


//作用：保护工作表单元
function WebSheetsLock(){
    webform.WebOffice.WebObject.Application.Sheets(1).Select;

    webform.WebOffice.WebObject.Application.Range("A1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "产品";

    webform.WebOffice.WebObject.Application.Range("B1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "价格";
    webform.WebOffice.WebObject.Application.Range("C1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "详细说明";
    webform.WebOffice.WebObject.Application.Range("D1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "库存";
    webform.WebOffice.WebObject.Application.Range("A2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "书签";
    webform.WebOffice.WebObject.Application.Range("A3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "毛笔";
    webform.WebOffice.WebObject.Application.Range("A4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "钢笔";
    webform.WebOffice.WebObject.Application.Range("A5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "尺子";

    webform.WebOffice.WebObject.Application.Range("B2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "0.5";
    webform.WebOffice.WebObject.Application.Range("C2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "樱花";
    webform.WebOffice.WebObject.Application.Range("D2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "300";

    webform.WebOffice.WebObject.Application.Range("B3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "2";
    webform.WebOffice.WebObject.Application.Range("C3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "狼毫";
    webform.WebOffice.WebObject.Application.Range("D3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "50";

    webform.WebOffice.WebObject.Application.Range("B4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "3";
    webform.WebOffice.WebObject.Application.Range("C4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "蓝色";
    webform.WebOffice.WebObject.Application.Range("D4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "90";

    webform.WebOffice.WebObject.Application.Range("B5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "1";
    webform.WebOffice.WebObject.Application.Range("C5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "20cm";
    webform.WebOffice.WebObject.Application.Range("D5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "40";


    //保护工作表
    webform.WebOffice.WebObject.Application.Range("B2:D5").Select;
    webform.WebOffice.WebObject.Application.Selection.Locked = false;
    webform.WebOffice.WebObject.Application.Selection.FormulaHidden = false;
    webform.WebOffice.WebObject.Application.ActiveSheet.Protect(true,true,true);

    webform.WebOffice.Alert("已经保护工作表，只有B2-D5单元格可以修改。");
}

//作用：VBA套红
function WebInsertVBA(){

	//画线
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

	var mtext="★";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
   	var myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
   	myRange.ParagraphFormat.LineSpacingRule =1.5;
   	myRange.font.ColorIndex=6;
   	myRange.ParagraphFormat.Alignment=1;
   	myRange=webform.WebOffice.WebObject.Range(0,0);
	myRange.Select();
	mtext="金格发[２０１２]１５４号";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
	myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	myRange.ParagraphFormat.LineSpacingRule =1.5;
	myRange.ParagraphFormat.Alignment=1;
	myRange.font.ColorIndex=1;

	mtext="金格电子政务文件";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
	myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	myRange.ParagraphFormat.LineSpacingRule =1.5;

	//myRange.Select();
	myRange.Font.ColorIndex=6;
	myRange.Font.Name="仿宋_GB2312";
	myRange.font.Bold=true;
	myRange.Font.Size=50;
	myRange.ParagraphFormat.Alignment=1;

	//myRange=myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	webform.WebOffice.WebObject.PageSetup.LeftMargin=70;
	webform.WebOffice.WebObject.PageSetup.RightMargin=70;
	webform.WebOffice.WebObject.PageSetup.TopMargin=70;
	webform.WebOffice.WebObject.PageSetup.BottomMargin=70;
}

//作用：模版套红功能
function WebUseTemplate(){
  var mDialogUrl = "Template/TemplateForm.htm";
  var mObject = new Object();
  mObject.Template = "";
  window.showModalDialog(mDialogUrl, mObject, "dialogHeight:200px; dialogWidth:360px;center:yes;scroll:no;status:no;");

  //判断用户是否选择模板
  if (mObject.Template==""){
    StatusMsg("取消套用模板");
    return false;
  }else{
    if(WebAcceptAllRevisions()==false){                         //清除正文痕迹的目的是为了避免痕迹状态下出现内容异常问题。
      StatusMsg("清除正文痕迹失败，套红中止");
      return false;      
    }
    SaveDocument();                                             //保存当前编辑的文档
    webform.WebOffice.WebSetMsgByName("COMMAND","INSERTFILE");  //设置变量COMMAND="INSERTFILE"，在WebLoadTemplate()时，一起提交到OfficeServer中     <参考技术文档>
    webform.WebOffice.Template=mObject.Template;                //全局变量Template赋值，此示例读取服务器目录中模板，如读取数据库中模板，Template值为数据库中的模板编号，则上句代码不需要，如Template="1050560363767"，模板名称为“Word公文模板”，注：模板中有要标签Content，区分大小写，可以自行修改
    webform.WebOffice.EditType="1";                             //控制为不保留痕迹的状态
    if (webform.WebOffice.WebLoadTemplate()){                   //交互OfficeServer的OPTION="LOADTEMPLATE"
      //SetBookmarks("Title","关于中间件研发工作会议通知_HelloWorld");     //填充模板其它基本信息，如标题，主题词，文号，主送机关等
      if (webform.WebOffice.WebInsertFile()){                   //填充公文正文   交互OfficeServer的OPTION="INSERTFILE"
        StatusMsg("模板套红成功");
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

//作用：保存定稿文件
function WebUpdateFile(){
  if (webform.WebOffice.WebUpdateFile()){                //交互OfficeServer的OPTION="UPDATEFILE"，类似WebSave()或WebSaveVersion()方法
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}



//打印份数控制
function WebCopysCtrlPrint(){
  var mCopies,objPrint;
  objPrint = webform.WebOffice.WebObject.Application.Dialogs(88);     //打印设置对话框
  if (objPrint.Display==-1){
    mCopies=objPrint.NumCopies;    //取得需要打印份数
    webform.WebOffice.WebSetMsgByName("COMMAND","COPIES");
    webform.WebOffice.WebSetMsgByName("OFFICEPRINTS",mCopies.toString());   //设置变量OFFICEPRINTS的值，在WebSendMessage()时，一起提交到OfficeServer中
    webform.WebOffice.WebSendMessage();                               //交互OfficeServer的OPTION="SENDMESSAGE"
    if (webform.WebOffice.Status=="1") {
      webform.WebOffice.Alert("可以允许打印，注：该实例设置总文档打印份数2份");
      objPrint.Execute;
    }else{
      webform.WebOffice.Alert("已超出允许的打印份数");
      return false;
    }
  }
}


//作用：导入Text
function WebInportText(){
    var mText;
    webform.WebOffice.WebSetMsgByName("COMMAND","INPORTTEXT");  //设置变量COMMAND="INPORTTEXT"，在WebSendMessage()时，一起提交到OfficeServer中
    if (webform.WebOffice.WebSendMessage()){                    //交互OfficeServer的OPTION="SENDMESSAGE"
      mText=webform.WebOffice.WebGetMsgByName("CONTENT");       //取得OfficeServer传递的变量CONTENT值
      webform.WebOffice.WebObject.Application.Selection.Range.Text=mText;
      webform.WebOffice.Alert("导入文本成功");
    }
    StatusMsg(webform.WebOffice.Status);
}


//作用：导出Text
function WebExportText(){
    var mText=webform.WebOffice.WebObject.Content.Text;
    webform.WebOffice.WebSetMsgByName("COMMAND","EXPORTTEXT");  //设置变量COMMAND="EXPORTTEXT"，在WebSendMessage()时，一起提交到OfficeServer中
    webform.WebOffice.WebSetMsgByName("CONTENT",mText);         //设置变量CONTENT="mText"，在WebSendMessage()时，一起提交到OfficeServer中，可用于实现全文检索功能，对WORD的TEXT内容进行检索
    if (webform.WebOffice.WebSendMessage()){                    //交互OfficeServer的OPTION="SENDMESSAGE"
      webform.WebOffice.Alert("导出文本成功");
    }
    StatusMsg(webform.WebOffice.Status);
}


//作用：获取文档页数
function WebDocumentPageCount(){
  var intPageTotal = webform.WebOffice.WebObject.Application.ActiveDocument.BuiltInDocumentProperties(14);
  webform.WebOffice.Alert("文档页总数："+intPageTotal);
}

//作用：获取文档字节大小
function WebLocalFileSize(){
  var intPageTotal = webform.WebOffice.WebLocalFileSize();
  webform.WebOffice.Alert("文档字节大小："+intPageTotal);
}

//作用：签章锁定文件功能
function WebSignatureAtReadonly(){
  webform.WebOffice.WebSetProtect(false,"");                  //解除文档保护
  webform.WebOffice.WebSetRevision(false,false,false,false);  //设置文档痕迹保留的状态  参数1:不显示痕迹  参数2:不保留痕迹  参数3:不打印时有痕迹  参数4:不显痕迹处理工具
  try{
    webform.WebOffice.WebOpenSignature();                     //交互OfficeServer的 A签章列表OPTION="LOADMARKLIST"    B签章调出OPTION="LOADMARKIMAGE"    C确定签章OPTION="SAVESIGNATURE"    <参考技术文档>    文档中要定义标签Manager，可以自行修改标签名称
    StatusMsg(webform.WebOffice.Status);
  }catch(e){webform.WebOffice.Alert(e.description);}
  webform.WebOffice.WebSetProtect(true,"");                   //锁定文档
}

//作用：客户端和服务器端信息信息交互
function WebSendInformation(){
  var info = window.prompt("请输入要传到服务器处理页面上的内容:","参数内容");
  if (info==null){return false}

  webform.WebOffice.WebSetMsgByName("COMMAND","SELFINFO");		//设置变量COMMAND="SELFINFO"，用来在服务器端做判断，以进入处理自定义参数传递的代码。
  webform.WebOffice.WebSetMsgByName("TESTINFO",info);			//自定义的一个参数"TESTINFO"，将info变量的信息设置到信息包中，以便传到后台。
  if (webform.WebOffice.WebSendMessage()){						//向后台发信息包。交互OfficeServer的OPTION="SENDMESSAGE"。
    info = webform.WebOffice.WebGetMsgByName("RETURNINFO");		//如果交互成功，接受服务器端返回的信息。
	webform.WebOffice.Alert(info);
  }
  else{
    StatusMsg(webform.WebOffice.Status);
  }
}

//判断编辑器
function GetEditer(){
  if(webform.WebOffice.WebApplication(".doc")){     //WORD
    webform.WebOffice.Alert("存在WORD编辑器");
  }
  if(webform.WebOffice.WebApplication(".xls")){     //EXCEL
    webform.WebOffice.Alert("存在EXCEL编辑器");
  }
  if(webform.WebOffice.WebApplication(".wps")){     //金山WPS
    webform.WebOffice.Alert("存在WPS编辑器");
  }
  if(webform.WebOffice.WebApplication(".et")){      //金山表格
    webform.WebOffice.Alert("存在ET编辑器");
  }
  //参数还可以是".ppt"、".vso"......
}

//设置OFFICE2007的选项卡显示
function WebSetRibbonUIXML(){
	//webform.WebOffice.Alert("1111");
  webform.WebOffice.RibbonUIXML = '' +
  '<customUI xmlns="http://schemas.microsoft.com/office/2009/07/customui">' +
  '  <ribbon startFromScratch="false">'+                    //不显示所有选项卡控制 false显示选项卡；true不显示选项卡
  '    <tabs>'+
  '      <tab idMso="TabReviewWord" visible="false">' +     //关闭视图工具栏
  '      </tab>'+
  '      <tab idMso="TabInsert" visible="false">' +         //关闭插入工具栏
  '      </tab>'+
  '      <tab idMso="TabHome" visible="false">' +           //关闭开始工具栏
  '      </tab>'+
  '    </tabs>' +
  '  </ribbon>' +
  '</customUI>';

/*
    最常用的内置选项卡名称
    选项卡名称      idMso（Excel）      idMso（Word）       idMso（Access）
    开始            TabHome             TabHome             TabHomeAccess
    插入            TabInsert           TabInsert           （none）
    页面布局        TabPageLayoutExcel  TabPageLayoutWord   （none）
    公式            TabFormulas         （none）            （none）
    数据            TabData             （none）            （none）
    视图            TabReview           TabReviewWord       （none）
    创建            （none）            （none）            TabCreate
    外部数据        （none）            （none）            TabExternalData
    数据库工具      （none）            （none）            TabDatabaseTools
*/

/*
    iWebOffice控件的RibbonUIXML属性，是基于OFFICE2007的RibbonX的应用。关于RibbonX的相关资料，需要自己另行查询。
*/
//webform.WebOffice.Alert("22222");
}

//读取注册表（十进制）
function WebReadRegString(){
  try{
    webform.WebOffice.WebOpenKey('HKEY_CURRENT_USER', 'Software\\Microsoft\\Office\\12.0\\Common\\Toolbars');    //打开注册表
    var Content = webform.WebOffice.WebReadString('AddNewString');                                          //读取注册表
    webform.WebOffice.WebCloseKey();                                                                        //关闭注册表
    webform.WebOffice.Alert(Content);
  }
  catch(e){
    webform.WebOffice.Alert(e.description);
    webform.WebOffice.WebCloseKey();
  } 
} 

//写入注册表（十进制）
function WebWriteRegString(){
  try{
    webform.WebOffice.WebOpenKey('HKEY_CURRENT_USER', 'Software\\Microsoft\\Office\\12.0\\Common\\Toolbars');    //打开注册表
    var result = webform.WebOffice.WebWriteString('AddNewString','1234');                                   //写入注册表
    webform.WebOffice.WebCloseKey();                                                                        //关闭注册表
    if (result) {
      webform.WebOffice.Alert("写入注册表成功！");
    }else{
      webform.WebOffice.Alert("写入注册表失败！");
    }
  }
  catch(e){
    webform.WebOffice.Alert("写入注册表失败！原因："+e.description);
    webform.WebOffice.WebCloseKey();
  } 
} 

//读取注册表（十六进制）
function WebReadRegInteger(){
  try{
    webform.WebOffice.WebOpenKey('HKEY_CURRENT_USER', 'Software\\Microsoft\\Office\\12.0\\Common\\Toolbars');    //打开注册表
    var Content = webform.WebOffice.WebReadInteger('AddNewInteger');                                        //读取注册表
    webform.WebOffice.WebCloseKey();                                                                        //关闭注册表
    webform.WebOffice.Alert(Content);
  }
  catch(e){
    webform.WebOffice.Alert(e.description);
    webform.WebOffice.WebCloseKey();
  } 
}

//写入注册表（十六进制）
function WebWriteRegInteger(){
  try{
    webform.WebOffice.WebOpenKey('HKEY_CURRENT_USER', 'Software\\Microsoft\\Office\\12.0\\Common\\Toolbars');    //打开注册表
    var result = webform.WebOffice.WebWriteInteger('AddNewInteger',5678);                                   //写入注册表
    webform.WebOffice.WebCloseKey();                                                                        //关闭注册表
    if (result) {
      webform.WebOffice.Alert("写入注册表成功！");
    }else{
      webform.WebOffice.Alert("写入注册表失败！");
    }
  }
  catch(e){
    webform.WebOffice.Alert(e.description);
    webform.WebOffice.WebCloseKey();
  } 
} 

//接受文档中全部痕迹
function WebAcceptAllRevisions(){
  webform.WebOffice.WebObject.Application.ActiveDocument.AcceptAllRevisions();
  var mCount = webform.WebOffice.WebObject.Application.ActiveDocument.Revisions.Count;
  if(mCount>0){
    return false;
  }else{
    return true;
  }
}

//打开的服务器上的文档并修复
function WebOpenAndRepair(){
  webform.WebOffice.WebRepairMode = true;   //打开修复模式
  webform.WebOffice.WebOpen();              //重调刚才打开的服务器上的文档
  StatusMsg(webform.WebOffice.Status);
  webform.WebOffice.WebRepairMode = false;  //关闭修复模式
}

//打开本机上的文档并修复
function WebOpenLocalAndRepair(){
  webform.WebOffice.WebRepairMode = true;   //打开修复模式
  webform.WebOffice.WebOpenLocal();         //打开本机上的文档
  StatusMsg(webform.WebOffice.Status);
  webform.WebOffice.WebRepairMode = false;  //关闭修复模式
}

//调用iWebOffice2015控件属性获取控件版本号
function Get2015Version(){
	//webform.WebOffice.Alert(WebOffice);
	webform.WebOffice.Alert(WebOffice.Version);
	//webform.WebOffice.Alert(webform.WebLocalFileSize);
}
//显示或隐藏自定义工具栏
function ShowCustomToolbar(){
	WebOffice.Style.ShowCustomToolbar = !WebOffice.Style.ShowCustomToolbar;
}

function OnReady(){
 //获取iWebOffice2015控件对象，WebOffice.FuncExtModule是iWebOffice2015控件扩展接口对象
	WebOffice = document.getElementById('WebOffice2015');
	setTimeout(function(){Load();}, 500); //需要做一个延时，iWebOffice2015才能获取FuncExtModule扩展接口对象
}
//菜单栏按纽点击事件
function OnCommand(ID, Caption, bCancel)
{
	if (ID==1 || ID==101){  
    WebOpenLocal();     //打开本地文件
  }
  if (ID==2 || ID==102){  
    WebSaveLocal();     //保存本地文件
  }
  if (ID==3 || ID==103){
    SaveDocument();     //保存正文到服务器上（不退出）
  }
  if (ID==5 || ID==201){  
    WebOpenSignature(); //签名印章
  }
  if (ID==6 || ID==202){  
    WebShowSignature(); //验证签章
  }
  if (ID==8 || ID==301){  
    WebSaveVersion();   //保存版本
  }
  if (ID==9 || ID==302){  
    WebOpenVersion();   //打开版本
  }
  if (ID==11 || ID==104){
    SaveDocument();     //保存正文到服务器上
    webform.submit();   //然后退出
  }
  if (ID==13 || ID==501){  
    WebOpenPrint();     //打印文档
  }
}

</script>
</head>
<body bgcolor="#ffffff"  onUnload="UnLoad()">  <!--引导和退出iWebOffice-->
  <form name="webform" method="post" action="DocumentSave.jsp" onSubmit="return SaveDocument();">  <!--保存iWebOffice后提交表单信息-->
    <input type="hidden" name="RecordID" value="<%=mRecordID%>">
    <input type="hidden" name="Template" value="<%=mTemplate%>">
    <input id="FileType" type="hidden" name="FileType" value="<%=mFileType%>">
    <input type="hidden" name="EditType" value="<%=mEditType%>">
    <input type="hidden" name="HTMLPath" value="<%=mHTMLPath%>">
    <table border=0 cellspacing='0' cellpadding='0' width=100% height=100% align=center class=TBStyle>
      <tr>
        <td height="24" align=center class="TDTitleStyle">主　题</td>
        <td class="TDStyle">&nbsp;<input type="text" name="Subject" value="<%=mSubject%>" class="IptStyle" onBlur="SetBookmarks('Caption',this.value);" style="WIDTH:75%" title="此处有一个自动设置标签的功能：输入“主题”内容光标移开后，文档中“Caption”标签处内容会自动修改。">&nbsp;|←请输入主题</td>
        <td width="400" rowspan="4" class="TDTitleStyle" align="center"><input type="submit"  value="保存文档">&nbsp;<input type=button onClick="history.back()" value="返回列表"><br><br>注意：只有进行“保存文档”后，所做的操作才有效！</td>
      </tr>
      <tr>
        <td height="24" align=center class="TDTitleStyle">作　者</td>
        <td class="TDStyle">&nbsp;<input type=text name=Author value="<%=mAuthor%>" class="IptStyle"  style="WIDTH:75%">&nbsp;|←请输入作者</td>
      </tr>
      <tr>
        <td height="24" align=center class="TDTitleStyle">时　间</td>
        <td class="TDStyle">&nbsp;<input type=text name=FileDate value="<%=mFileDate%>" readonly class="IptStyleBlack" style="WIDTH:75%">&nbsp;|←编辑时间</td>
      </tr>
      <tr>
        <td height="24" align=center class="TDTitleStyle">状　态</td>
        <td class="TDStyle">&nbsp;<input type=text name=StatusBar readonly class="IptStyleBlack" style="WIDTH:75%">&nbsp;|←状态信息</td>
      </tr>
      <tr width="100" height="28">
        <td align="center" class="TDTitleMiddleStyle">
          <font color="#FF0000"><b>↓功能列表↓</b></font>
	    </td>
        <td  id = "OfficeDiv" height="100%" colspan="2" rowspan="12" align="right" valign="top" class="TDStyle" hegith="90%" style="height: 90%">
          <table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
            <tr>
              <td height="98%" valign="top">
                <!--调用iWebPicture，注意版本号，可用于升级-->
			    <script src="iWebOffice2015.js"></script>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr width="100">
        <td align="center" valign=top class="TDTitleStyle" width="100" height="90%">
		  <input type=button class=SideButton value="设置皮肤" onclick='WebSetSkin(0xfdd6e5, 0xfdd8e6, 0xfdd8e6, 0xfdd6e5, 0xfdd6e5, 0xfdd6e5, 0x000000)'>
          <input type=button class=SideButton value="文档核稿" onclick='webform.WebOffice.ShowType=0;'>
          <input type=button class=SideButton value="新建文件" onclick='webform.WebOffice.CreateFile();'>
          <input type=button class=SideButton value="全屏显示" onclick='webform.WebOffice.FullSize();'>
          <input type=button class=SideButton value="关闭工具栏" onClick="webform.WebOffice.ShowToolBar=0">
          <input type=button class=SideButton value="打开工具栏" onClick="webform.WebOffice.ShowToolBar=1">
          <input type=button class=SideButton value="显示版本" onClick="webform.WebOffice.Alert('当前控件版本为：'+webform.WebOffice.VersionEx()+webform.WebOffice.Version());">
		  <input type=button class=SideButton value="显示版本" onClick="Get2015Version()">
		  <input type=button class=SideButton value="显示或隐藏工具栏" onClick="ShowCustomToolbar()">
	    </td>
      </tr>
      <tr width="100">
        <td align="center" class="TDTitleMiddleStyle" height="28">
          <font color="#FF0000"><b>↓普通功能↓</b></font>
	    </td>
      </tr>
      <tr width="100">
        <td align="center" valign=top class="TDTitleStyle" width="100">
          <input type=button class=SideButton value="显示痕迹"   onClick="ShowRevision(true)">
          <input type=button class=SideButton value="隐藏痕迹" <%=mDisabled%> <%=mWord%> onClick="ShowRevision(false)">
          <input type=button class=SideButton value="获取痕迹"  onClick="WebGetRevisions()">
          <input type=button class=SideButton value="清除痕迹" <%=mDisabled%> <%=mWord%> onClick="WebAcceptAllRevisions()">
          <input type=button class=SideButton value="保护文档" <%=mDisabled%> onClick="WebProtect(true)">
          <input type=button class=SideButton value="解除保护" <%=mDisabled%> onClick="WebProtect(false)">
          <input type=button class=SideButton value="允许拷贝" <%=mDisabled%> onClick="WebEnableCopy(true)">
          <input type=button class=SideButton value="禁止拷贝" <%=mDisabled%> onClick="WebEnableCopy(false)">
          <input type=button class=SideButton value="页面设置" <%=mDisabled%> <%=mWord%> onClick="WebOpenPageSetup()">
          <input type=button class=SideButton value="打印文档" <%=mDisabled%> <%=mWord%> onClick="WebOpenPrint()">
          <input type=button class=SideButton value="插入图片" <%=mDisabled%> <%=mWord%> onClick="WebOpenPicture()">
          <input type=button class=SideButton value="重调文档" <%=mDisabled%> <%=mWord%> onClick="LoadDocument()">
          <input type=button class=SideButton value="刷新文档" <%=mDisabled%> <%=mWord%> onClick="WebReFresh()">
          <input type=button class=SideButton value="打开本地文件" <%=mDisabled%> onClick="WebOpenLocal()">
          <input type=button class=SideButton value="存为本地文件" <%=mDisabled%> onClick="WebSaveLocal()">
          <input type=button class=SideButton value="判断编辑器" onClick="GetEditer()">
          <input type=button class=SideButton value="写入注册表" onClick="WebWriteRegString()">
          <input type=button class=SideButton value="读取注册表" onClick="WebReadRegString()">
          <input type=button class=SideButton value="写入注册表16" onClick="WebWriteRegInteger()">
          <input type=button class=SideButton value="读取注册表16" onClick="WebReadRegInteger()">
	    </td>
      </tr>
      <tr width="100">
        <td align="center" class="TDTitleMiddleStyle" height="28">
          <font color="#FF0000"><b>↓交互功能↓</b></font>
	    </td>
      </tr>
      <tr width="100">
        <td align="center" valign=top class="TDTitleStyle" width="100">
          <input type=button class=SideButton value="签名印章" <%=mDisabled%> onClick="WebOpenSignature()">
          <input type=button class=SideButton value="签章锁定文件" <%=mDisabled%>  onclick="WebSignatureAtReadonly();">
          <input type=button class=SideButton value="验证签章[A]" <%=mDisabled%>  onclick="WebShowSignature()">
          <input type=button class=SideButton value="验证签章[B]" <%=mDisabled%>  onclick="WebCheckSignature()">
          <input type=button class=SideButton value="印章彩色" onClick="webform.WebOffice.SignatureColor(true);">
          <input type=button class=SideButton value="印章黑白" onClick="webform.WebOffice.SignatureColor(false);">
          <input type=button class=SideButton value="打开标签" <%=mDisabled%>  <%=mWord%>  onclick="WebOpenBookMarks()">
		  <input type=button class=SideButton value="书签保存" <%=mDisabled%>  <%=mWord%>  onclick="WebSaveBookMarks()">
          <input type=button class=SideButton value="填充模版标签" <%=mDisabled%>  <%=mWord%>  onclick="LoadBookmarks()">
          <input type=button class=SideButton value="保存版本" <%=mDisabled%>  onclick="WebSaveVersion()">
          <input type=button class=SideButton value="打开版本" <%=mDisabled%>  onclick="WebOpenVersion()">
          <input type=button class=SideButton value="保存当前版本" <%=mDisabled%>  onclick="WebSaveVersionByFileID()">
          <input type=button class=SideButton value="保存定稿版本" <%=mDisabled%>  onclick="WebUpdateFile()">
          <input type=button class=SideButton value="存为HTML" <%=mDisabled%>  onclick="WebSaveAsHtml()">
          <input type=button class=SideButton value="存为HTML图片" <%=mDisabled%>  <%=mWord%>  onclick="WebSaveAsPage()">
          <input type=button class=SideButton value="模版套红" <%=mDisabled%>  <%=mWord%> onClick="WebUseTemplate()">
          <input type=button class=SideButton value="VBA套红定稿" <%=mDisabled%>  <%=mWord%>  onclick="WebInsertVBA();">
          <input type=button class=SideButton value="打印控制管理" <%=mDisabled%> <%=mWord%>  onClick="WebCopysCtrlPrint()">
          <input type=button class=SideButton value="导入数据内容" <%=mDisabled%>  <%=mWord%>  onclick="WebInportText();">
          <input type=button class=SideButton value="导出文档内容" <%=mDisabled%>  <%=mWord%>  onclick="WebExportText();">
          <input type=button class=SideButton value="插入远程表格" <%=mDisabled%>  <%=mWord%>  onclick="WebSetWordTable()">
          <input type=button class=SideButton value="插入远程图片" <%=mDisabled%>  <%=mWord%>  onclick="WebInsertImage()">
          <input type=button class=SideButton value="下载服务器文件" <%=mDisabled%> <%=mWord%> onClick="WebGetFile()">
          <input type=button class=SideButton value="上传文件到服务器" <%=mDisabled%> <%=mWord%> onClick="WebPutFile()">
          <input type=button class=SideButton value="打开远程文件"  <%=mDisabled%> <%=mWord%>  onclick="WebDownLoadFile()">
          <input type=button class=SideButton value="设置本地时间"  <%=mDisabled%>  onclick="WebDateTime()">
          <input type=button class=SideButton value="信息传递"  <%=mDisabled%>  onclick="WebSendInformation()">
    	</td>
      </tr>
      <tr width="100">
        <td align="center" class="TDTitleMiddleStyle" height="28">
          <font color="#FF0000"><b>↓VBA调用↓</b></font>
    	</td>
      </tr>
      <tr width="100">
        <td align="center" valign=top class="TDTitleStyle" width="100">
          <input type=button class=SideButton value="取Word内容" <%=mDisabled%>  <%=mWord%>  onclick="WebGetWordContent()">
      <input type=button class=SideButton value="写Word内容" <%=mDisabled%>  <%=mWord%>  onclick="WebSetWordContent()">
          <input type=button class=SideButton value="WORD禁止拖动" <%=mDisabled%> <%=mWord%> onClick="webform.WebOffice.WebObject.Application.Options.AllowDragAndDrop=false;">  <!--false禁止拖动  true允许拖动-->
          <input type=button class=SideButton value="打印黑白" <%=mDisabled%> <%=mWord%> onClick="WebWordPrintBlackAndWhile();">
          <input type=button class=SideButton value="插入页眉" <%=mDisabled%> <%=mWord%> onClick="webform.WebOffice.WebObject.ActiveWindow.ActivePane.View.SeekView=9;">
          <input type=button class=SideButton value="插入页码" <%=mDisabled%> <%=mWord%> onClick="webform.WebOffice.WebObject.Application.Dialogs(294).Show();">
          <input type=button class=SideButton value="用Excel求和" <%=mDisabled%>  <%=mExcel%> onClick="WebGetExcelContent()">
          <input type=button class=SideButton value="锁定工作表" <%=mDisabled%>   <%=mExcel%> onClick="WebSheetsLock()">
          <input type=button class=SideButton value="EXCEL禁止拖动" <%=mDisabled%> <%=mExcel%> onClick="webform.WebOffice.WebObject.Application.CellDragAndDrop=false;">  <!--false禁止拖动  true允许拖动-->
          <input type=button class=SideButton value="文档页数" <%=mDisabled%>  <%=mWord%>  onclick="WebDocumentPageCount()">
		  <input type=button class=SideButton value="文档字节数" onclick="WebLocalFileSize()">
      </tr>
      <tr width="100">
        <td align="center" class="TDTitleMiddleStyle" height="28">
          <font color="#FF0000"><b>↓工具栏控制↓</b></font>
	    </td>
      </tr>
      <tr width="100">
        <td align="center" valign=top class="TDTitleStyle" width="100">      
          <input type=button class=SideButton value="关闭常用工具" <%=mDisabled%>  onclick="WebToolsVisible('Standard',false)">
          <input type=button class=SideButton value="打开常用工具" <%=mDisabled%>  onclick="WebToolsVisible('Standard',true)">
          <input type=button class=SideButton value="关闭格式工具" <%=mDisabled%>  onclick="WebToolsVisible('Formatting',false)">
          <input type=button class=SideButton value="打开格式工具" <%=mDisabled%>  onclick="WebToolsVisible('Formatting',true)">
          <input type=button class=SideButton value="关闭打印按钮" <%=mDisabled%>  onclick="WebToolsEnable('Standard',2521,false);">
          <input type=button class=SideButton value="打开打印按钮" <%=mDisabled%>  onclick="WebToolsEnable('Standard',2521,true);">
          <input type=button class=SideButton value="关闭文档" <%=mDisabled%>  onclick="webform.WebOffice.WebClose();">
      </tr>
      <tr width="100">
        <td align="center" class="TDTitleMiddleStyle" height="28">
          <font color="#FF0000"><b>↓其他调用↓</b></font>
	    </td>
      </tr>
    </table>
  </form>
</body>
</html>