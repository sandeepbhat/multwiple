package com.spundhan.multwiple;

import java.util.Properties;

import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.http.AccessToken;

public class User {
	private int id;
	private int twitterId;
	private int groupId;
	private String userName;
	private String imageUrl;
	private String session;
	private int updateInterval;
	
	public User(){
		id = 0;
		userName = "";
	}
	
	public User(int id, String uname){
		this.id = id;
		userName = uname;
	}

	public User(int id, String uname, String imageUrl){
		this.id = id;
		userName = uname;
		this.imageUrl = imageUrl;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}

	public int getGroupId() {
		return groupId;
	}

	public void setTwitterId(int twitterId) {
		this.twitterId = twitterId;
	}

	public int getTwitterId() {
		return twitterId;
	}

	public void setSession(String session) {
		this.session = session;
	}

	public String getSession() {
		return session;
	}

	public void setUpdateInterval(int interval) {
		updateInterval = interval;
	}

	public int getUpdateInterval() {
		return updateInterval;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getImageUrl() {
		return imageUrl;
	}

	/* Get the latest updated image's URL for the given user. 
	 * This fixes bug #67 
	 */
	public void refreshProfileImage() {
		AccessToken accessToken = new DB().isSessionValid(id, groupId, session);
		Properties prop = TwitterProperties.getProperties();
		Twitter twitter = new TwitterFactory().getOAuthAuthorizedInstance(prop.getProperty("consumer.key"), prop.getProperty("consumer.secret"), accessToken);
		String newImageUrl = null;
		try {
			twitter4j.User twitterUser = twitter.showUser(userName);
			newImageUrl = Constants.escape(twitterUser.getProfileImageURL().toString());
		}
		catch (TwitterException e) {
			e.printStackTrace();
			System.out.println("GetImageOnline: exit(false)");
			return;
		}
		if (newImageUrl == null || newImageUrl.trim().equals("")) {
			return;
		}
		this.imageUrl = newImageUrl;
		new DB().updateProfileImage(this.imageUrl, this.id);
	}
}
