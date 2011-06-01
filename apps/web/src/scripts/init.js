var g_tabs_count = 1;
var g_user_list;
var g_selected_user_id = 0;
var g_selected_user_name = '';

function getUrlParam(param) {
	param = param.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
	var regexS = "[\\?&]"+param+"=([^&#]*)";
	var regex = new RegExp( regexS );
	var results = regex.exec(window.location.href);
	if( results == null ) {
		return "";
	}
	else {
		return results[1];
	}
}

$(document).ready(function () {
	
	//Hide the Settings panel onload...
	$("#settings_panel").hide();
	
	/* multwiple */
//	$("#newUser").html('<div class="container"><hr class="space"/><hr class="space"/>' + $("#mainBody").html() + '<hr class="space"/><hr class="space"/></div>');
	$("#tabs").tabs();
	

	/* login_state is set by the first /s/getlogin call. 
	 * If the user has not logged in dont show him the setting buttons.
	 * Return. 
	 * */ 
	if(!login_state.success) {
		$("#settings_panel").hide();
		document.location = '/index.html';
		return;
	}
	
	/*If the user has logged in...*/	
	
	//Parse the userList & get the JavaScript JSON
	var users = login_state.users;

	//If the cookie is not set then return...
	if(users == null || users == "[]" || users == "") {
		$("#settings_panel").hide();
		document.location = '/index.html';
		return;
	}
	
	//Init settings dialog
	$("#settings_dialog").dialog (
									{
										autoOpen		: false,
										title 			: "Settings",
										width 			: 500,
										closeOnEscape	: true,
										resizable		: false,
										modal 			: true,
										buttons			: 
															{
																"Cancel"	: function() { $(this).dialog('close');},
																"Save" 		: function() { setSettings(); }
															}
									}
							     );

	//Get the user group ID
	login_state.gid = getCookie("usergid");
	
	//Get the session
	login_state.session = getCookie("session");
	
	g_user_list = users;
		
	//Get the update interval for auto-update
	UPDATE_INTERVAL = parseInt(getCookie("interval")) * 60 * 1000;
		
	$("#member").show();
	//$("#mpanel").show();
	$("#mainBody").hide();
	$("#settings_panel").show();
		
	var index;
	var user;
	
	//Add a tab for every user.
	for (index in users) {
		user = users[index];
		loginAddOnSuccess(user);
	}
		
	//Set a tabsselect event for the tabs... auto-updates are enabled for the selected tabs only...
	$("#tabs").bind('tabsselect', 
							function(event, ui) {
								//Get the anchor element of the selected tab
								var href =  $(ui.tab).attr('href');
								
								g_selected_user_id = 0;
									
								//If the tab is for adding new account dont do anything
								if(href == "#newUser") {
									$("#newUserForm").submit();
//									$("#settings_panel").hide();
									return;
								}
								
								$("#settings_panel").show();
								
								//Get the User ID from the tab's href... Eg: href = #user32
								var userId = parseInt(href.substring(5, href.length));

								g_selected_user_id = userId;
								
								var i = 0;
								for(i in g_user_list) {
									if(g_user_list[i].id == g_selected_user_id) {
										g_selected_user_name = g_user_list[i].name;
									}
								}

								//Stop all the updates & update Now....
								stopAutoUpdates('a');

								//Update New Friend Tweets Immediately 
								getNewFriendUpdates(userId);
								
								//Update New Mentions Immediately 
								getNewMentions(userId);
								
								//Update New Directs Immediately 
								getNewDirects(userId);
							}
						);
		
	//Start auto-updates for last added tab... which will be initially visible
	startAutoUpdates(user.id, 'a');

	g_selected_user_id = user.id;
	g_selected_user_name = user.name;
	
	var errMsg = getUrlParam("error");
	if(errMsg != null && errMsg.length > 0){
		alert("Ooops! Twitter is down. Please try again later!");
//		document.location = '/login.html';
		return;
	}
});

/* 
 * When page is refreshed make sure that it does not have any params
 */
function checkRefresh()	{
	var errMsg = getUrlParam("error");
	if(errMsg != null && errMsg.length > 0) {
		document.location = '/login.html';
		return;
	}
}

