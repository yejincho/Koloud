package net.kbssm.koloud.HomeDeco;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import net.kbssm.koloud.xstream.GetFile;

import com.thoughtworks.xstream.XStream;

public class HomeConvert {

	public HomeConvert() {
	}

	public void homeList(int visitCnt, int serverCnt, int pageCnt, int resourceCnt) throws IOException{
		XStream xStream = new XStream();
		
		xStream.alias("home", Home.class);
		xStream.alias("homeList", HomeList.class);
		xStream.addImplicitCollection(HomeList.class, "homeList");
		
		HomeList h = new HomeList();
		
		GetFile file = new GetFile("HomeList.xml");
		
		h = (HomeList)xStream.fromXML(file.reader());
		
		h.add(new Home(visitCnt,serverCnt,pageCnt,resourceCnt));
		
		String xml = xStream.toXML(h);
		
		file.writer(xml);
	}
	
	public List<Home> getHomeList() throws IOException {
		XStream xStream = new XStream();
		
		xStream.alias("home", Home.class);
		xStream.alias("homeList", HomeList.class);
		xStream.addImplicitCollection(HomeList.class, "homeList");
		
		HomeList h = new HomeList();
		
		GetFile file = new GetFile("HomeList.xml");
		
		h = (HomeList)xStream.fromXML(file.reader());
		
		List<Home> lh = new ArrayList<Home>();
		
		for(int i=0;i<h.getSize();i++){
			lh.add(h.getElement(i));
		}
		
		return lh;
	}
	
}
