package com.kinggrid.office.demo.model;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import java.util.Properties;

public class PropertyUtil {
	
	private String mProFile = "config.properties";
	private Properties props  = new Properties();
	
	public static PropertyUtil getInstance(String proFile)
	{
		PropertyUtil mPropertyUtil = new PropertyUtil();
		mPropertyUtil.mProFile = proFile;
		
		return mPropertyUtil;
	}
	
	public boolean loadProps(){
		boolean mRet = false;
		props.clear();
        InputStream in = null;
        try {
            in = PropertyUtil.class.getResourceAsStream("/"+mProFile);
            props.load(in);
            
            mRet = true;
        } catch (Exception e) {
            
        } finally {
        	try
        	{
	            if(null != in) {
	                in.close();
	            }
        	}
        	catch (Exception e) {
                
            } 
            return mRet;
        }
        //logger.info("加载properties文件内容完成...........");
        //logger.info("properties文件内容：" + props);
    }
	
	public void writeProperties(String keyname,String keyvalue) {   
		try { 
			String path = PropertyUtil.class.getClassLoader().getResource(mProFile).getPath();   
			props.clear();
			props.load(new FileInputStream(path));   
			OutputStream fos = new FileOutputStream(path);              
			props.setProperty(keyname, keyvalue);
			props.store(fos, "Update '" + keyname + "' value");   
		} 
		catch (Exception e) {   
			  
		}   
	}  

    public String getProperty(String key){
    	try {   
    		String path = PropertyUtil.class.getClassLoader().getResource(mProFile).getPath();  
			props.clear(); 
			FileInputStream in = new FileInputStream(path);
			props.load(in); 
			String value = props.getProperty(key);
			in.close();
			
			return value;
		} catch (Exception e) {   
			return null;
		}
    }

   
}
