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
	 $('#s3slider').s3Slider (
		 { 
			 timeOut: 6000 
		 }
	 );

	var errMsg = getUrlParam("error");
	if(errMsg != null && errMsg.length > 0){
		alert("Ooops! Twitter is down. Please try again later!");
		return;
	}
	
	if(login_state.success) {
		var users = login_state.users;
//		alert("Users: " + users);
		if(users != null && users.length > 0) {
			document.location = '/login.html';
			return;
		}
	}
});


/* 
 * When page is refreshed make sure that it does not have any params
 */
function checkRefresh()	{
	var errMsg = getUrlParam("error");
	if(errMsg != null && errMsg.length > 0) {
		document.location = '/index.html';
		return;
	}
}
