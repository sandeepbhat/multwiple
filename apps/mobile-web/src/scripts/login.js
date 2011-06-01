var RT_BY_ME = 1;
var RT_TO_ME = 2;
var icons = {
				"retweet"	: "ui-icon-refresh", 
				"search"	: "ui-icon-search", 
				"favorite"	: "ui-icon-star", 
				"following"	: "ui-icon-heart",
				"followers"	: "ui-icon-gear",
				"trends"	: "ui-icon-signal-diag"
			};

function loginAddOnSuccess(user){
	var code = 	'<td id="tab_'+user.id+'" onclick="javascript:selectTab('+user.id+');">'+
			 	'	<a href="#user_'+user.id+'">'+
			 	'		<img src="'+user.img+'" alt="'+user.name+'"/>'+
			 	'	</a>'+
			 	'</td>';
	$("#tabs").prepend(code);
	
	code = 	'<div class="tweet-container" id="user_'+user.id+'">'+
			'	<form action="" method="" style="display:none;">'+
			'		<input type="hidden" value="0" id="latest_home_'+user.id+'"/>'+
			'		<input type="hidden" value="0" id="latest_mention_'+user.id+'"/>'+
			'		<input type="hidden" value="0" id="latest_direct_'+user.id+'"/>'+
			'		<span id="decoded_tweet_'+user.id+'"></span>'+
			'	</form>'+
				buildTopMenu(user.id) +
			'	<div class="tweet-box-'+user.id+' tweet-box"  id="home_container_'+user.id+'">'+
			'		<div class="section">Home</div>'+
			'		<div id="home_'+user.id+'"></div>'+
			'	</div>'+
			'	<div  class="tweet-box-'+user.id+' tweet-box" id="mention_container_'+user.id+'">'+
			'		<div class="section">Mentions</div>'+
			'		<div id="mention_'+user.id+'"></div>'+
			'	</div>'+
			'	<div class="tweet-box-'+user.id+' tweet-box" id="direct_container_'+user.id+'">'+
			'		<div class="section">DM</div>'+
			'		<div id="direct_'+user.id+'"></div>'+
			'	</div>'+
			'	<div class="tweet-box-'+user.id+' tweet-box" id="RT_by_me_container_'+user.id+'">'+
			'		<div class="section">Retweets By You</div>'+
			'		<div id="RT_by_me_'+user.id+'"></div>'+
			'	</div>'+
			'	<div class="tweet-box-'+user.id+' tweet-box" id="RT_to_me_container_'+user.id+'">'+
			'		<div class="section">Retweets To You</div>'+
			'		<div id="RT_to_me_'+user.id+'"></div>'+
			'	</div>'+
			'	<div class="tweet-box-'+user.id+' tweet-box" id="favorite_container_'+user.id+'">'+
			'		<div class="section">Favorites</div>'+
			'		<div id="favorite_'+user.id+'"></div>'+
			'	</div>'+
			'	<div class="tweet-box-'+user.id+' tweet-box" id="followers_container_'+user.id+'">'+
			'		<div class="section">Your Followers</div>'+
			'		<div id="followers_'+user.id+'"></div>'+
			'	</div>'+
			'	<div class="tweet-box-'+user.id+' tweet-box" id="following_container_'+user.id+'">'+
			'		<div class="section">Peoplw You Follow</div>'+
			'		<div id="following_'+user.id+'"></div>'+
			'	</div>'+
			'	<div class="tweet-box-'+user.id+' tweet-box" id="trends_container_'+user.id+'">'+
			'		<div class="section">Trends</div>'+
			'		<div id="trends_'+user.id+'">'+
			'			<div style="margin: 5px 0 0 0;" id="trend_list_'+user.id+'"></div>'+
			'			<div style="margin: 10px 0 0 0;" id="trend_result_'+user.id+'"></div>'+
			'		</div>'+
			'	</div>'+
			'	<div class="tweet-box-'+user.id+' tweet-box" id="search_container_'+user.id+'">'+
			'		<div class="section">Search</div>'+
			'		<div id="search_'+user.id+'">'+
			'			<div style="text-align:center; padding-top:5px;">'+
			'				<form method="post" action="" onsubmit="return false;">'+
			'					<input style="margin:0 0 0 5px; width:70%;" type="text" '+
			'						onblur="return(this.value == \'\' ? this.value = \'Search\': this.value = this.value);" '+
			'						onfocus="this.value = \'\';" '+
			'						class="text-box" id="search_key_'+user.id+'" value="Search"/>'+
			'					<input type="submit" class="jui-button" value="Go" onclick="startNewSearch('+user.id+');"/>'+
			'				</form>'+
			'			</div>'+
			'			<div id="search_result_'+user.id+'"></div>'+
			'		</div>'+
			'	</div>'+
			'	<div class="tweet-box-'+user.id+' tweet-box" id="tweet_container_'+user.id+'">'+
			'		<div class="section">Tweet</div>'+
			'		<div id="tweet_'+user.id+'" style="margin: 5px 0px 0px 0px;text-align:center;">'+
			'			<form class="tweet-submit-form" method="post" action="" onsubmit="return (false);">' +
			'				<span id="decoded_tweet_'+user.id+'" style="display: none;"></span>'+
			'				<textarea id="user_tweet'+ user.id +'0" style="font-size: smaller;" class="text-box" maxlength="140" cols="70" rows="2" onkeyup="updateChars(this.value,'+ user.id +', \'user\', 0);"></textarea>'+
			'				<div style="margin:10px 0px 0px 0px; text-align:right;width:90%;">' +
			' 						<span class="chars_left" id="user_chars_left'+ user.id +'0">140</span>' +
			'     					<input type="button" class="ui-state-disabled jui-button" name="update" value="Submit" id="user_updateButton'+ user.id +'0" onclick="tweetUpdate(\'user\','+ user.id +', 0);" disabled="disabled"/>' +
			'						<span id="user_updateStatus'+ user.id +'0" style="display: none; color:#eee;">Sending &nbsp;<img src="images/indicator_arrows_black.gif" alt="Updating"/></span>' +
			'				</div>' +
			'			</form>' +
			'		</div>'+
			'	</div>'+
				buildMainMenu(user.id)+
			'</div>';
	
	$("#panel").append(code);
	
	selectTab(user.id);
	
	$("#home_"+user.id).html('');
	$("#direct_"+user.id).html('');
	$("#mention_"+user.id).html('');
//	updateHome(user);
//	updateMentions(user);
//	updateDirects(user);
	updateChars('', user.id);
	showTweetBox(user.id, 'home');
}

function getCookie(c_name) {
	if (document.cookie.length>0) {
		c_start = document.cookie.indexOf(c_name + "=");
		if (c_start!=-1) {
			c_start=c_start + c_name.length+1;
			c_end=document.cookie.indexOf(";",c_start);
			if (c_end==-1)
				c_end=document.cookie.length;
			return unescape(document.cookie.substring(c_start,c_end));
		}
	} 
	return "";
}



function buildTopMenu(userId) {
	var code = 	'<div id="top_menu_'+userId+'">'+
				'	<table style="width: 100%; margin: 0; padding:0;" cellpadding="0" cellspacing="0">'+
				'		<tr>'+
				'			<td class="header">'+
				'				<a href="javascript:showTweetBox('+userId+', \'menu\');">'+
				'					<span class="ui-icon ui-icon-lightbulb"></span>'+
				'				</a>'+
				'			</td>'+
				'			<td class="header">'+
				'				<a href="javascript:showTweetBox('+userId+', \'tweet\');">'+
				'					<span class=""><img src="../images/tweet-icon-32.png" alt="tweet" title="Tweet"/></span>'+
				'				</a>'+
				'			</td>'+
				'			<td class="header">'+
				'				<a href="javascript:showTweetBox('+userId+', \'home\');">'+
				'					<span class="ui-icon ui-icon-home"></span>'+
				'				</a>'+
				'			</td>'+
				'			<td class="header">'+
				'				<a href="javascript:showTweetBox('+userId+', \'mention\');">'+
				'					<span class="">@</span>'+
				'				</a>'+
				'			</td>'+
				'			<td class="header">'+
				'				<a href="javascript:showTweetBox('+userId+', \'direct\');">'+
				'					<span class="ui-icon ui-icon-mail-closed"></span>'+
				'				</a>'+
				'			</td>'+
				'			<td class="header">'+
				'				<a href="javascript:showTweetBox('+userId+', \'search\');">'+
				'					<span class="ui-icon ui-icon-search"></span>'+
				'				</a>'+
				'			</td>'+
				'		</tr>'+
				'	</table>'+
				'</div>';
	return code;
}

function buildMainMenu(userId) {
	var code = 	'<div id="menu_container_'+userId+'" class="tweet-box-'+userId+' tweet-box main-menu" style="display:none;">'+
				'	<div class="main-menu-item" onclick="openSettings();">Settings</div>'+
				'	<div class="main-menu-item" onclick="refresh('+userId+');">Get Tweets Now</div>'+
				'	<div class="main-menu-item" onclick="getRetweet('+userId+', false, 1);">Retweet To Me</div>'+
				'	<div class="main-menu-item" onclick="getRetweet('+userId+', true, 1);">Retweet By Me</div>'+
				'	<div class="main-menu-item" onclick="getFavorites('+userId+', 1);">Favorites</div>'+
				'	<div class="main-menu-item" onclick="getTrends('+userId+');">Trends</div>'+
				'	<div class="main-menu-item" onclick="getFriends( '+userId+', -1 ,\'following\');">People You Follow</div>'+
				'	<div class="main-menu-item" onclick="getFriends( '+userId+', -1, \'followers\');">Your Followers</div>'+
				'	</div>'+
				'</div>';
	return code;
}

function selectTab(userId) {
	
	//Dont do anything is selected tab is clicked
	if(g_selected_user_id == userId) {
		return;
	}
	
	//Hide all tweet conatiners
	$(".tweet-container").hide();
	
	//Stop Currently running Auto Updates...
	stopAutoUpdates();

	//Now select the tab & show the corresponding tweet container
	$("#tabs td").each (
		function() {
			if($(this).attr('id') == 'tab_'+userId) {
				$(this).removeClass('tab tab-off');
				$(this).addClass('tab tab-on');
				$("#user_"+userId).show();
				g_selected_username = '';
				g_selected_user_id = 0;
				
				if(userId != 0) {
					for(i in login_state.users) {
						var user = login_state.users[i]; 
						if(user.id == userId) {
							g_selected_username = user.name;
							g_selected_user_id = user.id;	
						}
					}
					updateHome(user);
					updateDirects(user);
					updateMentions(user);
				}
			}
			else {
				$(this).removeClass('tab tab-on');
				$(this).addClass('tab tab-off');
			}
		}
	);
}