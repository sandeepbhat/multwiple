$(document).ready (
	function() {
		getUsers();
	}
);

function getUsers() {
	$.post("/s/getUsers", 
			{}, 
			function(response) {
				if(response.success) {
					var id = 0;
					var code = '';
					for(id in response.users) {
						var user = response.users[id];
						code += '<li>'+
								'	<a href="javascript:getStatistics(\''+user.name+'\');">'+user.name+'</a>'+
								'</li>';
					}
					$("#user_list").append(code);
				}
			}, 
		"json"
	);
}

function plotGraphs(table_id) {
	$("#"+table_id).visualize(
			{
				type	: 'line',
				height	: 300,
				width	: 1000
			}
	);
}

function getStatistics(username) {
	$.post("/s/getStatistics", 
			{
				"username" : username 
			}, 
			function(response) {
				if(response.success) {
					
					var statistics = response.statistics;
					var table; 

					table = buildGraphTable(statistics.sign_in);
					$("#sign_in").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}

					table = buildGraphTable(statistics.added_new_account);
					$("#added_new_account").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}


					table = buildGraphTable(statistics.delete_user);
					$("#delete_user").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}
					
					table = buildGraphTable(statistics.settings);
					$("#settings").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}
					

					table = buildGraphTable(statistics.RT_by_user);
					$("#RT_by_user").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}
					
					table = buildGraphTable(statistics.RT_to_user);
					$("#RT_to_user").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}
					

					table = buildGraphTable(statistics.RT_wc);
					$("#RT_wc").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}
					
					table = buildGraphTable(statistics.RT_woc);
					$("#RT_woc").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}
					

					table = buildGraphTable(statistics.tweet);
					$("#tweet").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}

					table = buildGraphTable(statistics.dm);
					$("#dm").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}


					table = buildGraphTable(statistics.search);
					$("#search").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}

					table = buildGraphTable(statistics.trends);
					$("#trends").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}

					
					table = buildGraphTable(statistics.follow_user);
					$("#follow_user").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}
					
					table = buildGraphTable(statistics.unfollow_user);
					$("#unfollow_user").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}
					

					table = buildGraphTable(statistics.mark_faorite);
					$("#mark_favorite").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}

					table = buildGraphTable(statistics.unmark_favorite);
					$("#unmark_favorite").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}


					table = buildGraphTable(statistics.followers);
					$("#followers").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}

					table = buildGraphTable(statistics.following);
					$("#following").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}

					
					table = buildGraphTable(statistics.favorites);
					$("#favorites").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}

					table = buildGraphTable(statistics.user_info);
					$("#user_info").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}

					
					table = buildGraphTable(statistics.url_shortener);
					$("#url_shortener").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}
					
					table = buildGraphTable(statistics.follow_url);
					$("#follow_url").html(table.code);
					if(table.id != 0) {
						plotGraphs(table.id);
					}

				}
			}, 
		"json"
	);
}


function buildGraphTable(statistic) {
	if(statistic.length == 0) {
		return {"code": "", "id": 0};
	}
	
	var th = '';
	var tr = '';
	
	for(var i in statistic) {
		if(i == 0) {
//			tr += '<th scope="row">'+statistic[i].action+'</th>';
		}
		tr += '	<td>'+statistic[i].count+'</td>';
		th += '<th scope="col">'+statistic[i].date+'</th>';
	}
	
	var code =	'<table id="table_'+statistic[0].actionId+'" style="display:none; width:100%;">'+
				'	<caption class="table-caption">'+statistic[0].action+'</caption>'+
				'	<thead>'+
				'		<tr>'+
				'			<td></td>'+
							th +
				'		</tr>'+
				'	</thead>'+
				'	<tbody>'+
						tr +
				'	</tbody>'+
				'</table>';
	
	return {"code": code, "id":'table_'+statistic[0].actionId};
}

