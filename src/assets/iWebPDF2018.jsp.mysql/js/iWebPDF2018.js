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

var copyright='金格科技iWebOffice2015智能文档中间件[演示版];V5.0S0xGAAEAAAAAAAAAEAAAAJEBAACgAQAALAAAAEnETMLfjzlFKkLbsBP8QVd2P5OtkkDyMgxgC1pFIRacyXbx8diNwmCITUtMwEDfDyAdCEVVr6yXCHD97ZiaT8YIZCNeE4A7gs3HY2tM8sspVWCd30/CiZaDUx0AsqcXEEXoB/vsqnZaET0u1wGsphKe8ZKcvJJJdQ3Ciy2cTiQObN//pSPY/3LgdxdJeEyC5ibUvVW9ngjJG0brXt4N17r1TDygcaC+SZ/pBTLg3Hac6bHoHHks5P9R5HvAjICsShbtkO2snAIvvslWn0BSDoL4XRSKyUErCdOwgUs+QjQ7HkoziQI+YpszJD05dP2AxH39S8feWlTg0D9ouIEHTCQH0KNvzaqKc2c2dYqrHqY77SJ9JRozb9SsqruQvUBo/CG91rVivzUiZrybJ14KjepAVO1mAmbCzbSYMFtGFWlBIwN6NbNYBtD+jZ4EB2dLs+V7dQpbR7J/EZVI2Sg8npwls3b9DTxkaNOubL7CkvTNfpETB8Irmq8kkWYzGRrv0iOKgRvkwm8AnQqliHCzRdvytzmoaUVhjEiTMjbEMYkovu1U1W2cVLD4jxA1xcDiXw==';



if ((window.ActiveXObject!=undefined) || (window.ActiveXObject!=null) ||"ActiveXObject" in window)
{
	str += '<object id="iWebPDF2018" ';
	str += ' width="100%"';
	str += ' height="100%"';
	if(window.navigator.platform == "Win32")
		str += ' CLASSID="CLSID:7017318C-BC50-4DAF-9E4A-10AC8364C315"   codebase="iWebPDF2018.cab#version=9.0.2800.1806"';
	if (window.navigator.platform == "Win64")
		str += ' CLASSID="CLSID:7017318C-BC50-4DAF-9E4A-10AC8364C364"   codebase="iWebPDF2018.cab#version=9.0.2800.1806"';
	str += '>';
	
}
else if (browser == "chrome") 
{
	str += '<object id="iWebPDF2018" ';
	str += ' width="100%"';
	str += ' height="100%"';
	str += ' clsid="CLSID:7017318C-BC50-4DAF-9E4A-10AC8364C315"';         
	str += ' type="application/kg-plugin"';
	str += ' OnAddinEventInvoke="OnAddinEventInvoke"';
	str += ' OnCommand="OnCommand"';
	str += ' OnOLECommand="OnOLECommand"';	
	str += ' Copyright="' + copyright + '"';
	str += '>';
}
else if (browser == "firefox") 
{
	str += '<object id="iWebPDF2018" ';
	str += ' width="100%"';
	str += ' height="100%"';
	str += ' clsid="CLSID:7017318C-BC50-4DAF-9E4A-10AC8364C315"';
	str += ' type="application/kg-activex"';
	str += ' OnCommand="OnCommand"';
	str += ' OnAddinEventInvoke="OnAddinEventInvoke"';
	str += ' OnOLECommand="OnOLECommand"';
	str += ' Copyright="' + copyright + '"';
	str += '>';
}
str += '</object>';
document.write(str); 


