package com.spundhan.multwiple_admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

public class DB {

	private static String DB_URL = "jdbc:postgresql://localhost/multwipleDB";
	private static String DB_USER_NAME = "mtwiple_user"; 
	private static String DB_USER_PASSWD = "yl4FUS456yD3FIghq";
	private Connection connection = null;

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
	
	public String getStatistics(int actionId, String username) {
		PreparedStatement statement = null;
		ResultSet rs = null;
		String json = "";
		try {
			Date[] dates = getLogDates();
			if(dates == null) {
				return "";
			}
			int i = 0;
			
			String query = null;
			
			System.out.println("Username: ["+username+"] Action ID: ["+actionId+"]");
			
			if(username.equals("All Users")) {
				query = "SELECT action FROM main.logs l, main.actions a WHERE l.action_id = "+actionId+" AND l.action_id = a.id ";
			}
			else {
				query = "SELECT action FROM main.logs l, main.actions a WHERE l.action_id = "+actionId+" AND l.action_id = a.id AND l.log_screen_name = '"+username+"' ";
			}
			
			for(Date date: dates) {
				statement = connection.prepareStatement(query + "AND l.log_date = ? ", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
				statement.setDate(1, new java.sql.Date(date.getTime()));
				rs = statement.executeQuery();
				rs.last();
				int count = rs.getRow();
				rs.beforeFirst();
				if(rs.next()) {
					if(i > 0) {
						json += ",";
					}
					json += "{\"actionId\": "+actionId+", \"action\":\""+rs.getString(1)+"\", \"count\":"+count+", \"date\":\""+Constants.getDateString(date)+"\"}";
					i++;
				}
			}
		}
		catch (SQLException e) {
			System.out.println("We got an Exception while executing Query !!");
			e.printStackTrace();
			return "";
		}
		return json;
	}

	private Date[] getLogDates() {
		Statement  statement = null;
		ResultSet rs = null;
		Date [] dates = null;
		
		try {
			statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = statement.executeQuery("SELECT DISTINCT log_date FROM main.logs ORDER BY log_date");
			rs.last();
			int count = rs.getRow();
			dates = new Date[count];
			rs.beforeFirst();
			int i = 0;
			while(rs.next()) {
				dates[i] = rs.getDate(1);
				i++;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return dates;
	}
	
	public String[] getUsers() {
		Statement statement = null;
		ResultSet rs = null;
		try {
			statement = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = statement.executeQuery("SELECT DISTINCT log_screen_name FROM main.logs WHERE log_screen_name != 'New User' ORDER BY log_screen_name");
			
			rs.last();
			int count = rs.getRow();
			rs.beforeFirst();
			
			if(count <= 0) {
				return null;
			}
			
			String [] users = new String[count];
			int i = 0;
			while(rs.next()) {
				users[i] = rs.getString(1);
				i++;
			}
			
			return users;
		}
		catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}
