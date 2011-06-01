package com.spundhan.multwiple;

import java.util.Properties;

public class TwitterProperties {

	public static Properties getProperties(){
		Properties props = new Properties();
		props.setProperty("consumer.key","VN0lR9Rr9LsnUY4jRfy6kw");
		props.setProperty("consumer.secret","343xaNyayCNXbeBstoU5ONZEuH3YeJHA86nHewSZrUI");
		props.setProperty("request.token.verb","POST");
		props.setProperty("request.token.url","http://twitter.com/oauth/request_token");
		props.setProperty("access.token.verb","POST");
		props.setProperty("access.token.url","http://twitter.com/oauth/access_token");
		props.setProperty("auth.token.url","https://api.twitter.com/oauth/authorize");
		props.setProperty("callback.url", Constants.SERVER_URL + "/s/oauthcback");
		return props;
	}
}
