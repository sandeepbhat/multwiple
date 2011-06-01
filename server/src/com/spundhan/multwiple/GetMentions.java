package com.spundhan.multwiple;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import twitter4j.Paging;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.http.AccessToken;

public class GetMentions extends HttpServlet {


	private static final long serialVersionUID = -8265151299192806614L;
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		super.destroy();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("GetMentions: enter");
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
		
		System.out.println("GetMentions: userId:" + userId + ", groupId: " + groupId + ", session: " + session);
		
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
			System.out.println("getMentions: exit(false)");
			return;
		}
		
		Properties prop = TwitterProperties.getProperties();
		Twitter twitter = new TwitterFactory().getOAuthAuthorizedInstance(prop.getProperty("consumer.key"), prop.getProperty("consumer.secret"), accessToken);
		String tweetJSON = "[";
		int newMentionCount = 0;
		
		try {
			List<Status> tweets = twitter.getMentions(new Paging(page, 20));
			int i = 0;
			long oldMentionId = getLastReadMention(userId);
			long newMentionId = oldMentionId;
			
			for (Status status : tweets) {
				User tweetUser = status.getUser();
				long currentMentionId = status.getId();
				
				if(tweetId == 0 || (tweetId > 0 && tweetId < status.getId())){
					if(i > 0){
						tweetJSON += ",";
					}

					tweetJSON +="{ " +
					"\"id\": \"" + currentMentionId + "\"," +
					"\"text\": \"" + Constants.escape(status.getText()) + "\"," + 
					"\"date\": \"" + Constants.getTimeStr(status.getCreatedAt()) + "\"," +
					"\"user\": \"" + Constants.escape(tweetUser.getScreenName()) + "\"," +
					"\"src\": \"" + Constants.escape(status.getSource()) + "\"," +
					"\"img\": \""+ Constants.escape(tweetUser.getProfileImageURL().toString()) +"\",";
					
					if(status.isFavorited()) {
						tweetJSON += "\"favorite\": true,";
					}
					else {
						tweetJSON += "\"favorite\": false,";
					}

					if(oldMentionId >= currentMentionId) {
//						System.out.println("Old Mention: " + currentMentionId + "(" + oldMentionId + ")");
						tweetJSON += "\"old\":true}";
					}
					else {
						newMentionCount++;
//						System.out.println("New Mention: " + currentMentionId + "(" + oldMentionId + ")");
						if(newMentionId < currentMentionId){
							newMentionId = currentMentionId;
						}
						tweetJSON += "\"old\":false}";
					}
					
					i++;
				}
			}
			
			System.out.println("Old Mention: " + oldMentionId + ", new Mention: " + newMentionId);
			
			if(newMentionId > oldMentionId){
				updateLastReadMention(userId, newMentionId);
			}

			/* test-data when internet is not UP */
			//		tweetJSON += "{ " +
			//		"\"text\": \"This is a test tweet.\"," + 
			//		"\"date\": \"31-12-2009\"," +
			//		"\"user\": \"ammubhai\"," +
			//		"\"src\": \"echofone\"," +
			//		"\"img\": \"images/user1.png\"" +
			//		"}";
		} catch (TwitterException e) {
			//		e.printStackTrace();
//			System.err.println("ERROR: " + e.getLocalizedMessage());
//			String errText = e.getMessage();
//			int index = errText.indexOf("<!DOCTYPE ");
//			String errorMsg = errText.substring(0, index - 1);
//			errorMsg = errorMsg.replaceAll("(\r\n|\r|\n|\n\r)", "");
			out.print("{\"success\": false, \"msg\": \"" + TwitterError.getErrorMessage(e.getStatusCode()) + "\"}");
			out.close();
			return;
		}
		tweetJSON += "]";

		out.print("{ \"success\": true," +
				"\"page\": " + page + "," +
				"\"result\": " + tweetJSON + "," +
				"\"count\": "+ newMentionCount + " }");
		out.close();
		
		System.out.println("getMentions("+ userId +"): exit(true)");
		
	}

	private void updateLastReadMention(int userId, long newMentionId) {
		int m = 0;
		PreparedStatement ps = null;
		System.out.println("updateLastReadMention: enter:");
		try {
			ps = connection.prepareStatement("UPDATE main.user_tokens SET mention_id=? WHERE id=?");
			ps.setLong(1, newMentionId);
			ps.setInt(2, userId);
		} catch (SQLException se) {
			System.out.println("updateLastReadMention: ERROR prep SQL");
			se.printStackTrace();
		}

		try {
			m = ps.executeUpdate();
			ps.close();
		} catch (SQLException se) {
			System.out.println("updateLastReadMention: ERROR exec SQL");
			se.printStackTrace();
		} 
		System.out.println("updateLastReadMention: Successfully added " + m + " row(s). ROWID: ");
	}

	private long getLastReadMention(int userId) {
		Statement s = null;
		ResultSet rs = null;
		System.out.println("getLastReadMention: enter:" + userId);
		try {
			s = connection.createStatement();
			rs = s.executeQuery("SELECT mention_id FROM main.user_tokens " +
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
		System.out.println("getLastReadMention: exit(false) :" + userId);
		return 0;
	}

}
