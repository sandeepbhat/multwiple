package com.spundhan.multwiple;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONValue;

public class SetSettings extends HttpServlet {

	/**
	 * 
	 */
	private static final long	serialVersionUID	= 1L;
	private Connection connection;
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
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("SetSettings: enter");

		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		
		Cookies cookies = new Cookies(request);
		String usersStr = request.getParameter("users");
		String intervalStr = request.getParameter("interval");
		String multUser = request.getParameter("multUser");
		int userId = Integer.parseInt(request.getParameter("userId"));
		
		int interval = cookies.getUpdateInterval();
		if(intervalStr != null && intervalStr.length() > 0){
			interval = Integer.parseInt(intervalStr);
		}
		
		System.out.println("SetSettings: Users' ID >>> "+usersStr);
		System.out.println("SetSettings: Users' Interval >>> ["+interval+"]");

		JSONArray array = (JSONArray)JSONValue.parse(usersStr);
		if(array != null){
			System.out.println("JSON Array-Size: " + array.size());
			/*Taking elements from array*/
			for (Object object : array) {
				long id = (Long) object;
				if(!deleteUser(id, cookies.getGroupId())) {
					out.print("{\"success\": false, \"msg\": \"Unable to remove. User: "+ id + " not found.\"}");
					out.close();
					return;
				}
				db.logs((int)id, multUser, Constants.DELETE_USER);
				cookies.decrementUserCount();
			}	
		}
		
		if(interval != cookies.getUpdateInterval()){
			if(updateInterval(cookies.getGroupId(), interval)) {
				cookies.setUpdateInterval(interval);
			}
		}
		
		cookies.createCookies(response);
		String redirect = "false";
		if(cookies.getUserCount() == 0){
			redirect = "true";
		}
		db.logs(userId, multUser, Constants.SAVE_SETTINGS);
		out.print("{\"success\": true, \"msg\": \"Settings saved.\", \"redirect\": "+ redirect +"}");
		out.close();
	}

	private boolean updateInterval(int groupId, int interval) {
		Statement s = null;
		boolean result = false;
		System.out.println("isSessionValid: enter");

		try {
			s = connection.createStatement();
			int rc = s.executeUpdate("UPDATE main.user_group SET update_interval = " + interval + 
					" WHERE id = '"+ groupId +"';");
			System.out.println("Updated Interval: " + rc);
			if (rc > 0) {
				result = true;
			}
			s.close();
		} catch (SQLException se) {
			System.err.println("We got an exception while executing our query:" +
			"that probably means our SQL is invalid");
			se.printStackTrace();
			System.out.println("queryUserData: exit(null)");
			return false;
		}

		return result;
	}

	private boolean deleteUser(long id, int groupId) {
		Statement s = null;
		boolean result = false;
		System.out.println("isSessionValid: enter");

		try {
			s = connection.createStatement();
			int rc = s.executeUpdate("DELETE FROM main.user_tokens " +
					"WHERE id = '"+ id +"' AND group_id='"+ groupId +"';");
			System.out.println("Deleted user: " + rc);
			if (rc > 0) {
				result = true;
			}
			s.close();
		} catch (SQLException se) {
			System.err.println("We got an exception while executing our query:" +
			"that probably means our SQL is invalid");
			se.printStackTrace();
			System.out.println("queryUserData: exit(null)");
			return false;
		}

		return result;
	}



}
