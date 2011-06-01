package com.spundhan.multwiple;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import twitter4j.http.AccessToken;



public class DB {

	private static String DB_URL = "jdbc:postgresql://localhost/multwipleDB";
	private static String DB_USER_NAME = "mtwiple_user"; 
	private static String DB_USER_PASSWD = "yl4FUS456yD3FIghq";
	private Connection connection = null;
	private int twitterUserId = 0;

	public DB(){
		connect();
	}

	public Connection getConnection(){
		return connection;
	}

	private boolean connect(){
		if(connection != null){
			return true;
		}

		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException cnfe) {
			System.out.println("Couldn't find the driver!");
			System.out.println("Let's print a stack trace, and exit.");
			cnfe.printStackTrace();
			return false;
		}

		System.out.println("Registered the driver ok, so let's make a connection.");

		connection = null;

		try {
			// The second and third arguments are the username and password,
			// respectively. They should be whatever is necessary to connect
			// to the database.
			connection = DriverManager.getConnection(DB_URL,	DB_USER_NAME, DB_USER_PASSWD);
		} catch (SQLException se) {
			System.out.println("Couldn't connect: print out a stack trace and exit.");
			se.printStackTrace();
			return false;
		}
		return true;
	}

	public AccessToken isSessionValid(int userId, int groupId, String session) {
		AccessToken accessToken = null;
		Statement s = null;
		ResultSet rs = null;
		System.out.println("isSessionValid: enter");
		connect();
		try {
			s = connection.createStatement();
			rs = s.executeQuery("SELECT token, secret, user_id FROM main.user_tokens u, main.user_group g " +
					"WHERE u.id = '"+ userId +"' AND u.group_id = '"+ groupId +"' AND u.group_id = g.id AND g.group_salt = '"+ session +"';");
			if (rs.next()) {
				String token = rs.getString(1);
				String secret = rs.getString(2);
				twitterUserId = rs.getInt(3);
				accessToken = new AccessToken(token, secret);
				System.out.println("isSessionValid: User: "+ userId +", Token :" + token + ", Secret :" + secret);
			}
			s.close();
		} catch (SQLException se) {
			System.err.println("We got an exception while executing our query:" +
			"that probably means our SQL is invalid");
			se.printStackTrace();
			System.out.println("isSessionValid: exit(false)");
			return null;
		}

		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return accessToken;
	}


	public int getTwitterUserId() {
		return twitterUserId;
	}

	public boolean deleteUser(String username) {
		Statement s = null;
		int rs = 0;
		try {
			// read common areas
			s = connection.createStatement();
			rs = s.executeUpdate("DELETE FROM main.member WHERE username = '" + username + "'");
			s.close();
		} catch (SQLException se) {
			System.err.println("We got an exception while executing our query:" +
			"that probably means our SQL is invalid");
			se.printStackTrace();
			return false;
		}

		if(rs == 1){
			return true;
		}

		return false;
	}

	public boolean isGroupValid(int groupId, String session) {
		Statement s = null;
		ResultSet rs = null;
		System.out.println("isGroupValid: enter");
		connect();
		try {
			s = connection.createStatement();
			rs = s.executeQuery("SELECT id FROM main.user_group " +
					"WHERE id = '"+ groupId +"' AND group_salt = '"+ session +"';");
			if (rs.next()) {
				int id = rs.getInt(1);
				System.out.println("isGroupValid: Group: "+ id);
				return true;
			}
			s.close();
		} catch (SQLException se) {
			System.err.println("We got an exception while executing our query:" +
			"that probably means our SQL is invalid");
			se.printStackTrace();
			System.out.println("isGroupValid: exit(false)");
			return false;
		}

		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("isGroupValid: exit(false)");
		return false;
	}

	public int getUpdateInterval(int groupId) {
		int updateInterval = -1;
		Statement s = null;
		ResultSet rs = null;
		System.out.println("getUpdateInterval: enter");
		connect();

		try {
			s = connection.createStatement();
			rs = s.executeQuery("SELECT update_interval from main.user_group WHERE id = '"+groupId+"'");

			if(rs.next()) {
				updateInterval = rs.getInt(1);
				System.out.println("getUpdateInterval: "+updateInterval+" min");
				return updateInterval;
			}
			s.close();
		}
		catch (SQLException e) {
			System.err.println("We got an exception while executing our query:" +
			"that probably means our SQL is invalid");
			e.printStackTrace();
			System.out.println("getUpdateInterval (1): exit(false)");
			return -1;
		}

		try {
			connection.close();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		System.out.println("getUpdateInterval (2): exit(false)");
		return -1;
	}
	
	public void logs(int userId, String username, int actionId) {
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement("INSERT INTO main.logs(log_user_id, log_screen_name, action_id, log_date) VALUES("+userId+", '"+username+"', '"+actionId+"', ?)");
			ps.setDate(1, new java.sql.Date(new java.util.Date().getTime()));
			ps.executeUpdate();
			ps.close();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void logs(int userId, String username, int actionId, String data) {
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement("INSERT INTO main.logs(log_user_id, log_screen_name, action_id, log_date, log_data) VALUES("+userId+", '"+username+"', '"+actionId+"', ?, '"+data+"')");
			ps.setDate(1, new java.sql.Date(new java.util.Date().getTime()));
			ps.executeUpdate();
			ps.close();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/* Update the profile image URL for the given user.
	 * This fixes bug #67
	 */
	public void updateProfileImage(String imageUrl, int id) {
		System.out.println("UpdateProfileImage: " + imageUrl + " ID: " + id + "\n");
		String query = "UPDATE main.user_tokens SET image_url = '" + imageUrl + "' WHERE id = " + id + ";";
		try {
			Statement statement = connection.createStatement();
			statement.executeUpdate(query);
			statement.close();
			connection.close();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
