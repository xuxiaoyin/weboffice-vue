/**
 * @author Lenovo
 */
// 兼容性创建xmlHttp对象
var snull = "undefined";
var sstr = "string";
// XMLHttpRequest对象
var xhr = null;
function createXHR() {
	// 新浏览器Firefox、Chrome、IE7及以上等
	if (typeof XMLHttpRequest != snull) {
	    //对某些特定版本的mozillar浏览器的bug进行修正  
alert("1");
	       xhr =  new XMLHttpRequest();
	       if(xhr.overrideMineType)
		   {  
	    	   xhr.overrideMineType("text/xml");  
	       } 
	       return xhr;
	       
	}
	// IE6或者更老的版本
	if (typeof ActiveObject != snull) {
		if (typeof arguments.callee.activeXString != sstr) {
			var version = [ "MSXML2.XMLHttp6.0", "MSXML2.XMLHttp3.0",
					"MSXMLHttp" ];
			for ( var i = 0; i < version.length; i++) {
				try {
					var xhr = new ActiveXObject(version[i]);
					arguments.callee.activeXString = version[i];
					return xhr;
				} catch (ex) {
					throw new Error(ex.toString());
				}
			}
			return new ActiveXObject(arguments.callee.activeXString);
		} else {
			throw new Error("no XHR object available");
		}
	}
	return null;
}
 
function getDataFromServer(url) {
	//var reader = new FileReader();
	//alert(reader);
	alert('getDataFromServer');
	xhr = new createXHR();
	// xhr.setRequestHeader("Content-Type",
	// "application/x-www-form-urlencoded");
 
	if (xhr != null) {
		xhr.onreadystatechange = handleStateChange;
 
		// 创建一个新的http请求，并指定此请求的方法、URL以及验证信息、是否异步（后面代码继续执行，不等待服务器的响应）
		/*
		 * open(method, url, async, username, password) method 参数是用于请求的
		 * HTTP方法。值包括 GET、POST 和 HEAD。 url 参数是请求的主体。 大多数浏览器实施了一个同源安全策略，并且要求这个
		 * URL与包含脚本的文本具有相同的主机名和端口。 async 参数指示请求使用应该异步地执行。 如果这个参数是
		 * false，请求是同步的，后续对send() 的调用将阻塞，直到响应完全接收。 如果这个参数是 true
		 * 或省略，请求是异步的，且通常需要一个onreadystatechange 事件句柄。 username 和 password
		 * 参数是可选的，为 url所需的授权提供认证资格。 如果指定了，它们会覆盖 url 自己指定的任何资格。
		 */
		xhr.open("post", "" + url, true);
		// 将xhr对象设置请求头信息(向一个打开但未发送的请求设置或添加一个 HTTP 请求。
		// 例如：在调用了 open() 之后，但在调用 send() 之前。)
		/*xhr.setRequestHeader("Content-Type",
				"application/x-www-form-urlencoded");*/
		xhr.responseType = "arraybuffer";
		//xhr.overrideMimeType('text/plain; charset=x-user-defined');
		//xhr.responseType = "blob";
		
		// 发送请求到http服务器并接收回应
		xhr.send("name="+"zhangsan&"+"password="+"psw");
	}
}
 
function handleStateChange() {
 
	// 状态0 -- Uninitialized 初始化状态。XMLHttpRequest 对象已创建或已被 abort() 方法重置。
	// 状态1 -- open方法已调用，但是 send() 方法未调用。请求还没有被发送。
	// 状态2 -- send方方法已调用，HTTP 请求已发送到 Web 服务器。未接收到响应。
	// 状态3 -- 所有响应头部都已经接收到。响应体开始接收但未完成;这时通过responseBody和responseText获取部分数据会出现错误
	// 状态4 -- 数据接收完毕,此时可以通过通过responseBody和responseText获取完整的回应数据
	// 4 Loaded HTTP 响应已经完全接收。
	if (4 == xhr.readyState) {
		// 返回当前请求的http状态码[200--成功
		if ((200 <= xhr.status && 300 > xhr.status) || 304 == xhr.status) {
			// 处理请求后服务器发回来的数据
			dealResponseText();
		} else if (404 == xhr.status) {
			alert("文件不存在！");
		} else if (500 == xhr.status) {
			alert("服务器内部错误！");
		} else {
			alert("没有返回正确数据！");
		}
	} else if (3 == xhr.readyState) {
		// 3 Receiving 所有响应头部都已经接收到。响应体开始接收但未完成。
		alert("正在接收数据-3!");
	} else if (2 == xhr.readyState) {
		// 2 Sent Send() 方法已调用，HTTP 请求已发送到 Web 服务器。未接收到响应。
		alert("数据已经发送完毕-2！");
	} else if (1 == xhr.readyState) {
		// 1 Open open() 方法已调用，但是 send() 方法未调用。请求还没有被发送。
		alert("对象创建完毕，初始化成功-1！");
	} else if (0 == xhr.readyState) {
		// 0 Uninitialized 初始化状态。XMLHttpRequest 对象已创建或已被 abort() 方法重置。
		alert("对象已经创建，但还没初始化-0！");
	} else {
		alert("Request was unsuccessful: " + xhr.status+xhr.statusText);
	}
}
 
function dealResponseText() {
	alert('dealResponseText ');

	alert(xhr.response);
	var arrayBuffer = xhr.response;
	if (arrayBuffer) {
	    var byteArray = new Uint8Array(arrayBuffer);
	     alert("byteArray.byteLength: " + byteArray.byteLength);
	    
	}
	
   /* var binStr = xhr.responseText;
    //然后自己再想方法将逐个字节还原为二进制数据
    for (var i = 0, len = binStr.length; i < len; ++i) {
      var c = binStr.charCodeAt(i);
      //String.fromCharCode(c & 0xff);
      var byte = c & 0xff; 
      alert(byte);
    }
	*/
	// responseText 将响应信息作为字符串返回
	// alert(xhr.responseText);
	// responseXML xml的文档节点
 
	// var xmlData = xmlHttp.responseXML;
	// documentElement 返回跟节点
 
	// var xmlRoot = xmlData.documentElement;
	// attributes 获取属性集合
 
	// var attrs = xmlRoot.attributes;
	// alert(attr.length)
	// ie下获取节点值 text
	// FF下获取节点值 textContent
	// 兼容性获取
	// var oFind = xmlRoot.getElementsByTagName("findTag")[0];
	// var isFindTXT = xmlRoot.text ? oFind.text : oFind.textContent;
	// alert(isFindTXT);
 
	// var jsonTextDiv = document.getElementById("jsonText");
 
	// Deserializes JavaScript Object Notation (JSON) text to
	// produce a JavaScript value.
 
	//
	// xhr.getResponseHeader('Last-Modified');
 
	// 打印返回来的响应头信息(Server,Content-Length,Date,Last-Modified)
	//document.write(xhr.getAllResponseHeaders() + "<br/>");
	// 打印返回来的文本
	/*try{		
		document.write(xhr.responseText);
	}catch(ex){
		alert("打印返回文本出错！");
	}
	*/
	//var data = JSON.parse(xhr.responseText);
 
	/*
	 * for ( var i = 0; i < data.length; i++) { var item = date[i]; var div =
	 * window.document.createElement("div"); //div.setAttribute("class",
	 * "dataitem"); // Inserts data into the html. div.innerHTML = item.Name + "
	 * sold "; /*jsonTextDiv*window.document.appendChild(div); }
	 */
	//alert(data.length);
}
 
function isXML() {
 
}
