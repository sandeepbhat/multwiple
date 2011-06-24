package com.spundhan.multwiple;

import java.util.Date;

public class Constants {
	public static final String SERVER_URL = "http://multwiple.com";
//	public static final String SERVER_URL = "http://localhost:8080";

	public static final int FOLLOW_URL 				= 1;
	public static final int FOLLOW_USER 			= 2;
	public static final int GET_FAVORITES 			= 3;
	public static final int GET_FOLLOWERS			= 4;
	public static final int GET_FOLLOWING 			= 5;
	public static final int GET_RT_BY_USER 			= 6;
	public static final int GET_RT_TO_USER 			= 7;
	public static final int GET_USER_INFO 			= 8;
	public static final int MARK_FAVORITE 			= 9;
	public static final int UNMARK_FAVORITE 		= 10;
	public static final int ADDED_NEW_ACCOUNT 		= 11;
	public static final int SIGN_IN_WITH_TWITTER 	= 12;
	public static final int SAVE_SETTINGS 			= 13;
	public static final int RT_WITHOUT_COMMENT 		= 14;
	public static final int DIRECT_MESSAGE 			= 15;
	public static final int TWEET 					= 16;
	public static final int RT_WITH_COMMENT 		= 17;
	public static final int UNFOLLOW_USER 			= 18;
	public static final int	DELETE_USER				= 19;
	public static final int	GET_TRENDS				= 20;
	public static final int	SEARCH_TWEETS			= 21;
	public static final int	URL_SHORTENER			= 22;
	public static final int	ADVERTISEMENT			= 23;
	
	public static String escape(String source) {
//		System.err.println("Before: " + source);
		// replace \ with \\
		source = source.replaceAll("\\\\", "\\\\\\\\");
		// replace " with \\"
		source = source.replaceAll("\"", "\\\\\\\"");
		source = source.replaceAll("[\n]|[\r\n]|[\r]", "<br/>");
//		System.err.println("After: " + source);
		return source;
	}
	
	public static String getTimeStr(Date createdAt) {
		Date now = new Date();
		long seconds = (now.getTime() - createdAt.getTime())/1000;
		if(seconds < 60){
			if(seconds < 0) seconds = 0;
			return seconds + " secs. ago.";
		}
		
		long minutes = seconds / 60;
		if(minutes < 60){
			return minutes + " mins. ago.";
		}
		
		long hours = minutes / 60;
		if(hours < 24){
			return hours + " hrs. ago.";
		}

		long days = hours / 24;
		return days + " days ago.";
	}

	public static boolean isNull (String string) {
		if (string == null || string.trim().length() == 0) {
			return true;
		}
		return false;
	}
}
