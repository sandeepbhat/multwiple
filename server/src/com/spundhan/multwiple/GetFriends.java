package com.spundhan.multwiple;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import twitter4j.PagableResponseList;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.auth.AccessToken;

public class GetFriends extends HttpServlet {

	private static final long	serialVersionUID	= 4464407110643237915L;
	private Connection connection;

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
			e.printStackTrace();
		}
		super.destroy();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GetFollowing: enter");

		String user = request.getParameter("user");
		String multUser = request.getParameter("username");
		String group = request.getParameter("gid");
		String session = request.getParameter("session");
		String cursorStr = request.getParameter("cursor");
		boolean followers = Boolean.parseBoolean(request.getParameter("followers")); 

		int userId = 0;
		
		if(user != null){
			userId = Integer.parseInt(user);
		}

		DB db = new DB();
		if(followers) {
			db.logs(userId, multUser, Constants.GET_FOLLOWERS);
		}
		else {
			db.logs(userId, multUser, Constants.GET_FOLLOWING);
		}
		
		long cursor = -1;
		long nextCursor = 0;
		long prevCursor = 0;
		if(cursorStr != null) {
			 cursor = Long.parseLong(cursorStr);
		}
		
		int groupId = 0;
		if(group != null){
			groupId = Integer.parseInt(group);
		}

		System.out.println("GetFollowing: userId:" + userId + ", groupId: " + groupId + ", session: " + session);

		/*
		 * Set the content type(MIME Type) of the response.
		 */
		response.setContentType("application/json");

		PrintWriter out = response.getWriter();


		AccessToken accessToken = db.isSessionValid(userId, groupId, session);
		if(userId == 0 || groupId == 0 || session.equals("") || accessToken == null){
			out.print("{ \"success\": false, \"msg\": \"Authentication failed.\"}");
			out.close();
			System.out.println("getMentions: exit(false)");
			return;
		}

		Twitter twitter = new TwitterFactory().getInstance();
		Properties prop = TwitterProperties.getProperties();
		twitter.setOAuthConsumer(prop.getProperty("consumer.key"), prop.getProperty("consumer.secret"));
		twitter.setOAuthAccessToken(accessToken);
		
		String tweetJSON = "[";
		int friendsCount = 0;
		try {
			
			PagableResponseList<User> friends = null;
			PagableResponseList<User> following = null;
			
			if(followers) {
				friends = twitter.getFollowersStatuses(cursor);
				following = twitter.getFriendsStatuses(cursor);
			}
			else {
				friends = twitter.getFriendsStatuses(cursor);
			}
			
			nextCursor = friends.getNextCursor();
			prevCursor = friends.getPreviousCursor();
			
			for (User friend : friends) {
				System.out.println("Building Friends --> ["+followers+"]["+friend.getScreenName()+"]["+friendsCount+"]");
				if(friendsCount > 0) {
					tweetJSON += ",";
				}
				tweetJSON += "{";
				tweetJSON +=  "\"name\": \""+friend.getScreenName()+"\","+
											"\"followers\":"+ friend.getFollowersCount() + ", " +
											"\"following\":"+ friend.getFriendsCount() + ", " + 
											"\"updates\":"+ friend.getStatusesCount() + ", ";
//											"\"block\":"+twitter.existsBlock(friend.getScreenName()) + ", ";
				
											if(friend.getStatus() == null) {
												tweetJSON += "\"text\":\"\"," +
																			"\"id\": \"0\",";
											}
											else {
												tweetJSON +=  "\"text\":\""+ Constants.escape(friend.getStatus().getText()) + "\"," +
																			"\"id\":\""+friend.getStatus().getId()+"\",";
											}
											
											if(followers) {
												tweetJSON += "\"friend\": "+ ((following.indexOf(friend)==-1)?false:true) +",";
											}
											else {
												tweetJSON += "\"friend\":true, ";
											}
											
											tweetJSON += "\"img\": \""+ Constants.escape(friend.getProfileImageURL().toString())+"\"";
											
				tweetJSON += "}";
				friendsCount++;
			}
		}
		catch (TwitterException e) {
			out.print("{\"success\": false, \"msg\": \"" + TwitterError.getErrorMessage(e.getStatusCode()) + "\"}");
			out.close();
			return;
		}
		catch (NullPointerException e) {
			e.getCause();
			e.printStackTrace();
		}
		
		tweetJSON += "]";
		System.out.println("Built Friends --> ["+ friendsCount + 1 +"]");
		out.print("{ \"success\": true," + "\"prevCursor\": " + prevCursor + "," + "\"nextCursor\": " + nextCursor + "," + "\"result\": " + tweetJSON + " }");
		out.close();
		System.out.println("getMentions("+ userId +"): exit(true)");
	}
}
