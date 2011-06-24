var RT_BY_ME = 1;
var RT_TO_ME = 2;
var URL = "http://multwiple.com";
var icons = {
				"retweet"	: "ui-icon-refresh", 
				"search"	: "ui-icon-search", 
				"favorite"	: "ui-icon-star", 
				"following"	: "ui-icon-heart",
				"followers"	: "ui-icon-gear",
				"trends"	: "ui-icon-signal",
				"mt_feeds"	: "ui-icon-signal-diag"
			};

var g_url = "http://multwiple.com";

function loginAddOnSuccess(user){
	g_tabs_count ++;
	var code =	
			'<div id="user'+ user.id +'" class="tweets-container">' +
			'<table class="main-body-table">'+
			'<tr>'+
			'	<td class="left-dashboard">'+
//			'		<div class="dashboard-item"  onclick="showSearchBox('+user.id+');">'+
//			'			<span class="ui-icon ui-icon-search"></span>'+
//			'			<span class="dashboard-item-name">Search Tweets</span>'+
//			'			<img src="../images/indicator_arrows.gif" alt="Loading" style="display:none;" id="search_img_'+user.id+'"/>'+
//			'		</div>'+
			'		<div class="dashboard-item" id="search_box_'+user.id+'">'+
			'			<form method="post" action="" onsubmit="return false;">'+
			'				<span class="ui-icon ui-icon-search" style="margin-top: 2px;"></span>'+
			'				<input style="margin:0 0 0 5px; width:150px;" type="text" '+
			'					onblur="return(this.value == \'\' ? this.value = \'Search\': this.value = this.value);" '+
			'					onfocus="this.value = \'\';" '+
			'					class="text-box" id="search_key_'+user.id+'" value="Search"/>'+
			'				<input type="submit" class="jui-small-button" value="Go" onclick="startNewSearch('+user.id+');"/>'+
			'			</form>'+
			'		</div>'+
			'		<div class="dashboard-item friend-btn" onclick="showTweetBox(\'friend\', '+user.id+');">'+
			'			<span class="ui-icon ui-icon-home"></span>'+
			'			<span class="dashboard-item-name">Home</span>'+
			'			<span id="new_friend_count'+user.id+'"></span>'+
			'		</div>'+
			'		<div class="dashboard-item direct-btn" onclick="showTweetBox(\'direct\', '+user.id+');">'+
			'			<span class="ui-icon ui-icon-mail-closed"></span>'+
			'			<span class="dashboard-item-name">Direct Messages</span>'+
			'			<span id="new_direct_count'+user.id+'"></span>'+
			'		</div>'+
			'		<div class="dashboard-item mention-btn" onclick="showTweetBox(\'mention\', '+user.id+');">'+
			'			<span class="ui-icon ui-icon-person"></span>'+
			'			<span class="dashboard-item-name">Mentions</span>'+
			'			<span id="new_mention_count'+user.id+'"></span>'+
			'		</div>'+
//			'		<div  class="dashboard-item" onclick="showRetweetOptions('+user.id+');" id="user_retweets_'+user.id+'">'+
//			'			<span class="ui-icon ui-icon-refresh"></span>'+
//			'			<span class="dashboard-item-name">Retweets &nbsp;&nbsp;</span> '+
//			'			<img src="../images/indicator_arrows.gif" alt="Loading" style="display:none;" id="RT_loading_img_'+user.id+'"/>'+
//			'		</div>'+
//			'		<div id="retweet_options_'+user.id+'" style="display:none;">'+
			'			<div class="dashboard-item" onclick="getRetweets('+user.id+', '+RT_BY_ME+', 1);">'+
			'				<span class="ui-icon ui-icon-refresh"></span>'+
			'				<span class="dashboard-item-name">Retweeted By Me</span>'+
			'				<img src="../images/indicator_arrows.gif" alt="Loading" style="display:none;" id="RT_by_me_img_'+user.id+'"/>'+
			'			</div>'+
			'			<div class="dashboard-item"  onclick="getRetweets('+user.id+', '+RT_TO_ME+', 1);">'+
			'				<span class="ui-icon ui-icon-refresh"></span>'+
			'				<span class="dashboard-item-name">Retweeted To Me</span>'+
			'				<img src="../images/indicator_arrows.gif" alt="Loading" style="display:none;" id="RT_to_me_img_'+user.id+'"/>'+
			'			</div>'+
//			'		</div>'+
			'		<div class="dashboard-item"  onclick="getFavorites('+user.id+', 1);">'+
			'			<span class="ui-icon ui-icon-star"></span>'+
			'			<span class="dashboard-item-name">Favorites</span>'+
			'			<img src="../images/indicator_arrows.gif" alt="Loading" style="display:none;" id="favorites_img_'+user.id+'"/>'+
			'		</div>'+
			'		<div class="dashboard-item"  onclick="getFriends('+user.id+', -1, \'following\');">'+
			'			<span class="ui-icon ui-icon-heart"></span>'+
			'			<span class="dashboard-item-name">People You Follow</span>'+
			'			<img src="../images/indicator_arrows.gif" alt="Loading" style="display:none;" id="following_img_'+user.id+'"/>'+
			'		</div>'+
			'		<div class="dashboard-item"  onclick="getFriends('+user.id+', -1, \'followers\');">'+
			'			<span class="ui-icon ui-icon-gear"></span>'+
			'			<span class="dashboard-item-name">Your Followers</span>'+
			'			<img src="../images/indicator_arrows.gif" alt="Loading" style="display:none;" id="followers_img_'+user.id+'"/>'+
			'		</div>'+
			'		<div id="trends_' + user.id + '">'+
			'			<div class="dashboard-item" onclick="javascript:showHideTrends('+ user.id +');">'+
			'				<span class="ui-icon ui-icon-signal"></span>'+
			'				<span class="dashboard-item-name">Trends</span>'+
			'				<img src="../images/indicator_arrows.gif" alt="Loading" style="display:none;" id="trends_img_'+user.id+'"/>'+
		    '				<span id="trends_hide_icon_'+user.id+'" class="ui-icon ui-icon-circle-triangle-s" style="float:right;"></span>'+
			'			</div>'+
			'			<div id="trend_list_'+user.id+'" style="display:none;">'+
			'			</div>'+
			'		</div>'+
			'		<div>' +
			'			<div class="dashboard-item" onclick="showToggleFeeds(' + user.id + ');">' +
			'				<span class="ui-icon ui-icon-signal-diag"></span>' +
			'				<span class="dashboard-item-name">Feeds</span>' +
			'				<img src="../images/indicator_arrows.gif" alt="Loading" style="display:none;" id="feeds_img_' + user.id + '"/>'+
			'			</div>' +
			'			<div id="feeds_' + user.id + '" style="display:none;">' +
			'				<div class="feeds-add">'+
			'					<input type="text" id="feed_new_url"/>'+
			'					<input type="button" value="Add" onclick="addNewFeed(' + user.id + ');"/>'+
			'				</div>' +
			'				<div id="feeds_list_' + user.id + '">' +
			'				</div>' +
			'			</div>' +
			'		</div>' +
			'		<div class="dashboard-item" onclick="javascript:tellFriends('+ user.id +');">'+
			'			<span class="ui-icon ui-icon-comment"></span>'+
			'			<span class="dashboard-item-name">Tell Your Friends</span>'+
			'		</div>'+
			'		<div class="">&nbsp;</div>'+
			'		<div class="">&nbsp;</div>'+
			'		<div class="dashboard-item" onclick="javascript: window.open(\'https://github.com/spundhan/multwiple\', \'\', \'\');">'+
			'			<span class="">'+
			'				<img src="images/github-logo.png"/></span>'+
			'			<span class="dashboard-item-name">'+
			'				Contribute on'+
			'				<img src="images/github-logo-text.png"/></span>'+
			'			</span>'+
			'		</div>'+
			'	</td>'+
			'	<td class="right-tweetboard">'+
			'		<div id="tweetBox">' +
			'			<table class="compose-tweet-table">'+
			'				<tr>'+
			'					<td class="user-img-column" style="width:50px;padding: 0px;">'+
			'						<span id="user_profile_img_'+user.id+'" style="cursor:pointer;" onclick="showUserInfo(0, '+user.id+', \'user\');">'+
			'							<img title="'+user.name+'" src="'+user.img+'"/>'+
			'							<span style="display:none;" id="user'+user.id+'0">'+user.name+'</span>'+
			'						</span>'+
									getUserInfoUI(0, user.id, user, 'user') +
			'					</td>'+
			'					<td class="compose-tweet">'+
			'						<div>' +
			'      						<form class="tweet-form">' +
			'    							<input type="hidden" name="user" value="0" id="friend'+user.id+'_latest"/>' +
			'	    						<input type="hidden" name="user" value="0" id="friend'+user.id+'_count"/>' +
			'   		 					<input type="hidden" name="user" value="0" id="direct'+user.id+'_latest"/>' +
			'	    						<input type="hidden" name="user" value="0" id="direct'+user.id+'_count"/>' +
			'    							<input type="hidden" name="user" value="0" id="mention'+user.id+'_latest"/>' +
			'    							<input type="hidden" name="user" value="0" id="mention'+user.id+'_count"/>' +
			'								<span id="decoded_tweet_'+user.id+'" style="display: none;"></span>'+
			'	   							<textarea id="tweet'+ user.id +'" style="font-size: smaller;" onfocus="hideMsg('+user.id+');" onblur="showMsg('+user.id+');" class="tweet-text-area ui-corner-all" maxlength="140" cols="70" rows="2" class="ui-corner-all" onkeyup="updateChars(this.value,'+ user.id +');"></textarea>'+
			'     						</form>' +
			'						</div>' +
			'						<div id="url_shortner_link" class="tweet-menu">'+
			'							<span class="tweet-menu-item">'+
			'								<a title="Make an Long URL Short." href="javascript:showHideShortenUrl('+user.id+');">URL Shortner</a>'+
			'							</span>'+
			'							<span class="tweet-menu-item">'+
			'								<a title="Add a Map/Event into your Tweet." href="javascript:openPlugin(\''+user.name+'\',\''+URL+'/mapsPhotosPlugin.html\', \'map\');">[+] Map/Event</a>'+
			'							</span>'+
			'							<span class="tweet-menu-item">'+
			'								<a title="Upload an Image/Photo." href="javascript:openPlugin(\''+user.name+'\',\''+URL+'/mapsPhotosPlugin.html\', \'photos\');">[+] Photos</a>'+
			'							</span>'+
			'						</div>'+
			'						<div id="url_shortner_'+user.id+'" class="url-shortner ui-corner-all">'+
			'							<div class="arrow-up"></div>'+
			'							<form method="post" action="" onsubmit="return false;">'+
			'								<table style="margin:0px;">'+
			'									<tr>'+
			'										<td style="vertical-align:middle;">'+
			'											<span>Long URL</span>'+
			'										</td>'+
			'										<td>'+
			'											<input type="text" class="text-box" id="long_url_'+user.id+'" style="width:340px;">'+
			'											<button title="Make It Short" id="url_short_btn_'+user.id+'" onclick="shortenUrl('+user.id+');" class="jui-dark-button">'+
			'												Add'+
			'											</button>'+
			'											<span style="display:none;" id="url_short_img_'+user.id+'">'+
			'												<img style="vertical-align:middle;" src="/images/indicator_arrows_black.gif"/>'+
			'											</span>'+
			'										</td>'+
			'										<td  style="vertical-align:middle;">'+
			'											<span style="float:right; cursor: pointer;" class="ui-icon ui-icon-circle-close" title="close" onclick="showHideShortenUrl('+user.id+');"></span>'+
			'										</td>'+
			'									</tr>'+
			'								</table>'+
			'							</form>'+
			'						</div>'+
			'					</td>'+
			'					<td class="submit-tweet" style="">'+
			'						<div>' +
			' 							<span class="chars_left" id="chars_left'+ user.id +'">140</span>' +
			'						</div>' +
			'						<div>' +
			'							<form class="tweet-submit-form" method="post" action="" onsubmit="return (false);">' +
			'     							<input type="submit" class="ui-state-disabled jui-button" name="update" value="Submit" id="updateButton'+ user.id +'" onclick="tweetUpdate('+ user.id +');" disabled="disabled"/>' +
			'							</form>' +
			'							<span id="updateStatus'+ user.id +'" style="display: none;">Sending &nbsp;<img src="images/indicator_arrows.gif" alt="Updating"/></span>' +
			'						</div>' +
			'					</td>'+
			'					<td style="">'+
			'						<div class="user-stats" id="user_stat_div_'+user.id+'" style="display: none;">'+
			'							<span class="user-stat-span" style="border:0px none;">'+
			'								<span class="user-stat-num" id="following_user_count_'+user.id+'">&nbsp;</span><br/>'+
			'								<span class="user-stat-text">Following</span>'+
			'							</span>'+
			'							<span class="user-stat-span">'+
			'								<span class="user-stat-num" id="followers_user_count_'+user.id+'">&nbsp;</span><br/>'+
			'								<span class="user-stat-text">Followers</span>'+
			'							</span>'+
			'							<span class="user-stat-span">'+
			'								<span class="user-stat-num" id="tweets_count_'+user.id+'">&nbsp;</span><br/>'+
			'								<span class="user-stat-text">Tweets</span>'+
			'							</span>'+
			'							<span class="user-stat-span">'+
			'								<span class="user-stat-num" id="favorites_count_'+user.id+'">&nbsp;</span><br/>'+
			'								<span class="user-stat-text">Favorites</span>'+
			'							</span>'+
			'						</div>'+
			'					</td>'+
			'				</tr>'+
			'			</table>'+
			'		</div>' +
			'		<div class="container tweet-container">' +
			'			<ul class="sortable-list" id="sortable_boxes_'+user.id+'">'+
			'				<li id="friend_list_'+user.id+'">'+
			' 					<div id="container_friend'+user.id+'" class="span-7">' +
			' 		 				<div class="tweetMsgs ui-corner-all" id="friend'+ user.id +'"></div>' +
			'					</div>' +
			'				</li>'+
			'				<li id="direct_list_'+user.id+'">'+
			' 					<div id="container_direct'+user.id+'"  class="span-7">' +
			' 						<div class="tweetMsgs ui-corner-all" id="direct'+ user.id +'"></div>' +
			' 					</div>' +
			'				</li>'+
			'				<li id="mention_list_'+user.id+'">'+
			' 					<div id="container_mention'+user.id+'" class="span-7">' +
			' 						<div class="tweetMsgs ui-corner-all" id="mention'+ user.id +'"></div>' +
			' 					</div>' +
			'				</li>'+
							buildTweetBox(user, 'retweet', 'Retweets') +
							buildTweetBox(user, 'favorite', 'Favorites')+
							buildTweetBox(user, 'search', 'Results') +
							buildTweetBox(user, 'following', 'People You Follow') +
							buildTweetBox(user, 'followers', 'Your Followers') +
							buildTweetBox(user, 'trends', 'Trends') +
							buildTweetBox(user, 'mt_feeds', 'Feeds') +
			'			</ul>'+
			'		</div>' +
			'	</td>'+
			'</tr>'+
			'</table>'+
			'</div>';

	$("#tabs").append(code);
	var $tabs = $('#tabs').tabs();
	var selected = $tabs.tabs('option', 'selected');
	var user_image = '<img class="user-icon" src="'+user.img+'"/>';
	$tabs.tabs("add", "#user"+user.id, user_image+user.name, selected);
	$tabs.tabs("select", selected);
	
	updateFriendTweets(user);
	updateMentions(user);
	updateDirects(user);
	getUserStat(user);
	makeBoxesSortable(user);
	showMsg(user.id);
}

/*logging in user*/
function loginAddOnUser(){ 
	var username = $('#username2').val();
	var password = $('#password2').val();
	$.post("/s/login",
	  {
		"username" : username,
		"password" : password, 
		"type" : "false" 
	  },
		function(response) { 
			if(response.success) { 
				 loginAddOnSuccess(username);
			}
			else {
				$("#loginError2").show(); 
			}
		},
			"json"
	);
}

/*logging in user*/
function loginUser(){ 
	$.get("http://localhost:8090/s/login",
	  {},
		function(response) { 
		  	alert("data: " + response.data);
			if(response.success) { 
				$("#member").show();
				$("#mpanel").show();
				$("#mainBody").hide();
				loginAddOnSuccess(response.username);
			}
			else {
				$("#loginError").show(); 
			}
		},
			"json"
	);
}

function getCookie(c_name) {
//	alert("Finding " + c_name + ": cookies= " + document.cookie);
	if (document.cookie.length>0) {
		c_start = document.cookie.indexOf(c_name + "=");
		if (c_start!=-1) {
			c_start=c_start + c_name.length+1;
			c_end=document.cookie.indexOf(";",c_start);
			if (c_end==-1)
				c_end=document.cookie.length;
//			alert("found: " + document.cookie);
			return unescape(document.cookie.substring(c_start,c_end));
		}
	} 
//	alert("not found");
	return "";
}



function makeBoxesSortable(user) {
	
	$(".sortable-list").sortable (
									{
										handle 		: '.tweet-header',
										revert		: true,
										opacity		: 0.7
									}
								 );
	
	$(".sortable-list").disableSelection();
}

function buildTweetBox(user, type, header) {
	code =
			'<li id="'+type+'_list_'+user.id+'" style="display:none;">'+
			'	<div id="container_'+ type + user.id +'" class="span-7">' +
			' 		<div class="tweetMsgs ui-corner-all" id="'+ type + user.id +'">' +
			'			<div class="tweettitle ui-widget-header ui-corner-all">'+
			'				<span class="ui-icon '+icons[type]+'"></span>'+
			'				<span class="tweet-header" id="'+type+'_header_'+user.id+'">'+header+'</span>'+
			'				<span class="close-icon">'+
			'					<a href="javascript:hideTweetBox(\''+type+'\', '+user.id+');">'+
			'						<span id="'+type+'_close_icon_'+ user.id +'" class="ui-icon ui-icon-close" onmouseover="changeCloseIcon(\''+type+'\','+user.id+');" onmouseout="changeCloseIcon(\''+type+'\','+user.id+');" unselectable="on"></span>'+
			'					</a>'+										
			'				</span>'+
			'			</div>'+
			'			<div class="scrollable" id="'+type+'_container_'+user.id+'"></div>'+
			'			<div class="paginate '+type+'-paginate-'+user.id+'">'+
			'				<table>'+
			'					<tr>'+
			'						<td style="width:90px;">'+
			'							<span style="float:left;"> '+
			'								<a id="new_'+type+'_link_'+user.id+'" style="display:none;" href=""> << Previous</a>'+
			'								<img src="../images/indicator_arrows.gif" style="display:none;" id="new_'+type+'_load_'+user.id+'" alt=""/>'+
			'							</span>'+
			'						</td>'+
			'						<td style="text-align:center;font-weight:bold;">'+
			'							<span id="'+type+'_page_no_'+user.id+'">1</span>'+
			'						</td>'+
			'						<td style="width:90px;">'+
			'							<span style="float:right;"> '+
			'								<img src="../images/indicator_arrows.gif" style="display:none;" id="old_'+type+'_load_'+user.id+'" alt=""/>'+
			'								<a id="old_'+type+'_link_'+user.id+'" href="">Next >> </a>'+
			'							</span>'+
			'						</td>'+
			'					</tr>'+
			'				</table>'+
			'			</div>'+
			'		</div>'+
			' 	</div>' +
			'</li>';
	return code;
}
