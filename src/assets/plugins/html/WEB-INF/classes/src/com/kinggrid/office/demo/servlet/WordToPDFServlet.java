package com.kinggrid.office.demo.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kinggrid.office.demo.common.BufferRecordHandle;
import com.kinggrid.office.demo.common.Common;
import com.kinggrid.office.demo.utils.Base64Util;

import iweboffice.preview.words.Document;

import com.kinggrid.office.demo.common.*;
public class WordToPDFServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		resp.setHeader("content-type", "text/html;charset=UTF-8");
		long start = System.currentTimeMillis();
		try {
			String contextPath = req.getSession().getServletContext().getContextPath();
			String webpath = req.getSession().getServletContext().getRealPath("/");
			String fileName = req.getParameter("filename");
			String fileType = req.getParameter("filetype");
			String filepath = webpath + "Document//" + fileName+fileType;
			Log.WriteLog("["+filepath+"]");
			String shortName = fileName + ".pdf";
			// 已经生成了则不再转换
			if(!Common.IsFileExist(webpath + "/Document/word/pdf/"+fileName+"/log.log"))
			{
				Document d = Document.getInstance(filepath);
				//d.SetFontFolder(webpath+"Font");
				d.saveToPDF(webpath + "/Document/word/pdf/" + shortName);
				BufferRecordHandle brh = BufferRecordHandle.CreateHandle(webpath + "/Document/word/pdf/"+fileName+"/log.log", BufferRecordHandle.eWrite);
				brh.AddMainKey("Main");
				String mMD5 = Common.GetMD5HashFromFile(filepath);
				brh.AddSubKey("Main", "MD5", mMD5);
				brh.Flush();
			}
			else
			{
				BufferRecordHandle brh = BufferRecordHandle.CreateHandle(webpath + "/Document/word/pdf/"+fileName+"/log.log", BufferRecordHandle.eRead);
				String mMD5 = Common.GetMD5HashFromFile(filepath);
				String mOldMD5 = brh.GetValue("Main", "MD5");
				if(!mMD5.equals(mOldMD5))
				{
					Document d = Document.getInstance(filepath);
					d.saveToPDF(webpath + "/Document/word/pdf/" + shortName);
					brh = BufferRecordHandle.CreateHandle(webpath + "/Document/word/pdf/"+fileName+"/log.log", BufferRecordHandle.eWrite);
					brh.AddMainKey("Main");
					brh.AddSubKey("Main", "MD5", mMD5);
					brh.Flush();
				}
			}
			resp.sendRedirect(contextPath + "/Document/word/pdf/" + shortName);
			long end = System.currentTimeMillis();
			Log.WriteLog("打开PDF时间(毫秒)", end-start);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
