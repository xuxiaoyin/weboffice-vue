package com.kinggrid.office.demo.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class WordToIMGServlet extends HttpServlet {

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
		resp.setHeader("content-type","text/html;charset=UTF-8");  
		String contextPath = req.getSession().getServletContext().getContextPath();
		//String webpath = req.getSession().getServletContext().getRealPath("/");
		String fileName = req.getParameter("filename");
		String pnos=req.getParameter("pageno");
		int pno=Integer.parseInt(pnos);
		String shortName = pno+ ".png";
		resp.sendRedirect(contextPath + "/Document/word/img/"+fileName+"/"+ shortName);
		return ;
	}
}
