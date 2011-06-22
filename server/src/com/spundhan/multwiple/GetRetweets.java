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

import twitter4j.Paging;
import twitter4j.ResponseList;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.auth.AccessToken;

public class GetRetweets extends HttpServlet {

	private static final long	serialVersionUID	= 5139027181917494095L;

	private Connection connection;

	@Override
	public void init() throws ServletException {
		super.init();
		DB db = new DB();
		connection = db.getConnection();
	}


	@Override
	public void destroy() {
		try {
			connection.close();
		} 
		catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		super.destroy();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("GetRetweets: enter");
		String user = request.getParameter("user");
		String group = request.getParameter("gid");
		String session = request.getParameter("session");
		String pageStr	= request.getParameter("page");
		boolean RTByMe = Boolean.parseBoolean(request.getParameter("RTMe"));

		int userId = 0;
		if(user != null){
			userId = Integer.parseInt(user);
		}
		
		String multUser = request.getParameter("multUser");
		DB db = new DB();
		if(RTByMe) {
			db.logs(userId, multUser, Constants.GET_RT_BY_USER);
		}
		else {
			db.logs(userId, multUser, Constants.GET_RT_TO_USER);
		}

		int page = 1;
		if(pageStr != null) {
			page = Integer.parseInt(pageStr);
		}
		
		int groupId = 0;
		if(group != null){
			groupId = Integer.parseInt(group);
		}

		System.out.println("GetRetweets: userId:" + userId + ", groupId: " + groupId + ", session: " + session);

		response.setContentType("application/json");
		PrintWriter out = response.getWriter();

		AccessToken accessToken = db.isSessionValid(userId, groupId, session);
		if(userId == 0 || groupId == 0 || session.equals("") || accessToken == null){
			out.print("{ success: false, \"msg\": \"Authentication failed.\"};");
			out.close();
			System.out.println("GetRetweets: exit(false)");
			return;
		}

		Twitter twitter = new TwitterFactory().getInstance();
		Properties prop = TwitterProperties.getProperties();
		twitter.setOAuthConsumer(prop.getProperty("consumer.key"), prop.getProperty("consumer.secret"));
		twitter.setOAuthAccessToken(accessToken);
		
		String tweetJSON = "[";

		try {
			
			ResponseList<Status> tweets; 
				
			if(RTByMe) {
				tweets = twitter.getRetweetedByMe(new Paging(page, 20));
			}
			else {
				tweets =  twitter.getRetweetedToMe(new Paging(page, 20));
			}

			int i = 0;

			for (Status status : tweets) {
				User tweetUser = status.getUser();
				Status retweetStatus = status.getRetweetedStatus();
				if(retweetStatus != null) {
					if(i > 0) {
						tweetJSON += ",";
					}
					tweetJSON += "{" +	"\"id\": \"" + status.getId() + "\",";
					tweetJSON +=
											"\"text\": \"" + Constants.escape(retweetStatus.getText()) + "\"," +
											"\"date\": \"" + Constants.getTimeStr(retweetStatus.getCreatedAt()) + "\"," +
											"\"user\": \"" + Constants.escape(retweetStatus.getUser().getScreenName()) + "\"," +
											"\"src\": \"" + Constants.escape(retweetStatus.getSource()) + "\"," +
											"\"img\": \""+ Constants.escape(retweetStatus.getUser().getProfileImageURL().toString()) +"\"," +
											"\"RT\":\""+tweetUser.getScreenName()+"\"," +
											"\"RID\": \"" + retweetStatus.getId() + "\",";
					if(retweetStatus.isFavorited()) {
						tweetJSON += "\"favorite\":true";
					}
					else {
						tweetJSON += "\"favorite\":false";
					}
					tweetJSON += "}";
					i++;
				}
			}
		}
		catch (TwitterException e) {
			out.print("{\"success\": false, \"msg\": \"" + TwitterError.getErrorMessage(e.getStatusCode()) + "\"}");
			out.close();
			return;
		}
		tweetJSON += "]";

		out.print("{ \"success\": true, \"page\":"+page+", \"result\": " + tweetJSON + "}");
		out.close();
		System.out.println("GetRetweets("+ userId +"): exit(true)");
		return;
	}
}
