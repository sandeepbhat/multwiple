package com.spundhan.multwiple;

import java.net.MalformedURLException;
import java.net.URL;

public class Tweets {

	public static String parseTweet(String s, long id){
		String newTweet = "";
		String [] parts = s.split("\\s");

		String gotoUrl = "";
		String gotoUrlEnd = "";
		if(id > 0){
			gotoUrl = "javascript:gotoUrl(" + id +", '";
			gotoUrlEnd = "');";
		}
		// Attempt to convert each item into an URL.   
		for( String word : parts ) {
			try {
				URL url = new URL(word);
				// If possible then replace with anchor...
				/* TODO: expand the URL here and set thelong url as the title */
				if(word.length() > 25){
					word = word.substring(0, 25) + "...";
				}
				newTweet += "<a alt=\""+url+"\" href=\""+ gotoUrl + url + gotoUrlEnd + "\">"+ word + "</a> ";    
			} catch (MalformedURLException e) {
				// If there was no URL
				if(word.indexOf('#') == 0){
					int index = word.indexOf('.');
					String splitStr = "";
					if(index > 0){
						splitStr = word.substring(index);
						word = word.substring(0, index);
					}
					String key = word.replaceAll("[^a-zA-Z0-9]", "");
					newTweet += "<a href=\""+ gotoUrl + "http://search.twitter.com/search?q="+ key + gotoUrlEnd + "\">"+ word + "</a>" + splitStr + " ";    
				}
				else if(word.indexOf('@') == 0){
					String user = word.substring(1);
					newTweet += "<a href=\"http://twitter.com/" + user + "\" target=\"_blank\">"+ word + "</a> ";    
				}
				else if(word.indexOf('\\') >= 0){
					String newWord = word.replaceAll("\\", "\\\\");
					newTweet += newWord + " ";
				}
				else {
					newTweet +=  word + " ";
				}
			}
		}
		return newTweet;
	}
}
