package net.kbssm.koloud.xstream;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringReader;

public class GetFile {
	private String file;
		
	public GetFile(){
		
	}
	
	public GetFile(String file){
		this.file = file;
	}

	public String reader() throws IOException{
		String line = null;
		String now_xml = new String();
		String path = "/xml/";
		
		BufferedReader br = new BufferedReader(new FileReader(path + "" +file));
		
		while((line = br.readLine())!=null){
			now_xml += line + "\n"; 
		}
		
		br.close();
		return now_xml;
	}
	
	public void writer(String xml) throws IOException{
		String path = "/xml/";
		
		BufferedReader reader = new BufferedReader(new StringReader(xml));
		BufferedWriter writer = new BufferedWriter(new FileWriter(path + "" + file,false));
		
		while((xml = reader.readLine()) != null){
			writer.write(xml + System.getProperty("line.separator"));
		}
		
		writer.close();
		
	}
}
