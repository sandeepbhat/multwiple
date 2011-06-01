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
import twitter4j.http.AccessToken;

public class GetUserStat extends HttpServlet {

	private static final long	serialVersionUID	= -3996655797857261039L;
	
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

		String user = request.getParameter("userId");
		String group = request.getParameter("gid");
		String session = request.getParameter("session");
		String username = request.getParameter("username");

		int userId = 0;
		int groupId = 0;
		
		if(user != null){
			userId = Integer.parseInt(user);
		}

		if(group != null){
			groupId = Integer.parseInt(group);
		}

		System.out.println("GetUserStat: userId:" + userId + ", groupId: " + groupId + ", session: " + session);

		/*
		 * Set the content type(MIME Type) of the response.
		 */
		response.setContentType("application/json");

		PrintWriter out = response.getWriter();

		DB db = new DB();
		
		AccessToken accessToken = db.isSessionValid(userId, groupId, session);
		
		if(userId == 0 || groupId == 0 || session.equals("") || accessToken == null){
			out.print("{ \"success\": false, \"msg\": \"Authentication failed.\"}");
			out.close();
			System.out.println("GetUserStat: exit(false)");
			return;
		}

		Properties prop = TwitterProperties.getProperties();
		Twitter twitter = new TwitterFactory().getOAuthAuthorizedInstance(prop.getProperty("consumer.key"), prop.getProperty("consumer.secret"), accessToken);
		String twitterJSON = "\"user\":{";
		try {
			twitter4j.User twitterUser = twitter.showUser(username);
			twitterJSON +=  "\"followers\":"+ twitterUser.getFollowersCount() + ", " +
											"\"following\":"+ twitterUser.getFriendsCount() + ", " + 
											"\"tweets\":"+ twitterUser.getStatusesCount()+", " +
											"\"favorites\":"+twitterUser.getFavouritesCount();
		}
		catch (TwitterException e) {
			e.printStackTrace();
			out.print("{\"success\": false, \"msg\": \""+TwitterError.getErrorMessage(e.getStatusCode())+"\"}");
			out.close();
			System.out.println("GetUserStat: exit(false)");
			return;
		}
		twitterJSON += "}";
		out.print("{\"success\":true, "+twitterJSON+"}");
		out.close();
	}
}
