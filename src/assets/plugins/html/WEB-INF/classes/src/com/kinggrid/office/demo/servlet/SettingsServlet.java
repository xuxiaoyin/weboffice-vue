package com.kinggrid.office.demo.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kinggrid.office.demo.model.PropertyUtil;
import com.kinggrid.office.demo.model.Settings;

public class SettingsServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3233533911781378098L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// req.setCharacterEncoding("utf-8");
		// resp.setCharacterEncoding("utf-8");
		// resp.setHeader("content-type", "text/html;charset=UTF-8");

		String uploadpath = (String) req.getParameter("uploadPath");
		if (uploadpath != null) {
			PropertyUtil mPropertyUtil = PropertyUtil.getInstance("config.properties");
			mPropertyUtil.writeProperties("OfficeDoc", uploadpath);
			Settings.uploadPath = uploadpath;
		}
		// 目录不存在则创建
		File file = new File(Settings.uploadPath);
		if (!file.exists()) {
			file.mkdirs();
		}

	}
}
