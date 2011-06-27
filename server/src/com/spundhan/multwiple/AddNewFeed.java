package com.spundhan.multwiple;

import it.sauronsoftware.feed4j.FeedIOException;
import it.sauronsoftware.feed4j.FeedParser;
import it.sauronsoftware.feed4j.FeedXMLParseException;
import it.sauronsoftware.feed4j.UnsupportedFeedException;
import it.sauronsoftware.feed4j.bean.Feed;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
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

public class AddNewFeed extends HttpServlet {

	private static final long	serialVersionUID	= 551165497515414350L;
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
		String url = request.getParameter("url");
		
		if (Constants.isNull(userIdStr) || Constants.isNull(gidStr) || Constants.isNull(session) || Constants.isNull(url)) {
			out.print("{\"success\": false, \"msg\": \"Error getting feeds. Please refresh the page and try again.\"}");
			out.close();
			return;
		}
		
		url = url.trim();
		
		String feedTitle = null;
		
		try {
			URL feedUrl = new URL(url);
			Feed feed = FeedParser.parse(feedUrl);
			feedTitle = feed.getHeader().getTitle();
			feedTitle = feedTitle.replaceAll("'", "''");
			feedTitle = Constants.escape(feedTitle);
			log.debug("AddNewFeed: Feed: " + feedTitle);
		}
		catch (MalformedURLException e) {
			log.error("AddNewFeed: MalformedURLException: " + e.getMessage());
			e.printStackTrace();
			out.print("{\"success\": false, \"msg\": \"Invalid URL specified.\"}");
			out.close();
			return;
		}
		catch (FeedIOException e) {
			log.error("AddNewFeed: FeedIOException: " + e.getMessage());
			e.printStackTrace();
			out.print("{\"success\": false, \"msg\": \"Error validating feeds from URL.\"}");
			out.close();
			return;
		}
		catch (FeedXMLParseException e) {
			log.error("AddNewFeed: FeedXMLParseException: " + e.getMessage());
			e.printStackTrace();
			out.print("{ \"success\": false, \"msg\": \"Error while processing feed.\"}");
			out.close();
			return;
		}
		catch (UnsupportedFeedException e) {
			log.error("AddNewFeed: UnsupportedFeedException: " + e.getMessage());
			e.printStackTrace();
			out.print("{ \"success\": false, \"msg\": \"Feed type not supported.\"}");
			out.close();
			return;
		}
		
		int userId = Integer.parseInt(userIdStr);
		int groupId = Integer.parseInt(gidStr);
		
		DB db = new DB();
		db.logs (userId, multUser, Constants.FEEDS, "Add New Feed URL");

		AccessToken accessToken = db.isSessionValid(userId, groupId, session);
		if (userId == 0 || groupId == 0 || accessToken == null) {
			out.print("{ \"success\": false, \"msg\": \"Authentication failed.\"}");
			out.close();
			return;
		}
		
		boolean exists = feedExists(url, userId, groupId);
		if (exists) {
			out.print("{\"success\": false, \"msg\": \"Feed already exists.\"}");
			out.close();
			return;
		}
		
		boolean success = addNewFeed (url, feedTitle, userId, groupId);
		if (!success) {
			out.print("{ \"success\": false, \"msg\": \"Error adding feeds.\"}");
			out.close();
			return;
		}
		
		out.print("{\"success\": true}");
		out.close();
	}
	
	private boolean addNewFeed (String url, String feedTitle, int userId, int groupId) {
		String query = "INSERT INTO main.feeds (feed_url, feed_title, user_id, group_id) VALUES ('" + url + "', '" + feedTitle + "', " + userId + ", " + groupId + ");";
		log.debug("AddNewFeed: addNewFeed: Query: " + query);
		try {
			Statement statement = connection.createStatement();
			int count = statement.executeUpdate(query);
			if (count > 0) {
				return true;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			log.error("GetFeeds: getFeeds: SQL Exception: " + e.getMessage());
			return false;
		}
		return false;
	}
	
	private boolean feedExists (String url, int userId, int groupId) {
		String query = 
			"SELECT " +
				"COUNT(id) " +
			"FROM " +
				"main.feeds " +
			"WHERE " +
				"feed_url = '" + url + "' " +
				"AND user_id = " + userId + " " +
				"AND group_id = " + groupId + ";";
		log.debug("AddNewFeed: feedExists: Query: " + query);
		try {
			Statement statement = connection.createStatement();
			ResultSet rs = statement.executeQuery(query);
			if (rs.next()) {
				if (rs.getInt(1) == 1) {
					statement.close();
					return true;
				}
			}
			statement.close();
		}
		catch (SQLException e) {
			e.printStackTrace();
			log.error("GetFeeds: feedExists: SQL Exception: " + e.getMessage());
			return false;
		}
		return false;
	}
}
