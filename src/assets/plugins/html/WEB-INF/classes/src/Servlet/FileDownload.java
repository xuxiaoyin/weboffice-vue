package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DBstep.iMsgServer2015;

public class FileDownload extends HttpServlet {
    private iMsgServer2015 MsgObj = new iMsgServer2015();
    
	public void doGet(HttpServletRequest request, HttpServletResponse response)	throws ServletException, IOException 
	{
		String mServerPath = request.getSession().getServletContext().getRealPath("");       //取得服务器路径
		String mFileName = request.getParameter("FileName");
		
		System.out.println("mServerPath = " + mServerPath);
		System.out.println("mFileName = " + mFileName);
		
		if (MsgObj.MsgFileLoad(mServerPath + mFileName))
		{
        	System.out.println(mServerPath + mFileName);
        }
		System.out.println("SendPackage");
		 
		 MsgObj.Send(response, 0);   
	}
}
