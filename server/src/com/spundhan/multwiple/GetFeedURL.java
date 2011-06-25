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

import twitter4j.auth.AccessToken;

public class GetFeedURL extends HttpServlet {

	private static final long	serialVersionUID	= -7718457566153760864L;
	private Logger log;
	private Connection connection;
	
	@Override
	public void init() throws ServletException {
		log = Logger.getRootLogger();
		DB db = new DB();
		connection = db.getConnection();
		super.init();
	}
	
	@Override
	public void destroy() {
		try {
			connection.close();
		}
		catch (SQLException e) {
			log.error("GetFeeds: destroy: SQL Exception: " + e.getMessage());
			e.printStackTrace();
		}
		super.destroy();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		String userIdStr = request.getParameter("user_id");
		String gidStr = request.getParameter("gid");
		String session = request.getParameter("session");
		String multUser = request.getParameter("multUser");
		
		if (Constants.isNull(userIdStr) || Constants.isNull(gidStr) || Constants.isNull(session)) {
			out.print("{\"success\": false, \"msg\": \"Error getting feeds. Please refresh the page and try again.\"}");
			out.close();
			return;
		}
		
		int userId = Integer.parseInt(userIdStr);
		int groupId = Integer.parseInt(gidStr);
		
		DB db = new DB();
		db.logs (userId, multUser, Constants.FEEDS, "Get Feed URL");
		
		AccessToken accessToken = db.isSessionValid(userId, groupId, session);
		if (userId == 0 || groupId == 0 || accessToken == null) {
			out.print("{ \"success\": false, \"msg\": \"Authentication failed.\"}");
			out.close();
			return;
		}
		
		String json = getFeeds (userId, groupId);
		if (json == null) {
			out.print("{ \"success\": false, \"msg\": \"Error getting feeds.\"}");
			out.close();
			return;
		}
		
		out.print("{\"success\": true, \"feeds\": " + json + "}");
		out.close();
	}
	
	private String getFeeds (int userId, int groupId) {
		String query = "SELECT id, feed_url, feed_title FROM main.feeds WHERE user_id = " + userId + " AND group_id = " + groupId + ";";
		String json = "[";
		try {
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);
			int count = 0;
			while (rs.next()) {
				if (count > 0) {
					json += ",";
				}
				json += 
					"{" +
						"\"id\": " + rs.getInt(1) + ", " +
						"\"url\": \"" + rs.getString(2) + "\"," +
						"\"title\": \"" + rs.getString(3) + "\"" +
					"}";
				count++;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			log.error("GetFeeds: getFeeds: SQL Exception: " + e.getMessage());
			return null;
		}

		json += "]";
		return json;
	}
}
