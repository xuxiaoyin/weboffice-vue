package com.kinggrid.office.demo.common;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;

import DBstep.iDBManager2000;

public class GenerateFile {
	private iDBManager2000 DbaObj = new iDBManager2000();
	
	  public InputStream GetFileByte(String recordID) {
		  byte[] mFileBody = null;
		  int mFileSize = 0;
		  InputStream input;
			//��ȡ��ݿ��ļ���
		    String Sql = "SELECT FileBody,FileSize FROM Document_File WHERE RecordID='" + recordID + "'";
		    try {
		      if (this.DbaObj.OpenConnection())
		        try {
		          ResultSet result = this.DbaObj.ExecuteQuery(Sql);
		          if (result.next()) {
		            try {
		            	mFileSize = result.getInt("FileSize");
		            	mFileBody = new byte[mFileSize];
		            	input = result.getBlob("FileBody").getBinaryStream();
		            	input.read(mFileBody, 0, mFileSize);
		              if (result.wasNull())
		            	  mFileBody = null;
		            }
		            catch (Exception ex)
		            {
		              System.out.println(ex.toString());
		            }
		          }
		          result.close();
		        }
		        catch (SQLException e) {
		          System.out.println(e.getMessage());
		        }
		    }
		    finally
		    {
		      this.DbaObj.CloseConnection();
		    }
		    input = new ByteArrayInputStream(mFileBody);
			return input;
	  }  
}
