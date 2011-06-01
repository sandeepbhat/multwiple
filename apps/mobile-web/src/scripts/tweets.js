var TELL_FRIEND_MSG = 'I am using http://multwiple.com .. Tweet using multiple twitter accounts on #multwiple..';
var REDIRECT_URL = '/s/goto';
var UPDATE_INTERVAL = 1 * 60 * 1000;
var NEW_COUNT_INTERVAL = 1 * 60 * 1000;
var TRENDS_ACTION_ID = 20;
var SEARCH_ACTION_ID = 21;
var URL_SHORTENER_ACTION_ID = 22;

var g_refresh_timer = {"search_result": 0, "trend_result": 0};   
var g_home_timer;
var g_mention_timer;
var g_direct_timer;
var g_stat_timer;

var g_remove_user = new Array();

var g_update_count_timers = new Array(); 

var TWEETS_PER_PAGE = 20; 

var RETWEETED = 1;
var DIRECT_MSG = 2;
var GENERAL_TWEET = 3;

function buildTweetBox(tweets, type, userId) {
	
	var tweet_id_str = $( "#latest_" + type + "_" + userId).val();

	var latest_tweet_id = 0;
	
	if(tweet_id_str != '') {
	  	latest_tweet_id = parseInt(tweet_id_str);
	}

	var code = '';
	
  	var count = 0;
  	
	for (tweet_index in tweets) {
		var tweet = tweets[tweet_index];
		var current_tweet_id = tweet.id;
		if(current_tweet_id > latest_tweet_id) {
			$( "#latest_" + type + "_" + userId).val(current_tweet_id);
			latest_tweet_id = current_tweet_id;
		}
		code += buildTweet(tweet, userId, type);
		count ++;
	}
	return code;	
}


function buildTweet(tweet, userId, type) {
	var tweet_src = '';
	
	if(type != 'direct') {
		tweet_src = ' via '+ tweet.src;
	}
	
	var retweet_icon = '';
	var retweet_user = '';
	
	if((type == 'home' || type == 'RT_to_me' || type == 'RT_by_me') && tweet.RT.length > 0) {
		retweet_icon =  '<span class="ui-icon ui-icon-refresh RT-icon"></span>';
		retweet_user =  '<span class="tweettime">Retweeted by <a target="_blank" href="http://twitter.com/'+tweet.RT+'">@' + tweet.RT + '</a></span>';
	}

	var tweet_class = 'tweetbox_1';
	if((type == 'home' || type == 'mention' || type == 'direct') && tweet.old) {
			tweet_class = 'tweetbox_0';
	}
	
	var code  = '<div id="'+type+'_'+ userId + tweet.id +'" class="'+tweet_class+'" onclick="javascript:showReplyMenu(\''+type+'\', '+userId+', '+tweet.id+');">'+ // home_35_18597891527
				'	<table class="tweet-table">'+
				'		<tr id="'+type+'_tweet_row_'+ userId + tweet.id +'">'+ //home_tweet_row_3518597891527		
				'			<td colspan="1">'+			
				'				<span class="userimg">'+
				'					<a href="#">'+
				'						<img alt="image" src="'+tweet.img+'" class="tweetimg" />'+
				'					</a>'+
				'				</span>'+		
				'			</td>'+		
				'			<td colspan="1" style="padding-right: 5px;">'+			
				'				<span class="tweetuser">'+
				'					'+ retweet_icon +'<a href="http://twitter.com/'+tweet.user+'" target="_blank" id="'+type+'_user_'+ userId + tweet.id +'">'+tweet.user+'</a>'+ //"f_3518597891527"
				'				</span>'+			
				'				<span class="tweetmsg" id="'+type+'_tweet_text_'+ userId + tweet.id +'">'+ //"home_tweet_3518597891527"
									encodeTweet(tweet.text, tweet.id)+ 
				'				</span>'+		
				'			</td>'+		
				'		</tr>'+
				'		<tr id="'+type+'_RT_row_'+ userId + tweet.id +'">'+
				'			<td id="'+ type +'_RT_column_'+ userId + tweet.id +'" colspan="2">'+
								retweet_user +
				'			</td>'+
				'		</tr>'+
				'		<tr id="'+type+'_tweet_date_row_'+ userId + tweet.id +'">'+
				'			<td colspan="2">'+
				'				<span class="tweettime">' + tweet.date + tweet_src +'</span>'+
				'			</td>'+
				'		</tr>'+
				'		<tr id="'+type+'_reply_row_'+ userId + tweet.id +'" style="display:none;">'+ 	//"home_reply_row_3518597891527"
				'			<td colspan="2">'+
				'				<form action="" method="" onsubmit="return false;">'+
				'					<div>'+
				'						<textarea id="'+type+'_tweet'+ userId + tweet.id +'" class="text-box" rows="2" cols="70" maxlength="140" onkeyup="updateChars(this.value,'+ userId +', \''+type+'\', '+tweet.id+');"></textarea>'+ // hoem_tweet_text_3518597891527
				'					</div>'+
				'					<div style="text-align:right;width:90%;padding-top:5px;">'+
				'	 					<span class="chars_left" id="'+type+'_chars_left'+ userId + tweet.id +'">140</span>' +
				'   	  				<input type="button" class="ui-state-disabled jui-button" name="update" value="Submit" id="'+type+'_updateButton'+ userId + tweet.id +'" onclick="tweetUpdate(\''+type+'\', '+ userId +', '+tweet.id+');" disabled="disabled"/>' +
				'   	  				<input type="button" class="jui-button" name="cancel" value="Cancel" onclick="hideReplyBox(\''+type+'\', '+ userId +', '+tweet.id+');"/>' +
				'						<span id="'+type+'_updateStatus'+ userId + tweet.id +'" style="display: none; color:#222;">Sending &nbsp;<img src="images/indicator_arrows.gif" alt="Updating"/></span>' +
				'					</div>'+
				'				</form>'+
				'			</td>'+
				'		</tr>'+	
				'	</table>'+	
				'</div>';
	return code;
}

function updateHome(user) {
	var tweet_id = parseInt($("#latest_home_"+user.id).val());
	$.post("/s/getUpdates",
			  { 
				"user" 		: user.id,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"tweetId"	: tweet_id 
			  },
			  function(response) { 
				if(response.success) {
					var code = buildTweetBox(response.result, 'home', user.id);
					$("#home_"+user.id).prepend(code);
				}
				else {
				}
				g_home_timer = setTimeout('updateHome({"id":'+user.id+', "name": \''+user.name+'\'});', UPDATE_INTERVAL);
			  },
	  "json"
	);
}



function updateMentions(user) {
	var tweet_id = parseInt($("#latest_mention_"+user.id).val());
	$.post("/s/getMentions",
			  { 
				"user" 		: user.id,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"tweetId"	: tweet_id 
			  },
			  function(response) { 
				if(response.success) {
					var code = buildTweetBox(response.result, 'mention', user.id);
					$("#mention_"+user.id).prepend(code);
				}
				else {
					
				}
				g_mention_timer = setTimeout('updateMentions({"id":'+user.id+', "name": \''+user.name+'\'});', UPDATE_INTERVAL);
			  },
	  "json"
	);
}



function updateDirects(user) {
	var tweet_id = parseInt($("#latest_direct_"+user.id).val());
	$.post("/s/getDirects",
			  { 
				"user" 		: user.id,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"tweetId"	: tweet_id 
			  },
			  function(response) { 
				if(response.success) {
					var code = buildTweetBox(response.result, 'direct', user.id);
					$("#direct_"+user.id).prepend(code);
				}
				else {
					
				}
				g_direct_timer = setTimeout('updateDirects({"id":'+user.id+', "name": \''+user.name+'\'});', UPDATE_INTERVAL);
			  },
	  "json"
	);
}

function stopAutoUpdates() {
	clearTimeout(g_home_timer);
	clearTimeout(g_mention_timer);
	clearTimeout(g_direct_timer);
}


function isUrl(s) {
	var regexp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/
	return regexp.test(s);
}


function encodeTweet(tweetMsg, id) {

	var gotoUrl = "";
	var gotoUrlEnd = "";
	if(id > 0){
		gotoUrl = "javascript:gotoUrl(" + id +", '";
		gotoUrlEnd = "');";
	}

	var newTweet = "";
	var parts = tweetMsg.split(" ");
	var index = 0;
	
	// Attempt to convert each item into an URL.   
	for( index in parts ) {
		var word = parts[index];
		if(isUrl(word)){
			var shortURL = word;
			if(shortURL.length > 25){
				shortURL = shortURL.substring(0, 25) + "...";
			}
			newTweet += '<a title="'+ word +'" href="'+ gotoUrl + word + gotoUrlEnd + '">'+ shortURL + '</a> ';
		}
		else {
			// If there was no URL
			if(word.indexOf("#") == 0){
				var hash_index = word.indexOf(".");
				var splitStr = "";
				if(hash_index > 0) {
					splitStr = word.substring(hash_index);
					word = word.substring(0, hash_index);
				}
//				var key = word.substring(1, word.length);
				var key = word.replace(/[^a-zA-Z0-9]/g, '');
				newTweet += '<a href="'+ gotoUrl + 'http://search.twitter.com/search?q='+ key + gotoUrlEnd + '">'+ word + '</a>' + splitStr + ' ';
			}
			else if(word.indexOf("@") == 0) {
				var user = word.replace(/[@#:\.\,\?!\s]/g, '');
				newTweet += '<a href="'+ gotoUrl + 'http://twitter.com/' + user + gotoUrlEnd + '">'+ word + '</a> ';    
			}
			else {
				newTweet +=  word + ' ';
			}
		}
	}
	return newTweet;
}

function showTweetBox(userId, type) {
	$(".tweet-box-"+userId).hide();
	$("#"+type+"_container_"+userId).show();
}

function showReplyMenu(type, userId, tweetId) {
	$("#reply_menu").toggle();
	if(type == 'direct') {
		$("#retweet_wc").hide();
		$("#retweet_woc").hide();
	}
	else {
		$("#retweet_wc").show();
		$("#retweet_woc").show();
		$("#retweet_wc").attr('href', 'javascript:reTweet(\''+type+'\', '+userId+', '+tweetId+');');
		$("#retweet_woc").attr('href', 'javascript:reTweetWOC(\''+type+'\', '+userId+', '+tweetId+');');
	}
	$("#public_reply").attr('href', 'javascript:publicReply(\''+type+'\', '+userId+', '+tweetId+');');
	$("#direct_msg").attr('href', 'javascript:directMessage(\''+type+'\', '+userId+', '+tweetId+');');
}

function hideReplyBox(type, userId, tweetId) {
	$('#'+ type +'_reply_row_'+ userId + tweetId).hide();
	$('#'+ type +'_tweet_row_'+ userId + tweetId).show();
	$('#'+ type +'_tweet_date_row_'+ userId + tweetId).show();
	$('#'+ type +'_RT_row_'+ userId + tweetId).show();
}

function showReplyBox(type, userId, tweetId) {
	$('#'+ type +'_tweet_row_'+ userId + tweetId).hide();
	$('#'+ type +'_tweet_date_row_'+ userId + tweetId).hide();
	$('#'+ type +'_RT_row_'+ userId + tweetId).hide();
	$('#'+ type +'_reply_row_'+ userId + tweetId).show();
}

function reTweetWOC(type, userId, tweetId) {
	$.post("/s/tweetUpdate",
			{
				"user" 		: userId,
				"multUser" 	: g_selected_username,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"tweetId"	: tweetId
			},
			function(response) { 
				if(response.success) {
					var html = $("#"+type+"_RT_column_"+userId+tweetId).html();
					if(html != '') {
						html += '<br/>';
					}
					html += '<span class="tweettime">Retweeted by <a target="_blank" href="http://twitter.com/'+response.tweet.RT+'">'+response.tweet.RT+'</a></span>';
					$("#"+type+"_RT_column_"+userId+tweetId).html(html);
				}
				else {
					
				}
			},
			"json"
		);
}

function publicReply(type, user, id){
	$("#"+type+"_tweet" + user + id).focus();
	var username = $("#"+ type +"_user_"+ user + id).text();
	var msg = '@' + username + ' ';
	alert(msg);
	$("#"+type+"_tweet" + user + id).val(msg);
	updateChars(msg, user, type, id);
	showReplyBox(type, user, id);
}

function reTweet(type, user, id) {
	$("#"+type+"_tweet" + user + id).focus();
	var username = $("#"+ type + "_user_" + user + id).text();
	var decodedtweet = decodeLinks("#"+ type + "_tweet_text_" + user + id);
	var msg = 'RT @' + username + ' ' + decodedtweet;
	alert(msg);
	$("#"+type+"_tweet" + user + id).val(msg);
	updateChars(msg, user, type, id);
	showReplyBox(type, user, id);
}

function directMessage(type, user, id){
	$("#"+type+"_tweet" + user + id).focus();
	var username = $("#"+ type + "_user_" + user + id).text();
	var msg = 'd ' + username + ' ';
	alert(msg);
	$("#"+type+"_tweet" + user + id).val(msg);
	updateChars(msg, user, type, id);
	showReplyBox(type, user, id);
}

function decodeLinks(tweetMsg) {
	var tweet = $(tweetMsg).html();
	$("#decoded_tweet_"+g_selected_user_id).html(tweet);
	$("#decoded_tweet_"+g_selected_user_id+" a").each (
		function() {
			var url = $(this).attr('title');
			if(url.length > 0) {
				$(this).replaceWith(url);
			}
		}
	);
	var msg = $("#decoded_tweet_"+g_selected_user_id).text();
	return (msg);
}


//$("#"+type+"_tweet_row_"+ userId + tweetId).hide();
//$("#"+type+"_reply_row_"+ userId + tweetId).show();

function updateChars(text, userId, type, tweetId){
	var remaining = 140 - text.length;
	if(remaining < 0){
		$("#"+type+"_chars_left" + userId + tweetId).text(remaining).css('color','#ff0000');
		$("#"+type+"_updateButton" + userId + tweetId).addClass('ui-state-disabled');
		$("#"+type+"_updateButton" + userId + tweetId).attr('disabled', true);
	}
	else if(remaining == 140) {
		$("#"+type+"_chars_left" + userId + tweetId).text(remaining).css('color','#aaa');
		$("#"+type+"_updateButton" + userId + tweetId).addClass('ui-state-disabled');
		$("#"+type+"_updateButton" + userId + tweetId).attr('disabled', true);
	}
	else {
		$("#"+type+"_chars_left" + userId + tweetId).text(remaining).css('color','#aaa');
		$("#"+type+"_updateButton" + userId + tweetId).removeClass('ui-state-disabled');
		$("#"+type+"_updateButton" + userId + tweetId).attr('disabled', false);
	}
}

function tweetUpdate(type, userId, tweetId) {
	
	var tweet = $("#"+type+"_tweet" + userId + tweetId).val();
	$("#"+type+"_updateButton" + userId + tweetId).hide();
	$("#"+type+"_updateStatus" + userId + tweetId).fadeIn('slow');

	$.post("/s/tweetUpdate",
			{
				"user" 		: userId,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"tweet" 	: tweet,
				"multUser"	: g_selected_username
			},
			function(response) { 
				if(response.success) {

					tweet = response.tweet;
					var code = '';
					if(response.direct) {
						
						//Update the latest tweet.. sent for the next updates...
						$("#latest_direct_"+userId).val(tweet.id);
						
						//Build tweet & display it...
						code = buildTweet(tweet, userId, 'direct');
						
						$("#direct_" + userId).prepend(code);
					}
					else {
						
						//Update the latest tweet.. sent for the next updates...
						$("#latest_home_"+userId).val(tweet.id);
						
						//Build tweet & display it...
						code = buildTweet(tweet, userId, 'home');
						
						$("#home_" + userId).prepend(code);
					}
					
					if(tweetId  > 0) {
						hideReplyBox(type, userId, tweetId);
					}
					else {
						//Clear the text field...
						$("#"+type+"_tweet" + userId + tweetId).val("");
						//Update the characters to 140 & disable the submit button..
						updateChars('' , userId, type, tweetId);
					}
					
				}
				else { 
					// show error
					alert('Sorry !! Some Error Occurred. '+response.msg);
				}
				
				$("#"+type+"_updateStatus" + userId + tweetId).hide();
				$("#"+type+"_updateButton" + userId + tweetId).fadeIn('slow');
			},
			"json"
		);
}

function startNewSearch(userId) {
	var key = $("#search_key_"+userId).val();
	searchTweets(userId, 1, key, 'search_result');
}

function searchTweets(userId, page, key, type) {
	
//	$("#"+type+"_img_"+userId).fadeIn('slow');

	var url = 'http://search.twitter.com/search.json?callback=?&rpp=20&';

	var refresh = false;
	
	//This means we are refreshing the results...
	if(key.indexOf('since_id') >= 0) {
		url += key;
		refresh = true;
	}
	else {
		var key_temp = '';
		
		//Clear the old refresh timer
		clearTimeout(g_refresh_timer[type]);
		
		//This means search also includes tweets' source (Eg: multwiple, hootsuite, echofon)
		if(key.indexOf(':') > 0) {
			var source = key.substring((key.indexOf(':') + 1), 	key.length);
			key_temp = key.substring(0, key.indexOf(':'));

			//Replace all non-alphabets...
			key_temp = key_temp.replace(/[^a-zA-Z0-9\s]/g,'');
			url += 'page='+page+'&';
			url += 'q='+key_temp+'+source:'+source;
		}
		else {
			//This means a normal keyword search
			key_temp = key.replace(/[^a-zA-Z0-9\s]/g,'');
			url += 'page='+page+'&';
			url += 'q='+key_temp;
		}
	}
	
	$.getJSON (
				url,
				function(response) {

					if(response.results.length == 0) {
						if(!refresh) {
							alert('No Results found for "'+key+'"');
						}
						return;
					}
					
					var i = 0;
					var code = '';
					
					for(i in response.results) {
						var tweet = response.results[i];
						code += buildSearchTweet(tweet, userId, type);
					}
					
					if(refresh) {
						$("#"+type+"_"+userId).prepend(code);
					}
					else {
						$("#"+type+"_"+userId).html(code);
					}
					
//					if(!$("#"+type+"_"+userId).is(':hidden')) {
//						g_refresh_timer[type] = setTimeout('searchTweets('+userId+', 1, \''+response.refresh_url+'\', \''+type+'\');', UPDATE_INTERVAL);
//					}
					
//					$("#"+type+"_img_"+userId).fadeOut('slow');
				}
			 );

	$.post(	"/s/log", 
			{
				"userId"	: userId,
				"multUser"	: g_selected_username,
				"actionId"	: SEARCH_ACTION_ID 
			}
		  );

}

function buildSearchTweet(tweet, userId, type) {
	var code  = '<div id="'+type+'_'+ userId + tweet.id +'" class="tweetbox_1" onclick="javascript:showReplyMenu(\''+type+'\', '+userId+', '+tweet.id+');">'+ // home_35_18597891527
				'	<table class="tweet-table">'+
				'		<tr id="'+type+'_tweet_row_'+ userId + tweet.id +'">'+ //home_tweet_row_3518597891527		
				'			<td colspan="1">'+			
				'				<span class="userimg">'+
				'					<a href="#">'+
				'						<img alt="image" src="'+tweet.profile_image_url+'" class="tweetimg" />'+
				'					</a>'+
				'				</span>'+		
				'			</td>'+		
				'			<td colspan="1" style="padding-right: 5px;">'+			
				'				<span class="tweetuser">'+
				'					<a href="http://twitter.com/'+tweet.from_user+'" target="_blank" id="'+type+'_user_'+ userId + tweet.id +'">'+tweet.from_user+'</a>'+ //"f_3518597891527"
				'				</span>'+			
				'				<span class="tweetmsg" id="'+type+'_tweet_text_'+ userId + tweet.id +'">'+ //"home_tweet_3518597891527"
									encodeTweet(tweet.text, tweet.id)+ 
				'				</span>'+		
				'			</td>'+		
				'		</tr>'+
				'		<tr id="'+type+'_tweet_date_row_'+ userId + tweet.id +'">'+
				'			<td colspan="2">'+
				'				<span class="tweettime">' + getTweetTime(tweet.created_at) + ' via ' + getTweetSource(tweet.source) +'</span>'+
				'			</td>'+
				'		</tr>'+
				'		<tr id="'+type+'_reply_row_'+userId+tweet.id+'" style="display:none;">'+ 	//"home_reply_row_3518597891527"
				'			<td colspan="2">'+
				'				<form action="" method="" onsubmit="return false;">'+
				'					<div>'+
				'						<textarea id="'+type+'_tweet'+ userId + tweet.id +'" class="text-box" rows="2" cols="70" maxlength="140" onkeyup="updateChars(this.value,'+ userId +', \''+type+'\', '+tweet.id+');"></textarea>'+ // hoem_tweet_text_3518597891527
				'					</div>'+
				'					<div style="text-align:right;width:90%;padding-top:5px;">'+
				'	 					<span class="chars_left" id="'+type+'_chars_left'+ userId + tweet.id +'">140</span>' +
				'	   		  			<input type="button" class="ui-state-disabled jui-button" name="update" value="Submit" id="'+type+'_updateButton'+ userId + tweet.id +'" onclick="tweetUpdate(\''+type+'\', '+ userId +', '+tweet.id+');" disabled="disabled"/>' +
				'  		  				<input type="button" class="jui-button" name="cancel" value="Cancel" onclick="hideReplyBox(\''+type+'\', '+ userId +', '+tweet.id+');"/>' +
				'						<span  id="'+type+'_updateStatus'+ userId + tweet.id +'" style="display: none; color:#222;">Sending &nbsp;<img src="images/indicator_arrows.gif" alt="Updating"/></span>' +
				'					</div>'+
				'				</form>'+
				'			</td>'+
				'		</tr>'+	
				'	</table>'+	
				'</div>';
	return code;
}

function getTweetTime(created_at) {
	var now = new Date();
	
	var now_utc = now.getTime();
	
	var tweet_date_utc = Date.parse(created_at);
	
	var seconds = Math.round((now_utc - tweet_date_utc) / 1000);
	
	if(seconds < 60) {
		if(seconds < 0) {
			seconds = 0;
		}
		return seconds + ' secs. ago.';
	}
	
	var minutes = Math.round(seconds / 60);
	if(minutes < 60) {
		return minutes + ' mins. ago.';
	}
	
	var hours = Math.round(minutes / 60);
	if(hours < 24) {
		return hours + ' hrs. ago.';
	}
	
	var days = Math.round(hours / 24);
	if(days == 1) {
		return days + ' day ago';
	}
	else if (days < 30) {
		return days + ' days ago';
	}
	
	var months = Math.round(days/30);
	if(months == 1) {
		return months + ' month ago.';
	}
	else {
		return months + ' months ago.';
	}
}

function getTweetSource(source_link) {
	var link = source_link.replace(/&lt;/g, '<');
	link = link.replace(/&gt;/g, '>');
	link = link.replace(/&quot;/g, '"');
	return link;
}


function getRetweet(userId, RT_by_me, page) {

	$.post("/s/getRetweets", 
			{
	
				"RTMe"		: RT_by_me,
				"user"		: userId,
				"multUser"	: g_selected_username,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"page"		: page
			},
			function(response) {
				if(response.success) {
					var i = 0;
					var type = '';
					var code = '';
					if(RT_by_me) {
						type = 'RT_by_me';
					}
					else {
						type = 'RT_to_me';
					}
					for(i in response.result) {
						var tweet = response.result[i];
						code += buildTweet(tweet, userId, type);
					}
					
					$("#"+type+"_"+userId).html(code);
					
					showTweetBox(userId, type);
				}
				else {
				}
			}, 
		"json"
	);
}

function getFavorites(userId, page) {
	
//	$("#favorites_img_"+userId).fadeIn('slow');
	$.post("/s/getFavorites", 
			{
				"user"		: userId,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"page"		: page,
				"multUser"	: g_selected_username
			},
			function(response) {
				if(response.success) {
					var code = '';
					var i = 0;
					
					for(i in response.result) {
						var tweet = response.result[i];
						code += buildTweet(tweet, userId, 'favorite');
					}
					$("#favorite_"+userId).html(code);
					showTweetBox(userId, 'favorite');
				}
				else {
					
				}
			},
		"json"
	);
}

function getTrends(userId) {
	
	var url = 'http://search.twitter.com/trends.json?callback=?';
//	var url = 'http://api.twitter.com/version/trends/current.format';
	$.getJSON (
				url, 
				function(response) {
					var code = '<ul class="trend-list">';
					
					if(response.trends.length == 0) {
						alert("Sorry !! Some error occurred. Try again.");
						return;
					}
					
					for(var i in response.trends) {
						var trend = response.trends[i];
						code += '<li>'+
								'	<a onmouseover="return (window.status=\'\');" href="javascript:searchTweets('+userId+', 1, \''+trend.name+'\', \'trend_result\');">'+trend.name+'</a>' +
								'</li>';
					}
					code += '</ul>';
					$("#trend_list_"+userId).html(code);
					showTweetBox(userId, 'trends');
				}
			 );
	
	$.post(	"/s/log", 
			{
				"userId"	: userId,
				"multUser"	: g_selected_username,
				"actionId"	: TRENDS_ACTION_ID 
			}
		  );
}



function getFriends(userId, cursor, type) {
	
	var followers = false;
	
	if(type == 'followers') {
		followers = true;
	}

	$.post("/s/getFriends", 
			{
				"user"			: userId,
				"gid"  			: login_state.gid,
				"session" 		: login_state.session,
				"cursor"		: cursor,
				"username"		: g_selected_username,
				"followers"		: followers
			}, 
			function(response) {
				if(response.success) {
					var i;
					var code = '';

					for(i in response.result) {
						var tweet = response.result[i];
						code += buildFriends(tweet, userId, type);
					}
					$("#"+type+"_"+userId).html(code);
					showTweetBox(userId, type);
				}
				else {
					alert('Sorry !! Some error occured. '+response.msg);
				}
			}, 
		"json"
	);
}


function buildFriends(tweet, userId, type) {
	
	var class_str = 'tweetbox_1';
	
	var button = '';
	
	if(tweet.friend) {
		button = '<button class="jui-button" onclick="unfollowUser(\''+tweet.name+'\', '+tweet.id+', \''+type+'\');" title="Unfollow '+tweet.name+'">Unfollow</button>';
	}
	else {
		button = '<button class="jui-button" onclick="followUser(\''+tweet.name+'\', '+tweet.id+', \''+type+'\');" title="Follow '+tweet.name+'">Follow</button>';
	}
	
	var code =  '<div class="'+class_str+'" id="'+type+'_' + userId  + '_' + tweet.id +'">' +
				'	<table class="tweet-table">'+
				'		<tr id="'+type+'_tweet_row_'+ userId + tweet.id +'">'+ //home_tweet_row_3518597891527		
				'			<td colspan="1">'+			
				'				<span class="userimg">'+
				'					<a href="#">'+
				'						<img alt="image" src="'+tweet.img+'" class="tweetimg" />'+
				'					</a>'+
				'				</span>'+		
				'			</td>'+		
				'			<td colspan="1" style="padding-right: 5px;">'+			
				'				<span class="tweetuser">'+
				'					<a href="http://twitter.com/'+tweet.name+'" target="_blank" id="'+type+'_user_'+ userId + tweet.id +'">'+tweet.name+'</a>'+ //"f_3518597891527"
				'				</span>'+			
				'				<span class="tweetmsg" id="'+type+'_tweet_text_'+ userId + tweet.id +'">'+ //"home_tweet_3518597891527"
									encodeTweet(tweet.text, tweet.id)+ 
				'				</span>'+		
				'			</td>'+		
				'		</tr>'+
				'		<tr>'+
				'			<td colspan="3">'+
				'				<div style="padding: 5px 0px 0px 0px;">'+
				'					<span style="border:0px none;" class="user-stat-span">'+
				'						<span class="user-stat-num">'+tweet.following+'</span><br/>'+
				'						<span class="user-stat-text">Following</span>'+
				'					</span>'+
				'					<span class="user-stat-span">'+
				'						<span class="user-stat-num">'+tweet.followers+'</span><br/>'+
				'						<span class="user-stat-text">Followers</span>'+
				'					</span>'+
				'					<span class="user-stat-span">'+
				'						<span class="user-stat-num">'+tweet.updates+'</span><br/>'+
				'						<span class="user-stat-text">Tweets</span>'+
				'					</span><br/>'+
				'				</div>'+
				'			</td>'+
				'		</tr>'+
				'		<tr>'+
				'			<td style="padding: 2px 0 0 3px">'+
			 	'				<span>'+
			 	'					<img style="display:none;" id="'+type+'_usr_load_img_'+ tweet.id + userId +'" src="../images/indicator_arrows.gif" alt="Loading"/>'+
			 	'				</span>'+
				'			</td>'+
				'			<td colspan="2" style="text-align:right; padding: 3px 5px 0px 0px;">'+
				'				<span class="follow-user" id="'+type+'_follow_user_'+ tweet.id + userId +'">'+
									button +
				'				</span>'+
				'			</td>'+
				'		</tr>'+
				'	</table>'+
				'</div>';
	return code;
}

function followUser(username, tweetId, type) {
	
	$("#"+type+"_usr_load_img_"+ tweetId + g_selected_user_id).fadeIn('slow');
	$.post("/s/followUser", 
			{
				"username"	: username,
				"user"		: g_selected_user_id,
				"multUser"	: g_selected_username,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session
			}, 
			function(response) {
				if(response.success) {
					code = '<button class="jui-button" onclick="unfollowUser(\''+username+'\', '+tweetId+', \''+type+'\');" title="Unfollow '+username+'">Unfollow</button>'; 
					$("#"+type+"_follow_user_"+ tweetId + g_selected_user_id).html(code);
				}
				else {
					alert('Some problem occured. '+response.msg); 
				}
				$("#"+type+"_usr_load_img_"+ tweetId + g_selected_user_id).fadeOut('slow');
			}, 
		"json"
	);
}


function unfollowUser(username, tweetId, type) {
	
	$("#"+type+"_usr_load_img_"+ tweetId + g_selected_user_id).fadeIn('slow');
	
	$.post("/s/unfollowUser", 
			{
				"username"	: username,
				"user"		: g_selected_user_id,
				"multUser"	: g_selected_username, 
				"gid"  		: login_state.gid,
				"session" 	: login_state.session
			}, 
			function(response) {
				if(response.success) {
					code = '<button class="jui-button" onclick="followUser(\''+username+'\', '+tweetId+', \''+type+'\');" title="Follow '+username+'">Follow</button>'; 
					$("#"+type+"_follow_user_"+ tweetId + g_selected_user_id).html(code);
				}
				else {
					alert('Some problem occured. '+response.msg); 
				}
				$("#"+type+"_usr_load_img_"+ tweetId + g_selected_user_id).fadeOut('slow');
			}, 
		"json"
	);
}

function openSettings() {
	
	if(g_selected_user_id == 0) {
		return;
	}
	
	g_remove_user = new Array();
	
	var index;

	var users = login_state.users;

	var user_table = '<table class="settings-table" class="ui-corner-all">';

	for (index in users) {
		var user = users[index];

		user_table += '<tr id="user_row_'+user.id+'">' +
					  '	<td style="border:1px solid #CCC;">' +
					  		user.name +
					  '	</td>' +
					  '	<td style="border:1px solid #CCC;">' +
					  '		<a href="javascript:removeUser('+user.id+');" title="Sign out '+user.name+'">'+
					  '			Signout'+
					  '		</a>' +
					  '	</td>' +
					  '</tr>';	  
	}
	
	user_table += '</table>';
	
	$("#user_list").html(user_table);
	
	var interval = login_state.interval;
	
	$("#update_interval option").each(
			function() {
				if($(this).val() == interval) {
					$(this).attr('selected', 'selected');
				}
			}
	);

	$(".tweet-container").hide();
	$("#settings_section").show();
}

function closeSettings() {
	$("#settings_section").hide();
	$("#user_"+g_selected_user_id).show();
}

function removeUser(userId) {
	g_remove_user[g_remove_user.length] = userId;
	$("#user_row_"+userId).fadeOut (
										'slow', 
										function(){
											$(this).remove();
										}
									);
}

function setSettings() {
	var id;
	var users = '[';
	for(id in g_remove_user) {
		if(id > 0) {
			users += ',';
		}
		users += g_remove_user[id];
	}
	users += ']';
	
	var interval = $("#update_interval option:selected").val();

	$.post("/s/setSettings", 
				{
					"users" 	: users,
					"interval"	: interval,
					"multUser"	: g_selected_username,
					"userId"	: g_selected_user_id
				}, 
				function(response) {
					if(response.success) {
						
						UPDATE_INTERVAL = parseInt(interval) * 60 * 1000;
						
						if(response.redirect) {
							alert(response.redirect);
							document.location = '/index.html';
							return;
						}
						
						//Remove the tabs... for which user are deleted
						for(id in g_remove_user) {
							var userId = g_remove_user[id];
							//Remove the main div containing all the content
							$("#user_"+userId).remove();
							$("#tab_"+userId).remove();
						}
						
						//Select the first tab after deleting the user
						var i = 0;
						
						$("#tabs td").each (
							function() {
								if(i == 0) {
									var id = $(this).attr('id');
									var user = parseInt(id.substring(4, id.length));
									selectTab(user);
								}
								i++;
							}
						);
					}
					else {
						alert('Sorry !! Some error occurred. '+ response.msg);
					}
				}, 
		"json"
	);
}


function refresh(userId) {
	stopAutoUpdates();
	var user = {"id": userId, "name": g_selected_username };
	updateHome(user);
	updateMentions(user);
	updateDirects(user);
}

function gotoUrl(tweetId, url) {
	var user = g_selected_user_id;
	var newWindow = window.open(REDIRECT_URL + '?'+ 'uid=' + user + '&' + 'username=' + g_selected_username + '&' + 'id=' + tweetId + '&' + 'url=' + url, '_blank');
	newWindow.focus();
}

