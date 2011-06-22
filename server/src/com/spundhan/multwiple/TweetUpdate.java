package com.spundhan.multwiple;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import twitter4j.DirectMessage;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.auth.AccessToken;

public class TweetUpdate extends HttpServlet {


	private static final long serialVersionUID = -8265151299192806614L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("TweetUpdate: enter");
		String user = request.getParameter("user");
		String multUser = request.getParameter("multUser");
		String group = request.getParameter("gid");
		String session = request.getParameter("session");
		String tweet = request.getParameter("tweet");
		String idStr = request.getParameter("tweetId");
		
		int userId = 0;
		int groupId = 0;
		long tweetId = 0;
				
		if(user != null && user.length() > 0){
			userId = Integer.parseInt(user);
		}
		
		if(idStr != null && idStr.length() > 0) {
			tweetId = Long.parseLong(idStr);
			System.out.println("RID >>> ["+tweetId+"]");
		}

		if(group != null && group.length() > 0){
			groupId = Integer.parseInt(group);
		}

		if(session.equals("0") && groupId == 0){
			Cookies cookies = new Cookies(request);
			session = cookies.getSession();
			groupId = cookies.getGroupId();
		}
		
		System.out.println("TweetUpdate: userId:" + userId + ", groupId: " + groupId + ", session: " + session);

		/*
		 * Set the content type(MIME Type) of the response.
		 */
		response.setContentType("application/json");

		PrintWriter out = response.getWriter();


		DB db = new DB();
		if(tweetId > 0) {
			db.logs(userId, multUser, Constants.RT_WITHOUT_COMMENT);
		}
		else if(tweet.indexOf("RT") >= 0) {
			db.logs(userId, multUser, Constants.RT_WITH_COMMENT);
		}
		else if(tweet.startsWith("d")) {
			db.logs(userId, multUser, Constants.DIRECT_MESSAGE);
		}
		else {
			db.logs(userId, multUser, Constants.TWEET);
		}
		
		AccessToken accessToken = db.isSessionValid(userId, groupId, session);
		if(userId == 0 || groupId == 0 || session.equals("") || accessToken == null){
			out.print("{ \"success\": false, \"msg\": \"Unable to tweet at this moment. Please try again later\"};");
			out.close();
			System.out.println("TweetUpdate: exit(false)");
			return;
		}

		Twitter twitter = new TwitterFactory().getInstance();
		Properties prop = TwitterProperties.getProperties();
		twitter.setOAuthConsumer(prop.getProperty("consumer.key"), prop.getProperty("consumer.secret"));
		twitter.setOAuthAccessToken(accessToken);

		String direct = "false";
		String tweetJSON = "{";
		try {
			if(tweetId > 0){
				Status status = twitter.retweetStatus(tweetId);
				User tweetUser = status.getUser();
				tweetJSON += "\"id\": \"" + status.getId() + "\"," +
					"\"text\": \"" + Constants.escape(status.getText()) + "\"," + 
					"\"date\": \"" + Constants.getTimeStr(status.getCreatedAt()) + "\"," +
					"\"user\": \"" + Constants.escape(tweetUser.getScreenName()) + "\"," +
					"\"src\": \"" + Constants.escape(status.getSource()) + "\"," +
					"\"img\": \""+ Constants.escape(tweetUser.getProfileImageURL().toString()) +"\"," +
					"\"RT\":\""+tweetUser.getScreenName()+"\"," +
					"\"RID\": \"" + status.getRetweetedStatus().getId() + "\"," +
					"\"favorite\": "+status.isFavorited();
			}
			else if(tweet.startsWith("d ")){
				direct = "true";
				int index = tweet.indexOf(' ', 3);
				String screenName = tweet.substring(2, index);
				String text = tweet.substring(index+1, tweet.length());
				System.out.println("Sending direct msg(" + text + ") => " + screenName);
				DirectMessage status = twitter.sendDirectMessage(screenName, text);
				User tweetUser = status.getSender();
				tweetJSON += "\"id\": \"" + status.getId() + "\"," +
					"\"text\": \"" + Constants.escape(status.getText()) + "\"," + 
					"\"date\": \"" + Constants.getTimeStr(status.getCreatedAt()) + "\"," +
					"\"user\": \"" + Constants.escape(tweetUser.getScreenName()) + "\"," +
					"\"img\": \""+ Constants.escape(tweetUser.getProfileImageURL().toString()) +"\"";
			}
			else {
				Status status = twitter.updateStatus(tweet);
				User tweetUser = status.getUser();
				tweetJSON += "\"id\": \"" + status.getId() + "\"," +
					"\"text\": \"" + Constants.escape(status.getText()) + "\"," + 
					"\"date\": \"" + Constants.getTimeStr(status.getCreatedAt()) + "\"," +
					"\"user\": \"" + Constants.escape(tweetUser.getScreenName()) + "\"," +
					"\"src\": \"" + Constants.escape(status.getSource()) + "\"," +
					"\"img\": \""+ Constants.escape(tweetUser.getProfileImageURL().toString()) +"\"," +
					"\"RT\": \"\"," +
					"\"favorite\": "+status.isFavorited();
			}
		} catch (TwitterException e) {
			// TODO Auto-generated catch block
			//			e.printStackTrace();
//			System.err.println("ERROR: " + e.getLocalizedMessage());
//			String errText = e.getMessage();
//			int index = errText.indexOf("\"error\":\"");
//			String errorMsg = errText.substring(index + 9, errText.lastIndexOf('"'));
			out.print("{\"success\": false, \"msg\": \"" + TwitterError.getErrorMessage(e.getStatusCode()) + "\"}");
			out.close();
			return;
		}
		tweetJSON += "}";

		out.print("{\"success\": true, \"direct\": " + direct + ", \"tweet\": " + tweetJSON + "}");
		out.close();
		return;
	}


}
