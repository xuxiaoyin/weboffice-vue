package com.kinggrid.office.demo.common;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


final class KeyValueCollection
{
	String mMainKeyName;
	Map<String, String> mKeyValuePairList = null;
	
	public KeyValueCollection()
	{
	
	}
}

//缓存数据记录
public class BufferRecordHandle {
	
	//缓存文件打开方式
	public static final int eUnknow = 0;
	public static final int eRead = 1;
    public static final int eWrite = 2;
    public static final int eReadWrite = 3;
	//缓存数据记录文件
	private String mTextFile = null;
	//缓存数据
    private List<KeyValueCollection> mKeyValuePair = null;
    
    //
    private BufferRecordHandle()
    {
        
    }

    

    //设置缓存文件路径
    public void SetTextFile(String ft)
    {
        mTextFile = ft;
    }

    //读取文本文件
    private static List<String> ReadTextFileAllLines(String sTextFile)
    {
    	try
    	{
            FileReader reader = new FileReader(sTextFile); 
            BufferedReader br = new BufferedReader(reader);
            String str = null; 
            List<String> mLinesText = new ArrayList<String>();
            while((str = br.readLine()) != null) {
            	mLinesText.add(str);
            } 
            br.close();
            reader.close();
            return mLinesText;
    	}
    	catch(Exception ex)
    	{
    		return null;
    	}
    }
    
    //创建操作对象
    public static BufferRecordHandle CreateHandle(String sTextFile, int mode)
    {
        try
        {
        	BufferRecordHandle kph = new BufferRecordHandle();
            kph.mTextFile = sTextFile;
            kph.mKeyValuePair = new ArrayList<KeyValueCollection>();
            if (mode == eRead)
            {
            	List<String> mLinesText = ReadTextFileAllLines(sTextFile);
            	if(mLinesText == null)
            		return null;
                KeyValueCollection ld = null;
                String s;
                for (int n = 0; n < mLinesText.size(); ++n)
                {
                	s = mLinesText.get(n);
                    int posL = s.indexOf('[');
                    int posR = s.indexOf(']');
                    if (posL == 0 && posR == s.length() - 1)
                    {
                        ld = new KeyValueCollection();
                        ld.mMainKeyName = s.substring(posL + 1, posR);
                        ld.mKeyValuePairList = new HashMap<String, String>();
                    }
                    else
                    {
                        int pos = s.indexOf('=');
                        if (pos > 0 && pos < s.length())
                        {
                            if (ld == null)
                                return null;
                            String sKey = s.substring(0, pos);
                            String sValue = s.substring(pos + 1);
                            ld.mKeyValuePairList.put(sKey, sValue);
                        }
                        else
                        {
                            return null;
                        }
                    }
                }
                if (ld != null)
                    kph.mKeyValuePair.add(ld);

                return kph;
            }
            else if (mode == eWrite)
            {
                return kph;
            }
            else
                return null;
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    //读取值
    public String GetValue(String sMainKey, String sSubKey)
    {
        try
        {
        	String sValue = null;
            for(KeyValueCollection a : mKeyValuePair)
            {
                if (a.mMainKeyName.equals(sMainKey))
                {
                    String v = a.mKeyValuePairList.get(sSubKey);
                    if (v != null)
                    {
                        sValue = v;
                    }
                    break;
                }
            }

            return sValue;
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    //添加主键
    public boolean AddMainKey(String sMainKey)
    {
        if (mKeyValuePair != null)
        {
            for (KeyValueCollection a : mKeyValuePair)
            {
                if (a.mMainKeyName == sMainKey)
                {
                    return false;
                }
            }

            KeyValueCollection newKVC = new KeyValueCollection();
            newKVC.mMainKeyName = sMainKey;
            mKeyValuePair.add(newKVC);

            return true;
        }

        return false;
    }

    //添加子键
    public boolean AddSubKey(String sMainKey, String sSubKey, String sSubValue)
    {
        if (mKeyValuePair != null)
        {
            KeyValueCollection aFind = null;
            for (KeyValueCollection a : mKeyValuePair)
            {
                if (a.mMainKeyName == sMainKey)
                {
                    aFind = a;
                    break;
                }
            }
            if (aFind == null)
            {
                aFind = new KeyValueCollection();
                aFind.mMainKeyName = sMainKey;
                mKeyValuePair.add(aFind);
            }
            if (aFind.mKeyValuePairList == null)
            {
                aFind.mKeyValuePairList = new HashMap<String, String>();
            }
            aFind.mKeyValuePairList.put(sSubKey, sSubValue);

            return true;
        }

        return false;
    }

    //写缓存文件
    public void Flush()
    {
        if (mKeyValuePair != null)
        {
            try
            {
            	String sText = "";
            	String sKey = "";
            	String sValue = "";
                for (KeyValueCollection a : mKeyValuePair)
                {
                    sText += "[";
                    sText += a.mMainKeyName;
                    sText += "]";
                    sText += "\n";
                    for(Map.Entry<String, String> entry : a.mKeyValuePairList.entrySet()){
                    	sKey = entry.getKey();
                        sValue = entry.getValue();
                        sText += sKey;
                        sText += "=";
                        sText += sValue;
                        sText += "\n";
                    }
                }
                //
                StringBuffer sb= new StringBuffer(sText);
                FileWriter writer = new FileWriter(mTextFile); 
                BufferedWriter bw = new BufferedWriter(writer);
                bw.write(sb.toString());
                bw.close();
                writer.close();
            }
            catch (Exception ex)
            {

            }
        }
    }
}
