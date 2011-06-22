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

import org.apache.log4j.Logger;

public class CheckLogin extends HttpServlet {

	private static final long serialVersionUID = -872625933096069088L;
	private Logger log;
	
	@Override
	public void init() throws ServletException {
		log = Logger.getRootLogger();
		super.init();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		Cookies cookies = new Cookies(request);
		int groupId = cookies.getGroupId();
		String session = cookies.getSession();
		int interval = cookies.getUpdateInterval();
		
		log.debug("CheckLogin: Group ID: " + groupId + ", Session: " + session);

		if (session == null || groupId == 0) {
			cookies.deleteAllCookies(response);
			out.print("var login_state = { success: false};");
			log.error("CheckLogin: session or groupId is incorrect.");
			return;
		}
		
		if ((interval = isSessionValid(groupId, session)) == 0) {
			cookies.deleteAllCookies(response);
			out.print("var login_state = {success: false};");
			log.error("CheckLogin: User session is no more valid.");
			return;
		}

		cookies.setGroupId(groupId);
		cookies.setSession(session);
		cookies.setUpdateInterval(interval);
		cookies.createCookies(response);
		out.print("var login_state = {\"success\":true, \"gid\":"+ groupId +", \"session\": \"" + session +"\", \"interval\": "+ interval +", \"users\":" + cookies.getUsersJSON() + "};");
		out.close();
		
		log.debug("CheckLogin: All OK. Login success.");
	}

	private int isSessionValid(int groupId, String session) {
		DB db = new DB();
		Connection connection = db.getConnection();
		Statement s = null;
		ResultSet rs = null;
		int result = 0;
		try {
			s = connection.createStatement();
			rs = s.executeQuery("SELECT update_interval FROM main.user_group " +
					"WHERE id = '"+ groupId +"' AND group_salt='"+ session +"';");
			if (rs.next()) {
				result = rs.getInt(1);
			}
			s.close();
		}
		catch (SQLException se) {
			se.printStackTrace();
			log.error("CheckLogin: isSessionValid: SQL Exception: " + se.getMessage());
			return 0;
		}

		try {
			connection.close();
		}
		catch (SQLException e) {
			log.error("CheckLogin: isSessionValid: SQL Exception: " + e.getMessage());
			e.printStackTrace();
		}
		return result;
	}


}
