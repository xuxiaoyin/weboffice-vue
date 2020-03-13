package com.kinggrid.office.demo.common;

import java.io.File;
import java.io.FileInputStream;
import java.math.BigInteger;
import java.security.MessageDigest;

import com.sun.org.apache.xml.internal.security.utils.Base64;


public class Common {
	//创建文件目录
	public static boolean CreateFolder(String sFolderPath)
	{
		try
		{
			File file = new File(sFolderPath); 
			if(file.exists())
				return false;
			return file.mkdirs();
		}
		catch(Exception ex)
		{
			return false;
		}
	}
	
	//从文件路径中获取文件名（带后缀）
    public static String GetFileNameExt(String sFileUrl)
    {
        //提取文件名称（包括文件名后缀）
    	String sFileNameExt = sFileUrl.replace('\\', '/');
        int pos = sFileNameExt.lastIndexOf('/');
        if(pos >= 0)
            sFileNameExt = sFileNameExt.substring(pos + 1);

        return sFileNameExt;
    }

    //从文件路径中获取文件名（不带后缀）
    public static String GetFileName(String sFileUrl)
    {
        //提取文件名称（包括文件名后缀）
    	String sFileName = sFileUrl.replace('\\', '/');
        int pos = sFileName.lastIndexOf('/');
        if (pos >= 0)
            sFileName = sFileName.substring(pos + 1);
        pos = sFileName.lastIndexOf('.');
        if (pos >= 0)
            sFileName = sFileName.substring(0, pos);

        return sFileName;
    }

    //获取文件后缀
    public static String GetFileExt(String sFileUrl)
    {
        //提取文件名称（包括文件名后缀）
    	String sFileExt = sFileUrl.replace('\\', '/');
        int pos = sFileExt.lastIndexOf('/');
        if (pos >= 0)
            sFileExt = sFileExt.substring(pos + 1);
        pos = sFileExt.lastIndexOf('.');
        if (pos >= 0)
            sFileExt = sFileExt.substring(pos + 1);

        return sFileExt;
    }
    
	//目录路径后添加斜杠
    public static String FolderPathAddSlash(String sFolderPath)
    {
        if (sFolderPath == null)
            return sFolderPath;
        sFolderPath = sFolderPath.replace('/', '\\');
        if (sFolderPath.length() == 0)
            return sFolderPath;
        if (sFolderPath.charAt(sFolderPath.length() - 1) == '\\')
            return sFolderPath;

        return sFolderPath + "\\";
    }
    
  //字符串base64加密
    public static String EncryptBase64(String sText)
    {
    	try
    	{
    		return Base64.encode(sText.getBytes("utf-8"));
    	}
    	catch(Exception ex)
    	{
    		return null;
    	}
    }

    //字符串base64解密
    public static String DecryptBase64(String sText)
    {
        try
        {
            return new String(Base64.decode(sText), "utf-8");
        }
        catch (Exception ex)
        {
            return null;
        }
    }
    
    //获取文件MD5值
    public static String GetMD5HashFromFile(String sFile)
    {
    	try {
            File file = new File(sFile);
            FileInputStream fis = new FileInputStream(file);
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] buffer = new byte[1024];
            int length = -1;
            while ((length = fis.read(buffer, 0, 1024)) != -1) {
                md.update(buffer, 0, length);
            }
            BigInteger bigInt = new BigInteger(1, md.digest());
            fis.close();
            
            return bigInt.toString(16);
            
        } catch (Exception e) {
          return null;
        }
    }
    
    public static boolean IsFileExist(String sFile)
    {
    	try
    	{
    		 File file = new File(sFile);
    		 
    		 return file.exists();
    	}
    	catch(Exception ex)
    	{
    		return false;
    	}
    	
    }
}
