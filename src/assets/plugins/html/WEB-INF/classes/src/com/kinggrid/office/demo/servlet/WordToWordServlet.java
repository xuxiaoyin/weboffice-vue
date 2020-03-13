package com.kinggrid.office.demo.servlet;

import java.awt.Color;
import java.awt.Font;
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
public class WordToWordServlet extends HttpServlet {

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
			String fileName = req.getParameter("fileName");
			String fileType = req.getParameter("fileType");
			String filepath = webpath + "Document//" + fileName+fileType;
			Log.WriteLog("["+filepath+"]");
			String shortName = fileName + fileType;
			// 已经生成了则不再转换
			if(!Common.IsFileExist(webpath + "/Document/word/word/"+fileName+"/log.log"))
			{
				Document d = Document.getInstance(filepath);
				int bCoument = d.getBookmarkCount(); //获取文档书签数量，书签多可以根据这个做循环插入
				d.setBookmarkText("标题", "云预览修改的地方"); //设置书签值 书签多可以做循环插入
				d.InsertTextWatermark("金 格 科 技",new Font("宋体",5,80),45,Color.RED); //插入水印  参数顺序：1.水印内容，2.Font参数("字体"，阴影（不是很明显默认5就好），字体大小 )，3.旋转角度，4.水印颜色
				//d.SetFontFolder(webpath+"Font");
				if(fileType.equals(".doc")){
					d.saveToDoc(webpath + "/Document/word/word/" + shortName);  //转doc格式
				}else{
					d.saveToDocx(webpath + "/Document/word/word/" + shortName); //转docx格式
				}
				//d.saveToPDF(webpath + "/Document/word/pdf/" + shortName); //设置后转成PDF
				BufferRecordHandle brh = BufferRecordHandle.CreateHandle(webpath + "/Document/word/word/"+fileName+"/log.log", BufferRecordHandle.eWrite);
				brh.AddMainKey("Main");
				String mMD5 = Common.GetMD5HashFromFile(filepath);
				brh.AddSubKey("Main", "MD5", mMD5);
				brh.Flush();
			}
			else
			{
				BufferRecordHandle brh = BufferRecordHandle.CreateHandle(webpath + "/Document/word/word/"+fileName+"/log.log", BufferRecordHandle.eRead);
				String mMD5 = Common.GetMD5HashFromFile(filepath);
				String mOldMD5 = brh.GetValue("Main", "MD5");
				if(!mMD5.equals(mOldMD5))
				{
					Document d = Document.getInstance(filepath);
					if(fileType.equals(".doc")){
						d.saveToDoc(webpath + "/Document/word/word/" + shortName);  //转doc格式
					}else{
						d.saveToDocx(webpath + "/Document/word/word/" + shortName); //转docx格式
					}
					//d.saveToPDF(webpath + "/Document/word/" + shortName);	//设置后转成PDF
					brh = BufferRecordHandle.CreateHandle(webpath + "/Document/word/word/"+fileName+"/log.log", BufferRecordHandle.eWrite);
					brh.AddMainKey("Main");
					brh.AddSubKey("Main", "MD5", mMD5);
					brh.Flush();
				}
			}
			resp.sendRedirect(contextPath + "/samples/PreviewWord/Word.jsp?fileName=" + fileName +"&fileType=" + fileType +"&wordPath=/Document/word/word/");
			//resp.sendRedirect(contextPath + "/Document/word/word/" + shortName);
			long end = System.currentTimeMillis();
			Log.WriteLog("打开word时间(毫秒)", end-start);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
