package com.spundhan.multwiple_admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetUsers extends HttpServlet {
	private static final long	serialVersionUID	= 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		DB db = new DB();
		String [] users = db.getUsers();
		if(users == null) {
			out.print("{\"success\": false, \"msg\":\"No Users Found\"}");
			out.close();
			return;
		}
		String reply = "";
		int count = 0;
		for(String user : users) {
			if(count > 0) {
				reply += ",";
			}
			reply += "{\"name\": \""+user+"\"}";
			count ++;
		}
		out.print("{\"success\": true, \"users\": ["+reply+"]}");
		out.close();
	}
}
