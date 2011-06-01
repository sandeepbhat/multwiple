package com.spundhan.multwiple;

import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.SendFailedException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.sun.mail.smtp.SMTPAddressFailedException;
import com.sun.mail.smtp.SMTPAddressSucceededException;
import com.sun.mail.smtp.SMTPSendFailedException;

public class EmailThread extends Thread {
	private static String SMTP_HOST_NAME = "smtp.gmail.com";
	private static int SMTP_HOST_PORT = 465;
	private static String SMTP_AUTH_USER = "no-reply@spundhan.com";
	private static String SMTP_AUTH_PWD  = "AEKjhr748otype";
//	private static String SMTP_FROM_ADDR = "Multwiple Notifier";
	private String[] emailList = {"ameet.patil@spundhan.com"};
	private String body;

	public EmailThread(String localIP, String remoteIP, String remoteHost, String purpose){
		this.body = "Multwiple Server @ "+ localIP +":\n\nIP: " + remoteIP + "\nHost: " + remoteHost + "\nPurpose: " + purpose;
	}

	@Override
	public void run() {
		
		if(emailList.length == 0 || body.equals("")){
			return; 
		}
		Properties props = new Properties();

		props.put("mail.transport.protocol", "smtps");
		props.put("mail.smtps.host", SMTP_HOST_NAME);
		props.put("mail.smtps.auth", "true");

		Session mailSession = Session.getDefaultInstance(props, null);

		try {

			Message message =new MimeMessage(mailSession);
//			Address[] from = { new InternetAddress(SMTP_AUTH_USER), SMTP_FROM_ADDR};
			message.setFrom(new InternetAddress(SMTP_AUTH_USER));

			Address[]  emails = new Address[emailList.length];
			int i = 0;
			for (String email : emailList) {
				emails[i++] = new InternetAddress(email);
				System.err.println("Sending mail: <<Multwiple: Usage log >>to " + email);
			}
			message.addRecipients(Message.RecipientType.TO, emails);

			message.setSubject("Multwiple: Usage log.");
			message.setSentDate(new Date());
			message.setContent(body, "text/plain");        

			Transport transport = mailSession.getTransport();

			transport.connect (SMTP_HOST_NAME, SMTP_HOST_PORT, SMTP_AUTH_USER, SMTP_AUTH_PWD);
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();

		} catch (Exception e) {
			/*
			 * Handle SMTP-specific exceptions.
			 */
			if (e instanceof SendFailedException) {
				MessagingException sfe = (MessagingException)e;
				if (sfe instanceof SMTPSendFailedException) {
					SMTPSendFailedException ssfe =
						(SMTPSendFailedException)sfe;
					System.out.println("SMTP SEND FAILED:");
					System.out.println(ssfe.toString());
					System.out.println("  Command: " + ssfe.getCommand());
					System.out.println("  RetCode: " + ssfe.getReturnCode());
					System.out.println("  Response: " + ssfe.getMessage());
				} else {
					System.out.println("Send failed: " + sfe.toString());
				}
				Exception ne;
				while ((ne = sfe.getNextException()) != null &&
						ne instanceof MessagingException) {
					sfe = (MessagingException)ne;
					if (sfe instanceof SMTPAddressFailedException) {
						SMTPAddressFailedException ssfe =
							(SMTPAddressFailedException)sfe;
						System.out.println("ADDRESS FAILED:");
						System.out.println(ssfe.toString());
						System.out.println("  Address: " + ssfe.getAddress());
						System.out.println("  Command: " + ssfe.getCommand());
						System.out.println("  RetCode: " + ssfe.getReturnCode());
						System.out.println("  Response: " + ssfe.getMessage());
					} else if (sfe instanceof SMTPAddressSucceededException) {
						System.out.println("ADDRESS SUCCEEDED:");
						SMTPAddressSucceededException ssfe =
							(SMTPAddressSucceededException)sfe;
						System.out.println(ssfe.toString());
						System.out.println("  Address: " + ssfe.getAddress());
						System.out.println("  Command: " + ssfe.getCommand());
						System.out.println("  RetCode: " + ssfe.getReturnCode());
						System.out.println("  Response: " + ssfe.getMessage());
					}
				}
			} else {
				System.out.println("Got Exception: " + e);
				e.printStackTrace();
			}
		}

	}
}
