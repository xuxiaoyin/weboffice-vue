package com.kinggrid.office.demo.model;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.kinggrid.office.demo.common.Log;

public class GreyClientInitListener implements ServletContextListener {
	public void contextDestroyed(ServletContextEvent event) {
        // 初始化数据库连接的代码
        // and store it as a context attribute
		
    }

    public void contextInitialized(ServletContextEvent event) {
    	try {
        // 关闭数据库连接的代码
//    	PropertyUtil.writeProperties("test", "test");
    	PropertyUtil mPropertyUtil = PropertyUtil.getInstance("config.properties");
    	Settings.uploadPath = mPropertyUtil.getProperty("OfficeDoc");
    	String copyright = mPropertyUtil.getProperty("Copyright");
    	iweboffice.preview.Copyright.load(copyright);
    	ServletContext context=event.getServletContext();
    	String webpath = context.getRealPath("/");
    	Log.mLogFile = webpath+"log.log";
    	Log.WriteLog("/*---------------------------程序启动---------------------------*/");
    	} catch (Exception e) {
    		// TODO Auto-generated catch block
    		e.printStackTrace();
    	}
    	
    }
}
