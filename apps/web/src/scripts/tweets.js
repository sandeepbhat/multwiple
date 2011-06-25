var TELL_FRIEND_MSG = 'I use http://multwiple.com - Best twitter client around. Check it out! Follow @multwiple for updates.';
var REDIRECT_URL = '/s/goto';
var UPDATE_INTERVAL = 1 * 60 * 1000;
var NEW_COUNT_INTERVAL = 1 * 60 * 1000;
var TRENDS_ACTION_ID = 20;
var SEARCH_ACTION_ID = 21;
var URL_SHORTENER_ACTION_ID = 22;
var g_refresh_timer = {"search": 0, "trends": 0};   
var g_friend_timer;
var g_mention_timer;
var g_direct_timer;
var g_stat_timer;

var g_remove_user = new Array();

var g_update_count_timers = new Array(); 

var TWEETS_PER_PAGE = 20; 

var RETWEETED = 1;
var DIRECT_MSG = 2;
var GENERAL_TWEET = 3;

var ERROR	= 1;
var SUCCESS	= 2;
var NOTICE	= 3;

function showNotification (title, text, type) {
	switch (type) {
		case ERROR:
			ui_icon = 'ui-icon ui-icon-alert';
			notice_type = 'error';
			break;
		case SUCCESS:
			ui_icon = 'ui-icon ui-icon-circle-check';
			notice_type = 'notice';
			break;
		case NOTICE: 
			ui_icon = 'ui-icon ui-icon-info';
			notice_type = 'notice';
			break;
	}
	
	$.pnotify (
		{
			pnotify_title		: title,
			pnotify_text 		: text,
			pnotify_type		: notice_type,
			pnotify_notice_icon : ui_icon
		}
	 );
}

function getUserObj(currentUserId){
	for (i in login_state.users) {
		var userId = login_state.users[i].id;
		if(currentUserId == userId){
			return login_state.users[i];
		}
	}
	return {"img":"","name":"","id":""};
}

function buildDirectMessage(tweet, userId, old) {
	var class_str = 'tweetbox_1';
	
	if(old) {
		class_str = 'tweetbox_0';
	}
	
	var reply_icons = 	'<span class="action-icons" id="d_reply_'+userId+'_'+tweet.id+'">' +
						' 	<ul>' +
						'			<li class="reply"><span onclick="javascript:publicReply(\'d\', '+ userId +', \'' + tweet.id +'\');" class="ui-icon ui-icon-arrowreturnthick-1-w" title="Reply"></span></li><br/>'+ //<img src="../images/arrow_left.png"/>
						'			<li class="direct"><span onclick="javascript:directMessage(\'d\', '+ userId +', \'' + tweet.id +'\');" class="ui-icon ui-icon-mail-closed" title="Direct Message"></span></li><br/>'+ //<img src="../images/email.png"/>
						'		</ul>'+
						'</span>';
	
	var user = {"name": tweet.user, "img": tweet.img};
	
	var from_or_to = "From: ";
	var imgUrl = tweet.img;
	var userName = tweet.user;
	if(tweet.to){
		from_or_to = "To: ";
		var obj = getUserObj(userId);
		imgUrl = obj.img;
		userName = obj.name;
		user = {"name": userName, "img": imgUrl};
	}
	var code =  '<div class="'+class_str+' directs_tweet_box" id="d_box_' + userId  + '_' + tweet.id + '" onmouseover="showReplyMenu(\'d_reply_'+userId+'_'+tweet.id+'\');" onmouseout="hideReplyMenu(\'d_reply_'+userId+'_'+tweet.id+'\');">' +
				'	<table class="tweet-table">'+
				'		<tr class="user-info-row">'+
				'			<td>'+
								getUserInfoUI(tweet.id, userId, user, 'd') +
				'			</td>'+
				'		</tr>'+
				'		<tr>'+
				'			<td colspan="1">'+
//				'				<span class="userimg"><a target="_blank" href="http://twitter.com/'+tweet.user+'"><img class="tweetimg" src="' + tweet.img + '" alt="image" /></a></span>'+
				'				<span class="userimg"><a href="javascript:showUserInfo(\'' + tweet.id + '\', '+userId+', \'d\');"><img class="tweetimg" src="' + imgUrl + '" alt="image" /></a></span>' +
				'			</td>'+
				'			<td style="padding-right: 5px;" colspan="1">'+
				'				<span style="display:none;" id="d' + userId  + tweet.id + '">'+ userName +'</span>' + from_or_to + 		
				'				<span class="tweetuser"><a target="_blank" href="http://twitter.com/'+tweet.user+'">' + tweet.user + '</a></span>' +
				'				<span id="dtweet' + userId + tweet.id + '" class="tweetmsg">' + encodeTweet(tweet.text, tweet.id) +  '</span><br/>' +
				'			</td>'+
				'			<td style="width:20px; height:45px; padding:2px;" colspan="1">'+
								reply_icons+
				'			</td>'+
				'		<tr>'+
				'			<td colspan="3">'+
				'				<span class="tweettime">' + tweet.date +'</span>'+
				'			</td>'+
				'		</tr>'+
				'	</table>'+
				'</div>';
	return code;
}


function showUserInfo(tweetId, userId, type) {
	
	$("#"+type+"_followers_"+ tweetId + userId).text('');
	$("#"+type+"_following_"+ tweetId + userId).text('');
	$("#"+type+"_status_"+ tweetId + userId).text('');
	$("#"+type+"_user_stat_"+ tweetId + userId).hide();
	$("#"+type+"_error_"+ tweetId + userId).hide();
	$("#"+type+"_user_info_"+tweetId+userId).fadeIn('slow');
	$("#"+type+"_usr_load_img_"+tweetId+userId).fadeIn('slow');
	$("#"+type+"_follow_user_"+tweetId+userId).html('');
	
	var username = $("#" + type + userId  + tweetId).text();
	
	$.post("/s/getUserInfo", 
			{
				"username"		: username,
				"multUserId" 	: userId,
				"multUsername"	: g_selected_user_name,
				"gid"  			: login_state.gid,
				"session" 		: login_state.session
			}, 
			function(response){
				if(response.success) {
					var code = '';
					
					if(username != g_selected_user_name) {
						if(response.user.friend) {
							code = '<button class="jui-dark-button" onclick="unfollowUser(\''+username+'\', '+tweetId+', \''+type+'\');" title="Unfollow '+username+'">Unfollow</button>'; 
						}
						else {
							code = '<button class="jui-dark-button" onclick="followUser(\''+username+'\', '+tweetId+', \''+type+'\');" title="Follow '+username+'">Follow</button>'; 
						}
					}
					$("#"+type+"_follow_user_"+tweetId+userId).html(code);
					$("#"+type+"_followers_"+ tweetId + userId).text(response.user.followers);
					$("#"+type+"_following_"+ tweetId + userId).text(response.user.following);
					$("#"+type+"_status_"+ tweetId + userId).text(response.user.status);
					$("#"+type+"_updates_count_"+ tweetId + userId).text(response.user.updates);
					$("#"+type+"_user_stat_"+ tweetId + userId).fadeIn('slow');
				}
				else {
					$("#"+type+"_error_"+ tweetId + userId).text(response.msg);
					$("#"+type+"_error_"+ tweetId + userId).fadeIn('slow');
					showNotification ('User Information', response.msg, ERROR);
				}
				$("#"+type+"_usr_load_img_"+ tweetId + userId).fadeOut('slow');
			}, 
		"json"
	);
	$("#"+type+"_user_info_"+tweetId+userId).fadeIn('slow');
}


function hideUserInfo(tweetId, userId, type) {
	$("#"+type+"_user_info_"+tweetId+userId).fadeOut('slow');
}

function buildUpdateMessage(tweet, userId, old) {
	
	var class_str = 'tweetbox_1';
	
	if(old) {
		class_str = 'tweetbox_0';
	}
	
	var reply_icons = '<span class="action-icons" id="f_reply_'+userId+'_'+tweet.id+'">' + 
					  '		<ul>'+
					  '			<li class="reply"><span onclick="javascript:publicReply(\'f\', '+ userId +', \'' + tweet.id +'\');" class="ui-icon ui-icon-arrowreturnthick-1-w" title="Reply"></span></li><br/>'+ //<img src="../images/arrow_left.png"/>
					  '			<li class="retweet"><span onclick="javascript:reTweet(\'f\', '+ userId +', \'' + tweet.id +'\');" class="ui-icon ui-icon-refresh" title="Retweet with Comment" ></span></li><br/>'+ //<img src="../images/arrow_rotate_clockwise.png"/>
					  '			<li class="direct"><span onclick="javascript:directMessage(\'f\', '+ userId +', \'' + tweet.id +'\');" class="ui-icon ui-icon-mail-closed" title="Direct Message"></span></li><br/>'+ //<img src="../images/email.png"/>
					  '		</ul>' +
					  '</span>';

	
	
	var RT_icon = 	'<span title="Retweet" class="ui-icon ui-icon-refresh" style="cursor:pointer;" id="RT_icon'+tweet.id+'" onclick="reTweetWithoutComment(\'' + tweet.id + '\', \'f\');"></span>'+
					'<img src="../images/indicator_arrows_circle.gif" class="smaller-icon" style="display:none;" id="retweeting_img'+tweet.id+'"/>';
	
	var is_retweet_icon = '';
	var retweet_column =  '';
	var RT_id = tweet.id;
	
	if(tweet.RT.length > 0) {
		
		is_retweet_icon = '<span style="border:1px solid #ddd; margin-top:1px;" class="ui-icon ui-corner-all ui-icon-refresh"></span>';
		
		//Hide RT Icon
		if(tweet.RT == g_selected_user_name) {
			RT_icon = '';
		}
		
		retweet_column =  '<span class="RT">Retweeted by <a target="_blank" href="http://twitter.com/'+tweet.RT+'">@' + tweet.RT + '</a></span>'+
						  '<input type="hidden" id="orig_tweet_id_'+ tweet.id + userId +'" value="'+tweet.RID+'"/>';
		RT_id = tweet.RID;
	}

	var favorite = '';
	if(tweet.favorite) {
		favorite = 	'<a id="fav_link_'+ tweet.id + userId +'" title="Unmark As Favorite" href="javascript:markFavorite('+ userId +',' + tweet.id +',false)">'+
					'	<img id="fav_icon_'+ tweet.id + userId +'" src="../images/star-32.png" class="small-icon"/>'+
					'</a>';
	}
	else {
		favorite = 	'<a id="fav_link_'+ tweet.id + userId +'" title="Mark As Favorite" href="javascript:markFavorite('+ userId +',' + tweet.id +',true)">'+
					'	<img id="fav_icon_'+ tweet.id + userId +'" src="../images/star-none-32.png" class="small-icon"/>'+
					'</a>';
	}

	var user = {"name": tweet.user, "img": tweet.img};
	
	var code =  '<div class="'+class_str+' updates_tweet_box" id="f_' + userId + '_'+ tweet.id + '" onmouseover="showReplyMenu(\'f_reply_'+userId+'_'+tweet.id+'\');" onmouseout="hideReplyMenu(\'f_reply_'+userId+'_'+tweet.id+'\');">' +
				' <table class="tweet-table">'+
				'	<tr class="user-info-row">'+
				'		<td>'+
							getUserInfoUI(tweet.id, userId, user, 'f') +
				'		</td>'+
				'	</tr>'+
				' 	<tr>'+
				'		<td colspan="1">'+
//				'  			<span class="userimg"><a target="_blank" href="http://twitter.com/'+tweet.user+'"><img class="tweetimg" src="' + tweet.img + '" alt="image" /></a></span>' +
				'			<span class="userimg"><a href="javascript:showUserInfo(\'' + tweet.id + '\', '+userId+', \'f\');"><img class="tweetimg" src="' + tweet.img + '" alt="image" /></a></span>' +
				'		</td>'+
				'		<td style="padding-right: 5px;" colspan="1">'+
				'			<span class="tweetuser">'+is_retweet_icon+'<a id="f' + userId  + tweet.id + '" target="_blank" href="http://twitter.com/'+tweet.user+'">' + tweet.user + '</a></span>'+
				'			<span id="ftweet' + userId + tweet.id + '" class="tweetmsg">' + encodeTweet(tweet.text, tweet.id) + '</span>'+
				'		</td>'+
				'		<td style="width:20px; height:55px; padding:2px;" colspan="1">'+
							reply_icons+
				'		</td>'+
				'	</tr>'+
				'	<tr>'+
				'		<td id="RT_column'+tweet.id+'" colspan="3" style="padding: 5px 0px 0px;">'+
							retweet_column+
				'		</td>'+
				'	</tr>'+
				'	<tr>'+
				'		<td colspan="2">'+
				'			'+favorite+'<span class="tweettime">' + tweet.date + ' via ' + tweet.src +'</span>'+
				'		</td>'+
				'		<td>'+
							RT_icon +
				'		</td>'+
				'	</tr>'+
				' </table>'+
				'</div>';
	return code;
}



function buildMentionMessage(tweet, userId, old) {
	var class_str = 'tweetbox_1';
	
	if(old) {
		class_str = 'tweetbox_0';
	}
	
	var reply_icons = 	'<span class="action-icons" id="m_reply_'+userId+'_'+tweet.id+'">' + 
						'	<ul>'+
						'		<li class="reply"><span onclick="javascript:publicReply(\'m\', '+ userId +', \'' + tweet.id + '\');" class="ui-icon ui-icon-arrowreturnthick-1-w" title="Reply"></span></li><br/>'+ //<img src="../images/arrow_left.png"/>
						'		<li class="retweet"><span onclick="javascript:reTweet(\'m\', '+ userId +', \'' + tweet.id +'\');" class="ui-icon ui-icon-refresh" title="Retweet with Comment" ></span></li><br/>'+ //<img src="../images/arrow_rotate_clockwise.png"/>
						'		<li class="direct"><span onclick="javascript:directMessage(\'m\', '+ userId+', \'' + tweet.id +'\');" class="ui-icon ui-icon-mail-closed" title="Direct Message"></span></li><br/>'+ //<img src="../images/email.png"/>
						'	</ul>' +
						'</span>';

	var favorite = 	'<a id="fav_link_'+ tweet.id + userId +'" title="Mark As Favorite" href="javascript:markFavorite('+ userId +',' + tweet.id +',true)">'+
					'	<img id="fav_icon_'+ tweet.id + userId +'" src="../images/star-none-32.png" class="small-icon"/>'+
					'</a>';

	if(tweet.favorite) {
		favorite = 	'<a id="fav_link_'+ tweet.id + userId +'" title="Unmark As Favorite" href="javascript:markFavorite('+ userId +',' + tweet.id +',false)">'+
					'	<img id="fav_icon_'+ tweet.id + userId +'" src="../images/star-32.png" class="small-icon"/>'+
					'</a>';
	}

	var user = {"name": tweet.user, "img": tweet.img};
	var code =  '<div class="'+class_str+' mentions_tweet_box" id="m_' + userId  + '_' + tweet.id +'" onmouseover="showReplyMenu(\'m_reply_'+userId+'_'+tweet.id+'\');" onmouseout="hideReplyMenu(\'m_reply_'+userId+'_'+tweet.id+'\');">' +
				'	<table class="tweet-table">'+
				'		<tr class="user-info-row">'+
				'			<td>'+
								getUserInfoUI(tweet.id, userId, user, 'm') +
				'			</td>'+
				'		</tr>'+
				'		<tr>'+
				'			<td colspan="1">'+
//				'				<span class="userimg"><a target="_blank" href="http://twitter.com/'+tweet.user+'"><img class="tweetimg" src="' + tweet.img + '" alt="image" /></a></span>'+
				'				<span class="userimg"><a href="javascript:showUserInfo(\'' + tweet.id + '\', '+userId+', \'m\');"><img class="tweetimg" src="' + tweet.img + '" alt="image" /></a></span>' +
				'			</td>'+
				'			<td style="padding-right: 5px;" colspan="1">'+
				'				<span class="tweetuser"><a id="m' + userId  + tweet.id + '" target="_blank" href="http://twitter.com/'+tweet.user+'">' + tweet.user + '</a></span>' +
				'				<span id="mtweet' + userId + tweet.id + '" class="tweetmsg">' + encodeTweet(tweet.text, tweet.id) +  '</span><br/>' +
				'			</td>'+
				'			<td style="width:20px; height:55px; padding:2px;" colspan="1">'+
								reply_icons+
				'			</td>'+
				'		</tr>'+
				'		<tr>'+
				'			<td id="RT_column'+tweet.id+'" colspan="3" style="padding: 5px 0px 0px;"></td>'+
				'		</tr>'+
				'		<tr>'+
				'			<td colspan="2">'+
				'				'+ favorite +'<span class="tweettime">' + tweet.date + ' via ' + tweet.src + '</span>'+
				'			</td>'+
				'			<td>'+
				'				<span title="Retweet" class="ui-icon ui-icon-refresh" style="cursor:pointer;" id="RT_icon'+tweet.id+'" onclick="reTweetWithoutComment(\'' + tweet.id + '\', \'m\');"></span>'+
				'				<img src="../images/indicator_arrows_circle.gif" class="smaller-icon" style="display:none;" id="retweeting_img'+tweet.id+'"/>'+
				'			</td>'+
				'		</tr>'+
				'	</table>'+
				'</div>';
	return code;
}



function buildUpdatePagination(userId, page) {
	var code = '<div class="paginate friend-paginate-'+userId+'">'+
			'	<table>'+
			'	<tr>'+
			'	<td style="width:90px;">'+
			'	<span style="float:left;"> '+
			'		<a id="new_friend_link_'+userId+'" style="display:none;" href="">'+ 
			'			&laquo; newer'+
			'		</a>'+
			'		<img src="../images/indicator_arrows.gif" style="display:none;" id="new_friend_load_'+userId+'" alt=""/>'+
			'	</span>'+
			'	</td>'+
			'	<td style="text-align:center;font-weight:bold;">'+
			'	<span id="friend_page_no_'+userId+'">1</span>'+
			'	</td>'+
			'	<td style="width:90px;">'+
			'	<span style="float:right;"> '+
			'		<img src="../images/indicator_arrows.gif" style="display:none;" id="old_friend_load_'+userId+'" alt=""/>'+
			'		<a id="old_friend_link_'+userId+'" href="javascript:getOlderFriendUpdates('+(page + 1)+', \'o\', '+userId+');">'+
			'			older &raquo;'+
			'		</a>'+
			'	</span>'+
			'	</td>'+
			'	</tr>'+
			'	</table>'+
			'</div>';
	return code;
}


function buildDirectPagination(userId, page) {
	var code = 	'<div class="paginate direct-paginate-'+userId+'">'+
				'	<table>'+
				'	<tr>'+
				'	<td style="width:90px;">'+
				'	<span style="float:left;"> '+
				'		<a id="new_direct_link_'+userId+'" style="display:none;" href=""> &laquo; newer</a>'+
				'		<img src="../images/indicator_arrows.gif" style="display:none;" id="new_direct_load_'+userId+'" alt=""/>'+
				'	</span>'+
				'	</td>'+
				'	<td style="text-align:center;font-weight:bold;">'+
				'	<span id="direct_page_no_'+userId+'">1</span>'+
				'	</td>'+
				'	<td style="width:90px;">'+
				'	<span style="float:right;"> '+
				'		<img src="../images/indicator_arrows.gif" style="display:none;" id="old_direct_load_'+userId+'" alt=""/>'+
				'		<a id="old_direct_link_'+userId+'" href="javascript:getOlderDirectUpdates('+(page + 1)+', \'o\', '+userId+');">older &raquo;</a>'+
				'	</span>'+
				'	</td>'+
				'	</tr>'+
				'	</table>'+
				'</div>';
	return code;
}

function buildMentionPagination(userId, page) {
	var	code =  '<div class="paginate mention-paginate-'+userId+'">'+
				'	<table>'+
				'	<tr>'+
				'	<td style="width:90px;">'+
				'	<span style="float:left;"> '+
				'		<a id="new_mention_link_'+userId+'" style="display:none;" href=""> &laquo; newer</a>'+
				'		<img src="../images/indicator_arrows.gif" style="display:none;" id="new_mention_load_'+userId+'" alt=""/>'+
				'	</span>'+
				'	</td>'+
				'	<td style="text-align:center;font-weight:bold;">'+
				'	<span id="mention_page_no_'+userId+'">1</span>'+
				'	</td>'+
				'	<td style="width:90px;">'+
				'	<span style="float:right;"> '+
				'		<img src="../images/indicator_arrows.gif" style="display:none;" id="old_mention_load_'+userId+'" alt=""/>'+
				'		<a id="old_mention_link_'+userId+'" href="javascript:getOlderMentions('+(page + 1)+', \'o\', '+userId+');">older &raquo;</a>'+
				'	</span>'+
				'	</td>'+
				'	</tr>'+
				'	</table>'+
				'</div>';
	return code;
}

function changeCloseIcon(type,userId) {
	var icon_class = $("#"+type+"_close_icon_"+userId).attr('class');
	
	if(icon_class.indexOf('ui-icon-close') >= 0) {
		$("#"+type+"_close_icon_"+userId).removeClass('ui-icon-close');
		$("#"+type+"_close_icon_"+userId).addClass('ui-icon-circle-close');
	}
	else {
		$("#"+type+"_close_icon_"+userId).removeClass('ui-icon-circle-close');
		$("#"+type+"_close_icon_"+userId).addClass('ui-icon-close');
	}
}



function hideCloseIcon(type,userId) {
	$("#"+type+"_close_icon_"+userId).hide();
}

function buildTweets(tweets, type, userId) {
	
	var tweet_id_str = $( "#" + type + userId + "_latest" ).val();
	
	var latest_tweet_id = 0;
	
	if(tweet_id_str != '') {
	  	latest_tweet_id = tweet_id_str;
	}

	var code = '';
	
  	var count = 0;
  	
	for (tweet_index in tweets) {
		
		var tweet = tweets[tweet_index];
		
		var current_tweet_id = tweet.id;
		if(current_tweet_id.length >= latest_tweet_id.length && current_tweet_id > latest_tweet_id) {
			$( "#" + type + userId + "_latest" ).val(current_tweet_id);
			latest_tweet_id = current_tweet_id;
		}
		else if(latest_tweet_id.length == 1 && latest_tweet_id == "0") {
			$( "#" + type + userId + "_latest" ).val(current_tweet_id);
			latest_tweet_id = current_tweet_id;
		}
		
		if(type == 'friend') {
			code += buildUpdateMessage(tweet, userId, tweet.old);
		}
		else if(type == 'direct') {
			code += buildDirectMessage(tweet, userId, tweet.old);
		}
		else if(type == 'mention') {
			code += buildMentionMessage(tweet, userId, tweet.old);
		}
		
		count ++;
	}
	
	return ({"code": code, "count": count});	
}

function updateFriendTweets(user) {
	
	var loading_code = 	 '<div class="tweettitle ui-widget-header ui-corner-all">'+
							'<span class="ui-icon ui-icon-home"></span>'+
							'<span class="tweet-header">Home &nbsp; <img src="../images/indicator_arrows.gif" alt="Loading"/></span>'+
						'</div>';
	
	$("#friend" + user.id).html(loading_code);

	var code = 	'<div class="tweettitle ui-widget-header ui-corner-all">'+
				'	<span class="ui-icon ui-icon-home"></span>'+
				'		<span class="tweet-header" id="friend_header_'+user.id+'">Home (<span id="no_of_friend'+user.id+'">0</span>)</span>'+
				'		<span class="close-icon">'+
				'			<a href="javascript:hideTweetBox(\'friend\', '+user.id+');">'+
				'				<span  id="friend_close_icon_'+user.id+'" '+
				'							class="ui-icon ui-icon-close" '+
				'								unselectable="on" '+
				'									onmouseover="changeCloseIcon(\'friend\','+user.id+');" '+
				'										onmouseout="changeCloseIcon(\'friend\','+user.id+');">'+
				'				</span>'+
				'			</a>'+										
				'		</span>'+
				'</div>';
	
	//To hold all the tweets.. this is the only which scrolls
	code += '<div class="scrollable" id="friend_container_'+user.id+'">';
	
	var count = 0;
	
	$.post("/s/getUpdates",
			  { 
				"user" : user.id,
				"gid"  : login_state.gid,
				"session" : login_state.session
			  },
				function(response) { 
					if(response.success) {
						
						//Close the scrollable div
						code += '</div>';
						
						$("#friend" + user.id).html(code);
						
						var build = buildTweets(response.result, 'friend', user.id);
						
						code = build.code;
						
						count = build.count;

						$("#friend_container_" + user.id).html(code);
						
						code = buildUpdatePagination(user.id, response.page);
						
						$("#friend" + user.id).append(code);
						
						$('#friend_page_no_'+user.id).text(response.page);

						$("#friend"+user.id+"_count").val(count);

						updateNewTweetCount('friend', user.id, response.count);
					}
					else {
						// Close the scrollable div
						code += '</div>';
						code += buildUpdatePagination(user.id, 1);
						$("#friend" + user.id).html(code);
						showNotification ('Updates', response.msg, ERROR);
					}
					
//					$("#friend_container_"+user.id).scroll(
//							function() {
//								$(".user-info").hide();
//								 if ($(this)[0].scrollHeight - $(this).scrollTop() == $(this).outerHeight()) {
//									 // If we're at the bottom, show the overlay and retrieve the next page
//								     getOlderFriendUpdates((response.page + 1), 'o', user.id);
//								 }
//							}
//					);
					
					if(count < TWEETS_PER_PAGE) {
						$("#old_friend_link_"+user.id).hide();
					}
				},
			"json"
		);
}

function updateDirects(user){

	var loading_code = 	 '<div class="tweettitle ui-widget-header ui-corner-all">'+
							'<span class="ui-icon ui-icon-mail-closed"></span>'+
							'<span class="tweet-header">Direct Messages &nbsp;<img src="../images/indicator_arrows.gif" alt="Loading"/></span>'+
						'</div>';
	
	$("#direct" + user.id).html(loading_code);
	
	var code =  '<div class="tweettitle ui-widget-header ui-corner-all">'+
				'	<span class="ui-icon ui-icon-mail-closed"></span>'+
				'		<span class="tweet-header" id="direct_header_'+user.id+'">Direct Messages (<span id="no_of_direct'+user.id+'">0</span>)</span>'+
				'		<span class="close-icon">'+
				'		<a href="javascript:hideTweetBox(\'direct\', '+user.id+');">'+
				'			<span id="direct_close_icon_'+user.id+'"'+
				'						class="ui-icon ui-icon-close" '+
				'								onmouseover="changeCloseIcon(\'direct\','+user.id+');" '+
				'										onmouseout="changeCloseIcon(\'direct\','+user.id+');" unselectable="on">'+
				'			</span>'+
				'		</a>'+											
				'	</span>'+
				'</div>';

	//To hold all the tweets.. this is the only which scrolls
	code += '<div class="scrollable" id="direct_container_'+user.id+'">';

	var count = 0;
	
	$.post("/s/getDirects",
			  { 
				"user" : user.id,
				"gid"  : login_state.gid,
				"session" : login_state.session
			  },
				function(response) { 
					if(response.success) { 

						//Close the scrollable div
						code += '</div>';
						
						$("#direct" + user.id).html(code);
						
						var build = buildTweets(response.result, 'direct', user.id);
						
						code = build.code;
						
						count = build.count;
						
						$("#direct_container_"+user.id).html(code);
						
						code = buildDirectPagination(user.id, response.page);
						
						$("#direct" + user.id).append(code);

						$('#direct_page_no_'+user.id).text(response.page);

						$("#direct"+user.id+"_count").val(count);
						
						updateNewTweetCount('direct', user.id, response.count);
						
					}
					else {
						code += '</div>'; 
						code += buildDirectPagination(user.id, 1);
						$("#direct" + user.id).html(code);
						showNotification ('Direct Messages', response.msg, ERROR);
					}
					
					if(count < TWEETS_PER_PAGE) {
						$("#old_direct_link_"+user.id).hide();
					}
				},
			"json"
		);
}

function updateMentions(user){
	var loading_code = 	 '<div class="tweettitle ui-widget-header ui-corner-all">'+
							'<span class="ui-icon ui-icon-person"></span>'+
							'<span class="tweet-header">Mentions &nbsp;<img src="../images/indicator_arrows.gif" alt="Loading"/></span>'+
						'</div>';
	
	$("#mention" + user.id).html(loading_code);
	
	var code =  '<div class="tweettitle ui-widget-header ui-corner-all">'+ 
				'	<span class="ui-icon ui-icon-person"></span>'+
				'		<span class="tweet-header" id="mention_header_'+user.id+'">Mentions (<span id="no_of_mention'+user.id+'">0</span>)</span>'+
				'		<span class="close-icon">'+
				'		<a href="javascript:hideTweetBox(\'mention\', '+user.id+');">'+
				'			<span id="mention_close_icon_'+user.id+'" '+
				'						class="ui-icon ui-icon-close"  '+
				'							onmouseover="changeCloseIcon(\'mention\','+user.id+');" '+
				'								onmouseout="changeCloseIcon(\'mention\','+user.id+');" '+
				'									unselectable="on">'+
				'			</span>'+
				'		</a>'+											
				'	</span>'+
				'</div>';
	
	//To hold all the tweets.. this is the only which scrolls
	code += '<div class="scrollable" id="mention_container_'+user.id+'">';
	
	var count = 0;

	$.post("/s/getMentions",
			  { 
				"user" : user.id,
				"gid"  : login_state.gid,
				"session" : login_state.session
			  },
				function(response) {
					if(response.success) { 
						
						//Close the scrollable div
						code += '</div>';
						
						$("#mention" + user.id).html(code);
						
						var build = buildTweets(response.result, 'mention', user.id);
						
						code = build.code;
						
						count = build.count;
						
						$("#mention_container_" + user.id).html(code);
						
						code = buildMentionPagination(user.id, response.page);
						
						$("#mention" + user.id).append(code);
						$('#mention_page_no_'+user.id).text(response.page);
						$("#mention"+user.id+"_count").val(count);
						updateNewTweetCount('mention', user.id, response.count);
					}
					else {
						code += '</div>';
						code += buildMentionPagination(user.id, 1);
						$("#mention" + user.id).html(code);
						showNotification ('Mentions', response.msg, ERROR);
					}
					
					if(count < TWEETS_PER_PAGE) {
						$("#old_mention_link_"+user.id).hide();
					}
				},
					"json"
			);
}

function toggleButtons(type, id){
	$("#" + type + "panel" + id).toggle();
}


function markAsRead(type, userId) {
	var container = '#'+type+'_container_'+userId;
	$(container).children().addClass('tweetbox_0',1000);
	$(container).children().removeClass('tweetbox_1');
	$("#no_of_"+type+userId).text('0');
}

/*
 * Used to update the character count in the twitter update text.
 */
function updateChars(text, userId){
	var remaining = 140 - text.length;
	if(remaining < 0){
		$("#chars_left" + userId).text(remaining).css('color','#ff0000');
		$("#updateButton" + userId).addClass('ui-state-disabled');
		$("#updateButton" + userId).attr('disabled', true);
	}
	else if(remaining == 140) {
		$("#chars_left" + userId).text(remaining).css('color','#aaa');
		$("#updateButton" + userId).addClass('ui-state-disabled');
		$("#updateButton" + userId).attr('disabled', true);
	}
	else {
		$("#chars_left" + userId).text(remaining).css('color','#aaa');
		$("#updateButton" + userId).removeClass('ui-state-disabled');
		$("#updateButton" + userId).attr('disabled', false);
	}
}

function publicReply(type, user, id){
	$("#tweet" + user).focus();
	var username = $("#"+ type + user + id).text();
	var msg = '@' + username + ' ';
	$("#tweet" + user).val(msg);
	updateChars(msg, user);
}

function reTweet(type, userId, id) {
	$("#tweet" + userId).focus();
	var username = $("#"+ type + userId + id).text();
	var decodedtweet = decodeLinks("#"+ type + "tweet" + userId + id);
	var msg = 'RT @' + username + ' ' + decodedtweet;
	$("#tweet" + userId).val(msg);
	updateChars(msg, userId);
//	$("#decoded_tweet_"+userId).text(msg);
//	var i = 0;
//	for(i in g_user_list) {
//		var user = g_user_list[i];
//		if(user.id == userId) {
//			g_user_list[i]['RID'] = $("#orig_tweet_id_"+ id + userId).val();
//		}
//	}
}

function directMessage(type, user, id){
	$("#tweet" + user).focus();
	var username = $("#"+ type + user + id).text();
	var msg = 'd ' + username + ' ';
	$("#tweet" + user).val(msg);
	updateChars(msg, user);
}

function reTweetWithoutComment(tweetId, type) {
	
	$("#RT_icon" + tweetId).hide();
	$("#retweeting_img" + tweetId).fadeIn('slow');
	$.post("/s/tweetUpdate",
			{
				"user" 		: g_selected_user_id,
				"multUser" 	: g_selected_user_name,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"tweetId"	: tweetId
			},
			function(response) { 
				if(response.success) {
					var html = $("#RT_column" + tweetId).html();
					var username = $("#"+ type + g_selected_user_id + tweetId).text();
					if(html != '') {
						html += '<br/>';
					}
					html += '<span class="RT">Retweeted by <a target="_blank" href="http://twitter.com/'+response.tweet.RT+'">'+response.tweet.RT+'</a></span>';
					$("#RT_column" + tweetId).html(html);
					$("#retweeting_img" + tweetId).hide();
				}
				else {
					$("#retweeting_img" + tweetId).hide();
					$("#RT_icon" + tweetId).fadeIn('slow');
					showNotification ('Retweet', response.msg, ERROR);
				}
			},
			"json"
		);
}

function markFavorite(user, tweetId, mark) {
	var orig_image = $("#fav_icon_"+ tweetId + user).attr('src');
	var orig_href = $("#fav_link_"+ tweetId + user).attr('href');
	
	//Show a loading image when marking favorite & disable clicking
	$("#fav_icon_"+ tweetId + user).attr('src', '../images/indicator_arrows_circle.gif');
	$("#fav_icon_"+ tweetId + user).removeClass('small-icon');
	$("#fav_icon_"+ tweetId + user).addClass('smaller-icon');
	$("#fav_link_"+ tweetId + user).attr('href', 'javascript:void(0);');
	
	$.post("/s/setFavorite",
			{
				"user" 		: user,
				"multUser"	: g_selected_user_name,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"tweetId" 	: tweetId,
				"mark"		: mark
			},
			function(response) {
				
				$("#fav_icon_"+ tweetId + user).removeClass('smaller-icon');
				$("#fav_icon_"+ tweetId + user).addClass('small-icon');
				
				if(response.success) {
					if(mark) {
						$("#fav_icon_"+ tweetId + user).attr('src', '../images/star-32.png');
						$("#fav_link_"+ tweetId + user).attr('title', 'Unmark As Favorite');
						$("#fav_link_"+ tweetId + user).attr('href', 'javascript:markFavorite('+user+', '+tweetId+',false);');
					}
					else {
						$("#fav_icon_"+ tweetId + user).attr('src', '../images/star-none-32.png');
						$("#fav_link_"+ tweetId + user).attr('title', 'Mark As Favorite');
						$("#fav_link_"+ tweetId + user).attr('href', 'javascript:markFavorite('+user+', '+tweetId+',true);');
					}
				}
				else {
					
					//Restore the original href & image as mark favorite failed
					$("#fav_icon_"+ tweetId + user).attr('src', orig_image);
					$("#fav_link_"+ tweetId + user).attr('href', orig_href);
					
					showNotification ('Mark Favorite', response.msg, ERROR);
				}
			},
			"json"
		);
}


function tweetUpdate(userId) {
	
	var tweet = $("#tweet" + userId).val();
	$("#updateButton" + userId).hide();
	$("#updateStatus" + userId).fadeIn('slow');
	
	$.post("/s/tweetUpdate",
			{
				"user" 		: userId,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"tweet" 	: tweet,
				"multUser"	: g_selected_user_name
			},
			function(response) { 
				if(response.success) {

					tweet = response.tweet;
					var code = '';
					if(response.direct) {
						
						//Update the latest tweet.. sent for the next updates...
						$("#direct"+userId+"_latest").val(tweet.id);
						
						//Build tweet & display it...
						code = buildDirectMessage(tweet, userId, false);
						
						$("#direct_container_" + userId).prepend(code);
						
						//No of unread tweets...
						var new_tweets = parseInt($("#no_of_direct" + userId).text()) + 1;
						
						//Update the unread count...
						updateNewTweetCount('direct', userId, new_tweets);
						
						//Check if older tweet link has to be shown.. shown only if tweets exceed 20...
						var total_no_of_direct = parseInt($("#direct"+userId+"_count").val()) + 1;
						$("#direct"+userId+"_count").val(total_no_of_direct);
						
						if(total_no_of_direct > TWEETS_PER_PAGE) {
							$("#old_direct_link_"+userId).fadeIn('slow');
						}
					}
					else {
						
						//Update the latest tweet.. sent for the next updates...
						$("#friend"+userId+"_latest").val(tweet.id);
						
						//Build tweet & display it...
						code = buildUpdateMessage(tweet, userId, false);
						
						$("#friend_container_" + userId).prepend(code);
						
						//No of unread tweets...
						new_tweets = parseInt($("#no_of_friend" + userId).text()) + 1;
						
						//Update the unread count...
						updateNewTweetCount('friend', userId, new_tweets);
						
						//Check if older tweet link has to be shown.. shown only if tweets exceed 20...
						var total_no_of_tweets = parseInt($("#friend"+userId+"_count").val()) + 1;
						$("#friend"+userId+"_count").val(total_no_of_tweets);
						
						if(new_tweets > TWEETS_PER_PAGE) {
							$("#old_friend_link_"+userId).fadeIn('slow');
						}
					}
					
					//Clear the text field...
					$("#tweet" + userId).val("");
					
					//Update the characters to 140 & disable the submit button..
					updateChars('' , userId);
				}
				else { 
					// show error
					showNotification ('Tweet', response.msg, ERROR);
				}
				$("#updateStatus" + userId).hide();
				$("#updateButton" + userId).fadeIn('slow');
			},
			"json"
		);
}

function tellFriends(userId){
	$("#tweet" + userId).focus();
	$("#tweet" + userId).val(TELL_FRIEND_MSG);
	updateChars(TELL_FRIEND_MSG, userId);
}

function hideTweetBox(type, userId) {
	
	if(!$("#"+ type + "_list_" +userId).is(':hidden')) {
		
		$("#"+ type + "_list_" +userId).fadeOut('slow');
		var container = '#'+type+'_container_'+userId;
		$(container).children().removeClass('tweetbox_1');
		$(container).children().addClass('tweetbox_0');
		$("#no_of_"+type+userId).text('0');
		$("#no_of_"+type+userId).parent().removeClass('bold-text');
		
		//Hiding search or trends tweetbox... STOP auto updates...
		if(type == 'search' || type == 'trends') {
			clearTimeout(g_refresh_timer[type]);
		}
	}
}

function showTweetBox(type, userId) {
	if ($("#" + type + "_list_" + userId).is(':hidden')) {
		var i = 0;
		$("#sortable_boxes_" + userId + " li").each (
			function() {
				if(!$(this).is(':hidden')) {
					i++;
					if(i == 4) {
						$(this).hide();
					}
				}
			}
		);
		$("#new_" + type + "_count" + userId).parent().removeClass('bold-text');
		$("#new_" + type + "_count" + userId).text('');
		$("#"+ type + "_list_" + userId).fadeIn('slow');
	}
}

function showReplyMenu(replyMenu) {
	$("#"+replyMenu).show();
}

function hideReplyMenu(replyMenu) {
	$("#"+replyMenu).hide();
}

function getOlderFriendUpdates(page, old_new, userId) {
	
	showTweetLoadImage('friend', userId, old_new);
	
	$.post("/s/getUpdates",
			  { 
				"user" 		: userId,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"page"		: page 
			  },
				function(response) { 
					if(response.success) {
						
						var code = '';
						
						var count = 0;
						
						//Update the unread tweet's count
						updateNewTweetCount('friend', userId, response.count);

						//Stop all the updates.. since the user is viewing old tweets..
						stopAutoUpdates('f');

						//Start all auto updates.. the user is back to latest page
						if(page == 1) {
							startAutoUpdates(userId, 'f');
						}

						//If there are no older tweets dont do anything... 
						if(response.result.length == 0) {
							hideTweetLoadImage('friend', userId, old_new);
							
							//hide the older tweet link..
							$("#old_friend_link_"+userId).fadeOut('slow');
							
							//If the page 2 does not hv any tweets...Start auto updates.. the user is still on the latest page
							if(page == 2) {
								startAutoUpdates(userId, 'f');
							}
							
							return;
						}

						//There are older tweets.. show older link...
						$("#old_friend_link_"+userId).fadeIn('slow');
						
						var build = buildTweets(response.result, 'friend', userId);
						
						code = build.code;

						count = build.count;
						
						$("#friend_container_" + userId).html(code);

						//Change the page no for the link.. points to (current + 1)
						$("#old_friend_link_"+userId).attr('href', 'javascript:getOlderFriendUpdates('+( response.page+1 )+',\'o\','+userId+');');
						
						//If the page displayed is 1 then hide newer link...
						if(response.page == 1) {
							$("#new_friend_link_"+userId).fadeOut('slow');
						}
						else {
							//Change the page no for the link.. points to (current - 1)
							$("#new_friend_link_"+userId).attr('href', 'javascript:getOlderFriendUpdates('+( response.page-1 )+', \'n\', '+userId+');');
							$("#new_friend_link_"+userId).fadeIn('slow');
						}

//						$("#friend_container_"+userId).unbind('scroll');
//						$("#friend_container_"+userId).scroll(
//								function() {
//									$(".user-info").hide();
//									 if ($(this)[0].scrollHeight - $(this).scrollTop() == $(this).outerHeight()) {
//										 // If we're at the bottom, show the overlay and retrieve the next page
//									     getOlderFriendUpdates((response.page + 1), 'o', userId);
//									 }
//								}
//						);
//						
						$('#friend_page_no_'+userId).text(response.page);
					}
					else {
						showNotification ('Older Updates', response.msg, ERROR);
					}
					hideTweetLoadImage('friend', userId, old_new);
			  },
		"json"
	);
}


function getOlderDirectUpdates(page, old_new, userId) {
	
	showTweetLoadImage('direct', userId, old_new);
	
	$.post("/s/getDirects",
			{ 
				"user" 		: userId,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"page"		: page
			},
			function(response) { 
				if(response.success) {
					
					var count = 0;
					
					var code = '';

					//Update the unread tweet count...
					updateNewTweetCount('direct', userId, response.count);

					//Stop all the updates.. since the user is viewing old tweets..
					stopAutoUpdates('d');
					
					//Start all auto updates.. the user is back to latest page
					if(page == 1) {
						startAutoUpdates(userId, 'd');
					}

					//If there are no older directs dont do anything...
					if(response.result.length == 0) {
						hideTweetLoadImage('direct', userId, old_new);

						//Hide the older link as there are none..
						$("#old_direct_link_"+userId).fadeOut('slow');

						//If the page 2 does not hv any tweets...Start auto updates.. the user is still on the latest page
						if(page == 2) {
							startAutoUpdates(userId, 'd');
						}
						
						return;
					}

					//Show the older links...
					$("#old_direct_link_"+userId).fadeIn('slow');

					var build = buildTweets(response.result, 'direct', userId);
					
					code = build.code;
					
					count = build.count;
					
					$("#direct_container_" + userId).html(code);
					
					//Update the href of link... now points to page (current + 1)
					$("#old_direct_link_"+userId).attr('href', 'javascript:getOlderDirectUpdates('+( response.page+1 )+', \'o\', '+userId+');');
					
					//If the page being displayed is 1 then hide newer link...
					if(response.page == 1) {
						$("#new_direct_link_"+userId).fadeOut('slow');
					}
					else {
						//Update the href of link... now points to page (current - 1)
						$("#new_direct_link_"+userId).attr('href', 'javascript:getOlderDirectUpdates('+( response.page-1 )+', \'n\', '+userId+');');
						$("#new_direct_link_"+userId).fadeIn('slow');
					}
					$('#direct_page_no_'+userId).text(response.page);
				}
				else {
					showNotification ('Older Direct Messages', response.msg, ERROR);
				}
				hideTweetLoadImage('mention', userId, old_new);
			},
		"json"
	);
	
}


function getOlderMentions(page, old_new, userId) {

	showTweetLoadImage('mention', userId, old_new);
	
	$.post("/s/getMentions",
			{ 
				"user" 		: userId,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"page"		: page
				
			},
			function(response) {
				
				if(response.success) { 

					var count = 0;
					var code = '';

					//Update the unread tweet count...
					updateNewTweetCount('mention', userId, response.count);

					//Stop all the updates.. since the user is viewing old tweets..
					stopAutoUpdates('m');

					//Start all auto updates.. the user is back to latest page
					if(page == 1) {
						startAutoUpdates(userId, 'm');
					}
					
					//If there are no older mentions...
					if(response.result.length == 0) {
						hideTweetLoadImage('mention', userId, old_new);

						//Hide the older tweet link as there are none...
						$("#old_mention_link_"+userId).fadeOut('slow');

						//If the page 2 does not hv any tweets...Start auto updates.. the user is still on the latest page
						if(page == 2) {
							startAutoUpdates(userId, 'm');
						}
						
						return;
					}
					
					//Show the older tweet link...					
					$("#old_mention_link_"+userId).fadeIn('slow');

					var build = buildTweets(response.result, 'mention', userId);
					
					code = build.code;
					
					count = build.count;
					
					$("#mention_container_" + userId).html(code);
					
					//Update the link's href.. now points to (current + 1)
					$("#old_mention_link_"+userId).attr('href', 'javascript:getOlderMentions('+( response.page+1 )+', \'o\', '+userId+');');
										
					//If page being displayed is 1 then hide newer link..
					if(response.page == 1) {
						$("#new_mention_link_"+userId).fadeOut('slow');
					}
					else {
						//Update the link's href.. now points to (current + 1)
						$("#new_mention_link_"+userId).attr('href', 'javascript:getOlderMentions('+( response.page-1 )+', \'n\', '+userId+');');
						$("#new_mention_link_"+userId).fadeIn('slow');
					}
					$('#mention_page_no_'+userId).text(response.page);
				}
				else {
					showNotification ('Older Mentions', response.msg, ERROR);
				}
				hideTweetLoadImage('mention', userId, old_new);
			},
			"json"
	);
	
}


function hideTweetLoadImage(type, userId, old_new) {
	
	if(old_new == 'o') {
		$("#old_"+type+"_load_"+userId).fadeOut('slow');
	}
	else {
		$("#new_"+type+"_load_"+userId).fadeOut('slow');
	}
}

function showTweetLoadImage(type, userId, old_new) {
	if(old_new == 'o') {
		$("#old_"+type+"_load_"+userId).fadeIn('slow');
	}
	else {
		$("#new_"+type+"_load_"+userId).fadeIn('slow');
	}
}


function getNewFriendUpdates(userId) {
	
	//Get the latest friend's update id
	var tweet_id = $("#friend"+userId+"_latest").val();
	
	$.post("/s/getUpdates",
			  { 
				"user" 		: userId,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"tweetId"	: tweet_id 
			  },
				function(response) { 
					if(response.success) {
						
						var code = '';
						
						var count = 0;
						
						//Get the count of new unread tweets... 
						var new_tweets = parseInt($("#no_of_friend"+userId).text()) + response.count;
						
						//Update the unread tweet count...
						updateNewTweetCount('friend', userId, new_tweets);
						
						//If there are no older tweets dont do anything
						if(response.result.length == 0) {
							
							//Call the Update after fixed interval
							g_friend_timer = setTimeout("getNewFriendUpdates("+userId+");", UPDATE_INTERVAL);
							return;
							
						}
						
						var build = buildTweets(response.result, 'friend', userId);
						
						code = build.code;
						
						count = build.count;
						
						$("#friend_container_" + userId).prepend(code);
						
						var no_of_tweets = parseInt($("#friend"+userId+"_count").val()) + count;
						
						$("#friend"+userId+"_count").val(no_of_tweets);
						
						if(no_of_tweets > TWEETS_PER_PAGE) {
							$("#old_friend_link_"+userId).fadeIn('slow');
						}
					}
					else {
						showNotification ('New Updates', response.msg, ERROR);
					}

					// Call the Update
					g_friend_timer = setTimeout("getNewFriendUpdates("+userId+");", UPDATE_INTERVAL);
			  },
		"json"
	);
}

function getNewDirects(userId) {
	
	//Get the latest direct's id
	var direct_id =  $("#direct"+userId+"_latest").val();
		
	$.post("/s/getDirects",
			{ 
				"user" 		: userId,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"tweetId"	: direct_id
			},
			function(response) { 
				if(response.success) {
					
					var count = 0;
					
					var code = '';

					var new_tweets = parseInt($("#no_of_direct"+userId).text()) + response.count;
					
					
					updateNewTweetCount('direct', userId, new_tweets);
					
					//If there are no older directs dont do anything
					if(response.result.length == 0) {
						//Call the Update after the fixed interval
						g_direct_timer = setTimeout("getNewDirects("+userId+");", UPDATE_INTERVAL);
						return;
					}
					
					var build = buildTweets(response.result, 'direct', userId);
					
					code = build.code;
					
					count = build.count;
					
					$("#direct_container_" + userId).prepend(code);
					
					var no_of_directs = parseInt($("#direct"+userId+"_count").val()) + count;
					
					$("#direct"+userId+"_count").val(no_of_directs);
					
					if(no_of_directs > TWEETS_PER_PAGE) {
						$("#old_direct_link_"+userId).fadeIn('slow');
					}
				}
				else {
					showNotification ('New Direct Messages', response.msg, ERROR);
				}

				//Call the Update after the fixed interval
				g_direct_timer = setTimeout("getNewDirects("+userId+");", UPDATE_INTERVAL);
			},
		"json"
	);
}

function getNewMentions(userId) {

	//Get the latest mention's id
	var mention_id = $("#mention"+userId+"_latest").val(); 
	
	$.post("/s/getMentions",
			{ 
				"user" 		: userId,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"tweetId"	: mention_id
			},
			function(response) {
				
				if(response.success) { 

					var count = 0;
					var code = '';
					
					var new_tweets = parseInt($("#no_of_mention"+userId).text()) + response.count;
					
					updateNewTweetCount('mention', userId, new_tweets);

					//If there are no older mentions... return
					if(response.result.length == 0) {
						//Call the Update after fixed interval
						g_mention_timer = setTimeout("getNewMentions("+userId+");", UPDATE_INTERVAL);
						return;
					}

					var build = buildTweets(response.result, 'mention', userId);
					
					code = build.code;
					
					count = build.count;
					
					$("#mention_container_" + userId).prepend(code);
					
					var no_of_mentions = parseInt($("#mention"+ userId +"_count").val()) + count;
					
					$("#mention"+ userId +"_count").val(no_of_mentions);
					
					if(no_of_mentions > TWEETS_PER_PAGE) {
						$("#old_mention_link_"+userId).fadeIn('slow');
					}
				}
				else {
					showNotification ('New Mentions', response.msg, ERROR);
				}
				
				//Call the Update after fixed interval
				g_mention_timer = setTimeout("getNewMentions("+userId+");", UPDATE_INTERVAL);
			},
		"json"
	);

}


function startAutoUpdates(userId, type) {
	switch(type) {
		case 'f' : 
			g_friend_timer = setTimeout("getNewFriendUpdates("+userId+");", UPDATE_INTERVAL);
			break;
		case 'd' : 
			g_direct_timer = setTimeout("getNewDirects("+userId+");", UPDATE_INTERVAL);
			break;
		case 'm' :
			g_mention_timer = setTimeout("getNewMentions("+userId+");", UPDATE_INTERVAL);
		default	 :
			g_friend_timer = setTimeout("getNewFriendUpdates("+userId+");", UPDATE_INTERVAL);
			g_direct_timer = setTimeout("getNewDirects("+userId+");", UPDATE_INTERVAL);
			g_mention_timer = setTimeout("getNewMentions("+userId+");", UPDATE_INTERVAL);
	}
}

function stopAutoUpdates(type) {
	
	switch(type) {
		case 'f' : 
			clearTimeout(g_friend_timer);
			break;
		case 'd' : 
			clearTimeout(g_direct_timer);
			break;
		case 'm' :
			clearTimeout(g_mention_timer);
		default	 :
			clearTimeout(g_friend_timer);
			clearTimeout(g_direct_timer);
			clearTimeout(g_mention_timer);
			clearTimeout(g_stat_timer);
	}
}

function settingsDialog() {
	
	if(g_selected_user_id == 0) {
		return;
	}
	
	g_remove_user = new Array();
	
	var index;

	var users = login_state.users;

	var user_table = '<table class="user-table ui-corner-all">';

	for (index in users) {
		var user = users[index];
		if(user.id == 0){
			continue;
		}
		user_table += '<tr id="user_row_'+user.id+'">' +
					  '	<td  class="left-column ui-corner-left">' +
					  		user.name +
					  '	</td>' +
					  '	<td class="right-column ui-corner-right">' +
					  '		<button onclick="javascript:removeUser('+user.id+', '+ index +');" class="jui-button ui-corner-all"  title="Sign out '+user.name+'">'+
					  '			<span class="ui-icon ui-icon-trash"></span>'+
					  '		</button>' +
					  '	</td>' +
					  '</tr>';	  
	}
	
	user_table += '</table>';
	
	$("#user_list").html(user_table);
	
	var interval = getCookie("interval");
	
	$("#update_interval option").each(
			function() {
				if($(this).val() == interval) {
					$(this).attr('selected', 'selected');
				}
			}
	);
	
	$("#settings_dialog").dialog('open');
}

function setSettings() {
	var index;
	var users = '[';
	for(index in g_remove_user) {
		if(index > 0) {
			users += ',';
		}
		users += g_remove_user[index].id;
	}
	users += ']';
	
	var interval = $("#update_interval option:selected").val();

	$.post("/s/setSettings", 
				{
					"users" 	: users,
					"interval"	: interval,
					"multUser"	: g_selected_user_name,
					"userId"	: g_selected_user_id
				}, 
				function(response) {
					if(response.success) {
						
						UPDATE_INTERVAL = parseInt(interval) * 60 * 1000;
						
						if(response.redirect) {
							document.location = '/index.html';
							return;
						}
						
						var delete_visible_tab = false;
						
						//Remove the tabs... for which user are deleted
						for(index in g_remove_user) {
							
							var userId = g_remove_user[index].id;
							
							//Remove the main div containing all the content
							$("#user"+userId).remove();
							
							login_state.users[g_remove_user[index].index].id = 0;
							
							if(userId == g_selected_user_id) {
								delete_visible_tab = true;
							}
							
							//Remove the ui-tab.. match the href of the link
							$("#users_tab li").each (
								function() {
									if($(this).children().attr('href') == "#user"+userId) {
										$(this).remove();
									}
								}
							);
						}
						
						//Select the tab from the remaining ones....
						for(index in login_state.users) {
							if(login_state.users[index].id != 0) {
								$("#tabs").tabs("select", "#user"+login_state.users[index].id);
							}
						}
						
					}
					else {
						showNotification ('Save Settings', response.msg, ERROR);
					}
				}, 
		"json"
	);
	
	$("#settings_dialog").dialog('close');
}

function removeUser(userId, index) {
	var user = {
			"id": userId, 
			"index" :index 
			};
	g_remove_user[g_remove_user.length] = user;
	$("#user_row_"+userId).fadeOut (
										'slow', 
										function(){
											$(this).remove();
										}
									);
}

function showMsg(userId) {
	if($("#tweet"+userId).val() == '') {
		$("#tweet"+userId).removeClass('focus');
		$("#tweet"+userId).addClass('blur');
		$("#tweet"+userId).val('Type Your Status Message Here');
	}
}

function hideMsg(userId) {
	if($("#tweet"+userId).val() == 'Type Your Status Message Here') {
		$("#tweet"+userId).removeClass('blur');
		$("#tweet"+userId).addClass('focus');
		$("#tweet"+userId).val('');
	}
}

function updateNewTweetCount(type, userId, count) {
	
	$("#no_of_"+ type + userId).text(count);
	
	if(count > 0) {
		$("#no_of_"+ type + userId).parent().addClass('bold-text');
	}
	else {
		$("#no_of_"+ type + userId).parent().removeClass('bold-text');
	}

	if($("#" + type + userId).is(':hidden') && count > 0 && g_selected_user_id == userId) {
		$("#new_"+type+"_count"+userId).text('(' + count + ')');
		$("#new_"+type+"_count"+userId).parent().addClass('bold-text');
	}
}

function refresh() {
	if(g_selected_user_id == 0) {
		return;
	}
	stopAutoUpdates('a');
	updateDirects({ "id" : g_selected_user_id });
	updateFriendTweets({ "id" : g_selected_user_id });
	updateMentions({ "id" : g_selected_user_id });
	startAutoUpdates(g_selected_user_id, 'a');
}

function gotoUrl(tweetId, url) {
	var user = g_selected_user_id;
	var newWindow = window.open(REDIRECT_URL + '?'+ 'uid=' + user + '&' + 'username=' + g_selected_user_name + '&' + 'id=' + tweetId + '&' + 'url=' + url, '_blank');
	newWindow.focus();
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
//	return ($(tweetMsg).text());
}

function isUrl(s) {
	var regexp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/
	return regexp.test(s);
}

function encodeTweet(tweetMsg, id) {

	var gotoUrl = "";
	var gotoUrlEnd = "";
	if(id > 0){
		gotoUrl = "javascript:gotoUrl('" + id +"', '";
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
			newTweet += '<a title="'+ word +'" href="#" onclick="'+ gotoUrl + word + gotoUrlEnd + '">'+ shortURL + '</a> ';
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
				var key = word.substring(1, word.length);
				
//				var key = word.replaceAll("[^a-zA-Z0-9]", "");
				
				newTweet += '<a href="#" onclick="'+ gotoUrl + 'http://search.twitter.com/search?q='+ key + gotoUrlEnd + '">'+ word + '</a>' + splitStr + ' ';    
			}
			else if(word.indexOf("@") == 0) {
//				var user = word.substring(1);
				var user = word.replace(/[@#:\.\,\?!\s]/g, "");
				newTweet += '<a target="_blank" href="http://twitter.com/' + user + '">'+ word + '</a> ';    
			}
			else {
				newTweet +=  word + ' ';
			}
		}
	}
	return newTweet;
}


function followUser(username, tweetId, type) {
	
	$("#"+type+"_usr_load_img_"+ tweetId + g_selected_user_id).fadeIn('slow');
	$.post("/s/followUser", 
			{
				"username"	: username,
				"user"		: g_selected_user_id,
				"multUser"	: g_selected_user_name,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session
			}, 
			function(response) {
				if(response.success) {
					code = '<button class="jui-dark-button" onclick="unfollowUser(\''+username+'\', '+tweetId+', \''+type+'\');" title="Unfollow '+username+'">Unfollow</button>'; 
					$("#"+type+"_follow_user_"+ tweetId + g_selected_user_id).html(code);
				}
				else {
					showNotification ('Follow User', response.msg, ERROR); 
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
				"multUser"	: g_selected_user_name, 
				"gid"  		: login_state.gid,
				"session" 	: login_state.session
			}, 
			function(response) {
				if(response.success) {
					code = '<button class="jui-dark-button" onclick="followUser(\''+username+'\', '+tweetId+', \''+type+'\');" title="Follow '+username+'">Follow</button>'; 
					$("#"+type+"_follow_user_"+ tweetId + g_selected_user_id).html(code);
				}
				else {
					showNotification ('Unfollow User', response.msg, ERROR); 
				}
				$("#"+type+"_usr_load_img_"+ tweetId + g_selected_user_id).fadeOut('slow');
			}, 
		"json"
	);
}

function getUserStat(user) {
	
	$.post("/s/getUserStat", 
			{
				"userId"	: user.id,
				"username"	: user.name,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session
			}, 
			function(response) {
				if(response.success) {
					$("#following_user_count_"+user.id).text(response.user.following);
					$("#followers_user_count_"+user.id).text(response.user.followers);
					$("#tweets_count_"+user.id).text(response.user.tweets);
					$("#favorites_count_"+user.id).text(response.user.favorites);
					$("#user_stat_div_"+user.id).fadeIn('slow');
				}
				else {
					showNotification ('User Statistics', response.msg, ERROR);
				}
				g_stat_timer = setTimeout("getUserStat({\"name\":\""+user.name+"\", \"id\":"+user.id+"});", UPDATE_INTERVAL);
			}, 
		"json"
	);
}


function showRetweetOptions(userId) {
	if($("#retweet_options_"+userId).is(':hidden')) {
		$("#retweet_options_"+userId).slideDown('slow');
	}
	else {
		$("#retweet_options_"+userId).slideUp('slow');
	}
}


function getReplyIcons(type, userId, tweetId, menu_type) {
	var reply_icons = '';

	switch(menu_type) {
		case DIRECT_MSG:
		case RETWEETED:
			reply_icons = 	'<span class="action-icons" id="'+type+'_reply_'+userId+'_'+tweetId+'">' + 
							'	<ul>'+
							'		<li class="reply"><span onclick="javascript:publicReply(\''+type+'\', '+ userId +', \'' + tweetId +'\');" class="ui-icon ui-icon-arrowreturnthick-1-w" title="Reply"></span></li><br/>'+ 
							'		<li class="direct"><span onclick="javascript:directMessage(\''+type+'\', '+ userId+', \'' + tweetId +'\');" class="ui-icon ui-icon-mail-closed" title="Direct Message"></span></li><br/>'+
							'	</ul>' +
							'</span>';
			break;
		case GENERAL_TWEET:
			reply_icons = 	'<span class="action-icons" id="'+type+'_reply_'+userId+'_'+tweetId+'">' + 
							'	<ul>'+
							'		<li class="reply"><span onclick="javascript:publicReply(\''+type+'\', '+ userId +', \'' + tweetId +'\');" class="ui-icon ui-icon-arrowreturnthick-1-w" title="Reply"></span></li><br/>'+ 
							'		<li class="retweet"><span onclick="javascript:reTweet(\''+type+'\', '+ userId +', \'' + tweetId +'\');" class="ui-icon ui-icon-refresh" title="Retweet with Comment" ></span></li><br/>'+
							'		<li class="direct"><span onclick="javascript:directMessage(\''+type+'\', '+ userId+', \'' + tweetId +'\');" class="ui-icon ui-icon-mail-closed" title="Direct Message"></span></li><br/>'+
							'	</ul>' +
							'</span>';
			break;
	}
	
	return reply_icons;
}

function getFavoriteIcon(userId, tweetId, isFav) {
	var favorite = 	'';
	if(isFav) {
		favorite = 	'<a id="fav_link_'+ tweetId + userId +'" title="Unmark As Favorite" href="javascript:markFavorite('+ userId +',' + tweetId +',false)">'+
					'	<img id="fav_icon_'+ tweetId + userId +'" src="../images/star-32.png" class="small-icon"/>'+
					'</a>';
	}
	else {
		favorite = 	'<a id="fav_link_'+ tweetId + userId +'" title="Mark As Favorite" href="javascript:markFavorite('+ userId +',' + tweetId +',true)">'+
					'	<img id="fav_icon_'+ tweetId + userId +'" src="../images/star-none-32.png" class="small-icon"/>'+
					'</a>';
	}
	return favorite;
}

function getUserInfoUI(tweetId, userId, user, type) {
	
	var code = 	'<div id="'+type+'_user_info_'+ tweetId + userId +'" style="display: none;" class="user-info ui-corner-all">'+
				'	<div class="arrow-up"></div>'+
				'	<div class="user-info-header">'+
				'		<table>'+
				'			<tr>'+
				'				<td style="width:35px;">'+
			 	'					<span class="userimg">'+
			 	'						<a href="http://twitter.com/'+user.name+'" target="_blank"  title="'+user.name+'">'+
			 	'							<img class="tweetimg" id="usr_img_'+ tweetId + userId +'" src="'+user.img+'" alt="image"/>'+
			 	'						</a>'+
			 	'					</span>'+
				'				</td>'+
				'				<td style="padding-left:3px;width:185px;">'+
				'					<span class="tweetuser">'+
			 	'						<a style="color: #DDD;" target="_blank" href="http://twitter.com/'+user.name+'">'+user.name+'</a>'+
			 	'					</span>'+
				'					<span class="status" id="'+type+'_status_'+ tweetId + userId +'"></span>'+
				'				</td>'+
				'				<td>'+
				'					<span title="Close" onclick="javascript:hideUserInfo(\'' + tweetId + '\', '+userId+', \''+type+'\');" class="ui-icon ui-icon-circle-close"></span>'+
				'				</td>'+
				'			</tr>'+
				'		</table>'+
				'	</div>'+
				'	<div id="'+type+'_user_stat_'+tweetId+userId+'" style="padding: 5px 0px 0px 0px;">'+
				'		<span style="border:0px none;" class="user-stat-span">'+
				'			<span class="user-stat-num" id="'+type+'_following_'+ tweetId + userId +'"></span><br/>'+
				'			<span class="user-stat-text">Following</span>'+
				'		</span>'+
				'		<span class="user-stat-span">'+
				'			<span class="user-stat-num" id="'+type+'_followers_'+ tweetId + userId +'"></span><br/>'+
				'			<span class="user-stat-text">Followers</span>'+
				'		</span>'+
				'		<span class="user-stat-span">'+
				'			<span class="user-stat-num" id="'+type+'_updates_count_'+ tweetId + userId +'"></span><br/>'+
				'			<span class="user-stat-text">Tweets</span>'+
				'		</span>'+
				'		<hr class="space"/>'+
				'		<span class="follow-user" id="'+type+'_follow_user_'+ tweetId + userId +'"></span>'+
				'	</div>'+
			 	'	<span>'+
			 	'		<img style="display:none;bottom:5px;left:5px;position:absolute;" id="'+type+'_usr_load_img_'+ tweetId + userId +'" src="../images/indicator_arrows_black.gif" alt="Loading"/>'+
			 	'	</span>'+
				'	<span id="'+type+'_error_'+ tweetId + userId +'" class="twitter-error">'+
				'	</span>'+
				'</div>';
	return code;
}

function buildRetweet(tweet, userId, old, type, retweeted) {
	
	var class_str = 'tweetbox_1';
	
	if(old) {
		class_str = 'tweetbox_0';
	}
	
	var favorite = getFavoriteIcon(userId, tweet.id, tweet.favorite);
	
	var RT_code = '';
	var reply_icons = '';
	
	if(retweeted) {
		reply_icons = getReplyIcons(type, userId, tweet.id, RETWEETED);
	}
	else {
		RT_code =	'<span title="Retweet" class="ui-icon ui-icon-refresh" style="cursor:pointer;" id="RT_icon'+tweet.id+'" onclick="reTweetWithoutComment(\'' + tweet.id + '\', \''+type+'\');"></span>'+
					'<img src="../images/indicator_arrows_circle.gif" class="smaller-icon" style="display:none;" id="retweeting_img'+tweet.id+'"/>';
		reply_icons = getReplyIcons(type, userId, tweet.id, GENERAL_TWEET);
	}

	

	var RT_id = tweet.id;
	var re_tweet_icon = '';
	var retweet_column = '';
	
	if(tweet.RT.length > 0) {
		re_tweet_icon = '<span style="border:1px solid #ddd; margin-top:1px;" class="ui-icon ui-corner-all ui-icon-refresh"></span>';
		retweet_column =  '<span class="RT">Retweeted by <a target="_blank" href="http://twitter.com/'+tweet.RT+'">@' + tweet.RT + '</a></span>'+
						  '<input type="hidden" id="orig_tweet_id_'+ tweet.id + userId +'" value="'+tweet.RID+'"/>';
		RT_id = tweet.RID;
	}
	var user = {"name": tweet.user, "img": tweet.img};
	var code =  '<div class="'+class_str+'" id="'+type+'_' + userId  + '_' + tweet.id +'" onmouseover="showReplyMenu(\''+type+'_reply_'+userId+'_'+tweet.id+'\');" onmouseout="hideReplyMenu(\''+type+'_reply_'+userId+'_'+tweet.id+'\');">' +
				'	<table class="tweet-table">'+
				'		<tr class="user-info-row">'+
				'			<td>'+
								getUserInfoUI(tweet.id, userId, user, 'RT') +
				'			</td>'+
				'		</tr>'+
				'		<tr>'+
				'			<td colspan="1">'+
				'				<span class="userimg"><a href="javascript:showUserInfo(\'' + tweet.id + '\', '+userId+', \''+type+'\');"><img class="tweetimg" src="' + tweet.img + '" alt="image" /></a></span>' +
				'			</td>'+
				'			<td style="padding-right: 5px;" colspan="1">'+
				'				<span class="tweetuser">'+re_tweet_icon+'<a id="'+ type + userId  + tweet.id + '" target="_blank" href="http://twitter.com/'+tweet.user+'">' + tweet.user + '</a></span>' +
				'				<span id="'+type+'tweet' + userId + tweet.id + '" class="tweetmsg">' + encodeTweet(tweet.text, tweet.id) +  '</span><br/>' +
				'			</td>'+
				'			<td style="width:20px; height:55px; padding:2px;" colspan="1">'+
								reply_icons+
				'			</td>'+
				'		</tr>'+
				'		<tr>'+
				'			<td id="RT_column'+tweet.id+'" colspan="3" style="padding: 5px 0px 0px;">'+
								retweet_column +
				'			</td>'+
				'		</tr>'+
				'		<tr>'+
				'			<td colspan="2">'+
				'				'+ favorite +'<span class="tweettime">' + tweet.date + ' via ' + tweet.src + '</span>'+
				'			</td>'+
				'			<td>'+
								RT_code +
				'			</td>'+
				'		</tr>'+
				'	</table>'+
				'</div>';
	return code;
}


function getRetweets(userId, rt_code, page) {
	
	var RT_by_me = false;

	if(rt_code == RT_BY_ME) {
		RT_by_me = true;
		$("#RT_by_me_img_"+userId).fadeIn('slow');
	}
	else {
		$("#RT_to_me_img_"+userId).fadeIn('slow');
	}
	
	$.post("/s/getRetweets", 
			{
				"RTMe"		: RT_by_me,
				"user"		: userId,
				"multUser"	: g_selected_user_name,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"page"		: page
			}, 
			function(response) {
				if(response.success) {
					var i;
					var code = '';
					for(i in response.result) {
						var tweet = response.result[i];
						code += buildRetweet(tweet, userId, true, 'rt', RT_by_me);
					}
					
					if(RT_by_me) {
						$("#retweet_header_"+userId).text('Retweets By Me');
					}
					else {
						$("#retweet_header_"+userId).text('Retweeted To Me');
					}
					
					$("#retweet_container_"+userId).html(code);
					
					if($("#retweet"+userId).is(':hidden')) {
						showTweetBox('retweet', userId);
					}
					
					if(response.result.length >= TWEETS_PER_PAGE) {
						//Change the page no for the link.. points to (current + 1)
						$("#old_retweet_link_"+userId).attr('href', 'javascript:getRetweets('+userId+','+rt_code+','+(response.page + 1)+');');
						$("#old_retweet_link_"+userId).fadeIn('slow');
					}
					else {
						$("#old_retweet_link_"+userId).hide();
					}
					
					//If the page displayed is 1 then hide newer link...
					if(response.page == 1) {
						$("#new_retweet_link_"+userId).fadeOut('slow');
					}
					else {
						//Change the page no for the link.. points to (current - 1)
						$("#new_retweet_link_"+userId).attr('href', 'javascript:getRetweets('+userId+','+rt_code+','+(response.page -1)+');');
						$("#new_retweet_link_"+userId).fadeIn('slow');
					}
					
					$('#retweet_page_no_'+userId).text(response.page);
				}
				else {
					showNotification('Retweets', response.msg, ERROR);
				}
				
				if(RT_by_me) {
					$("#RT_by_me_img_"+userId).fadeOut('slow');
				}
				else {
					$("#RT_to_me_img_"+userId).fadeOut('slow');
				}
				
			}, 
		"json"
	);
}

function getFavorites(userId, page) {
	
	$("#favorites_img_"+userId).fadeIn('slow');
	
	$.post("/s/getFavorites", 
			{
				"user"		: userId,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"page"		: page,
				"multUser"	: g_selected_user_name
			},
			function(response) {
				if(response.success) {
					var i = 0;
					var code = '';
					
					for(i in response.result) {
						var tweet = response.result[i];
						code += buildRetweet(tweet, userId, true, 'fav', false);
					}
					
					$("#favorite_container_"+userId).html(code);
					
					if($("#favorite_container_"+userId).is(':hidden')) {
						showTweetBox('favorite', userId);
					}
					
					if(response.result.length >= TWEETS_PER_PAGE) {
						//Change the page no for the link.. points to (current + 1)
						$("#old_favorite_link_"+userId).attr('href', 'javascript:getFavorites('+userId+','+(response.page + 1)+');');
						$("#old_favorite_link_"+userId).fadeIn('slow');
					}
					else {
						$("#old_favorite_link_"+userId).hide();
					}
					
					//If the page displayed is 1 then hide newer link...
					if(response.page == 1) {
						$("#new_favorite_link_"+userId).fadeOut('slow');
					}
					else {
						//Change the page no for the link.. points to (current - 1)
						$("#new_favorite_link_"+userId).attr('href', 'javascript:getFavorites('+userId+','+(response.page - 1)+');');
						$("#new_favorite_link_"+userId).fadeIn('slow');
					}
					$('#favorite_page_no_'+userId).text(response.page);
				}
				else {
					showNotification('Favorites', response.msg, ERROR);
				}
				$("#favorites_img_"+userId).fadeOut('slow');
			},
		"json"
	);
}

function buildSearchTweet(tweet, userId, type) {
	
	var class_str = 'tweetbox_1';
	
	var favorite = getFavoriteIcon(userId, tweet.id, false);
	
	var RT_code = '';
	var reply_icons = '';
	
	RT_code =	'<span title="Retweet" class="ui-icon ui-icon-refresh" style="cursor:pointer;" id="RT_icon'+tweet.id+'" onclick="reTweetWithoutComment(\'' + tweet.id + '\', \''+type+'\');"></span>'+
				'<img src="../images/indicator_arrows_circle.gif" class="smaller-icon" style="display:none;" id="retweeting_img'+tweet.id+'"/>';
	reply_icons = getReplyIcons(type, userId, tweet.id, GENERAL_TWEET);

	var RT_id = tweet.id;
	var re_tweet_icon = '';
	var retweet_column = '';
	var user = {"name": tweet.from_user, "img": tweet.profile_image_url};
	
	var code =  '<div class="'+class_str+'" id="'+type+'_' + userId  + '_' + tweet.id +'" onmouseover="showReplyMenu(\''+type+'_reply_'+userId+'_'+tweet.id+'\');" onmouseout="hideReplyMenu(\''+type+'_reply_'+userId+'_'+tweet.id+'\');">' +
				'	<table class="tweet-table">'+
				'		<tr class="user-info-row">'+
				'			<td>'+
								getUserInfoUI(tweet.id, userId, user, type) +
				'			</td>'+
				'		</tr>'+
				'		<tr>'+
				'			<td colspan="1">'+
				'				<span class="userimg"><a href="javascript:showUserInfo(\'' + tweet.id + '\', '+userId+', \''+type+'\');"><img class="tweetimg" src="' + tweet.profile_image_url + '" alt="image" /></a></span>' +
				'			</td>'+
				'			<td style="padding-right: 5px;" colspan="1">'+
				'				<span class="tweetuser">'+re_tweet_icon+'<a id="'+ type + userId  + tweet.id + '" target="_blank" href="http://twitter.com/'+tweet.from_user+'">' + tweet.from_user + '</a></span>' +
				'				<span id="'+type+'tweet' + userId + tweet.id + '" class="tweetmsg">' + encodeTweet(tweet.text, tweet.id) +  '</span><br/>' +
				'			</td>'+
				'			<td style="width:20px; height:55px; padding:2px;" colspan="1">'+
								reply_icons+
				'			</td>'+
				'		</tr>'+
				'		<tr>'+
				'			<td id="RT_column'+tweet.id+'" colspan="3" style="padding: 5px 0px 0px;">'+
								retweet_column +
				'			</td>'+
				'		</tr>'+
				'		<tr>'+
				'			<td colspan="2">'+
				'				'+ favorite +'<span class="tweettime">' + getTweetTime(tweet.created_at) + ' via ' + getTweetSource(tweet.source) + '</span>'+
				'			</td>'+
				'			<td>'+
								RT_code +
				'			</td>'+
				'		</tr>'+
				'	</table>'+
				'</div>';
	return code;
}


function searchTweets(userId, page, key, type) {
	
	$("#"+type+"_img_"+userId).fadeIn('slow');

	var url = 'http://search.twitter.com/search.json?callback=?&rpp=20&';
	var refresh = false;
	var keyword = '';

	//This means we are refreshing the results...
	if(key.indexOf('since_id') >= 0) {
		url += key;
		refresh = true;
		keyword = key;
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
		
		keyword = key_temp;
	}
	
	$.getJSON (
				url,
				function(response) {

					if(response.results.length == 0) {
						if (!refresh) {
							showNotification('Search', 'No Results found for "' + key + '"', ERROR);
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
						$("#"+type+"_container_"+userId).prepend(code);
					}
					else {
						$("#"+type+"_container_"+userId).html(code);
						$("#"+type+"_header_"+userId).text('Results For '+key);
					}
					
					if($("#"+type+"_container_"+userId).is(':hidden') && !refresh) {
						showTweetBox(type, userId);
					}
					
					if(!$("#"+type+"_container_"+userId).is(':hidden')) {
						g_refresh_timer[type] = setTimeout('searchTweets('+userId+', 1, \''+response.refresh_url+'\', \''+type+'\');', UPDATE_INTERVAL);
					}
					
					if(!refresh) {
						if(response.results.length >= TWEETS_PER_PAGE) {
							//Change the page no for the link.. points to (current + 1)
							$("#old_"+type+"_link_"+userId).attr('href', 'javascript:searchTweets('+userId+','+(response.page + 1)+', \''+key+'\', \''+type+'\');');
							$("#old_"+type+"_link_"+userId).fadeIn('slow');
						}
						else {
							$("#old_"+type+"_link_"+userId).hide();
						}
						//If the page displayed is 1 then hide newer link...
						if(response.page == 1 && !refresh) {
							$("#new_"+type+"_link_"+userId).fadeOut('slow');
						}
						else {
							//Change the page no for the link.. points to (current - 1)
							$("#new_"+type+"_link_"+userId).attr('href', 'javascript:searchTweets('+userId+','+(response.page - 1)+', \''+key+'\', \''+type+'\');');
							$("#new_"+type+"_link_"+userId).fadeIn('slow');
						}
						$("#"+type+"_page_no_"+userId).text(response.page);
					}
				
					$("#"+type+"_img_"+userId).fadeOut('slow');
				}
			 );

	$.post(	"/s/log", 
			{
				"userId"	: userId,
				"multUser"	: g_selected_user_name,
				"actionId"	: SEARCH_ACTION_ID,
				"keyword"	: keyword
			}
		  );

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

function showSearchBox(userId) {
//	if($("#search_box_"+userId).is(':hidden')) {
//		$("#search_box_"+userId).slideDown('slow');
//	}
//	else {
//		$("#search_box_"+userId).slideUp('slow');
//	}
}

function startNewSearch(userId) {
	var key = $("#search_key_"+userId).val();
	searchTweets(userId, 1, key, 'search');
}

function getMyInfo(userId) {
	$("#user_info_"+userId).fadeIn('slow');
}

function hideMyInfo(userId) {
	$("#user_info_"+userId).fadeOut('slow');
}

var short_link = 
	{	
		user_id: 0,
		url: "",
	    shorten : function(url, userId) {
			short_link.user_id = userId;
			short_link.url = url;
	        BitlyClient.shorten(url, 'short_link.response');
	    },
	    
	    response : function(data) {
	    	var long_url = short_link.url;
	    	var bitly_link = data.results[long_url]['shortUrl'];
	        addShortUrl2Tweet(short_link.user_id, bitly_link);
	    	showHideShortenUrl(short_link.user_id);
	    	$("#url_short_img_"+short_link.user_id).hide();
	    	$("#url_short_btn_"+short_link.user_id).show('slow');
	    }
	};


function shortenUrl(userId) {
	$("#url_short_btn_"+userId).hide();
	$("#url_short_img_"+userId).fadeIn('slow');
	var long_url = $("#long_url_"+userId).val();
	$.post(	"/s/log", 
			{
				"userId"	: userId,
				"multUser"	: g_selected_user_name,
				"actionId"	: URL_SHORTENER_ACTION_ID 
			}
		  );
	short_link.shorten(long_url, userId);
}

function showHideShortenUrl(userId) {
	if($("#url_shortner_"+userId).is(':hidden')) {
		$("#url_shortner_"+userId).fadeIn('slow');
		$("#long_url_"+userId).val('');
		$("#long_url_"+userId).focus();
	}
	else {
		$("#url_shortner_"+userId).fadeOut('slow');
	}
}

function addShortUrl2Tweet(userId, url) {
    $("#tweet" + userId).focus();
    var tweet = $("#tweet"+userId).val() +' '+ url;
    $("#tweet"+userId).val(tweet);
}

function buildFriends(tweet, userId, type) {
	
	var class_str = 'tweetbox_1';
	
	var button = '';
	
	if(tweet.friend) {
		button = '<button class="jui-dark-button" onclick="unfollowUser(\''+tweet.name+'\', '+tweet.id+', \''+type+'\');" title="Unfollow '+tweet.name+'">Unfollow</button>';
	}
	else {
		button = '<button class="jui-dark-button" onclick="followUser(\''+tweet.name+'\', '+tweet.id+', \''+type+'\');" title="Follow '+tweet.name+'">Follow</button>';
	}
	
	var reply_icons = getReplyIcons(type, userId, tweet.id, DIRECT_MSG);

	var code =  '<div class="'+class_str+'" id="'+type+'_' + userId  + '_' + tweet.id +'" onmouseover="showReplyMenu(\''+type+'_reply_'+userId+'_'+tweet.id+'\');" onmouseout="hideReplyMenu(\''+type+'_reply_'+userId+'_'+tweet.id+'\');">' +
				'	<table class="tweet-table">'+
				'		<tr>'+
				'			<td colspan="1">'+
				'				<span class="userimg">'+
				'					<a title="'+tweet.name+'" target="_blank" href="http://twitter.com/'+tweet.name+'"><img class="tweetimg" src="' + tweet.img + '" alt="image" /></a>'+
				'				</span>' +
				'			</td>'+
				'			<td style="padding-right: 5px;" colspan="1">'+
				'				<span class="tweetuser">'+
				'					<a id="'+ type + userId  + tweet.id + '" target="_blank" href="http://twitter.com/'+tweet.name+'">' + tweet.name + '</a>'+
				'				</span>' +
				'				<span id="'+type+'tweet' + userId + tweet.id + '" class="tweetmsg">' + encodeTweet(tweet.text, tweet.id) +  '</span><br/>' +
				'			</td>'+
				'			<td style="width:20px; height:30px; padding:2px;" colspan="1">'+
								reply_icons+
				'			</td>'+
				'		</tr>'+
				'		<tr>'+
				'			<td colspan="3">'+
				'				<div style="padding: 5px 0px 0px 0px;">'+
				'					<span style="border:0px none;" class="user-stat-span">'+
				'						<span style="font-size:larger;" class="user-stat-num">'+tweet.following+'</span><br/>'+
				'						<span class="user-stat-text">Following</span>'+
				'					</span>'+
				'					<span class="user-stat-span">'+
				'						<span style="font-size:larger;" class="user-stat-num">'+tweet.followers+'</span><br/>'+
				'						<span class="user-stat-text">Followers</span>'+
				'					</span>'+
				'					<span class="user-stat-span">'+
				'						<span style="font-size:larger;" class="user-stat-num">'+tweet.updates+'</span><br/>'+
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

function getFriends(userId, cursor, type) {
	
	$("#"+type+"_img_"+userId).fadeIn('slow');
	
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
				"username"		: g_selected_user_name,
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
					
					$("#"+type+"_container_"+userId).html(code);

					if($("#"+type+"_list_"+userId).is(':hidden')) {
						showTweetBox(type, userId);
					}

					if(response.nextCursor > 0) {
						$("#old_"+type+"_link_"+userId).attr('href', 'javascript:getFriends('+userId+', '+(response.nextCursor)+', \''+type+'\');');
						$("#old_"+type+"_link_"+userId).fadeIn('slow');
					}
					else {
						$("#old_"+type+"_link_"+userId).hide();
					}

					if(response.prevCursor > 0) {
						$("#new_"+type+"_link_"+userId).attr('href', 'javascript:getFriends('+userId+','+(response.prevCursor)+', \''+type+'\');');
						$("#new_"+type+"_link_"+userId).fadeIn('slow');
					}
					else {
						//If the page displayed is 1 then hide newer link...
						$("#new_"+type+"_link_"+userId).fadeOut('slow');
					}

					$("#"+type+"_page_no_"+userId).text(response.page);
				}
				else {
					showNotification('Friends', response.msg, ERROR);
				}
				$("#"+type+"_img_"+userId).fadeOut('slow');
			}, 
		"json"
	);
}


function showHideTrends(userId) {
	if(!$("#trend_list_"+userId).is(':hidden')) {
		$("#trends_hide_icon_"+userId).removeClass('ui-icon-circle-triangle-n');
		$("#trends_hide_icon_"+userId).addClass('ui-icon-circle-triangle-s');
		$("#trend_list_"+userId).slideUp('slow');
	}
	else {
		getTrends(userId);
	}
}


function getTrends(userId) {
	
	var url = 'http://api.twitter.com/1/trends.json?callback=?';
	
	$("#trends_img_" + userId).fadeIn('slow');
	
	$.getJSON (
				url, 
				function(response) {
					if (response.trends.length == 0) {
						$("#trends_img_" + userId).fadeOut('slow');
						showNotification('Trends', 'Some error occurred. Please try again.', ERROR);
						return;
					}
					
					var code = '<ul class="trend-list">';
					
					for(var i in response.trends) {
						var trend = response.trends[i];
						code += '<li>'+
								'	<a href="#" onclick="javascript:searchTweets('+userId+', 1, \''+trend.name+'\', \'trends\');">'+trend.name+'</a>' +
								'</li>';
					}
					
					code += '</ul>';
					$("#trend_list_"+userId).html(code);
					$("#trends_hide_icon_"+userId).removeClass('ui-icon-circle-triangle-s');
					$("#trends_hide_icon_"+userId).addClass('ui-icon-circle-triangle-n');
					$("#trend_list_"+userId).slideDown('slow');
					$("#trends_img_"+userId).fadeOut('slow');
				}
			 );
	
	$.post("/s/log", 
			{
				"userId"	: userId,
				"multUser"	: g_selected_user_name,
				"actionId"	: TRENDS_ACTION_ID 
			}
	);
}

/* Schmaps Plugin Callback */
function pluginCallback(url) {
	var userId = g_selected_user_id;
    $("#tweet" + userId).focus();
    var tweet = $("#tweet"+userId).val() +' '+ url;
    $("#tweet"+userId).val(tweet);
}

function tweetFeed (user_id, feed_id) {
	$("#tweet" + user_id).focus();
	var link = $("#mt_feeds_" + user_id + "_" + feed_id + "_link").attr('href');
	var msg = $("#mt_feeds_" + user_id + "_" + feed_id + "_text").text();
	$("#tweet" + user_id).val(link + ' ' + msg);
	updateChars(msg, user_id);
}

function buildFeeds (user_id, feed) {
	var class_str = 'tweetbox_1';
	feed.guid = feed.guid.replace(/[^a-zA-Z0-9\s]/g,'');
	var code =  '<div class="' + class_str + '" id="mt_feeds_' + user_id  + '_' + feed.guid +'"  onmouseover="showReplyMenu(\'mt_feeds_reply_' + user_id + '_' + feed.guid + '\');" onmouseout="hideReplyMenu(\'mt_feeds_reply_' + user_id + '_' + feed.guid + '\');">' +
				'	<table class="tweet-table">'+
				'		<tr>'+
				'			<td style="padding: 0px 5px; text-align: justify;">'+
				'				<span class="tweetuser">'+
				'					<a id="mt_feeds_' + user_id  + '_' + feed.guid +'_link" target="_blank" href="' + feed.link + '">' + feed.title + '</a>'+
				'				</span>' +
				'				: <span id="mt_feeds_' + user_id  + '_' + feed.guid +'_text" class="tweetmsg">' + feed.text + '</span><br/>' +
				'			</td>'+
				'			<td style="width:20px; height:55px; padding:2px; vertical-align: middle;">'+
				'				<span class="action-icons" id="mt_feeds_reply_' + user_id + '_' + feed.guid + '">' + 
				'					<ul>'+
				'						<li class="reply"><span onclick="javascript:tweetFeed('+ user_id +', \'' + feed.guid +'\');" class="ui-icon ui-icon-lightbulb" title="Tweet Feed"></span></li><br/>'+ 
				'					</ul>' +
				'				</span>' +
				'			</td>' +
				'		</tr>'+
				'		<tr>'+
				'			<td colspan="2">'+
				'				<span class="tweettime">' + feed.date + '</span>'+
				'			</td>'+
				'		</tr>'+
				'	</table>'+
				'</div>';
	return code;
}

function getFeeds (user_id, url) {
	$("#feeds_img_" + user_id).fadeIn('slow');
	$.post ("/s/getFeeds", 
			{
				"user_id" 	: user_id,
				"multUser"	: g_selected_user_name,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"url"		: url
			},
			function (response) {
				if (response.success) {
					$("#mt_feeds_container_" + user_id).html('');
					var code = '';
					for (i in response.feeds) {
						code += buildFeeds(user_id, response.feeds[i]);
					}
					$("#mt_feeds_container_" + user_id).html(code);

					if ($("#mt_feeds_container_" + user_id).is(':hidden')) {
						showTweetBox('mt_feeds', user_id);
					}
				}
				else {
					showNotification('Feeds', response.msg, ERROR);
				}
				$("#feeds_img_" + user_id).fadeOut('slow');
			},
		"json"
	);
}

function getFeedURL (user_id) {
	$("#feeds_img_" + user_id).fadeIn('slow');
	$.post ("/s/getFeedURL", 
			{
				"user_id" 	: user_id,
				"multUser"	: g_selected_user_name,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session
			}, 
			function(response) {
				if (response.success) {
					$("#feeds_list_" + user_id).html('');
					var code = '<ul class="feeds-list">';
					for (i in response.feeds) {
						var feed = response.feeds [i];
						code += '<li><a title="View Feed" href="#" onclick="javascript:getFeeds(' + user_id + ', \'' + feed.url + '\');">' + feed.title + '</a></li>';
					}
					code += '</ul>';
					$("#feeds_list_" + user_id).html(code);
					$("#feeds_" + user_id).slideDown('slow');
				}
				else {
					showNotification('Feed List', response.msg, ERROR);
				}
				$("#feeds_img_" + user_id).fadeOut('slow');
			}, 
		"json"
	);
}

function showToggleFeeds (user_id) {
	if ($("#feeds_" + user_id).is(':hidden')) {
		$("#feeds_hide_icon_" + user_id).removeClass('ui-icon-circle-triangle-s');
		$("#feeds_hide_icon_" + user_id).addClass('ui-icon-circle-triangle-n');
		getFeedURL (user_id);
	}
	else {
		$("#feeds_hide_icon_" + user_id).removeClass('ui-icon-circle-triangle-n');
		$("#feeds_hide_icon_" + user_id).addClass('ui-icon-circle-triangle-s');
		$("#feeds_" + user_id).slideUp('slow');
	}
}

function addNewFeed (user_id) {
	var feed_url = $("#feed_new_url").val().trim();
	
	if (feed_url == null || feed_url == '') {
		showNotification('Add Feed', 'Please provide an URL.', ERROR);
		return;
	}
	
	$("#feeds_img_" + user_id).fadeIn('slow');

	$.post ("/s/addNewFeed", 
			{
				"user_id" 	: user_id,
				"gid"  		: login_state.gid,
				"session" 	: login_state.session,
				"multUser"	: g_selected_user_name,
				"url"		: feed_url
			}, 
			function(response) {
				if (response.success) {
					getFeedURL (user_id);
				}
				else {
					showNotification('Add Feed', response.msg, ERROR);
				}
				$("#feeds_img_" + user_id).fadeOut('slow');
				$("#feed_new_url").val('');
			}, 
		"json"
	);
}
