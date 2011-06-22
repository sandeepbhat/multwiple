package com.spundhan.multwiple;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import twitter4j.DirectMessage;
import twitter4j.Paging;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.auth.AccessToken;

public class GetDirectMessages extends HttpServlet {


	private static final long serialVersionUID = -8265151299192806614L;
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
		String pageStr = request.getParameter("page");
		int page = 1;
		if(pageStr != null){
			page = Integer.parseInt(pageStr);
		}
		String tweetIdStr = request.getParameter("tweetId");
		long tweetId = 0;
		if(tweetIdStr != null && tweetIdStr.length() > 0){
			tweetId = Long.parseLong(tweetIdStr);
		}

		int userId = 0;
		int groupId = 0;
		if(user != null){
			userId = Integer.parseInt(user);
		}
		
		if(group != null){
			groupId = Integer.parseInt(group);
		}
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		DB db = new DB();
		AccessToken accessToken = db.isSessionValid(userId, groupId, session);
		if(userId == 0 || groupId == 0 || session.equals("") || accessToken == null){
			out.print("{\"success\": false, \"msg\": \"Authentication failed.\"}");
			out.close();
			return;
		}
		
		Twitter twitter = new TwitterFactory().getInstance();
		Properties prop = TwitterProperties.getProperties();
		twitter.setOAuthConsumer(prop.getProperty("consumer.key"), prop.getProperty("consumer.secret"));
		twitter.setOAuthAccessToken(accessToken);

		int newDirectCount = 0;
		String tweetJSON = "[";
		try {
			
			List<DirectMessage> tweets = twitter.getDirectMessages(new Paging(page, 20));
			List<DirectMessage> tweetsSent = twitter.getSentDirectMessages(new Paging(page, 20));
			tweets.addAll(tweetsSent);
			DirectMessageComparator compare = new DirectMessageComparator();
			Collections.sort(tweets, compare);
			
			int i = 0;
			long oldDirectId = getLastReadDirect(userId);
			long newDirectId	= oldDirectId;	
			
			for (DirectMessage status : tweets) {
				
				User tweetFromUser = status.getSender();
				User tweetToUser = status.getRecipient();
				long currentDirectId = status.getId();
				
				if(tweetId == 0 || (tweetId > 0 && tweetId < status.getId())) {
					
					if(i > 0){
						tweetJSON += ",";
					}

					String imgUrl = tweetFromUser.getProfileImageURL().toString();
					String tweetUser = tweetFromUser.getScreenName();
					boolean to = false; 
					if(tweetFromUser.getScreenName().equals(twitter.getScreenName())){
						imgUrl = tweetToUser.getProfileImageURL().toString();
						tweetUser = tweetToUser.getScreenName();
						to = true;
					}
					tweetJSON +="{ " +
					"\"id\": \"" + status.getId() + "\"," +
					"\"text\": \"" + Constants.escape(status.getText()) + "\"," + 
					"\"date\": \"" + Constants.getTimeStr(status.getCreatedAt()) + "\"," +
					"\"to\": " + to + "," + 
					"\"user\": \"" + Constants.escape(tweetUser) + "\"," + 
					"\"img\": \""+ Constants.escape(imgUrl) +"\",";
					
					if(oldDirectId >= currentDirectId){
						tweetJSON += "\"old\":true}";
					}
					else {
						newDirectCount++;
						if(newDirectId < currentDirectId){
							newDirectId = currentDirectId;
						}
						tweetJSON += "\"old\":false}";
					}
					i++;
				}
			}

			if(newDirectId > oldDirectId){
				updateLastReadDirect(userId, newDirectId);
			}
		}
		catch (TwitterException e) {
			e.printStackTrace();
			out.print("{\"success\": false, \"msg\": \"" + TwitterError.getErrorMessage(e.getStatusCode()) + "\"}");
			out.close();
			return;
		}
		
		tweetJSON += "]";

		out.print("{ \"success\": true," +
					"\"page\": " + page + "," +
					"\"result\": " + tweetJSON + "," + 
					"\"count\": "+ newDirectCount + " }");
		out.close();
	}

	private void updateLastReadDirect(int userId, long newDirectId) {
		int m = 0;
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement("UPDATE main.user_tokens SET direct_id=? WHERE id=?");
			ps.setLong(1, newDirectId);
			ps.setInt(2, userId);
		}
		catch (SQLException se) {
			se.printStackTrace();
		}

		try {
			m = ps.executeUpdate();
			ps.close();
		} 
		catch (SQLException se) {
			se.printStackTrace();
		} 
	}

	private long getLastReadDirect(int userId) {
		Statement s = null;
		ResultSet rs = null;
		try {
			s = connection.createStatement();
			rs = s.executeQuery("SELECT direct_id FROM main.user_tokens " +
													"WHERE id="+ userId + ";");
			if (rs.next()) {
				return rs.getLong(1);
			}
			s.close();
		} 
		catch (SQLException se) {
			se.printStackTrace();
		}
		return 0;
	}
}
