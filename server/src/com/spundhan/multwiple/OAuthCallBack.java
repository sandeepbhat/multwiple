package com.spundhan.multwiple;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.HashMap;
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
import twitter4j.http.AccessToken;


public class OAuthCallBack extends HttpServlet {

	private static final long serialVersionUID = -3830635241434774244L;
	private static HashMap<String, String> map;
	private Connection connection;
	private int groupId = 0;
	private String session = null;
	private DB db;
	
	@Override
	public void init() throws ServletException {
		super.init();
		db = new DB();
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


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Came back from Twitter....>>>>>>>>>>>>");
		String token = request.getParameter("oauth_token");
		String verifier = request.getParameter("oauth_verifier");
		Twitter twitter = new TwitterFactory().getInstance();
		Properties prop = TwitterProperties.getProperties();
		twitter.setOAuthConsumer(prop.getProperty("consumer.key"), prop.getProperty("consumer.secret"));
		
		Scribe scribe = new Scribe(TwitterProperties.getProperties());
		Token requestToken = getRequestTokenFromDB(token);
		// send email notification
//		new EmailThread(request.getLocalAddr(), request.getRemoteAddr(), request.getRemoteHost(), "OAUTH CallBack").run();

		if(requestToken != null){
			Token  accessToken  = null;
			try {
				accessToken = scribe.getAccessToken(requestToken, verifier);
			} catch(Exception e){
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.print(TwitterError.prepareErrorHTML(e.getMessage()));
				out.close();
				return;
			}
			getQueryMap(accessToken.getRawString());
			
			// check if the user already registered with us?
			User user = isUserPresent(Integer.parseInt(map.get("user_id")));
			if(user != null){
				db.logs(user.getId(), user.getUserName(), Constants.ADDED_NEW_ACCOUNT);
				// if true then update the record with new token and secret key.
				updateOAuthAccessToken(user, accessToken);
				// setup cookies
				Cookies cookies = new Cookies(request);
				cookies.setGroupId(user.getGroupId());
				cookies.setSession(user.getSession());
				cookies.setUpdateInterval(user.getUpdateInterval());
				cookies.createCookies(response);
				map.clear();
				System.out.println("Redirecting to index page");
				response.sendRedirect(Constants.SERVER_URL + "/login.html");
				return;
			}
			
			// if the user is new and does not belong to an existing group.
			if(user == null && groupId == 0){
				// create a new session
				session = createSessionString(requestToken);
				// create a new group
				groupId = createNewUserGroup(session);
			}
			
			// check if a new user.
			if(user == null) {
				// create new user record with the groupid 
				user = addOAuthAccessToken(accessToken, groupId);
				if(user == null){
					response.setContentType("text/html");
					PrintWriter out = response.getWriter();
					out.print(TwitterError.prepareErrorHTML("Unable to get User Information."));
					out.close();
					return;
				}
				user.setSession(session);
			}
			
			// make sure at this point we definitely have a user record created/updated.
			if(user != null && user.getId() > 0){
				db.logs(user.getId(), user.getUserName(), Constants.ADDED_NEW_ACCOUNT);
				// setup cookies
				Cookies cookies = new Cookies(request);
				cookies.setGroupId(user.getGroupId());
				cookies.setSession(user.getSession());
				cookies.setUpdateInterval(user.getUpdateInterval());
				cookies.createCookies(response);
				map.clear();
				deleteRequestToken(token);

				System.out.println("Redirecting to index page");
				response.sendRedirect(Constants.SERVER_URL + "/login.html");
			}
		}
		/* TODO: proper error checking and response accordingly */
		
		return;
	}

	private boolean updateOAuthAccessToken(User user, Token token) {
		int m = 0;
		PreparedStatement ps = null;
		System.out.println("updateOAuthAccessToken: enter:");

		try {
			ps = connection.prepareStatement("UPDATE main.user_tokens SET token=?, secret=?, rawstring=? WHERE id=?");
			System.out.println("User: " +  user.getTwitterId() + ", Name: " + user.getUserName());
			ps.setString(1, token.getToken());
			ps.setString(2, token.getSecret());
			ps.setString(3, token.getRawString());
			ps.setInt(4, user.getId());
		} catch (SQLException se) {
			System.out.println("updateOAuthAccessToken: ERROR prep SQL");
			se.printStackTrace();
			return false;
		}

		try {
			m = ps.executeUpdate();
			ps.close();
		} catch (SQLException se) {
			System.out.println("updateOAuthAccessToken: ERROR exec SQL");
			se.printStackTrace();
			return false;
		} 

		System.out.println("updateOAuthAccessToken: Successfully added " + m + " row(s). ROWID: ");
		return true;
	}


	private User isUserPresent(int user_id) {
		Statement s = null;
		ResultSet rs = null;
		System.out.println("isUserPresent: enter:" + user_id);
		try {
			s = connection.createStatement();
			rs = s.executeQuery("SELECT u.id, screen_name, group_id, group_salt, g.update_interval FROM main.user_tokens u, main.user_group g " +
					"WHERE u.user_id="+ user_id + " AND u.group_id = g.id;");
			if (rs.next()) {
				User user = new User(rs.getInt(1), rs.getString(2));
				user.setGroupId(rs.getInt(3));
				user.setSession(rs.getString(4));
				user.setUpdateInterval(rs.getInt(5));
				System.out.println("ID :" + user.getId());
				System.out.println("isUserPresent: found!");
				return user;
			}
			s.close();
		} catch (SQLException se) {
			System.err.println("We got an exception while executing our query:" +
			"that probably means our SQL is invalid");
			se.printStackTrace();
		}

		System.out.println("isUserPresent: not found");
		return null;
	}


	private String createSessionString(Token token){
		String data_salt ="";
		String data = token.getToken() + (new Date()).toString();
		
		try {
			MessageDigest sha = MessageDigest.getInstance ("SHA-256");
			synchronized (sha) {
				for (Byte b : sha.digest(data.getBytes())) {
					data_salt += Integer.toHexString(b.intValue() & 0xff);
				}
			}
		} catch (NoSuchAlgorithmException e){
			e.printStackTrace();
		}
		
		return data_salt;
	}
	
	private int getNextGroupId(){
		int id = -1;
		Statement s = null;
		ResultSet rs = null;
		try {
			s = connection.createStatement();
			rs = s.executeQuery("SELECT nextval('main.user_group_id_seq')");
			if (rs.next()) {
				id = rs.getInt(1);
				System.out.println("ID :" + id);
			}
			s.close();
		} catch (SQLException se) {
			System.err.println("We got an exception while executing our query:" +
			"that probably means our SQL is invalid");
			se.printStackTrace();
			return id;
		}

		return id;
	}

	private int createNewUserGroup(String salt) {
		int m = 0;
		PreparedStatement ps = null;
		int id = getNextGroupId();
		if(id <= 0){
			return 0;
		}
		try {
			ps = connection.prepareStatement("INSERT INTO main.user_group (id, group_salt, update_interval) VALUES (?,?, 1)");
			ps.setInt(1, id);
			ps.setString(2, salt);
		} catch (SQLException se) {
			System.out.println("We got an exception while preparing a statement:" +
			"Probably bad SQL.");
			se.printStackTrace();
			return 0;
		}

		try {
			m = ps.executeUpdate();
			ps.close();
		} catch (SQLException se) {
			System.out.println("We got an exception while executing an update:" +
			"possibly bad SQL, or check the connection.");
			se.printStackTrace();
			return 0;
		} 

		System.out.println("Successfully added " + m + " row(s). ROWID: ");
		return id;
	}


	private void getQueryMap(String query) { 
		System.out.println("Query: " + query);
		String[] params = query.split("&");  
		map = new HashMap<String, String>();  
		for (String param : params)  
		{  
			String name = param.split("=")[0];  
			String value = param.split("=")[1];  
			map.put(name, value);  
		}  
	}  

	private int getNextUserId(){
		int id = -1;
		Statement s = null;
		ResultSet rs = null;
		try {
			s = connection.createStatement();
			rs = s.executeQuery("SELECT nextval('main.user_tokens_id_seq')");
			while (rs.next()) {
				id = rs.getInt(1);
				System.out.println("ID :" + id);
			}
			s.close();
		} catch (SQLException se) {
			System.err.println("We got an exception while executing our query:" +
			"that probably means our SQL is invalid");
			se.printStackTrace();
			return id;
		}

		return id;
	}

	private User addOAuthAccessToken(Token token, int groupId){
		int m = 0;
		PreparedStatement ps = null;
		Date today = new Date();
		int id = getNextUserId();
		if(id <= 0){
			return null;
		}
		int twitterId = Integer.parseInt(map.get("user_id"));
		String username = map.get("screen_name");
		Properties prop = TwitterProperties.getProperties();
		AccessToken accessToken = new AccessToken(token.getToken(), token.getSecret());
		Twitter twitter = new TwitterFactory().getOAuthAuthorizedInstance(prop.getProperty("consumer.key"), prop.getProperty("consumer.secret"), accessToken);
		String imgUrl = "";
		try {
			twitter4j.User user = twitter.showUser(twitterId);
			imgUrl = user.getProfileImageURL().toString();
		} catch (TwitterException e) {
			e.printStackTrace();
			return null;
		}
		
		try {
			ps = connection.prepareStatement("INSERT INTO main.user_tokens(id, user_id, screen_name, token, secret, rawstring, group_id, creation_date, login_date, home_id, direct_id, mention_id, image_url) VALUES (?,?,?,?,?,?,?,?,?,0,0,0,?)");
			System.out.println("User: " +  twitterId + ", Name: " + username);
			ps.setInt(1, id);
			ps.setInt(2, twitterId);
			ps.setString(3, username);
			ps.setString(4, token.getToken());
			ps.setString(5, token.getSecret());
			ps.setString(6, token.getRawString());
			ps.setInt(7, groupId);
			ps.setDate(8, new java.sql.Date(today.getTime()));
			ps.setDate(9, new java.sql.Date(today.getTime()));
			ps.setString(10, Constants.escape(imgUrl));
		} catch (SQLException se) {
			System.out.println("ERROR.");
			se.printStackTrace();
			return null;
		}

		try {
			m = ps.executeUpdate();
			ps.close();
		} catch (SQLException se) {
			System.out.println("ERROR.");
			se.printStackTrace();
			return null;
		} 

		System.out.println("Successfully added " + m + " row(s). ROWID: ");
		User user = new User(id, username);
		user.setTwitterId(twitterId);
		user.setGroupId(groupId);
		user.setUpdateInterval(1);
		return user;
	}

	private Token getRequestTokenFromDB(String token){
		Token rToken = null;
		String tokenSecret;
		Statement s = null;
		ResultSet rs = null;
		System.out.println("getRequestTokenFromDB: enter");
		int id = 0;
		try {
			s = connection.createStatement();
			rs = s.executeQuery("SELECT id, secret, group_id, session FROM main.login_tokens " +
					"WHERE token = '"+ token +"';");
			if (rs.next()) {
				id = rs.getInt(1);
				tokenSecret = rs.getString(2);
				groupId = rs.getInt(3);
				session = rs.getString(4);
				rToken = new Token(token, tokenSecret);
				System.out.println("Secret :" + tokenSecret);
			}
			s.close();
		} catch (SQLException se) {
			System.err.println("ERROR");
			se.printStackTrace();
			System.out.println("queryUserData: exit(null)");
			return null;
		}

		return rToken;
	}


	private boolean deleteRequestToken(String token) {
		Statement s = null;
		int rs = 0;
		try {
			// read common areas
			s = connection.createStatement();
			rs = s.executeUpdate("DELETE FROM main.login_tokens WHERE token = '" +  token + "'");
			s.close();
		} catch (SQLException se) {
			System.err.println("ERROR deleting token.");
			se.printStackTrace();
			return false;
		}
		
		if(rs == 1){
			return true;
		}
		
		return false;
	}

}
