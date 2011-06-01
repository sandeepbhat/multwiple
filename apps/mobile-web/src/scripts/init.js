var g_tabs_count = 1;
var g_user_list;
var g_selected_user_id = 0;
var g_selected_username = '';

$(document).ready(
	function () {

		/* login_state is set by the first /s/getlogin call. 
		 * If the user has not logged in dont show him the setting buttons.
		 * Return. 
		 * */ 
		if(!login_state.success) {
			document.location = '/index.html';
			return;
		}

		/*If the user has logged in...*/	
		var users = login_state.users;


		//If the cookie is not set then return...
		if(users == null || users == "[]" || users == "") {
			document.location = '/index.html';
			return;
		}

		g_user_list = users;

		//Get the update interval for auto-update
		UPDATE_INTERVAL = login_state.interval * 60 * 1000;

		var index;
		
		var user;

		//Add a tab for every user.
		for (index in users) {
			user = users[index];
			loginAddOnSuccess(user);
		}

		g_selected_user_id = user.id;
		g_selected_username = user.name;
	}
);

