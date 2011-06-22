package com.spundhan.multwiple;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;



public class Cookies {

	private static final int DEFAULT_EXPIRY_TIME = 60*60*24*90; // cookie expires after 90 days
	private int userCount = 0;
	private User[] users = null;
	private int groupId = 0;
	private String session = "";
	private int updateInterval = 1;
	private Logger log;
	
	public Cookies (HttpServletRequest request) {
		log = Logger.getRootLogger();

		/* Cookies must exist. 
		 * Otherwise use has not logged in.
		 */
		Cookie[] cookies = request.getCookies();
		if (cookies != null && cookies.length > 0) {
			/* Go through the list of cookies and get the ones required. */
			for (Cookie cookie : cookies) {
				String cookieName = cookie.getName();
				/* Get session cookie. */
				if (cookieName.equals("session") && cookie.getValue().length()  > 0) {
					session = cookie.getValue();
				}
				else if (cookieName.equals("usergid")) {
					/* Get user group id cookie. */
					String group = cookie.getValue();
					if (group == null || group.length() == 0) {
						continue;
					}
					groupId = Integer.parseInt(group);
				}
				else if(cookieName.equals("interval")) {
					/* Get update interval cookie. */
					String interval = cookie.getValue();
					if (interval == null || interval.length() == 0) {
						continue;
					}
					updateInterval = Integer.parseInt(interval);
				}
			}
		}
		getUsers();
	}

	public boolean isAlreadyThere (int userId) {
		for (User user : users) {
			if (user.getId() == userId) {
				return true;
			}
		}
		return false;
	}

	public void deleteCookie (HttpServletResponse response, String cookieName) {
		Cookie cookie = new Cookie(cookieName, "");
		cookie.setMaxAge(-1); // cookie expires immediately
		response.addCookie(cookie);
	}

	public void deleteAllCookies (HttpServletResponse response) {
		deleteCookie(response, "session");
		deleteCookie(response, "users");
		deleteCookie(response, "usergid");
		deleteCookie(response, "interval");
	}

	public int getUserCount() {
		return userCount;
	}

	public User[] getUsers() {
		log.debug("Cookies: prepareUserJSON: Enter: groupId: " + groupId);

		Connection connection = new DB().getConnection();
		
		try {
			Statement s = connection.createStatement();
			ResultSet rs = s.executeQuery (
					"SELECT " +
						"count(id) " +
					"FROM " +
						"main.user_tokens " +
					"WHERE " +
						"group_id = '"+ groupId + "';"
			);
			userCount = 0;
			
			if (rs.next()) {
				userCount = rs.getInt(1);
			}
			
			rs.close();
			
			if (userCount > 0) {
				rs = s.executeQuery (
						"SELECT " +
							"id, " +
							"screen_name, " +
							"image_url " +
						"FROM " +
							"main.user_tokens " +
						"WHERE " +
							"group_id = '" + groupId + "';"
				);
				
				int count = 0;
				users = new User[userCount];
				
				while (rs.next()) {
					users[count] = new User(rs.getInt(1), rs.getString(2), rs.getString(3));
					users[count].setSession(session);
					users[count].setGroupId(groupId);
					count++;
				}
			}
			rs.close();
			s.close();
		} 
		catch (SQLException se) {
			log.error("Cookies: prepareUserJSON: SQL Exception: " + se.getMessage());
			se.printStackTrace();
			return null;
		}

		try {
			connection.close();
		} 
		catch (SQLException e) {
			log.error("Cookies: prepareUserJSON: SQL Exception: " + e.getMessage());
			e.printStackTrace();
			return null;
		}
		
		try {
			connection.close();
		}
		catch (SQLException e) {
			log.error("Cookies: prepareUserJSON: SQL Exception: " + e.getMessage());
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
		
		cookie = new Cookie("usergid", groupId+"");
		cookie.setPath("/");
		cookie.setMaxAge(DEFAULT_EXPIRY_TIME); 
		response.addCookie(cookie);
		
		cookie = new Cookie("interval", updateInterval+"");
		cookie.setPath("/");
		cookie.setMaxAge(DEFAULT_EXPIRY_TIME); 
		response.addCookie(cookie);
	}

	public String getUsersJSON(){
		String userStr = "[";
		int count = 0;
		getUsers();
		if (users != null) {
			for (User user : users) {
				if (count > 0) {
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
			}
		}
		userStr += "]";  
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
