package Servlet;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.Charset;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileUploadException;

import DBstep.iMsgServer2015;

public class AJAXServer extends HttpServlet {
    
	//数据库相关功能结束
    // char[]转byte[]
    public static byte[] getBytes (char[] chars) 
    {
//    	Charset cs = Charset.forName ("UTF-8");
//    	CharBuffer cb = CharBuffer.allocate (chars.length);
//    	cb.put (chars);
//    	cb.flip ();
//    	ByteBuffer bb = cs.encode (cb);
//    	return bb.array();
    	int len=chars.length;
    	byte [] arr=new byte[len];
    	for(int i=0; i<len; i++){
    		arr[i] = (byte) chars[i];
    	}
    	return arr;
    }
    
    
	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String sOperate = request.getParameter("operate");
		if(sOperate.equalsIgnoreCase("download"))
		{

			try{
				System.out.println("download-----------------------");
	
				byte[] mFileBody = null;
				String mFilePath = request.getSession().getServletContext().getRealPath("");       //取得服务器路径
				File file = new File(mFilePath+"\\Document\\comparedoc.doc");
				if(file.exists()){
					InputStream fileContentStream = new FileInputStream(file);
					mFileBody = null;
					ByteArrayOutputStream output = new ByteArrayOutputStream();
					byte[] buffer = new byte[4096];
					int n = 0;
					while (-1 != (n = fileContentStream.read(buffer))) {
						output.write(buffer, 0, n);
					}
					mFileBody = output.toByteArray();
					fileContentStream.close();
				}else{
					mFileBody = new byte[0];
				}
				response.reset();
				if(mFileBody.length > 0)
		        {
		        	char[] charsFileBody = Base64.encode(mFileBody);
	        
		        	response.setContentLength(charsFileBody.length);
		        	System.out.println("mFileBody.length=" + mFileBody.length + " charsFileBody.length=" + charsFileBody.length);
		        	response.getOutputStream().write(getBytes(charsFileBody), 0, charsFileBody.length);	
		        	
					response.getOutputStream().flush();
					response.getOutputStream().close();
		        }
			response.flushBuffer();
		    }catch(Exception e){  
		       e.printStackTrace();  
		    }  
		}
		else if(sOperate.equalsIgnoreCase("upload"))
		{
			System.out.println("upload-----------------------");
			//MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
	        //MultipartFile myfile = multipartRequest.getFile("FileData");
	        //String formData = multipartRequest.getParameter("FormData");
		    iMsgServer2015 MsgObj = new iMsgServer2015();
			try {
				MsgObj.Load(request);
				
			} catch (FileUploadException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} //解析请求
		}

	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String mFilePath = request.getSession().getServletContext().getRealPath("");       //取得服务器路径
		System.out.println("mFilePath = " + mFilePath);
		try{
			System.out.println("AJAXServer-----------------------");
			String mOption = request.getParameter("OPTION");
			String mFileName = request.getParameter("FILENAME");
			String mFileType = request.getParameter("FILETYPE");
			String mRecordID = request.getParameter("RECORDID");
			String mEditType = request.getParameter("EDITTYPE");
			String mUserName = request.getParameter("USERNAME");
			System.out.println("OPTION=" + mOption + " FILENAME=" + mFileName + " USERNAME=" + mUserName + " FILETYPE=" + mFileType + " RECORDID=" + mRecordID + " EDITTYPE=" + mEditType);
			
			if(mOption.equalsIgnoreCase("LOADFILE"))
			{
				System.out.println("LOADFILE-----------");
				byte[] mFileBody = null;
				
				File file = new File(mFilePath+"\\Document\\" + mFileName);
				if(file.exists()){
					InputStream fileContentStream = new FileInputStream(file);
					mFileBody = null;
					ByteArrayOutputStream output = new ByteArrayOutputStream();
					byte[] buffer = new byte[4096];
					int n = 0;
					while (-1 != (n = fileContentStream.read(buffer))) {
						output.write(buffer, 0, n);
					}
					mFileBody = output.toByteArray();
					fileContentStream.close();
				}else{
					mFileBody = new byte[0];
				}

				response.reset();

				if(mFileBody.length > 0)
				{
					char[] charsFileBody = Base64.encode(mFileBody);

					response.setContentLength(charsFileBody.length);
					System.out.println("mFileBody.length=" + mFileBody.length + " charsFileBody.length=" + charsFileBody.length);
					
//					int cnt = 0;
//					byte[] charsByteBody = getBytes(charsFileBody);
//					byte[] tmpByte = new byte[4096];
//					while(cnt <= charsByteBody.length)
//					{
//						System.arraycopy(charsByteBody, cnt, tmpByte, 0, 4096);
//						response.getOutputStream().write(tmpByte);
//						cnt += 4096;
//					}
//					cnt -= 4096;
//					System.arraycopy(charsByteBody, cnt, tmpByte, 0, charsByteBody.length - cnt);
//					response.getOutputStream().write(tmpByte,);
					
//					byte[] bys = new byte[4096];
//					int len = 0 ;
					byte[] charsByteBody = getBytes(charsFileBody);
//					System.out.println("11111111111111");
//					InputStream input = new ByteArrayInputStream(charsByteBody);
//					
//	
//					while ((len = input.read(bys)) != -1) {
//						response.getOutputStream().write(bys,0,len);
//						System.out.println("xxxxxxxxxxxxxxxxx");
//					}
//					System.out.println("2222222222222222");
					response.getOutputStream().write(charsByteBody, 0, charsByteBody.length);	

					response.getOutputStream().flush();
					response.getOutputStream().close();
				}
				response.flushBuffer();
			}
			else if(mOption.equalsIgnoreCase("MultiPartUpload"))
			{
				System.out.println("MultiPartUpload-----------");
				iMsgServer2015 MsgObj = new iMsgServer2015();
				try {
					MsgObj.Load(request);
					
					if (MsgObj.MsgFileSave(mFilePath + "\\Document\\" + mFileName)){
			        	System.out.println(mFileName+"文档已经保存成功");
			        }				
				} catch (FileUploadException e) {
					e.printStackTrace();
				}
				 System.out.println("SendPackage");
				 MsgObj.Send(response, 0);   
			}
			else if(mOption.equalsIgnoreCase("SAVEFILE"))
			{
				System.out.println("SAVEFILE-----------");
				byte[] mFileBody = null;
				
				String base64file = request.getParameter("BASE64FILE");
				System.out.println("11111111111 length= " + base64file.length());
				
				char[] charsFileBody = base64file.toCharArray();
				System.out.println("2222222222");
				mFileBody = Base64.decode( base64file.toCharArray());
				System.out.println("333333333333");
				System.out.println("SAVEFILE mFileBody.length=" + mFileBody.length + " charsFileBody.length=" + charsFileBody.length);
				
				FileOutputStream fos = null;
				BufferedOutputStream bos = null; 
  	    	    try {
    	    	     
	    	    	 File f = new File(mFilePath+"\\Document\\"+mFileName);
		    	     fos = new FileOutputStream(f);  
		             bos = new BufferedOutputStream(fos);  
		             bos.write(mFileBody);  
				}
		    	catch (Exception e) {
		    		System.out.println("error: " + e.toString());
		             e.printStackTrace();  
		        }
		    	finally {  
		            if (bos != null) {  
		                try {  
		                     bos.close();  
		                 } catch (IOException e1) {  
		                     e1.printStackTrace();  
		                 }  
		            }  
		            if (fos != null) {  
		                try {  
		                    fos.close();  
		                } catch (IOException e1) {  
		                    e1.printStackTrace();  
		                }  
		            }  
		        }  
			}
		}catch(Exception e){  
			e.printStackTrace();  
		}  
	}
}
