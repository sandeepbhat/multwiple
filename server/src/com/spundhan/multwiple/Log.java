package com.spundhan.multwiple;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Log extends HttpServlet {
	private static final long	serialVersionUID	= 5697012127712530450L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		String multUser = request.getParameter("multUser");
		int userId = Integer.parseInt(request.getParameter("userId"));
		int actionId = Integer.parseInt(request.getParameter("actionId"));
		String data = null;
		if(actionId == Constants.SEARCH_TWEETS) {
			data = request.getParameter("keyword");
			new DB().logs(userId, multUser, actionId, data);
			return;
		}
		new DB().logs(userId, multUser, actionId);
	}
}
