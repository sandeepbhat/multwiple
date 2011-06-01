package com.spundhan.multwiple;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.http.AccessToken;

public class FollowURL extends HttpServlet {


	private static final long serialVersionUID = -8265151299192806614L;
	private Connection connection;

	public void init() throws ServletException {
		super.init();
		DB db = new DB();
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

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.println("Follow URL: enter");
		
		String user = request.getParameter("uid");
		int userId = 0;
		if(user != null && user.length() > 0){
			userId = Integer.parseInt(user);
		}
		
		String multUser = request.getParameter("username");
		DB db = new DB();
		db.logs(userId, multUser, Constants.FOLLOW_URL);

		String tweetIdStr = request.getParameter("id");
		String url = request.getParameter("url");
		long tweetId = 0;
		if(tweetIdStr != null && tweetIdStr.length() > 0){
			tweetId = Long.parseLong(tweetIdStr);
		}

		Cookies cookies = new Cookies(request);
		int groupId = cookies.getGroupId();
		String session = cookies.getSession();
		
		System.out.println("FollowURL: userId:" + userId + ", groupId: " + groupId + ", session: " + session);
		
		/*
		* Set the content type(MIME Type) of the response.
		*/
		response.setContentType("text/html");

		PrintWriter out = response.getWriter();
		
		AccessToken accessToken = db.isSessionValid(userId, groupId, session);
		if(userId == 0 || groupId == 0 || session.equals("") || accessToken == null){
			out.print("<h1>Show proper Error msg here</h1>{ \"success\": false, \"msg\": \"Authentication failed.\"}");
			out.close();
			System.out.println("FollowURL: exit(false)");
			return;
		}
		
		Properties prop = TwitterProperties.getProperties();
		Twitter twitter = new TwitterFactory().getOAuthAuthorizedInstance(prop.getProperty("consumer.key"), prop.getProperty("consumer.secret"), accessToken);
		String code = "";
		try {
			Status status = twitter.showStatus(tweetId);
			Status retweetStatus = status.getRetweetedStatus();
			if (retweetStatus != null){
				status = retweetStatus;
			}
			
			User tweetUser = status.getUser();

			String text = Tweets.parseTweet(Constants.escape(status.getText()), 0);
			String date = Constants.getTimeStr(status.getCreatedAt()) + " via " + Constants.escape(status.getSource());
			String screenName = Constants.escape(tweetUser.getScreenName());
			String img = Constants.escape(tweetUser.getProfileImageURL().toString());
			code = "<html><head><meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\"><title>Multwiple: Following link "+ url +"</title> <link type=\"text/css\" href=\"/css/cupertino/jquery-ui-1.7.2.custom.css\" rel=\"stylesheet\"/>" +
			"<style>html{height:100%;}body{padding:0;margin:0;height:100%;overflow:hidden;font-family:Helvetica Neue,Arial,Helvetica,sans-serif;}form{margin:0;}a,a:visited{color:#00c;}img{border:none;padding:0;margin:0;vertical-align:middle;}#outer-separator{clear:both;width:100%;border-bottom:2px solid #404040;border-top:1px solid #a0a0a0;margin:10px 0 0;padding:0;font-size:1px;overflow:hidden;}#separator{background:#eaeaea;height:3px;}table{vertical-align:top;font-size:100%;margin:0;padding:0;}.ds,.lsbb{display:inline;}table.main-table{height:100%;width:100%;}table.compose-tweet-table td,tr{padding:0 0 0 2px;}.compose-tweet{margin:5px;font-size:smaller;display:none;}.submit-tweet{display:none;width:120px;margin:0 0 0 5px;}.submit-tweet img{vertical-align:middle;}textarea.tweet-text-area{border:2px solid #ccc;height:55px;width:580px;resize:none;padding:5px;}.tweettime a{text-decoration:none;}.tweettime a:HOVER{text-decoration:underline;}.tweet-table td{padding:0;vertical-align:top;}.tweet-table{vertical-align:top;padding:0;margin-bottom:5px;}.tweetmsg{color:#555;}.tweettime{padding:0 0 2px 5px;color:#999;}.tweetbox_1{margin:5px;border:1px solid #ccc;font-size:smaller;background:#EEE;padding:5px 5px 3px 5px;}.original-tweet{width:570px; height: 55px;}.bold-link a{text-decoration:none;font-weight:bold;font-size:small;color:#222;}.bold-link a:HOVER{text-decoration:underline;font-weight:bold;font-size:small;color:#222;}.corner-all{-moz-border-radius-bottomleft:6px;-moz-border-radius-bottomright:6px;-moz-border-radius-topleft:6px;-moz-border-radius-topright:6px;}.tweet-submit-form input{width:70px;}.chars_left{font-size:large;color:#777;}img.small-icon{height:16px;width:16px;vertical-align:middle;}.retweet{width:100px;}.retweet button{width:110px;height:25px;font-size:small;}.jui-button:HOVER{border:1px solid #74b2e2;background:#e4f1fb url(images/ui-bg_glass_100_e4f1fb_1x400.png) 50% 50% repeat-x;font-weight:bold;color:#0070a3;outline:none;cursor:pointer;}span#cancel_retweet:HOVER{border:1px solid #ccc;cursor:pointer;}</style> <script type=\"text/javascript\" src=\"/scripts/jquery-1.4.2.min.js\"></script>" +
			"<script type=\"text/javascript\" src=\"scripts/jquery-ui-1.7.2.custom.min.js\"></script> <script type=\"text/javascript\">function reTweet(){$(\".original-tweet\").hide();$(\".retweet\").hide();$(\".compose-tweet\").show();$(\".submit-tweet\").show();var a=\"RT @\"+$(\"#tweet_user\").text()+\" \"+$(\"#tweet_msg\").text();$(\".tweet-text-area\").val(a);$(\".tweet-text-area\").focus();updateChars()}function closeRetweet(){$(\".compose-tweet\").hide();$(\".submit-tweet\").hide();$(\".original-tweet\").show();$(\".retweet\").show()}function updateChars(){var b=$(\".tweet-text-area\").val();var a=140-b.length;if(a<0){$(\".chars_left\").text(a).css(\"color\",\"#ff0000\");$(\"#updateButton\").attr(\"disabled\",true)}else{if(a==140){$(\".chars_left\").text(a).css(\"color\",\"#aaa\");$(\"#updateButton\").attr(\"disabled\",true)}else{$(\".chars_left\").text(a).css(\"color\",\"#aaa\");$(\"#updateButton\").attr(\"disabled\",false)}}}function submitComplete(){$(\"#wait_image\").hide();$(\"#cancel_retweet\").show();$(\"#updateButton\").fadeIn(\"slow\");$(\".tweet-text-area\").val(\"\");updateChars();closeRetweet()}function submitTweet(){$(\"#updateButton\").hide();$(\"#cancel_retweet\").hide();$(\"#wait_image\").fadeIn(\"slow\");var a=$(\"#tweetMsg\").val();$.post(\"/s/tweetUpdate\",{user:"+ userId +",gid:0,session:0,tweet:a},function(b){if(b.success){submitComplete()}else{alert(b.msg);submitComplete();}},\"json\")};</script>" +
			"</head> <body><table class=\"main-table\" cellpadding=\"0\" cellspacing=\"0\"> <tbody> <tr height=\"1%\"> <td style=\"top: 0pt; width: 100%;\"> <div style=\"border-bottom: 1px solid #ddd\" class=\"top-tweet-panel\"> <table cellpadding=\"0\" cellspacing=\"0\"> <tr> <td style=\"width:25%;\"><a href=\"http://multwiple.com\" title=\"Multwiple.com\"><img width=\"188\" height=\"55\" src=\"/images/logo.png\" alt=\"Multwiple\"/></a></td> <td style=\"width:50%;\"> <table cellpadding=\"0\" cellspacing=\"0\"> <tr> <td><span class=\"userimg\"> <a target=\"_blank\" href=\"http://twitter.com/"+ screenName +"\"> <img class=\"tweetimg\" src=\""+ img +"\" alt=\"image\"/> </a> </span></td> <td> <div class=\"tweetbox_1 ui-corner-all original-tweet\"> <table class=\"tweet-table\"> <tr> <td style=\"padding-right: 5px;\" colspan=\"1\"><span class=\"bold-link\"> <a id=\"tweet_user\" target=\"_blank\" href=\"http://twitter.com/"+ screenName +"\">"+ screenName +"</a> </span> <span id=\"tweet_msg\" class=\"tweetmsg\">"+ text +"</span> <br/> </td> </tr> <tr> <td colspan=\"3\"><span class=\"tweettime\">"+ date +"</span> </td> </tr> </table> </div> <div class=\"compose-tweet\"> <form class=\"tweet-form\"><textarea class=\"tweet-text-area ui-corner-all\" maxlength=\"140\" cols=\"70\" rows=\"2\" onkeyup=\"updateChars();\" id=\"tweetMsg\"> </textarea></form> </div> </td> <td> <div class=\"submit-tweet\"> <div style=\"padding: 0px 55px 0px 0px;\"><span class=\"chars_left\">140</span> <span style=\"float: right;\" id=\"cancel_retweet\" onclick=\"javascript:closeRetweet();\" class=\"ui-icon ui-icon-closethick ui-corner-all\"></span></div> <div class=\"bold-link\"> <form class=\"tweet-submit-form\" method=\"post\" action=\"\" onsubmit=\"return (false);\"><input type=\"submit\" name=\"update\" value=\"Submit\" id=\"updateButton\" onclick=\"submitTweet();\" disabled=\"disabled\" class=\"jui-button ui-state-default ui-corner-all\"/></form> <span id=\"wait_image\" style=\"display: none; font-size: smaller; font-weight: bold;\"> Sending &nbsp;<img src=\"/images/indicator_arrows.gif\" alt=\"Updating\"/> </span></div> </div> <div class=\"retweet\"> <button onclick=\"javascript:reTweet();\" class=\"jui-button ui-state-default ui-corner-all\">Re-Tweet <span style=\"float: right;\" class=\"ui-icon ui-icon-arrowreturnthick-1-w\"></span></button> </div> </td> </tr> </table> </td> </tr> </table> </div> </td> </tr> <tr> <td><iframe src=\""+ url +"\" allowtransparency=\"true\" style=\"width: 100%; height: 100%;\" frameborder=\"0\" scrolling=\"auto\"></iframe> </td> </tr> </tbody>" +
			"</table></body></html>";
					
		} catch (TwitterException e) {
			//		e.printStackTrace();
//			System.err.println("ERROR: " + e.getLocalizedMessage());
			out.print("<h1>Show proper Error msg here</h1>{\"success\": false, \"msg\": \"" + TwitterError.getErrorMessage(e.getStatusCode()) + "\"}");
			out.close();
			return;
		}
		
		out.print(code);
		out.close();
		
		System.out.println("getMentions("+ userId +"): exit(true)");
		
	}
}
