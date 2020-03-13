package com.kinggrid.office.demo.common;

import java.io.FileWriter;

public class Log {
	public static String mLogFile = "";
	
	public static void WriteLog(String log){
		try{
			FileWriter fw = new FileWriter(mLogFile, true);
			fw.write(log+"\n");
			fw.close();
		}
		catch(Exception ex){
			
		}
	}
	
	public static void WriteLog(String key, String value){
		try{
			String log = key;
			log += ":";
			log += value;
			WriteLog(log);
		}
		catch(Exception ex){
			
		}
	}
	
	public static void WriteLog(String key, long value){
		try{
			String log = key;
			log += ":";
			log += value;
			WriteLog(log);
		}
		catch(Exception ex){
			
		}
	}
}
