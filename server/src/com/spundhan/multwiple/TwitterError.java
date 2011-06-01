package com.spundhan.multwiple;

public class TwitterError {

	public static String getErrorMessage(int errCode){
		String msg = "";
		switch(errCode){
		case 304:
			msg = "There was no new data to return.";
			break;
		case 400:
			msg = "The request was invalid.  An accompanying error message will explain why.";
			break;
		case 401:
			msg = "Authentication credentials were missing or incorrect.";
			break;
		case 403:
			msg = "The request is understood, but it has been refused.  An accompanying error message will explain why.";
			break;
		case 404:
			msg = "The URI requested is invalid or the resource requested, such as a user, does not exists.";
			break;
		case 406:
			msg = "Returned by the Search API when an invalid format is specified in the request.";
			break;
		case 500:
			msg = "Something is broken.  Please post to the group so the Twitter team can investigate.";
			break;
		case 502:
			msg = "Twitter is down or being upgraded.";
			break;
		case 503:
			msg = "The Twitter servers are up, but overloaded with requests. Try again later.";
			break;
		default:
			msg="Unknown Error.";
		}
		
		return msg;
	}
	
	public static String prepareErrorHTML(String message){
		String code = "<html><head><meta http-equiv=\"content-type\" content=\"text/html; charset=ISO-8859-1\"><title>Multwiple: Came across a Twitter Error...</title><style>html {  font-family: Verdana, Arial, Helvetica, sans-serif;}</style></head><body>" +
				"<div style=\"border: 1px solid #aaa; background: #eefefe; margin: 50px auto; text-align: center; width: 1024px;  height: 400px;\"><table style=\"width: 1024px;\"><tbody><tr><td style=\"border-bottom: 1px solid #aaa;\"><img src=\"/images/logo.png\" alt=\"Multwiple.com\"/></td></tr><tr>" +
				"<td style=\"padding: 30px 100px;\"><h1>Ooops! Twitter Error.</h1></td>" +
				"</tr><tr><td style=\"padding: 0 100px;\">" +
				"We are experiencing problems accessing Twitter services at the moment. This can happen due to twitter being too busy catching the big whale! Unfortunately this situation is out of our hands.<br/><br/>" +
				"Reason: " + message +
				"<br/><br/><strong>Hint:</strong> Refreshing this page might fix this issue." +
				"</td></tr></tbody></table></div></body></html>";
		return code;
		
	}
}
