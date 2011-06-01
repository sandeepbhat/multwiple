package com.spundhan.multwiple;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import twitter4j.DirectMessage;
import twitter4j.Paging;
import twitter4j.ResponseList;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.http.AccessToken;

public class GetFriendUpdateCount extends HttpServlet {

	/**
	 * 
	 */
	private static final long	serialVersionUID	= 1L;
	private Connection	connection;

	public void init() throws ServletException {
		super.init();
		DB db = new DB();
		connection = db.getConnection();
	}

	
	@Override
	public void destroy() {
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		super.destroy();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user = request.getParameter("user");
		String group = request.getParameter("gid");
		String session = request.getParameter("session");

		int userId = 0;
		int groupId = 0;
		if(user != null && user.length() > 0){
			userId = Integer.parseInt(user);
		}
		
		if(group != null && group.length() > 0){
			groupId = Integer.parseInt(group);
		}
		
		System.out.println("GetFriendUpdateCount: userId:" + userId + ", groupId: " + groupId + ", session: " + session);
		
		/*
		* Set the content type(MIME Type) of the response.
		*/
		response.setContentType("application/json");

		PrintWriter out = response.getWriter();
		
		DB db = new DB();
		AccessToken accessToken = db.isSessionValid(userId, groupId, session);
		if(userId == 0 || groupId == 0 || session.equals("") || accessToken == null){
			out.print("{\"success\": false, \"msg\": \"Authentication failed.\"}");
			out.close();
			System.out.println("GetFriendUpdateCount: exit(false)");
			return;
		}
		
		Properties prop = TwitterProperties.getProperties();
		Twitter twitter = new TwitterFactory().getOAuthAuthorizedInstance(prop.getProperty("consumer.key"), prop.getProperty("consumer.secret"), accessToken);
		int newTweetCount = 0;
		try {
			
			ResponseList<Status> tweets = twitter.getHomeTimeline();
			
			long oldTweetId = getLastReadTweet(userId);
			
			for (Status status : tweets) {
					System.out.println("OLD >> ["+oldTweetId+"] NEW >> ["+status.getId()+"]");
					if(oldTweetId < status.getId()){
						newTweetCount++;
					}
			}

		} catch (TwitterException e) {
			//		e.printStackTrace();
//			System.err.println("ERROR: " + e.getLocalizedMessage());
			out.print("{\"success\": false, \"msg\": \"" + TwitterError.getErrorMessage(e.getStatusCode()) + "\"}");
			out.close();
			return;
		}

		out.print("{ \"success\": true," +
					"\"count\": "+ newTweetCount + " }");
		out.close();
		System.out.println("GetFriendUpdateCount("+ userId +"): exit(true)");
		return;
	}
	
	private long getLastReadTweet(int userId) {
		Statement s = null;
		ResultSet rs = null;
		System.out.println("getLastReadTweet: enter:" + userId);
		try {
			s = connection.createStatement();
			rs = s.executeQuery("SELECT home_id FROM main.user_tokens " +
													"WHERE id="+ userId + ";");
			if (rs.next()) {
				return rs.getLong(1);
			}
			s.close();
		} catch (SQLException se) {
			System.err.println("We got an exception while executing our query:" +
			"that probably means our SQL is invalid");
			se.printStackTrace();
		}
		System.out.println("getLastReadTweet: exit(false) :" + userId);
		return 0;
	}
	
}
