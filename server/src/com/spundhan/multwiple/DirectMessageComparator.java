package com.spundhan.multwiple;

import java.util.Comparator;
import twitter4j.DirectMessage;


public class DirectMessageComparator implements Comparator<DirectMessage> {

	@Override
	public int compare(DirectMessage obj1, DirectMessage obj2) {
		if(obj1.getId() > obj2.getId()){
			return -1;
		}
		else if(obj1.getId() < obj2.getId()){
			return 1;
		}
		return 0;
	}
	
}
