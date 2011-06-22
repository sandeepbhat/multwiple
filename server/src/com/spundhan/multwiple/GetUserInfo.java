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

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.AccessToken;

public class GetUserInfo extends HttpServlet {

	private static final long	serialVersionUID	= 8868674602338196250L;
	
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

		String user = request.getParameter("multUserId");
		String multUsername = request.getParameter("multUsername");
		String group = request.getParameter("gid");
		String session = request.getParameter("session");
		String username = request.getParameter("username");

		int userId = 0;
		int groupId = 0;
		
		if(user != null){
			userId = Integer.parseInt(user);
		}

		DB db = new DB();
		db.logs(userId, multUsername, Constants.GET_USER_INFO);

		if(group != null){
			groupId = Integer.parseInt(group);
		}

		System.out.println("GetUserInfo: userId:" + userId + ", groupId: " + groupId + ", session: " + session);

		response.setContentType("application/json");

		PrintWriter out = response.getWriter();

		AccessToken accessToken = db.isSessionValid(userId, groupId, session);
		
		if(userId == 0 || groupId == 0 || session.equals("") || accessToken == null){
			out.print("{ \"success\": false, \"msg\": \"Authentication failed.\"}");
			out.close();
			System.out.println("GetFriendUpdates: exit(false)");
			return;
		}

		Twitter twitter = new TwitterFactory().getInstance();
		Properties prop = TwitterProperties.getProperties();
		twitter.setOAuthConsumer(prop.getProperty("consumer.key"), prop.getProperty("consumer.secret"));
		twitter.setOAuthAccessToken(accessToken);

		String twitterJSON = "\"user\":{";
		try {
			twitter4j.User twitterUser = twitter.showUser(username);
			twitterJSON +=  "\"followers\":"+ twitterUser.getFollowersCount() + ", " +
											"\"following\":"+ twitterUser.getFriendsCount() + ", " + 
											"\"updates\":"+ twitterUser.getStatusesCount() + ", " + 
											"\"status\":\""+ Constants.escape(twitterUser.getStatus().getText()) +"\","+
											"\"friend\":"+twitter.existsFriendship(multUsername, username);
		}
		catch (TwitterException e) {
			e.printStackTrace();
			out.print("{\"success\": false, \"msg\": \""+TwitterError.getErrorMessage(e.getStatusCode())+"\"}");
			out.close();
			System.out.println("GetFriendUpdates: exit(false)");
			return;
		}
		twitterJSON += "}";
		out.print("{\"success\":true, "+twitterJSON+"}");
		out.close();
	}
}
