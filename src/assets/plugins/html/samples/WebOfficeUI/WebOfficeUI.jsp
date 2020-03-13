<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %>
<%
  //自动获取OfficeServer和OCX文件完整URL路径
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName="OfficeServer";
  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName));//取得OfficeServer文件的完整URL
%>

<html>
<style type="text/css">
    html, body
    {
        height: 100%;
    }
    
    select::-ms-expand {
       display: none;
    }
. select {     
    appearance: none;
    padding-left: 5px;
    padding-right: 36px;
    -webkit-appearance: none;
}       
select::-ms-expand {
    display: none;
}

</style>
<style>
    html, body
    {
        height: 100%;
    }
</style>
<head>
<title>控件UI</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="renderer" content="webkit" />
<script src="../../js/WebOffice.js"></script>
<script src="../../js/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
 	var WebOfficeObj = new WebOffice2015(); //创建WebOffice对象
</script>
<script language="javascript">
	  function Load()
		{
			try
			{
			WebOfficeObj.ServerUrl = "<%=mServerUrl%>";
			WebOfficeObj.UserName = "演示人";
			WebOfficeObj.FileName = "sample.doc";
			WebOfficeObj.FileType = ".doc";            //FileType:文档类型  .doc  .xls
			WebOfficeObj.ShowWindow = false;					//显示/隐藏进度条
			WebOfficeObj.AppendMenu("1","打开本地文件");
			WebOfficeObj.AppendMenu("2","保存本地文件");
			WebOfficeObj.AppendMenu("3","新建文件");
			WebOfficeObj.AppendTools("1", "打开本地文件", png3); //添加自定义工具栏  第一个参数对应回调函数OnCommand(ID, Caption, bCancel)
			WebOfficeObj.AppendTools("2", "保存本地文件", png2);
			WebOfficeObj.AppendTools("3", "新建文件", png27);
			WebOfficeObj.EditType = "1";				//设置加载文档类型 0 锁定文档，1无痕迹模式，2带痕迹模式
			WebOfficeObj.ShowMenu = 1;
			WebOfficeObj.ShowToolBar = 0;
			WebOfficeObj.SetCaption(WebOfficeObj.UserName + "正在编辑文档");
		    SetGraySkin();
			if(WebOfficeObj.WebOpen())
		    {
			  StatusMsg(WebOfficeObj.Status);
		    }
			}
			catch(e){
 	     	WebOfficeObj.Alert(e.description);
 	    }
		}


 		//设置页面中的状态值
 		function StatusMsg(mValue){
 	   	try{
	   		document.getElementById('StatusBar').innerHTML = mValue;
	   	}catch(e){
	     	return false;
	   	}
		}
		
		//显示/隐藏自定义工具栏
		function CustomToolBarsVisibled(mValue){
			WebOfficeObj.ShowCustomToolBar(mValue);
		}
		
		
		//显示/隐藏菜单栏
		function CustomMenu(mValue){
			WebOfficeObj.ShowMenuBar(mValue);
		}
		//烟枪灰皮肤
 		function SetGraySkin(){
 			//参数顺序依次为：控件标题栏颜色、自定义菜单开始颜色、自定义工具栏按钮开始颜色、自定义工具栏按钮结束颜色、
 			//自定义工具栏按钮边框颜色、自定义工具栏开始颜色、控件标题栏文本颜色（默认值为：0x000000）
 			if (!WebOfficeObj.WebSetSkin(0xdbdbdb, 0xeaeaea, 0xeaeaea, 0xdbdbdb, 0xdbdbdb, 0xdbdbdb, 0x000000))
 				WebOfficeObj.Alert(WebOfficeObj.Status);
		}
		//皮肤颜色值为BGR格式，即：RGB中的R与B值进行互调
		//紫罗兰皮肤
 		function SetPurpleSkin(){
 			//参数顺序依次为：控件标题栏颜色、自定义菜单开始颜色、自定义工具栏按钮开始颜色、自定义工具栏按钮结束颜色、
 			//自定义工具栏按钮边框颜色、自定义工具栏开始颜色、控件标题栏文本颜色（默认值为：0x000000）
 			if (!WebOfficeObj.WebSetSkin(0xfdd6e5, 0xfdd8e6, 0xfdd8e6, 0xfdd6e5, 0xfdd6e5, 0xfdd6e5, 0x000000))
 				WebOfficeObj.Alert(WebOfficeObj.Status);
		}
		
		//紫罗兰皮肤
 		function SetPurpleSkin1(){
 			//参数顺序依次为：控件标题栏颜色、自定义菜单开始颜色、自定义工具栏按钮开始颜色、自定义工具栏按钮结束颜色、
 			//自定义工具栏按钮边框颜色、自定义工具栏开始颜色、控件标题栏文本颜色（默认值为：0x000000）
 			if (!WebOfficeObj.WebSetSkin(0xb15d7d, 0xfdd8e6, 0xfdd8e6, 0xfdd6e5, 0xfdd6e5, 0xfdd6e5, 0xFFFFFF))
 				WebOfficeObj.Alert(WebOfficeObj.Status);
		}
		
		//胭脂红皮肤
 		function SetRedSkin(){
 			//参数顺序依次为：控件标题栏颜色、自定义菜单开始颜色、自定义工具栏按钮开始颜色、自定义工具栏按钮结束颜色、
 			//自定义工具栏按钮边框颜色、自定义工具栏开始颜色、控件标题栏文本颜色（默认值为：0x000000）
 			if (!WebOfficeObj.WebSetSkin(0xcfd9fa, 0xdce3fb, 0xdce3fb, 0xcfd9fa, 0xcfd9fa, 0xcfd9fa, 0x000000))
 				WebOfficeObj.Alert(WebOfficeObj.Status);
		}
		
		//胭脂红皮肤
 		function SetRedSkin1(){
 			//参数顺序依次为：控件标题栏颜色、自定义菜单开始颜色、自定义工具栏按钮开始颜色、自定义工具栏按钮结束颜色、
 			//自定义工具栏按钮边框颜色、自定义工具栏开始颜色、控件标题栏文本颜色（默认值为：0x000000）
 			if (!WebOfficeObj.WebSetSkin(0x3055f4, 0xdce3fb, 0xdce3fb, 0xcfd9fa, 0xcfd9fa, 0xcfd9fa, 0xffffff))
 				WebOfficeObj.Alert(WebOfficeObj.Status);
		}

		//烟枪灰皮肤
 		function SetGraySkin1(){
 			//参数顺序依次为：控件标题栏颜色、自定义菜单开始颜色、自定义工具栏按钮开始颜色、自定义工具栏按钮结束颜色、
 			//自定义工具栏按钮边框颜色、自定义工具栏开始颜色、控件标题栏文本颜色（默认值为：0x000000）
 			if (!WebOfficeObj.WebSetSkin(0xa0a0a3, 0xeaeaea, 0xeaeaea, 0xdbdbdb, 0xdbdbdb, 0xdbdbdb, 0xffffff))
 				WebOfficeObj.Alert(WebOfficeObj.Status);
		}
		
		//蓝色皮肤
 		function SetBlueSkin(){
 			//参数顺序依次为：控件标题栏颜色、自定义菜单开始颜色、自定义工具栏按钮开始颜色、自定义工具栏按钮结束颜色、
 			//自定义工具栏按钮边框颜色、自定义工具栏开始颜色、控件标题栏文本颜色（默认值为：0x000000）
 			if (!WebOfficeObj.WebSetSkin(0xfee6d3, 0xfee6d3, 0xfee6d3, 0xfee6d3, 0xfee6d3, 0xfee6d3, 0x000000))
 				WebOfficeObj.Alert(WebOfficeObj.Status);
		}
		
		//深蓝色皮肤
 		function SetBlueSkin1(){
 			//参数顺序依次为：控件标题栏颜色、自定义菜单开始颜色、自定义工具栏按钮开始颜色、自定义工具栏按钮结束颜色、
 			//自定义工具栏按钮边框颜色、自定义工具栏开始颜色、控件标题栏文本颜色（默认值为：0x000000）
 			if (!WebOfficeObj.WebSetSkin(0xe26602, 0xfee6d3, 0xfee6d3, 0xfee6d3, 0xfee6d3, 0xfee6d3, 0xffffff))
 				WebOfficeObj.Alert(WebOfficeObj.Status);
		}

		//柠檬黄皮肤
 		function SetYellowSkin(){
 			//参数顺序依次为：控件标题栏颜色、自定义菜单开始颜色、自定义工具栏按钮开始颜色、自定义工具栏按钮结束颜色、
 			//自定义工具栏按钮边框颜色、自定义工具栏开始颜色、控件标题栏文本颜色（默认值为：0x000000）
 			if (!WebOfficeObj.WebSetSkin(0x5edffe, 0xb7effd, 0xb7effd, 0xb7effd, 0xb7effd, 0x5edffe, 0x000000))
 				WebOfficeObj.Alert(WebOfficeObj.Status);
		}
		
		//柠檬黄皮肤
 		function SetYellowSkin1(){
 			//参数顺序依次为：控件标题栏颜色、自定义菜单开始颜色、自定义工具栏按钮开始颜色、自定义工具栏按钮结束颜色、
 			//自定义工具栏按钮边框颜色、自定义工具栏开始颜色、控件标题栏文本颜色（默认值为：0x000000）
 			if (!WebOfficeObj.WebSetSkin(0x00baff, 0xb7effd, 0xb7effd, 0xb7effd, 0xb7effd, 0x5edffe, 0x000000))
 				WebOfficeObj.Alert(WebOfficeObj.Status);
		}
		
		function OnUnLoad(){
			WebOfficeObj.WebClose();
		}
		
		//保存文档
		function SaveDocument()
		{
		  if (WebOfficeObj.WebSave()){    //交互OfficeServer的OPTION="SAVEFILE"
		    WebOfficeObj.WebClose();
		    window.close();
	  	}else{
	  		WebOfficeObj.Alert(WebOfficeObj.Status);
	     	StatusMsg(WebOfficeObj.Status);
	  	}
		}		
		
</script>



<!--  响应菜单事件  -->
<script language="javascript" for="WebOffice" event="OnCommand(ID, Caption, bCancel)">
	switch(ID){
	    case 1: WebOfficeObj.WebOpenLocal(); break;//打开本地文件
	    case 2: WebOfficeObj.WebSaveLocal(); break;//另存本地文件
		case 3: WebOfficeObj.CreateFile(); break;//新建文档
			case 4: WebOfficeObj.PrintPreview(); break;//启用
			case 5: WebOfficeObj.PrintPreviewExit(); WebOfficeObj.ShowField(); break;//启用
			default: ; return;
	}
</script>
<script language="javascript">
function OnCommand(ID, Caption, bCancel){
   switch(ID){
	    case 1: WebOfficeObj.WebOpenLocal(); break;//打开本地文件
	    case 2: WebOfficeObj.WebSaveLocal(); break;//另存本地文件
		case 3: WebOfficeObj.CreateFile(); break;//新建文档
		case 4: WebOfficeObj.PrintPreview(); break;//启用
		case 5: WebOfficeObj.PrintPreviewExit(); WebOfficeObj.ShowField(); break;//启用
		default: ; return;
  }
}

      function jumpPage() {
          Apply($("#selectID").val());
      }
      function Apply(id) {
          if (id == "烟枪灰"){
          	SetGraySkin(); 
          }else if (id == "烟枪灰(深)"){
            SetGraySkin1();
          }else if (id == "紫罗兰"){
            SetPurpleSkin();
          }else if (id == "紫罗兰(深)"){
            SetPurpleSkin1();
          }else if (id == "天空蓝"){
            SetBlueSkin();
          }else if (id == "天空蓝(深)"){
            SetBlueSkin1();
          }else if (id == "柠檬黄"){
            SetYellowSkin();
          }else if (id == "柠檬黄(深)"){
            SetYellowSkin1();
          }else if (id == "胭脂红"){
            SetRedSkin();
          }else if (id == "胭脂红(深)"){
            SetRedSkin1();
          }
      }
</script>




<!--以下是多浏览器的事件方法 -->
<script>
function OnReady(){
 WebOfficeObj.setObj(document.getElementById('WebOffice'));//给2015对象赋值
 //Load();//避免页面加载完，控件还没有加载情况
 setTimeout(function(){Load();}, 500);
}
</script>

<script language="javascript" for=WebOffice event="OnReady()">
	 WebOfficeObj.setObj(document.getElementById('WebOffice'));
   Load();//避免页面加载完，控件还没有加载情况
</script>
</head>

<body onUnload="OnUnLoad();" onbeforeunload="OnUnLoad();">
	<div style="width: 100%; height: 100%">
		<div style="width: 100%;">
            <font  size = "3" color="#FF0000">控件皮肤选择</font>
            <select onchange="return jumpPage()" style="color:Red;height: 22px;width:89px;background-color:#dbdbdb;margin-left: -5px;" id="selectID">
               <option value="烟枪灰" selected="selected" >烟枪灰</option>
               <option value="烟枪灰(深)" >烟枪灰(深)</option>
               <option value="紫罗兰" >紫罗兰</option>
               <option value="紫罗兰(深)" >紫罗兰(深)</option>
               <option value="天空蓝" >天空蓝</option>
               <option value="天空蓝(深)">天空蓝(深)</option>
               <option value="柠檬黄" >柠檬黄</option>
               <option value="柠檬黄(深)" >柠檬黄(深)</option>
               <option value="胭脂红" >胭脂红</option>
               <option value="胭脂红(深)">胭脂红(深)</option>
             </select>
			<input style="color:Red" type=button value="显示菜单栏" onclick="CustomMenu(true)">
  			<input style="color:Red;" type=button value="隐藏菜单栏" onclick="CustomMenu(false)">
  			<input style="color:Red;" type=button value="显示自定义工具栏" onclick="CustomToolBarsVisibled(true)">
  			<input style="color:Red;" type=button value="隐藏自定义工具栏" onclick="CustomToolBarsVisibled(false)">
		</div>
		<div id="OfficeDiv" style="width: 100%; height: 98%;" ><script src="../../js/iWebOffice2015.js"></script></div>
	</div>
</body>
</html>