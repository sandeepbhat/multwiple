package com.spundhan.multwiple;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



public class Cookies {

	private static final int DEFAULT_EXPIRY_TIME = 60*60*24*90; // cookie expires after 90 days
	private int userCount = 0;
	private User[] users = null;
	private int groupId = 0;
	private String session = "";
	private int updateInterval = 1;

	public Cookies(HttpServletRequest request){
		Cookie[] cookies = request.getCookies();
		if(cookies != null && cookies.length > 0){
			for (Cookie cookie : cookies) {
				String cookieName = cookie.getName();
				if(cookieName.equals("session") && cookie.getValue().length()  > 0){
					session = cookie.getValue();
					System.out.println("Session: " + session);
				}
				// @deprecated. not using the users cookie anymore.
//				else if(cookieName.equals("users")){
//					try {
//						String usersStr = cookie.getValue();
//						if(usersStr == null || usersStr.length() == 0){
//							continue;
//						}
//						System.out.println("Users: " + usersStr);
//						JSONArray array = (JSONArray)JSONValue.parse(usersStr);
//						if(array == null){
//							System.out.println("JSON Array: " + array);
//							continue;
//						}
//						System.out.println("JSON Array-Size: " + array.size());
//						users = new User[array.size()];
//						userCount = 0;
//						/*Taking elements from array*/
//						for (Object object : array) {
//							JSONObject o = (JSONObject)object;
//							long id = (Long) o.get("id");
//							String name = (String) o.get("name");
//							System.out.println("User Id: " + id + ", User Name: " + name);
//							users[userCount] = new User((int)id,name);
//							userCount++;
//						}	
//
//					} catch (NumberFormatException e){
//						userCount = 0;
//					}
//				}
				else if(cookieName.equals("usergid")){
					String group = cookie.getValue();
					if(group == null || group.length() == 0){
						continue;
					}
					groupId = Integer.parseInt(group);
					System.out.println("Group ID: " + groupId);
				}
				else if(cookieName.equals("interval")){
					String interval = cookie.getValue();
					if(interval == null || interval.length() == 0){
						continue;
					}
					updateInterval = Integer.parseInt(interval);
					System.out.println("Update Interval: " + updateInterval);
				}
			}

		}
		
		getUsers();

	}

	public boolean isAlreadyThere(int userId) {
		for (User user : users) {
			if(user.getId() == userId){
				return true;
			}
		}
		return false;
	}

	public void deleteCookie(HttpServletResponse response, String cookieName) {
		Cookie cookie = new Cookie(cookieName, "");
		cookie.setMaxAge(-1); // cookie expires immediately
		response.addCookie(cookie);
	}

	public void deleteAllCookies(HttpServletResponse response) {
		deleteCookie(response, "session");
		deleteCookie(response, "users");
		deleteCookie(response, "usergid");
		deleteCookie(response, "interval");
	}


	public int getUserCount() {
		return userCount;
	}

	public User[] getUsers() {
		DB db = new DB();
		Statement s = null;
		ResultSet rs = null;
		System.out.println("prepareUserJSON: enter, groupId: " + groupId);
		Connection  connection = db.getConnection();
		try {
			s = connection.createStatement();
			rs = s.executeQuery("SELECT count(id) FROM main.user_tokens " +
					"WHERE group_id = '"+ groupId +"';");
			userCount = 0;
			if (rs.next()) {
				userCount = rs.getInt(1);
			}
			rs.close();
			
			if(userCount > 0){
				rs = s.executeQuery("SELECT id,screen_name,image_url FROM main.user_tokens " +
						"WHERE group_id = '"+ groupId +"';");
				int count = 0;
				users = new User[userCount];
				while (rs.next()) {
					users[count] = new User(rs.getInt(1), rs.getString(2), rs.getString(3));
					count++;
					System.out.println("prepareUserJSON: id: "+ rs.getInt(1) + ", name: " + rs.getString(2));
				}
			}
			rs.close();
			s.close();
		} catch (SQLException se) {
			System.err.println("We got an exception while executing our query:" +
			"that probably means our SQL is invalid");
			se.printStackTrace();
			System.out.println("prepareUserJSON: exit(false)");
			return null;
		}

		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return users;
	}

	public String getSession() {
		return session;
	}

	public int getGroupId() {
		return groupId;
	}

	public String getParentUser() {
		// TODO Auto-generated method stub
		return "testing";
	}

	public boolean isAlreadyThere(String username) {
		// TODO Auto-generated method stub
		return true;
	}

	public void createCookies(HttpServletResponse response) {
		Cookie cookie = new Cookie("session", session);
		cookie.setPath("/");
		cookie.setMaxAge(DEFAULT_EXPIRY_TIME); 
		response.addCookie(cookie);
		System.out.println("Created session cookie:" + session);
		
		cookie = new Cookie("usergid", groupId+"");
		cookie.setPath("/");
		cookie.setMaxAge(DEFAULT_EXPIRY_TIME); 
		response.addCookie(cookie);
		System.out.println("Created GroupId cookie: " + groupId);
		
//		cookie = new Cookie("users", getUsersJSON());
//		cookie.setPath("/");
//		cookie.setMaxAge(DEFAULT_EXPIRY_TIME); 
//		response.addCookie(cookie);
//		System.out.println("Created Users cookie: ");

		cookie = new Cookie("interval", updateInterval+"");
		cookie.setPath("/");
		cookie.setMaxAge(DEFAULT_EXPIRY_TIME); 
		response.addCookie(cookie);
	}

	public String getUsersJSON(){
		String userStr = "[";
		int count = 0;
		getUsers();
		if(users != null) {
			for (User user : users) {
				if(count > 0){
					userStr += ",";
				}
				/* Get the profile image from twitter.com. 
				 * This will fetch the latest image updated by the user on twitter.
				 * This method will also update the DB with latest image url.
				 * Look at updateProfileImage() in DB.java
				 * This fixes bug #67
				 */
				user.refreshProfileImage();
				userStr += "{\"id\":" + user.getId() + ",\"name\":\""+ user.getUserName() + "\",\"img\":\""+ user.getImageUrl() + "\"}";
				count++;
				System.out.println("prepareUserJSON: id: "+ user.getId() + ", name: " + user.getUserName());
			}
		}
		userStr += "]";  
		System.out.println("prepareUserJSON: exit(true): " + userStr);
		return userStr;
	}
	
	public void setSession(String session) {
		this.session = session;
	}

	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}

	public int getUpdateInterval() {
		return this.updateInterval;
	}

	public void setUpdateInterval(int interval) {
		updateInterval = interval;
	}

	public void decrementUserCount() {
		userCount--;
	}
}
