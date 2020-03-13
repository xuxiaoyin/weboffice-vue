<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,DBstep.iDBManager2000.*" %>
<%!
DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();

//�г�����ģ��
public String GetTemplateList(String ObjType, String FileType)
  {
    String mTemplateList,mstr="";
    mTemplateList = "<select name=" + ObjType + " >";
    mTemplateList = mTemplateList +  "<option value=''>--------����ģ��--------</option>";
    String Sql = "select RecordID,Descript from Template_File where FileType='" + FileType + "'"; //�����ݿ�
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          mstr="selected";
          while (result.next()) {
            mTemplateList = mTemplateList + "<option value='" + result.getString("RecordID") + "'"+mstr+">" + result.getString("Descript") + "</option>";
          }
          result.close();
        }
        catch (SQLException sqlex) {
          System.out.println(sqlex.toString());
        }
      }
      else {
        System.out.println("GetTemplateList: OpenDatabase Error");
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
    mTemplateList = mTemplateList + "</select>";
    return (mTemplateList);
  }

  /**
   * ���ܻ����ã���ʽ������ʱ��
   * @param DateValue �������ڻ�ʱ��
   * @param DateType ��ʽ�� EEEE������, yyyy����, MM����, dd����, HH��Сʱ, mm�Ƿ���,  ss����
   * @return ����ַ���
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>WebOffice 2003��2009������iWebOffice2015ʾ��</title>
<link rel='stylesheet' type='text/css' href='test.css'>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="renderer" content="webkit" />
<script language="javascript">
 	function NewOpenWord(){
		//alert("newopenword");
 		var userName = document.getElementById("username").value;
		//alert(doc.value);
 		location.href = 'DocumentEdit.jsp?FileType=.doc&UserName=' + userName + '&Template=';
		
		//alert(location.href);
 	}
	
	function NewOpenWordDocx(){
		
 		var userName = document.getElementById("username").value;
 		location.href = 'DocumentEdit.jsp?FileType=.docx&UserName=' + userName + '&Template=';
		//alert(doc.value);
 	}
 	
 	function NewOpenExcel(){
 		var userName = document.getElementById("username").value;
 		location.href = 'DocumentEdit.jsp?FileType=.xls&UserName=' + userName + '&Template=';
 	}
 	
 	function NewOpenWPS(){
 		var userName = document.getElementById("username").value;
 		location.href = 'DocumentEdit.jsp?FileType=.wps&UserName=' + userName + '&Template=';
 	}
 	
 	function NewOpenET(){
 		var userName = document.getElementById("username").value;
 		location.href = 'DocumentEdit.jsp?FileType=.et&UserName=' + userName + '&Template=';
 	}
 	
 	function NewOpenET(){
 		var userName = document.getElementById("username").value;
 		location.href = 'DocumentEdit.jsp?FileType=.et&UserName=' + userName + '&Template=';
 	}
 	
 	function NewOpenPPT(){
 		var userName = document.getElementById("username").value;
 		location.href = 'DocumentEdit.jsp?FileType=.ppt&UserName=' + userName + '&Template=';
 	}
 	
 	function NewOpenVSD(){
 		var userName = document.getElementById("username").value;
 		location.href = 'DocumentEdit.jsp?FileType=.vsd&UserName=' + userName + '&Template=';
 	}
 </script>
</head>
<body bgcolor="#ffffff">
<div align="center"><font size=4 color=ff0000>WebOffice 2003��2009������iWebOffice2015ʾ��</font></div>
<br>
<table width="100%"><tr><td height="22"><script src="iWebOffice2015.js"></script></td></tr></table>
<hr size=1>

<table border=0  cellspacing='0' cellpadding='0' width=100% align=center class=TBStyle>
<tr>
  <td rowspan="2" nowrap class="TDTitleStyle" style="line-height:20px; padding-left:10px;">
    <p style="color:#000000">����ע�⣺<br>
      ����ʽ���ʵ�ָ�ǿ��Ĺ��ܣ���Ҫ��ʽ��������Ƽ���ϵ��0791-82221588����<br>
      �����ϣ����ȷ��ʾ��ʾ��������Ҫ��������������<br>
      ��1����ʹ��Windows XP���ϲ���ϵͳ��OFFICE2003���ϵı༭�����IE8���ϵ��������<br>
      ��2�����ڴ򿪱�ҳ�浯����װ����Ĵ���ʱѡ�񡾰�װ����ť������������װiWebOffice2015�����<br>
      ��3��������������Զ���װiWebOffice2015���������������<a href="../iWebOffice2015.msi">���ذ�װ����</a>��<br/>
      <font color=red>&nbsp4��Ĭ������MySql���ݿ⣬�����Ҫ�������ݿ⣬���޸�iDBManager2000.java���ö�Ӧ���ݿ⡣</font><br/>
	  </p>
    <p>��ǰ�༭�û���
      <input type=text id="username" name=username size=8 value="��ʾ��">
      �����ã��༭����ʱ��ͬ�û������ۼ���ɫ�᲻ͬ���������޸��ĵ�ǰ�������ݡ�<br> 
        </p></td>
  <td class="TDTitleStyle" align="center" width="550">
    &nbsp;<input type=button name="BookMark" value="��ǩ����"  onclick="javascript:location.href='BookMark/BookMarkList.jsp'">
     &nbsp;<input type=button name="Template" value="ģ�����"  onclick="javascript:location.href='Template/TemplateList.jsp'">
     &nbsp;<input type=button name="Template" value="ǩ�¹���"  onclick="javascript:location.href='Signature/SignatureList.jsp'">&nbsp;  </td>
</tr>
<tr>
  <td colspan=4 class="TDTitleStyle" align="center" style="line-height:28px;">
    ��ѡ��ģ�棺<%=GetTemplateList("doc",".doc")%>
    <input type=button value="�½�word�ĵ�  "  onclick="NewOpenWord();">
    <br>
	��ѡ��ģ�棺<%=GetTemplateList("docx",".docx")%>
    <input type=button value="�½�Docx�ĵ�  "  onclick="NewOpenWordDocx();">
    <br>
    ��ѡ��ģ�棺<%=GetTemplateList("xls",".xls")%>
    <input type=button value="�½�excel�ĵ� "  onclick="NewOpenExcel();">
    <br>
	��ѡ��ģ�棺<%=GetTemplateList("xlsx",".xlsx")%>
    <input type=button value="�½�xlsx�ĵ� "  onclick="NewOpenExcel();">
    <br>
    ��ѡ��ģ�棺<%=GetTemplateList("wps",".wps")%>
    <input type=button value="�½�wps�ĵ�   "  onclick="NewOpenWPS();">
    <br>
    ��ѡ��ģ�棺<%=GetTemplateList("et",".et")%>
    <input type=button value="�½���ɽ���  "  onclick="NewOpenET();">
    <br>
    ��ѡ��ģ�棺<%=GetTemplateList("ppt",".ppt")%>
    <input type=button value="�½�ppt�ĵ�   "  onclick="NewOpenPPT();">
    <br>
    ��ѡ��ģ�棺<%=GetTemplateList("vsd",".vsd")%>
    <input type=button value="�½�visio�ĵ� "  onclick="NewOpenVSD();">
  </td>
</tr>
</table>
<br>

<table border=0  cellspacing='0' cellpadding='0' width=100% align=center class=TBStyle>
<tr>
  <td nowrap align=center class="TDTitleStyle" height="25">���</td>
  <td nowrap align=center class="TDTitleStyle">����</td>
  <td nowrap align=center class="TDTitleStyle">����</td>
  <td nowrap align=center class="TDTitleStyle">����</td>
  <td nowrap align=center class="TDTitleStyle">����</td>
  <td nowrap align=center class="TDTitleStyle">����</td>
</tr>
<%
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery("select Status,RecordID,HtmlPath,DocumentID,Subject,Author,FileType,FileDate from Document order by DocumentID desc");
          while (result.next()) {
            String RecordID = result.getString("RecordID");
            String HTMLPath = result.getString("HtmlPath");
            if (HTMLPath == null)
               HTMLPath = "";
%>
<tr>
  <td align=center class="TDStyle" width="80"><%=result.getString("DocumentID")%>&nbsp;</td>
  <td align=center class="TDStyle"><%=result.getString("Subject")%>&nbsp;</td>
  <td align=center class="TDStyle" width="100"><%=result.getString("Author")%>&nbsp;</td>
  <td align=center class="TDStyle" width="100"><%=result.getString("FileType")%>&nbsp;</td>
  <td align=center class="TDStyle" width="100"><%=FormatDate(result.getString("FileDate"),"yyyy-MM-dd")%>&nbsp;</td>
  <td align=center class="TDStyle" nowrap width="480">
    <input type=button onClick="javascript:location.href='DocumentEdit.jsp?RecordID=<%=RecordID%>&EditType=0,0&ShowType=1&UserName='+username.value;" value="�Ķ�">
    <input type=button onClick="javascript:location.href='DocumentEdit.jsp?RecordID=<%=RecordID%>&EditType=1,1&ShowType=1&UserName='+username.value;" value="�޸�[�޺ۼ�]">
    <input type=button onClick="javascript:location.href='DocumentEdit.jsp?RecordID=<%=RecordID%>&EditType=2,1&ShowType=1&UserName='+username.value;" value="�޸�[�кۼ�]">
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
</table>
</body>
</html>