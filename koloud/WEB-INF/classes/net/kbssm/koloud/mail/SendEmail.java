package net.kbssm.koloud.mail;

import java.io.IOException;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.util.List;
import java.util.Properties;
import java.util.Random;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import net.kbssm.koloud.Server.Server;
import net.kbssm.koloud.Server.ServerConvert;
import net.kbssm.koloud.User.UserConvert;

public class SendEmail {
	MailConvert mc = new MailConvert();
	
	public SendEmail() {
		super();
	}

	public void defType(String name, String receiver,String type) throws IOException{
		String subject = "";
		String content = "";
		String sender = "koloudcloud@gmail.com";
		
		if(type.equals("register")){
			subject = "Welcome To Koloud Service!";
			content = "<h3>Welcome To Koloud Service!</h3>"+
			                  "Hey! "+name+", you'll be able to create own free server!<br>"+
			                  "Your id is "+receiver+"<br>"+
			                  "Enter the service and get your server now!<br>";
			
		
		}
		else if(type.equals("requestServer")){
			ServerConvert sv = new ServerConvert(); //create with waiting
			List<Server> ls = sv.getServerList();
			UserConvert uc = new UserConvert();
			
			String os = "";
			long cpu = 0;
			long ram = 0;
			long disk = 0;
			
			for(int i=1;i<ls.size();i++){
				if(ls.get(i).getId() == uc.getId(name)){
					os = ls.get(i).getOs();
					cpu = ls.get(i).getCpu();
					ram = ls.get(i).getRam();
					disk = ls.get(i).getDisk();
				}
					
			}
			subject = "You requested server!";
 			content = "<h3>Sended your requested server successfully!</h3>"+
 			                  "Hey! "+name+", you'll be able to use your own free server!<br>"+
 			                  "Here is your requested server infomation.<br>"+
 			                  "OS : "+os+"<br>"+
 			                  "CPU : "+cpu+" v Core<br>"+
 			                  "RAM : "+ram+" MB<br>"+
 			                  "HDD : "+disk+" GB<br>"+
 			                  "Enter the service and use your server<br>";
 			
		}
		else if(type.equals("requestAccept")){
			ServerConvert sv = new ServerConvert(); //create with waiting
			List<Server> ls = sv.getServerList();
			UserConvert uc = new UserConvert();
			
			String os = "";
			long cpu = 0;
			long ram = 0;
			long disk = 0;
			
			for(int i=1;i<ls.size();i++){
				if(ls.get(i).getId() == uc.getId(name)){
					os = ls.get(i).getOs();
					cpu = ls.get(i).getCpu();
					ram = ls.get(i).getRam();
					disk = ls.get(i).getDisk();
				}
					
			}

			subject = "Now you can use your requested server!";
			content = "<h3>Accepted your requested server !</h3>"+
			                  "Hey! "+name+", you'll be able to use your own free server!<br>"+
			                  "Here is your server infomation.<br>"+
			                  "OS : "+os+"<br>"+
			                  "CPU : "+cpu+" v Core<br>"+
			                  "RAM : "+ram+" MB<br>"+
			                  "HDD : "+disk+" GB<br>"+
			                  "Enter the service and use your server<br>";
			
		}
		else if(type.equals("requestDeny")){
			ServerConvert sv = new ServerConvert(); //create with waiting
			List<Server> ls = sv.getServerList();
			UserConvert uc = new UserConvert();
			
			String reason = "";
			
			for(int i=1;i<ls.size();i++){
				if(ls.get(i).getId() == uc.getId(name)){
					reason = ls.get(i).getReason();
				}
			}
			
			subject = "Your request is Denied";
 			content = "<h3>Unfortunately your request has denied</h3>"+
 			                  "Hey! "+name+", you'll be unable to use your own server<br>"+
 			                  "Here is your reason why request is denied<br>"+
 			                  "REASON : "+reason+"<br>"+
 			                  "Enter the service and use our service again!<br>";
		}
		else if(type.equals("changePw")){
			Random RANDOM = new SecureRandom();
			int PASSWORD_LENGTH = 8;
			
			String letters = "abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ23456789+@";
			
			String pw = "";
			for (int i=0; i<PASSWORD_LENGTH; i++)
			{
			int index = (int)(RANDOM.nextDouble()*letters.length());
			pw += letters.substring(index, index+1);
			}
			
			
			subject = "Temporary Password!";
			content = "<h3>You've recieved Temporary Password</h3>"+
					"Hey "+name+", you've got temporary password!<br>"+
					"Enter the temporary password, and please change your password.<br>" +
					"Password is <i>["+pw+"]";

			UserConvert cv = new UserConvert();
			cv.updateUserList(name, pw);
		}
		else if(type.equals("requestCancled")){
			ServerConvert sv = new ServerConvert(); //create with waiting
			List<Server> ls = sv.getServerList();
			UserConvert uc = new UserConvert();
			
			String reason = "";
			
			for(int i=1;i<ls.size();i++){
				if(ls.get(i).getId() == uc.getId(name)){
					reason = ls.get(i).getReason();
				}
			}
			
			subject = "Virtual OS service has stopped";
 			content = "<h3>Unfortunately virtual OS service has stopped</h3>"+
 			                  "Hey! "+name+", you'll be unable to use your own server no more<br>"+
 			                  "Here is your reason why service is stopped<br>"+
 			                  "REASON : "+reason+"<br>"+
 			                  "Enter the service and use our service again!<br>";
		}
		else if(type.equals("makeServer")){
			ServerConvert sv = new ServerConvert(); //create with waiting
			List<Server> ls = sv.getServerList();
			UserConvert uc = new UserConvert();
			
			String serverType = "";
			String os = "";
			for(int i=1;i<ls.size();i++){
				if(ls.get(i).getId() == uc.getId(name)){
					serverType= ls.get(i).getServer();
					os = ls.get(i).getOs();
				}
			}

			subject = "Now you can use your requested server";
			if(os.equals("Ubuntu")){
	 			content = "<h3>You available use your server right now!</h3>"+
	 			                  "Hey! "+name+", you can use your own free server<br>"+
	 			                  "Here is your server infomation<br>"+
	 			                  "ID : root"+
	 			                  "PASSWORD : ubuntu"+
	 			                  "VISIT NOW!<br>";
			}
			else{ //Centos
				content = "<h3>You available use your server right now!</h3>"+
		                  "Hey! "+name+", you can use your own free server<br>"+
		                  "Here is your server infomation<br>"+
		                  "ID : root"+
		                  "PASSWORD : centos"+
		                  "VISIT NOW!<br>";
			}
		}
		SendEmailToClient(receiver,subject,content);
		
		//add xml
		Timestamp time = new Timestamp(System.currentTimeMillis());
		mc.mailList(sender, receiver, name, content, subject, type, time);
		
	}
	
	
	
	
	
	public void SendEmailToClient(String receiver, String subject, String content) {

		String sender = "koloudservice@gmail.com";
		// 정보를 담기 위한 객체
		Properties p = new Properties();

		// SMTP 서버의 계정 설정
		// Naver와 연결할 경우 네이버 아이디 지정
		// Google과 연결할 경우 본인의 Gmail 주소
		p.put("mail.smtp.user", "koloudservice@gmail.com");

		// SMTP 서버 정보 설정
		// 네이버일 경우 smtp.naver.com
		// Google일 경우 smtp.gmail.com
		p.put("mail.smtp.host", "smtp.gmail.com");

		// 아래 정보는 네이버와 구글이 동일하므로 수정하지 마세요.
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable", "true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465");
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		p.put("mail.smtp.socketFactory.fallback", "false");

		try {
			Authenticator auth = new SMTPAuthenticator();
			Session ses = Session.getInstance(p, auth);

			// 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
			ses.setDebug(true);

			// 메일의 내용을 담기 위한 객체
			MimeMessage msg = new MimeMessage(ses);

			// 제목 설정
			msg.setSubject(subject);

			// 보내는 사람의 메일주소
			Address fromAddr = new InternetAddress(sender);
			msg.setFrom(fromAddr);

			// 받는 사람의 메일주소
			Address toAddr = new InternetAddress(receiver);
			msg.addRecipient(Message.RecipientType.TO, toAddr);

			// 메시지 본문의 내용과 형식, 캐릭터 셋 설정
			msg.setContent(content, "text/html;charset=UTF-8");

			// 발송하기
			Transport.send(msg);

		} catch (Exception mex) {
			System.out.println("Fail (Send mail)");
			return;
		}

	}

}