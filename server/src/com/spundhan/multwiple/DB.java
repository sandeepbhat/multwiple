package com.spundhan.multwiple;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import twitter4j.auth.AccessToken;

public class DB {

	private static String DB_URL = "jdbc:postgresql://localhost/multwipleDB";
	private static String DB_USER_NAME = "mtwiple_user"; 
	private static String DB_USER_PASSWD = "yl4FUS456yD3FIghq";
	private Connection connection = null;
	private int twitterUserId = 0;
	private Logger log;
	
	public DB(){
		log = Logger.getRootLogger();
		connect();
	}

	public Connection getConnection(){
		return connection;
	}

	private boolean connect() {
		
		if (connection != null) {
			return true;
		}

		try {
			Class.forName("org.postgresql.Driver");
		} 
		catch (ClassNotFoundException cnfe) {
			cnfe.printStackTrace();
			log.error("DB: connect: Class Not Found Exception: Couldn't find the driver: " + cnfe.getMessage());
			return false;
		}

		connection = null;

		try {
			/* The second and third arguments are the username and password respectively. 
			 * They should be whatever is necessary to connect to the database.
			 */
			connection = DriverManager.getConnection(DB_URL,	DB_USER_NAME, DB_USER_PASSWD);
		}
		catch (SQLException se) {
			se.printStackTrace();
			log.error("DB: connect: Couldn't connect: SQL Exception: " + se.getMessage());
			return false;
		}
		return true;
	}

	public AccessToken isSessionValid(int userId, int groupId, String session) {
		AccessToken accessToken = null;
		String query = 
			"SELECT " +
				"token, " +
				"secret, " +
				"user_id " +
			"FROM " +
				"main.user_tokens u, " +
				"main.user_group g " +
			"WHERE " +
				"u.id = '"+ userId +"' " +
				"AND u.group_id = '"+ groupId +"' " +
				"AND u.group_id = g.id " +
				"AND g.group_salt = '"+ session +"';";
		connect();
		try {
			Statement s = connection.createStatement();
			ResultSet rs = s.executeQuery(query);
			if (rs.next()) {
				String token = rs.getString(1);
				String secret = rs.getString(2);
				twitterUserId = rs.getInt(3);
				accessToken = new AccessToken(token, secret);
			}
			s.close();
		}
		catch (SQLException se) {
			se.printStackTrace();
			log.error("DB: isSessionValid: SQL Exception: " + se.getMessage());
			return null;
		}

		try {
			connection.close();
		}
		catch (SQLException e) {
			e.printStackTrace();
			log.error("DB: isSessionValid: SQL Exception: " + e.getMessage());
		}

		return accessToken;
	}

	public int getTwitterUserId() {
		return twitterUserId;
	}

	public boolean deleteUser(String username) {
		int rs = 0;
		try {
			// read common areas
			Statement s = connection.createStatement();
			rs = s.executeUpdate("DELETE FROM main.member WHERE username = '" + username + "'");
			s.close();
		}
		catch (SQLException se) {
			se.printStackTrace();
			log.error("DB: deleteUser: SQL Exception: " + se.getMessage());
			return false;
		}

		if(rs == 1){
			return true;
		}

		return false;
	}

	public boolean isGroupValid(int groupId, String session) {
		
		connect();
	
		try {
			Statement s = connection.createStatement();
			ResultSet rs = s.executeQuery("SELECT id FROM main.user_group " +
					"WHERE id = '"+ groupId +"' AND group_salt = '"+ session +"';");
			if (rs.next()) {
				return true;
			}
			s.close();
		} 
		catch (SQLException se) {
			se.printStackTrace();
			log.error("DB: isGroupValid: SQL Exception: " + se.getMessage());
			return false;
		}

		try {
			connection.close();
		}
		catch (SQLException e) {
			log.error("DB: isGroupValid: SQL Exception: " + e.getMessage());
			e.printStackTrace();
		}
		
		log.debug("DB: isGroupValid: Exit (false)");
		
		return false;
	}

	public int getUpdateInterval(int groupId) {
		int updateInterval = -1;
		connect();

		try {
			Statement s = connection.createStatement();
			ResultSet rs = s.executeQuery("SELECT update_interval from main.user_group WHERE id = '" + groupId + "'");
			if (rs.next()) {
				updateInterval = rs.getInt(1);
				return updateInterval;
			}
			s.close();
		}
		catch (SQLException e) {
			e.printStackTrace();
			log.error("DB: getUpdateInterval: SQL Exception: " + e.getMessage());
			return -1;
		}

		try {
			connection.close();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		log.debug("DB: getUpdateInterval: EXIT (false)");
		return -1;
	}
	
	public void logs (int userId, String username, int actionId) {
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement (
					"INSERT INTO " +
						"main.logs (log_user_id, log_screen_name, action_id, log_date) " +
					"VALUES " +
						"(" + userId + ", '" + username + "', '" + actionId + "', ?)"
			);
			ps.setDate(1, new java.sql.Date(new java.util.Date().getTime()));
			ps.executeUpdate();
			ps.close();
		}
		catch (SQLException e) {
			log.error("DB: logs [1]: SQL Exception: " + e.getMessage());
			e.printStackTrace();
		}
	}
	
	public void logs (int userId, String username, int actionId, String data) {
		PreparedStatement ps = null;
		try {
			ps = connection.prepareStatement(
					"INSERT INTO " +
						"main.logs (log_user_id, log_screen_name, action_id, log_date, log_data) " +
					"VALUES " +
						"(" + userId + ", '" + username + "', '" + actionId + "', ?, '" + data + "')");
			ps.setDate(1, new java.sql.Date(new java.util.Date().getTime()));
			ps.executeUpdate();
			ps.close();
		}
		catch (SQLException e) {
			log.error("DB: logs [2]: SQL Exception: " + e.getMessage());
			e.printStackTrace();
		}
	}

	/* Update the profile image URL for the given user.
	 * This fixes bug #67
	 */
	public void updateProfileImage (String imageUrl, int id) {
		String query = "UPDATE main.user_tokens SET image_url = '" + imageUrl + "' WHERE id = " + id + ";";
		try {
			Statement statement = connection.createStatement();
			statement.executeUpdate(query);
			statement.close();
			connection.close();
		}
		catch (SQLException e) {
			log.error("DB: updateProfileImage: SQL Exception: " + e.getMessage());
			e.printStackTrace();
		}
	}
}
