var userAgent = navigator.userAgent, 
				rMsie = /(msie\s|trident.*rv:)([\w.]+)/, 
				rFirefox = /(firefox)\/([\w.]+)/, 
				rOpera = /(opera).+version\/([\w.]+)/, 
				rChrome = /(chrome)\/([\w.]+)/, 
				rSafari = /version\/([\w.]+).*(safari)/;
				var browser;
				var version;
				var ua = userAgent.toLowerCase();
				function uaMatch(ua) {
					var match = rMsie.exec(ua);
					if (match != null) {
						return { browser : "IE", version : match[2] || "0" };
					}
					var match = rFirefox.exec(ua);
					if (match != null) {
						return { browser : match[1] || "", version : match[2] || "0" };
					}
					var match = rOpera.exec(ua);
					if (match != null) {
						return { browser : match[1] || "", version : match[2] || "0" };
					}
					var match = rChrome.exec(ua);
					if (match != null) {
						return { browser : match[1] || "", version : match[2] || "0" };
					}
					var match = rSafari.exec(ua);
					if (match != null) {
						return { browser : match[2] || "", version : match[1] || "0" };
					}
					if (match != null) {
						return { browser : "", version : "0" };
					}
				}
				var browserMatch = uaMatch(userAgent.toLowerCase());
				if (browserMatch.browser) {
					browser = browserMatch.browser;
					version = browserMatch.version;
				}

var str = '';
var copyright='金格科技iWebOffice2015智能文档中间件[演示版];V5.0S0xGAAEAAAAAAAAAEAAAAJ8BAACgAQAALAAAAPfx4cnr7n2wjo/4SpF61QY7nXOgBBDO6Jy5KlTSFqJqypb3pQghCXHbaaTyOX9kkpOrk0VkKiZ4ZmVvyEagEkyVHA3sgitPuGyLdLq5XNAqPAwBDPlZRT6JuiBALojluntS9ePtB9NO5fDsv5b1vUbeHm0RAYW47UKyppnYZ/v7k9HEdSlTmM+04FexHI7fJU89x3hySglu/pQyWmskSsDcxqLLiWNJ1Lt6HnBTTmbfqBGImQndkAPMz4UIDLUc0KrrVyrlx4SEPxUrN4HshfKKn4N6haPZsDX9L6R7bGS3MBkRArFJ+mUcGZPyx+V0N5ZQHugbl9XiBB9ry/ldP3oh8FdRHu8QCnkT7oAymJ6b98ujQh8nLFe3drQM2r3dPt0I8UUMQgOGvGHNDT72tl5ylusGNeXf2pg5W3ViOvPSwNiGseZ+A8PD6BPIl+MOw9mP+pebfqDYLUhUmrDFg67PoNbHxMrKTYBDfm1VnwdN534EhtKh0T/+LYNWukWDg5o2xuhMDKzpozs+FpOouApA2egseM1izQLLViFa6D7YPVXJ1mbb29W5raldlhhU9g==';
str += '<object id="WebOffice" ';

str += ' width="100%"';
str += ' height="100%"';

if ((window.ActiveXObject!=undefined) || (window.ActiveXObject!=null) ||"ActiveXObject" in window)
{
	if(window.navigator.platform == "Win32")
		str += ' CLASSID="CLSID:D89F482C-5045-4DB5-8C53-D2C9EE71D025"  codebase="../../iWebOffice2015.cab#version=0,0,0,0"';
	if (window.navigator.platform == "Win64")
		str += ' CLASSID="CLSID:D89F482C-5045-4DB5-8C53-D2C9EE71D024"  codebase="../../iWebOffice2015.cab#version=0,0,0,0"';
	str += '>';
	str += '<param name="Copyright" value="' + copyright + '">';
}
else if (browser == "chrome") 
{
	str += ' clsid="CLSID:D89F482C-5045-4DB5-8C53-D2C9EE71D025"';        
	str += ' type="application/kg-plugin"';
	str += ' OnReady="OnReady"';
	str += ' OnCommand="OnCommand"';
	str += ' OnRightClickedWhenAnnotate="OnRightClickedWhenAnnotate"';
	str += ' OnSending="OnSending"';
	str += ' OnSendEnd="OnSendEnd"';
	str += ' OnRecvStart="OnRecvStart"';
	str += ' OnRecving="OnRecving"';
	str += ' OnRecvEnd="OnRecvEnd"';
	str += ' OnFullSizeBefore="OnFullSizeBefore"';
	str += ' OnFullSizeAfter="OnFullSizeAfter"';	
	str += ' Copyright="' + copyright + '"';
	str += '>';
}
else if (browser == "firefox") 
{
	str += ' clsid="CLSID:D89F482C-5045-4DB5-8C53-D2C9EE71D025"';
	str += ' type="application/kg-activex"';
	str += ' OnCommand="OnCommand"';
	str += ' OnReady="OnReady"';
	str += ' OnOLECommand="OnOLECommand"';
	str += ' OnExecuteScripted="OnExecuteScripted"';
	str += ' OnQuit="OnQuit"';
	str += ' OnSendStart="OnSendStart"';
	str += ' OnSending="OnSending"';
	str += ' OnSendEnd="OnSendEnd"';
	str += ' OnRecvStart="OnRecvStart"';
	str += ' OnRecving="OnRecving"';
	str += ' OnRecvEnd="OnRecvEnd"';
	str += ' OnRightClickedWhenAnnotate="OnRightClickedWhenAnnotate"';
	str += ' OnFullSizeBefore="OnFullSizeBefore"';
	str += ' OnFullSizeAfter="OnFullSizeAfter"';	
	str += ' Copyright="' + copyright + '"';
	str += '>';
}
str += '</object>';
// document.write(str); 

//alert(str);

// if ((window.ActiveXObject != undefined) || (window.ActiveXObject != null) || "ActiveXObject" in window) {

// } else {
// 	if (browser == "firefox") {
// 		if(version < "52"){
// 			var fireFoxType = navigator.mimeTypes["application/kg-activex"];
// 			if (fireFoxType == undefined) {
// 				document.getElementById("WebOffice").width = "1px";
// 				var str='<div width="100%" height="100%" style="text-align:center; color: red;font-size:30px;" >该插件不受支持</br>点击跳转解决方案</div>';
// 				var t = document.getElementById("OfficeDiv");
// 				t.innerHTML = t.innerText + str;
// 			}
// 		}else{
// 			document.getElementById("WebOffice").width = "1px";
// 			var str='<div width="100%" height="100%" style="text-align:center;color: red;font-size:30px;" >该插件不受支持</br>请更换52版本以下的FireFox浏览器</div>';
// 			var t = document.getElementById("OfficeDiv");
// 			t.innerHTML = t.innerText + str;
// 		}
// 	}else if(browser == "chrome"){
// 		 var kgchromeType = navigator.mimeTypes["application/kg-plugin"]; //高级版
// 		 var chromeType = navigator.mimeTypes["application/kg-activex"]; //标准版
// 		 var oldChromeType = navigator.mimeTypes["application/iWebPlugin"]; //早期淘汰版本
// 		 if(document.getElementById("WebOffice").type == "application/kg-plugin"){
// 			 if (kgchromeType == undefined) {
// 				 document.getElementById("WebOffice").width = "1px";
// 				 var str='<div width="100%" height="100%" style="text-align:center; color: red;font-size:30px;" >该插件不受支持</br>引用的是高级版控件</br></div>';
// 				 var t = document.getElementById("OfficeDiv");
// 				 t.innerHTML = t.innerText + str;
// 				 //window.open("Faq002.html");
// 			 }	
// 		 }else{
// 			 if(version > "45"){
// 				 if (chromeType == undefined || oldChromeType == undefined) {
// 					 document.getElementById("WebOffice").width = "1px";
// 					 var str='<div width="100%" height="100%" style="text-align:center;color: red;font-size:30px;" >该插件不受支持</br>引用的是标准版控件</br></div>';
// 					 var t = document.getElementById("OfficeDiv");
// 					 t.innerHTML = t.innerText + str;
// 				 }	
// 			 }else{
// 				 document.getElementById("WebOffice").width = "1px";
// 				 var str='<div width="100%" height="100%" style="text-align:center;color: red;font-size:30px;" >标准版插件不受支持</br>请更换45版本以下的Chrome浏览器</br>如果需要使用高版本Chrome浏览器,需集成高级版插件</div>';
// 				 var t = document.getElementById("OfficeDiv");
// 				 t.innerHTML = t.innerText + str;
// 			 }
// 		 }
// 	}
// }

// console.log(str)
const webOfficeTpl = str
export default webOfficeTpl