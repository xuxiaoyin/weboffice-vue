package com.kinggrid.office.demo.servlet;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.kinggrid.office.demo.model.FileOpts;
import com.kinggrid.office.demo.model.PageReturnInfo;
import com.kinggrid.office.demo.model.Settings;
import com.kinggrid.office.demo.utils.Base64Util;

public class OfficeServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4039590386008902588L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int page = (Integer.parseInt(req.getParameter("page")));
		int size = (Integer.parseInt(req.getParameter("limit")));
		int pagestart = (page - 1) * size;
		int pageend = pagestart + size;

		String filePathPre = Settings.uploadPath;
		if (filePathPre == null) {
			filePathPre = "";
		}

		List<FileOpts> list = new ArrayList<FileOpts>();
		// 解析目录
		File file = new File(Settings.uploadPath);
		// 目录不存在新建
		if (!file.exists()) {
			file.mkdirs();
		}
		File[] tempList = file.listFiles();
		ArrayList<File> fileslist = new ArrayList<File>();
		// 过滤出文件，排除文件夹
		for (int i = 0; i < tempList.length; i++) {
			if (tempList[i].isFile()) {
				fileslist.add(tempList[i]);
			}
		}
		// 文件分页返回
		for (int i = pagestart; (i < pageend) && (i < fileslist.size()); i++) {
			if (fileslist.get(i).isFile()) {
				String filename = fileslist.get(i).getName();
				String canonicalPath = fileslist.get(i).getCanonicalPath();
				FileOpts fo = new FileOpts(filename, filename.substring(filename.lastIndexOf(".") + 1),
						Base64Util.encode(canonicalPath));
				list.add(fo);
			}
		}
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		resp.setHeader("content-type", "text/html;charset=UTF-8");
		PageReturnInfo pageinfo = new PageReturnInfo();
		pageinfo.setData(list);
		pageinfo.setCount(fileslist.size());
		String json = JSON.toJSONString(pageinfo);
		resp.getWriter().print(json);
	}

}
