package com.spundhan.multwiple;

import it.sauronsoftware.feed4j.FeedIOException;
import it.sauronsoftware.feed4j.FeedParser;
import it.sauronsoftware.feed4j.FeedXMLParseException;
import it.sauronsoftware.feed4j.UnsupportedFeedException;
import it.sauronsoftware.feed4j.bean.Feed;
import it.sauronsoftware.feed4j.bean.FeedItem;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import twitter4j.auth.AccessToken;

public class GetFeeds extends HttpServlet {

	private static final long	serialVersionUID	= 758185310062479500L;
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
		
		if (Constants.isNull(userIdStr) || Constants.isNull(gidStr) || Constants.isNull(session)) {
			out.print("{\"success\": false, \"msg\": \"Error getting feeds. Please refresh the page and try again.\"}");
			out.close();
			return;
		}
		
		int userId = Integer.parseInt(userIdStr);
		int groupId = Integer.parseInt(gidStr);
		
		AccessToken accessToken = new DB().isSessionValid(userId, groupId, session);
		if (userId == 0 || groupId == 0 || accessToken == null) {
			out.print("{ \"success\": false, \"msg\": \"Authentication failed.\"}");
			out.close();
			return;
		}

		String json = getFeed(url);
		if (json == null) {
			out.print("{\"success\": false, \"msg\": \"Error getting feeds.\"}");
			out.close();
			return;
		}
		
		out.print("{\"success\": true, \"feeds\": " + json + "}");
		out.close();
	}
	
	private String getFeed (String url) {
		String json = "[";
		try {
			URL feedUrl = new URL(url);
			Feed feed = FeedParser.parse(feedUrl);
			int feedCount = feed.getItemCount();
			int i;
			for (i = 0; i < feedCount; i++) {
				FeedItem item = feed.getItem(i);
				if (i > 0) {
					json += ",";
				}
				json += 
					"{" +
						"\"guid\": \"" + item.getGUID() + "\", " +
						"\"title\": \"" + ((item.getTitle() == null) ? "" : Constants.escape(item.getTitle())) + "\", " +
						"\"link\": \"" +  ((item.getLink() == null) ? "" : Constants.escape(item.getLink().toString())) + "\", " +
						"\"text\": \"" +  ((item.getDescriptionAsText() == null) ? "" : Constants.escape(item.getDescriptionAsText())) + "\", " +
						"\"date\": \"" +  ((item.getPubDate() == null) ? "" : item.getPubDate()) + "\"" +
					"}";
			}
		}
		catch (MalformedURLException e) {
			log.error("GetFeed: MalformedURLException: " + e.getMessage());
			e.printStackTrace();
			return null;
		}
		catch (FeedIOException e) {
			log.error("GetFeed: FeedIOException: " + e.getMessage());
			e.printStackTrace();
			return null;
		}
		catch (FeedXMLParseException e) {
			log.error("GetFeed: FeedXMLParseException: " + e.getMessage());
			e.printStackTrace();
			return null;
		}
		catch (UnsupportedFeedException e) {
			log.error("GetFeed: UnsupportedFeedException: " + e.getMessage());
			e.printStackTrace();
			return null;
		}
		
		json += "]";
		return json;
	}
}
