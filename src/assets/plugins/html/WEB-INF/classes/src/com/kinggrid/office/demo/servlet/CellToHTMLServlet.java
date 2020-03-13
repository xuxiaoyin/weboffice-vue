package com.kinggrid.office.demo.servlet;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kinggrid.office.demo.common.BufferRecordHandle;
import com.kinggrid.office.demo.common.Common;
import com.kinggrid.office.demo.common.GenerateFile;
import com.kinggrid.office.demo.common.Log;
import com.kinggrid.office.demo.utils.Base64Util;

import iweboffice.preview.cells.Workbook;

public class CellToHTMLServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	GenerateFile generateFile = new GenerateFile();

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
			String fileName=req.getParameter("fileName");
			String fileType=req.getParameter("fileType");
			String filepath = webpath + "Document\\" + fileName + fileType;
			System.out.println("HTMLfilepath=" + filepath);
			Log.WriteLog("[" + filepath + "]");
			String shortName = fileName + ".html";
			synchronized (this) {//添加一个同步锁
				// 已经生成了则不再转换
				if (!Common.IsFileExist(webpath + "Document\\excel\\html\\"+ fileName + "/log.log")) {
					Workbook w = Workbook.getInstance(filepath);
					w.saveToHTML(webpath + "Document\\excel\\html\\"+ fileName + "/" + shortName);
					BufferRecordHandle brh = BufferRecordHandle.CreateHandle(
							webpath + "Document\\excel\\html\\"+ fileName + "/log.log", BufferRecordHandle.eWrite);
					brh.Flush();
				} else {
					BufferRecordHandle brh = BufferRecordHandle.CreateHandle(
							webpath + "Document\\excel\\html\\"+ fileName + "/log.log", BufferRecordHandle.eRead);
						Workbook w = Workbook.getInstance(filepath);
						w.saveToHTML(webpath + "Document\\excel\\html\\"+ fileName + "/" + shortName);
						brh = BufferRecordHandle.CreateHandle(webpath + "Document\\excel\\html\\"+ fileName + "/log.log",
								BufferRecordHandle.eWrite);
						brh.Flush();
				}
			}
			//System.out.println(contextPath + "\\Document\\excel\\html\\"+ fileName + "\\" + shortName);
			resp.sendRedirect(contextPath + "\\Document\\excel\\html\\"+ fileName + "\\" + shortName);
			long end = System.currentTimeMillis();
			Log.WriteLog("打开HTML时间(毫秒)", end - start);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
