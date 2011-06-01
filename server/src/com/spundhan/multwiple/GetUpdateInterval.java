package com.spundhan.multwiple;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetUpdateInterval extends HttpServlet {

	/**
	 * 
	 */
	private static final long	serialVersionUID	= 1L;

	protected void  doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("GetUpdateInterval: enter");
		
		int groupId = Integer.parseInt(request.getParameter("gid"));
		String session = request.getParameter("session");

		PrintWriter out = response.getWriter();
		response.setContentType("application/json");


		DB db = new DB();

		if(!db.isGroupValid(groupId, session)) {
			out.print("{\"success\" : false}");
			out.close();
			System.out.println("GetUpdateInterval (3): exit(false)");
			return;
		}
		
		int interval = db.getUpdateInterval(groupId);
		
		if(interval <= -1) {
			out.print("{\"success\" : false}");
			out.close();
			System.out.println("GetUpdateInterval (4): exit(false)");
			return;
		}
		
		out.print("{\"success\" : true, \"update_interval\" : "+interval+"}");
		out.close();
		System.out.println("GetUpdateInterval : exit(true)");
	}

}
