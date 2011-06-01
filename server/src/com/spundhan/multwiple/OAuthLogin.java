package com.spundhan.multwiple;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.scribe.oauth.Scribe;
import org.scribe.oauth.Token;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.http.RequestToken;



public class OAuthLogin extends HttpServlet {


	private static final long serialVersionUID = 7865420047046175556L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Properties prop = TwitterProperties.getProperties();
		String callingPage = "/login";
		String token = request.getParameter("login");
		Cookies cookies = new Cookies(request);
		System.out.println("Got cookies");
		if(token != null && token.equals("Sign in with Twitter")){
			callingPage = "/index";
		}
		
		callingPage += ".html?error=";
		
//		Twitter twitter = new TwitterFactory().getInstance();
//		twitter.setOAuthConsumer(prop.getProperty("consumer.key"), prop.getProperty("consumer.secret"));
//		RequestToken requestToken = null;
//		try {
//			requestToken = twitter.getOAuthRequestToken();
//		} catch (TwitterException e) {
//			e.printStackTrace();
//			response.sendRedirect("/index.html?error=twitterdown");
//		}
		Scribe scribe = new Scribe(prop);
		Token requestToken = null;
		try {
		 requestToken = scribe.getRequestToken();
		} catch(Exception e) {
			System.out.println("Cant fetch request token.\nRedirect: " + callingPage);
			cookies.createCookies(response);
			response.sendRedirect(Constants.SERVER_URL + callingPage + "twitterdown");
			return;
		}
		System.out.println("Token: " + requestToken.getToken() + 
				"\nToken Secret: " + requestToken.getSecret());
//				"\nToken Secret: " + requestToken.getTokenSecret());
		
		int groupId = cookies.getGroupId();
		String session = cookies.getSession();
		
		DB db = new DB();
		db.logs(0, "New User", Constants.SIGN_IN_WITH_TWITTER);
		
		if(!db.isGroupValid(groupId, session)){
			groupId = 0;
			session = "";
			System.out.println("Reset groupId to: " + groupId);
		}
		
		System.out.println("Got groupId: " + groupId);
		
		// send email notification
//		new EmailThread(request.getLocalAddr(), request.getRemoteAddr(), request.getRemoteHost(), "OAUTH Login").run();
		
		if(addLoginToken(requestToken, groupId, session)){
			System.out.println("Redirecting to twitter");
//			response.sendRedirect(requestToken.getAuthorizationURL());
			response.sendRedirect(prop.getProperty("auth.token.url")+ "?oauth_token="+ requestToken.getToken());
			return;
		}
		
		System.out.println("Something is wrong.\nRedirect: " + callingPage);
		response.sendRedirect(Constants.SERVER_URL + callingPage + "unknown");
	}


	private boolean addLoginToken(Token token, int groupId, String session){
//	private boolean addLoginToken(RequestToken token, int groupId, String session){
		DB db = new DB();
		Connection connection = db.getConnection();

		int m = 0;

		PreparedStatement ps = null;
		Date today = new Date();
		try {
			ps = connection.prepareStatement("INSERT INTO main.login_tokens(token, secret, rawstring, group_id, session, creation_date) VALUES (?,?,?,?,?,?)");
			ps.setString(1, token.getToken());
			ps.setString(2, token.getSecret());
//			ps.setString(2, token.getTokenSecret());
			ps.setString(3, "deprecated on 22-07-2010");
			ps.setInt(4, groupId);
			ps.setString(5, session);
			ps.setDate(6, new java.sql.Date(today.getTime()));
		} catch (SQLException se) {
			System.out.println("We got an exception while preparing a statement:" +
			"Probably bad SQL.");
			se.printStackTrace();
			return false;
		}

		try {
			m = ps.executeUpdate();
			ps.close();
		} catch (SQLException se) {
			System.out.println("We got an exception while executing an update:" +
			"possibly bad SQL, or check the connection.");
			se.printStackTrace();
			return false;
		} 

		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println("Successfully added " + m + " row(s). ROWID: ");
		return true;
	}

}
