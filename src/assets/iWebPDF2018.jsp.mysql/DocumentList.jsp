<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,DBstep.iDBManager2000.*" %>
<%!
DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
  /**
   * 功能或作用：格式化日期时间
   * @param DateValue 输入日期或时间
   * @param DateType 格式化 EEEE是星期, yyyy是年, MM是月, dd是日, HH是小时, mm是分钟,  ss是秒
   * @return 输出字符串
   */
  public String FormatDate(String DateValue,String DateType)
  {
    String Result;
    SimpleDateFormat formatter = new SimpleDateFormat(DateType);
    try{
      Date mDateTime = formatter.parse(DateValue);
      Result = formatter.format(mDateTime);
    }catch(Exception ex){
      Result = ex.getMessage();
    }
    if (Result.equalsIgnoreCase("1900-01-01")){
      Result = "";
    }
    return Result;
  }
%>
<%
  SimpleDateFormat f1 = new SimpleDateFormat("yyyyMMddHHmm");
  SimpleDateFormat f2 = new SimpleDateFormat("ss");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>金格科技-iWebPDF2018在线管理中间件示例程序</title>
 <meta http-equiv="X-UA-Compatible" content="IE=8">
 <link rel='stylesheet' type='text/css' href='css/iWebProduct.css' />
 <script language="javascript">
  function CheckActiveX(){ 
    var mObject=true;
    try{
      var newAct = iWebPDF2018.Documents;
      if(newAct == undefined ){
       mObject=false;
      }
    }catch(e){
      mObject=false;
    }
    newAct = null;
    if(mObject){
	  activex_install.innerHTML = "已经安装iWebPDF2018中间件！";
	  activex_install.style.color="#FFFFFF";
    }else{
      //控件无法加载
      activex_install.innerHTML = "请注意，未检测到iWebPDF2018中间件！请查看说明，并按说明的要求检查您使用的环境。";
	  activex_install.style.color="#FF0000";
    } 
    return mObject; 
  }

  function init(){
    document.getElementById('showtr').style.height = getHeight('maintable')- 130 +"px";
    document.getElementById('showlist').style.height = getHeight('showtr')- 200  +"px";
    document.getElementById('showlist').style.width = document.getElementById('titleTable').offsetWidth;
  }
  //获取id的高度
  function  getHeight(id){
    return document.getElementById(id).offsetHeight; 
  }
  
  function ShowExplain(){
    window.showModalDialog("UserExplain.html",window,"dialogWidth=780px;dialogHeight=300px");  
  }
  
  
  function ShowNewPage(){
	var uName=document.getElementById("username").value;
	var sJect=document.getElementById("subject").value;
	window.location.href='DocumentEdit.jsp?UserName='+encodeURI(encodeURI(uName))+'&Subject='+encodeURI(encodeURI(sJect));
  }
  
  function showEdit(rId,subj,uName){
	window.location.href='DocumentEdit.jsp?UserName='+encodeURI(encodeURI(uName))+'&Subject='+encodeURI(encodeURI(subj))+'&RecordID='+encodeURI(encodeURI(rId));
  }
 </script>
</head>
<body onload="init()" onresize="init()" style="overflow-y:hidden;overflow-x:hidden">
<table id="maintable"  cellspacing='0' cellpadding='0' >
 <!-- head -->
 <tr><td valign="top" height="61px"><table cellspacing='0' cellpadding='0' cellspacing='0' cellpadding='0'  id="header"><tr ><td ><img src="css/logo.jpg"/></td><td><span>　iWebPDF2018</span> 在线管理中间件示例程序</td></tr></table></td></tr> 
 <tr><td height="34px" class="title" ><span id="activex_install" style="color: #FF0000">请注意，未检测到iWebPDF2018中间件！请查看说明，并按说明的要求检查您使用的环境。</span> 
    <a href="#" onclick="ShowExplain()">[说明]</a>
    <div id="obj" style="display:none">
		<table width="100%"><tr><td id="addPDF" height="22"><script src="js/iWebPDF2018.js"></script>
		</td></tr></table>
   </div>
    
 </td></tr> 
 <!-- end head -->
 
 <!-- showList -->
 <tr><td id="showtr" >
  <table><tr><td valign="top" align="center" >
    <img id="loading" src="css/load.gif" alt="" />
    <div style="display: none;" id="loaded">
    <table id="innerTable" border=0  cellspacing='0' cellpadding='0'>
     <tr>
       <td align="left" style="border: 0" height="50px" colspan="6">
	       <span>请输入主题：<input type=text id="subject" value="PDF演示主题<%=f1.format(new Date()) %>" class="InputLine" /></span>
	       <span style="padding-left: 30px;">当前编辑用户：<input type=text id="username" size=20 value="体验用户<%=f2.format(new Date())  %>" class="InputLine" /></span>
       </td>
       <td style="border: 0"><a href="#" onclick="ShowNewPage()">新建文档</a></td>
     </tr>   
    </table>
   <table id="titleTable" cellspacing='0' cellpadding='0' align="center"  style="height: 42px;">
	 <tr>
	  <td width="60px">编号</td>
	  <td >主题</td>
	  <td width="100px">作者</td>
	  <td width="100px">类型</td>
	  <td width="190px">保存时间</td>
	  <td width="250px">操作</td>
	
	</tr> 
   </table>
   <div id="showlist" style="vertical-align: top;">
	    <table align="center"  cellspacing='0' cellpadding='0' width="20px">
           <%
			  try {
			      if (DbaObj.OpenConnection()) {
			        try {
			          ResultSet result = DbaObj.ExecuteQuery("select * from Document order by DocumentID desc  limit 40");
			          int i = 1;
			          while (result.next()) {%> 		
		
			<tr>
			  <td width="60px"  class="TD<%=(i+1)%2 %>"><%=i++%></td>
			  <td class="TD<%=(i)%2%>"><%=result.getString("Subject")%></td>
			  <td width="100px" class="TD<%=(i)%2 %>"><%=result.getString("Author")%></td>
			  <td width="100px" class="TD<%=(i)%2 %>">PDF</td>
			  <td width="190px" class="TD<%=(i)%2 %>"><%=FormatDate(result.getString("FileDate"),"yyyy-MM-dd HH:mm:ss")%></td>
			  <td width="240px"  align=center class="TD<%=(i)%2 %>">
			       <a onclick='showEdit("<%=result.getString("RecordID")%>","<%=result.getString("Subject")%>","<%=result.getString("Author")%>")' >阅读</a>
			  </td>
			</tr>
		 <%
		          }
		          result.close();
		        }
		        catch (SQLException sqlex) {
		          System.out.println(sqlex.toString());
		        }
		      }
		      else {
		        out.println("OpenDatabase Error");
		      }
		    }
		    finally {
		      DbaObj.CloseConnection();
		    }
		%>	
		<tr><td style='border:none;'></td><tr>				
	  </table>
   </div>   
    </div>
 </td></tr></table>
 
 </td></tr>
 <!-- end showList -->
  
 <!-- footer -->
 <tr ><td height="30px"  class="footer"><table><tr><td align="center">江西金格科技股份有限公司 版权所有</td></tr></table></td></tr>
 <!-- end footer --> 
</table>
</body> 
</html>
<script language="javascript" type="text/javascript">
 var checkActiveX  = CheckActiveX();
 if(checkActiveX){
 document.getElementById('loading').style.display = "none";
 document.getElementById('loaded').style.display = "";
 }else{
  document.getElementById('loading').style.display = "none";
  document.getElementById('loaded').style.display = "";
 }

 
</script>