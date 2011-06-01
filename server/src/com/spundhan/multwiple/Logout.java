package com.spundhan.multwiple;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Logout extends HttpServlet {


	private static final long serialVersionUID = -8265151299192806614L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = null;
		String session = null;
		Cookies cookies = new Cookies(request);
		username = cookies.getParentUser();
		session = cookies.getSession();

		System.err.println("Username: " + username + ", Session: " + session);
		/*
		* Set the content type(MIME Type) of the response.
		*/
		response.setContentType("application/json");

		PrintWriter out = response.getWriter();
		
		if(session == null || username == null){
			out.print("{\"success\": false, \"msg\": \"Sorry. You are not logged in.\"}");
			return;
		}
		
		// reset record in the DB
//		DB myDB = new DB();
//		int member_id = myDB.validateCookie(username, session);
//		System.err.println("member id: " + member_id);
//		if(member_id == -1){
//			out.print("{success: false, msg: 'Sorry. You are not logged in.'}");
//			return;
//		}
//
//		Calendar c = Calendar.getInstance();
//		c.add(Calendar.DATE, -1);
//		if(!myDB.updateUserLogin(member_id, "", "", c.getTime(), 0)){
//			out.print("{success: false, msg: 'Sorry. You are not logged in.'}");
//			out.close();
//			return;
//		}
//
//		cookies.deleteAllCookies(response);
		
		out.print("{\"success\": true }");
		out.close();
		return;
		
	}


}
