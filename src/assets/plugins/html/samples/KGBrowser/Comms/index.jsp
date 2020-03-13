<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=gb2312" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <%
    String userName="name1";
  session.setAttribute("userName",userName);
  String thisSessionID = session.getId();
  System.out.println("index.jsp --- session = " + session.getId());
  %>
 <head id="Head1">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link href="css/style.css" rel="stylesheet" type="text/css" />
     <!--PageOffice.js和jquery.min.js文件一定要引用-->
    <script type="text/javascript" src="../../../js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="../../../js/WebOffice.js"></script>
    <script type="text/javascript">	
    	var KGBrowser = new KGBrowser(); 
    </script>
    
    <script type="text/javascript">
	   function click()
	   {
	   mycookie = 'JSESSIONID=' + "<%=thisSessionID%>";
	   strOptions = '$skin=1$tabshow=1$cookie=' + mycookie;
	   		//strOptions = '$skin=1$tabshow=1$cookie=' + document.cookie;
	   		KGBrowser.openWindow('samples/KGBrowser/Comms/Word.jsp?id=' + encodeURI(encodeURI(encodeURI('中文'))),strOptions, false);
	   		//KGBrowser.openWindow('samples/KGBrowser/Comms/Word2.jsp?id=' + "中文",strOptions, false);
	   }
	  
    </script>

</head>

 <body>
    <!--content-->
    <div class="zz-content mc clearfix pd-28" align="center">
        <div class="demo mc">
            <h2 class="fs-16">
                KGBrowser传递用户数据</h2>
        </div>

         <div style="margin : 10px" align="center">
           <table   style="border-collapse:separate; border-spacing:20px; ">
             <tr>
			 <td>向KGBrowser打开的页面传递参数：<a href="javascript:click()">Word.jsp</a></td>
			 <tr>
           </table>
           
       </div>
       
    </div>
    
    <!--footer
    <div class="login-footer clearfix">
        Copyright &copy 2017 江西金格科技股份有限公司</div>
    -->
</body>
</html>
