package net.kbssm.koloud.mail;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import net.kbssm.koloud.xstream.GetFile;

import com.thoughtworks.xstream.XStream;

public class MailConvert {

	public MailConvert(){
	}
	
	public void mailList(String sender, String receiver_email, String receiver_name, String contents, String subject, String type, Timestamp time) throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("mail", Mail.class);
		xStream.alias("mailList", MailList.class);
		xStream.addImplicitCollection(MailList.class, "mailList");
		
		MailList m = new MailList();
		
		GetFile file = new GetFile("MailList.xml");
		
		m = (MailList)xStream.fromXML(file.reader());
		
		m.add(new Mail(sender,receiver_email,receiver_name,contents,subject,type,time));
		
		String xml = xStream.toXML(m);
		
		file.writer(xml);
	}
	
	public List<Mail> getMailList() throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("mail", Mail.class);
		xStream.alias("mailList", MailList.class);
		xStream.addImplicitCollection(MailList.class, "mailList");
		
		MailList m = new MailList();
		
		GetFile file = new GetFile("MailList.xml");
		
		m = (MailList)xStream.fromXML(file.reader());
		
		List<Mail> lm = new ArrayList<Mail>();
		
		for(int i=0;i<m.getSize();i++){
			lm.add(m.getElement(i));				
		}
	
		return lm;
	}
		
}
