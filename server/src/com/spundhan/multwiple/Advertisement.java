package com.spundhan.multwiple;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Advertisement extends HttpServlet {

	private static final long	serialVersionUID	= 1593999942935576008L;
	DB db;
	Connection connection;
	
	@Override
	public void init() throws ServletException {
		db = new DB();
		connection = db.getConnection();
		super.init();
	}
	
	@Override
	public void destroy() {
		try {
			connection.close();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		super.destroy();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		
		// Log the event.
		db.logs(0, "New User", Constants.ADVERTISEMENT, "Schmap.it Advertisement");
		
		String html = 
		"<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">"+
		"<html>"+
		"<head>"+
		"	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"+
		"	<title>Multwiple</title>"+
		"	<style type=\"text/css\">"+
		"		#advertisement-body {"+
		"			font-family: Verdana, Arial, Helvetica, sans-serif;"+
		"			height: 75px;"+
		"			width: 522px;"+
		"			overflow: hidden;"+	
		"			padding: 0px;"+
		"			margin: 0px;"+
		"			cursor: pointer;"+
		"			background: #222;"+
		"		}"+
		"		#advertisement-text {"+
		"			font-size: small;"+
		"			padding: 5px;"+
		"			background: #FFF;"+
		"			-moz-border-radius: 3px;"+ 	
		"			-webkit-border-radius: 3px;"+ 	
		"			border-radius: 3px;"+ 	
		"		}"+
		"		#advertisement-table td {"+
		"			vertical-align: middle;"+
		"		}"+
		"	</style>"+
		"	<script type=\"text/javascript\">"+
		"		function openHomePage() {"+
		"			var newWindow = window.open('http://multwiple.com');"+
		"			newWindow.focus();"+
		"		}"+
		"	</script>"+	
		"</head>"+
		"<body id=\"advertisement-body\" onclick=\"javascript:openHomePage();\">"+
		"	<div id=\"advertisement\">"+
		"		<table id=\"advertisement-table\">"+
		"			<tr>"+
		"				<td>"+
		"					<img alt=\"Multwiple Logo\" src=\"/images/logo.png\">"+
		"				</td>"+
		"				<td>"+
		"					<div id=\"advertisement-text\">"+
		"						Multwiple is a web based twitter client. Managing multiple twitter accounts is easier than you think. Its fun too."+
		"					</div>"+
		"				</td>"+
		"			</tr>"+
		"		</table>"+
		"	</div>"+
		"</body>"+
		"</html>";
		out.print(html);
		out.close();
	}
}
