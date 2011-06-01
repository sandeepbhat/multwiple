package com.spundhan.multwiple_admin;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class Constants {
	public static final int FOLLOW_URL 						= 1;
	public static final int FOLLOW_USER 					= 2;
	public static final int GET_FAVORITES 				= 3;
	public static final int GET_FOLLOWERS					= 4;
	public static final int GET_FOLLOWING 				= 5;
	public static final int GET_RT_BY_USER 				= 6;
	public static final int GET_RT_TO_USER 				= 7;
	public static final int GET_USER_INFO 				= 8;
	public static final int MARK_FAVORITE 				= 9;
	public static final int UNMARK_FAVORITE 			= 10;
	public static final int ADDED_NEW_ACCOUNT 		= 11;
	public static final int SIGN_IN_WITH_TWITTER 	= 12;
	public static final int SAVE_SETTINGS 				= 13;
	public static final int RT_WITHOUT_COMMENT 		= 14;
	public static final int DIRECT_MESSAGE 				= 15;
	public static final int TWEET 								= 16;
	public static final int RT_WITH_COMMENT 			= 17;
	public static final int UNFOLLOW_USER 				= 18;
	public static final int	DELETE_USER						= 19;
	public static final int	GET_TRENDS						= 20;
	public static final int	SEARCH_TWEETS					= 21;
	public static final int	URL_SHORTENER					= 22;
	
	public static String getDateString(Date date) {
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		String date_str = calendar.get(Calendar.DAY_OF_MONTH) + "/" + (calendar.get(Calendar.MONTH) + 1) + "/" + calendar.get(Calendar.YEAR);
		return date_str;
	}
}
