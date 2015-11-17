package net.kbssm.koloud.mail;

import java.util.ArrayList;
import java.util.List;

public class MailList {

	private List<Mail> mailList;
	
	public MailList(){
		mailList = new ArrayList<Mail>();
	}
	
	public void add(Mail mail){
		mailList.add(mail);
	}
	
	public int getSize(){
		return mailList.size();
	}
	
	public Mail getElement(int index){
		return mailList.get(index);
	}
}

