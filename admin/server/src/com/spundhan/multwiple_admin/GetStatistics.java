package com.spundhan.multwiple_admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetStatistics extends HttpServlet {

	private static final long	serialVersionUID	= 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		String username  = request.getParameter("username");
		DB db = new DB();
		String json = "{\"success\":true, \"statistics\":{";
		if(username.equals("New User")) {
			json += "\"sign_in\":[" + db.getStatistics(Constants.SIGN_IN_WITH_TWITTER, username) +"]";
		}
		else {
			json += "\"added_new_account\":[" + db.getStatistics(Constants.ADDED_NEW_ACCOUNT, username) +"],";
			json += "\"delete_user\":[" + db.getStatistics(Constants.DELETE_USER, username) +"],";
			json += "\"dm\":[" + db.getStatistics(Constants.DIRECT_MESSAGE, username) +"],";
			json += "\"follow_url\":[" + db.getStatistics(Constants.FOLLOW_URL, username) +"],";
			json += "\"follow_user\":[" + db.getStatistics(Constants.FOLLOW_USER, username) +"],";
			json += "\"favorites\":[" + db.getStatistics(Constants.GET_FAVORITES, username) +"],";
			json += "\"followers\":[" + db.getStatistics(Constants.GET_FOLLOWERS, username) +"],";
			json += "\"following\":[" + db.getStatistics(Constants.GET_FOLLOWING, username) +"],";
			json += "\"RT_by_user\":[" + db.getStatistics(Constants.GET_RT_BY_USER, username) +"],";
			json += "\"RT_to_user\":[" + db.getStatistics(Constants.GET_RT_TO_USER, username) +"],";
			json += "\"trends\":[" + db.getStatistics(Constants.GET_TRENDS, username) +"],";
			json += "\"user_info\":[" + db.getStatistics(Constants.GET_USER_INFO, username) +"],";
			json += "\"mark_faorite\":[" + db.getStatistics(Constants.MARK_FAVORITE, username) +"],";
			json += "\"RT_wc\":[" + db.getStatistics(Constants.RT_WITH_COMMENT, username) +"],";
			json += "\"RT_woc\":[" + db.getStatistics(Constants.RT_WITHOUT_COMMENT, username) +"],";
			json += "\"settings\":[" + db.getStatistics(Constants.SAVE_SETTINGS, username) +"],";
			json += "\"search\":[" + db.getStatistics(Constants.SEARCH_TWEETS, username) +"],";
			json += "\"sign_in\":[" + db.getStatistics(Constants.SIGN_IN_WITH_TWITTER, username) +"],";
			json += "\"tweet\":[" + db.getStatistics(Constants.TWEET, username) +"],";
			json += "\"unfollow_user\":[" + db.getStatistics(Constants.UNFOLLOW_USER, username) +"],";
			json += "\"unmark_favorite\":[" + db.getStatistics(Constants.UNMARK_FAVORITE, username) +"],";
			json += "\"url_shortener\":[" + db.getStatistics(Constants.URL_SHORTENER, username) +"]";
		}
		json += "}}";
		out.print(json);
		out.close();
	}
}
