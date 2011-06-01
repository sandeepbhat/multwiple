package com.spundhan.multwiple;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.http.AccessToken;

public class MarkFavorite extends HttpServlet {


	private static final long serialVersionUID = -8265151299192806614L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("TweetUpdate: enter");
		String user = request.getParameter("user");
		String group = request.getParameter("gid");
		String session = request.getParameter("session");
		String tweet = request.getParameter("tweetId");
		boolean mark = Boolean.parseBoolean(request.getParameter("mark"));
		
		long tweetId = 0;
		int userId = 0;
		int groupId = 0;
		
		if(user != null){
			userId = Integer.parseInt(user);
		}
		
		String multUser = request.getParameter("multUser");
		DB db = new DB();
		if(mark) {
			db.logs(userId, multUser, Constants.MARK_FAVORITE);
		}
		else {
			db.logs(userId, multUser, Constants.UNMARK_FAVORITE);
		}

		if(group != null){
			groupId = Integer.parseInt(group);
		}

		if(tweet != null){
			tweetId = Long.parseLong(tweet);
		}

		System.out.println("TweetUpdate: userId:" + userId + ", groupId: " + groupId + ", session: " + session);

		/*
		 * Set the content type(MIME Type) of the response.
		 */
		response.setContentType("application/json");

		PrintWriter out = response.getWriter();


		AccessToken accessToken = db.isSessionValid(userId, groupId, session);
		if(userId == 0 || groupId == 0 || session.equals("") || accessToken == null){
			out.print("{ \"success\": false}");
			out.close();
			System.out.println("MarkFavorite: exit(false)");
			return;
		}

		Properties prop = TwitterProperties.getProperties();
		Twitter twitter = new TwitterFactory().getOAuthAuthorizedInstance(prop.getProperty("consumer.key"), prop.getProperty("consumer.secret"), accessToken);


		try {
			if(mark) {
				twitter.createFavorite(tweetId);
			}
			else {
				twitter.destroyFavorite(tweetId);
			}
		} catch (TwitterException e) {
			// TODO Auto-generated catch block
			//			e.printStackTrace();
			System.err.println("ERROR: " + e.getLocalizedMessage());
			out.print("{\"success\": false, \"msg\": \"Login details incorrect. Please check your username and password are correct.\"}");
			out.close();
			return;
		}

		out.print("{\"success\": true }");
		out.close();
		return;
	}


}
