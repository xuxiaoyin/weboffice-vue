<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,DBstep.iDBManager2000.*" %>
<html>
<head>
<title>ǩ�¹���</title>
<link rel='stylesheet' type='text/css' href='../test.css'>
<script language="javascript">
function ConfirmDel(FileUrl){
	if (confirm('�Ƿ�ȷ��ɾ����ӡǩ��')){
		location.href=FileUrl;
	}
}
</script>
</head>
<body bgcolor="#ffffff">
<div align="center"><font size=4 color="ff0000">ǩ�¹���</font></div>
<hr size=1>
<br>
<table border=0  cellspacing='0' cellpadding='0' width=100% align=center class=TBStyle>
	<tr>
		<td colspan=2 class="TDTitleStyle" nowrap>
		  <input type=button name="Add" value="����ǩ��"  onclick="javascript:location.href='SignatureAddFrm.jsp'">
		  <input type=button name="Return" value="�� ��"  onclick="javascript:location.href='../DocumentList.jsp';">
		</td>
		<td colspan=3 class="TDTitleStyle">&nbsp;</td>
	</tr>
	<tr>
		<td nowrap align=center class="TDTitleStyle" height="26">���</td>
		<td nowrap align=center class="TDTitleStyle">�û�����</td>
		<td nowrap align=center class="TDTitleStyle">ǩ������</td>
		<td nowrap align=center class="TDTitleStyle">ǩ������</td>
		<td nowrap align=center class="TDTitleStyle">����</td>
	</tr>
	<%
          DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
           if (DbaObj.OpenConnection())
           {
             try
             {
               ResultSet result=DbaObj.ExecuteQuery("select SignatureID,UserName,MarkName,MarkType from Signature order by SignatureID desc") ;
               while ( result.next() )
               {
                String mSignatureID=result.getString("SignatureID");
        %>
	<tr>
		<td class="TDStyle"><%=result.getString("SignatureID")%>&nbsp;</td>
		<td class="TDStyle"><%=result.getString("UserName")%>&nbsp;</td>
		<td class="TDStyle"><%=result.getString("MarkName")%>&nbsp;</td>
		<td class="TDStyle"><%=result.getString("MarkType")%>&nbsp;</td>
		<td class="TDStyle" width=148 nowrap>
			<input type=button onclick="javascript:location.href='SignatureEditFrm.jsp?SignatureID=<%=mSignatureID%>';" name="Edit" value=" �� �� ">
			<input type=button onclick="javascript:ConfirmDel('SignatureDel.jsp?SignatureID=<%=mSignatureID%>');" name="Del" value=" ɾ �� ">
		</td>
	</tr>
	<%
              }
          result.close() ;
             }
             catch(Exception e)
             {
               System.out.println(e.toString());
             }
             DbaObj.CloseConnection() ;
           }
           else
           {
             out.println("OpenDatabase Error") ;
           }

        %>
</table>
</body>
</html>
