package com.spundhan.multwiple;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class registerUser
 */
public class CheckLogin extends HttpServlet {

	private static final long serialVersionUID = -872625933096069088L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.err.println("/s/getLogin: enter");
		Cookies cookies = new Cookies(request);
		int groupId = cookies.getGroupId();
		String session = cookies.getSession();
		int interval = cookies.getUpdateInterval();
		
		System.out.println("Group ID:" + groupId + ", Session: " + session);
		// send email notification
//		new EmailThread(request.getServerName(), request.getRemoteAddr(), request.getRemoteHost(), "CheckLogin\n GroupId:" + groupId + "\nSession: " + session).start();

		System.out.println("Group ID:" + groupId + ", Session: " + session);
		/*
		* Set the content type(MIME Type) of the response.
		*/
		response.setContentType("application/json");

		PrintWriter out = response.getWriter();
		
		if(session == null || groupId == 0){
			cookies.deleteAllCookies(response);
			out.print("var login_state = { success: false};");
			System.out.println("CheckLogin: exit1(false)");
			return;
		}
		
		// add record in the DB
		if((interval = isSessionValid(groupId, session)) == 0){
			cookies.deleteAllCookies(response);
			out.print("var login_state = {success: false};");
			System.out.println("CheckLogin: exit2(false)");
			return;
		}

		cookies.setGroupId(groupId);
		cookies.setSession(session);
		cookies.setUpdateInterval(interval);
		cookies.createCookies(response);
		out.print("var login_state = {\"success\":true, \"gid\":"+ groupId +", \"session\": \"" + session +"\", \"interval\": "+ interval +", \"users\":" + cookies.getUsersJSON() + "};");
		out.close();
		
		System.out.println("CheckLogin: exit(true)");
	}

	private int isSessionValid(int groupId, String session) {
		DB db = new DB();
		Connection connection = db.getConnection();
		Statement s = null;
		ResultSet rs = null;
		int result = 0;
		System.out.println("isSessionValid: enter");

		try {
			s = connection.createStatement();
			rs = s.executeQuery("SELECT update_interval FROM main.user_group " +
					"WHERE id = '"+ groupId +"' AND group_salt='"+ session +"';");
			if (rs.next()) {
				result = rs.getInt(1);
			}
			s.close();
		} catch (SQLException se) {
			System.err.println("We got an exception while executing our query:" +
			"that probably means our SQL is invalid");
			se.printStackTrace();
			System.out.println("queryUserData: exit(null)");
			return 0;
		}

		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}


}
