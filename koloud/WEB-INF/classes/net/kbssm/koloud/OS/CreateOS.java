package net.kbssm.koloud.OS;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;
import java.util.List;

import net.kbssm.koloud.User.User;
import net.kbssm.koloud.User.UserConvert;

public class CreateOS {
	
	public CreateOS() {
		
	}
	
	public String ip(){
		 String ip = null;
		    try {
		        Enumeration<NetworkInterface> interfaces = NetworkInterface.getNetworkInterfaces();
		        while (interfaces.hasMoreElements()) {
		            NetworkInterface iface = interfaces.nextElement();
		            // filters out 127.0.0.1 and inactive interfaces
		            if (iface.isLoopback() || !iface.isUp())
		                continue;

		            Enumeration<InetAddress> addresses = iface.getInetAddresses();
		            while(addresses.hasMoreElements()) {
		                InetAddress addr = addresses.nextElement();
		                ip = addr.getHostAddress();
//		                System.out.println(iface.getDisplayName() + " " + ip);
		            }
		        }
		    } catch (SocketException e) {
		        throw new RuntimeException(e);
		    }
		    return ip;
	}
	public int creste_os(int ram, String os, int cpu, String s_name, int disk) throws IOException, InterruptedException{

		  String msg = "", emsg = "";
		  Process p = null;
//		  String errormsg = "";
		  
		  UserConvert uc = new UserConvert();
		  List<User> lu = uc.getUserList();
		  String password = lu.get(0).getSysPassword();
		  
		  if(os.equals("Ubuntu")){
		  	String[] cmd = {"/bin/bash","-c","echo "+password+" | sudo -S virt-install \\--connect qemu:///system \\--name "+s_name+" \\--ram "+ram+" \\--vcpus "+cpu+" \\--disk pool=default,size="+disk+",bus=virtio,sparse=false \\--network network=default,model=virtio \\--location http://kr.archive.ubuntu.com/ubuntu/dists/precise-updates/main/installer-i386  \\--initrd-inject=/var/lib/libvirt/images/preseed.cfg \\--extra-args=\"locale=en_GB.UTF-8 console-setup/ask_detect=false keyboard-configuration/layoutcode=en file=file:/preseed.cfg vga=788 quiet\" \\--os-type=linux \\--os-variant=ubuntuprecise \\--virt-type kvm \\--noreboot"};
		  	p = Runtime.getRuntime().exec(cmd);
		  }else{
			 String[] cmd = {"/bin/bash","-c","echo "+password+" | sudo -S virt-install \\--connect qemu:///system \\--name "+s_name+" \\--ram "+ram+" \\--vcpus "+cpu+" \\--disk pool=default,size="+disk+" \\--network network=default \\--location http://mirror.catn.com/pub/centos/6/os/i386 \\--initrd-inject=/var/lib/libvirt/images/centospreseed.cfg \\--extra-args=\"ks=file:/centospreseed.cfg vga=788 quiet\" \\--os-type linux \\--os-variant rhel6 \\--virt-type kvm \\--graphics vnc \\--hvm \\--force \\--noreboot"};
			 p = Runtime.getRuntime().exec(cmd);
		  }
		  p.waitFor();
		  BufferedReader inOut =
		    new BufferedReader(new InputStreamReader(p.getInputStream()));
		  BufferedReader inErr =
		    new BufferedReader(new InputStreamReader (p.getErrorStream()));
		  while ((msg = inOut.readLine()) != null)
		  {
		    System.out.println("Out = " + msg);
		  }
		  while ((emsg = inErr.readLine()) != null)
		  {
			  if(emsg.charAt(0) == 'E' && emsg.charAt(1) == 'R' && emsg.charAt(2) == 'R' && emsg.charAt(3) == 'O' && emsg.charAt(4) == 'R'){
				  p.destroy();
				  return 0; // fail
			  }
//			  errormsg += emsg;
			  System.out.println("Error = "+ emsg);
		  }
		  p.destroy();
		  
//		  return errormsg;
		  return 1; // success
	
	}
	
	public void setResources(String s_name, long disk, int cpu, long ram) throws InterruptedException, IOException{

		UserConvert uc = new UserConvert();
		List<User> lu = uc.getUserList();
		String password = lu.get(0).getSysPassword();
		
		//stop server 
		//for setting ram
		Process p = null;
		String[] cmd = {"/bin/bash","-c","echo "+password+" | sudo -S sh /netsh/virshDestroy.sh "+s_name};
		p = Runtime.getRuntime().exec(cmd);
		p.waitFor();
		p.destroy();

		  //set ram
		String[] cmd2 = {"/bin/bash","-c","echo "+password+" | sudo -S sh /netsh/virshSetmaxmem.sh "+s_name+" "+ram};
		p = Runtime.getRuntime().exec(cmd2);
		p.waitFor();
		p.destroy();
		  
		  //cpu setting
		String[] cmd4 = {"/bin/bash","-c","echo "+password+" | sudo -S sh /netsh/virshSetvcpus.sh "+s_name+" "+cpu};
		p = Runtime.getRuntime().exec(cmd4);
		p.waitFor();
		p.destroy();
		
		
		//TODO disk setting
		String[] cmd6 = {"/bin/bash","-c","echo "+password+" | sudo -S sh /netsh/qemuimgResize.sh "+s_name+" "+disk};
		p = Runtime.getRuntime().exec(cmd6);
		p.waitFor();
		p.destroy();
		
		//start os before cpu setting
		String[] cmd3 = {"/bin/bash","-c","echo "+password+" | sudo -S sh /netsh/virshStart.sh "+s_name};
		p = Runtime.getRuntime().exec(cmd3);
		p.waitFor();
		p.destroy();
	}
	
	public void startOS(String s_name) throws IOException, InterruptedException{

		UserConvert uc = new UserConvert();
		List<User> lu = uc.getUserList();
		String password = lu.get(0).getSysPassword();
		
		Process p = null;
		String[] cmd4 = {"/bin/bash","-c","echo "+password+" | sudo -S sh /netsh/virshStart.sh "+s_name};
		p = Runtime.getRuntime().exec(cmd4);
		p.waitFor();
		p.destroy();
	}
		
	
	public String getTotalDisk() throws IOException{
		
		UserConvert uc = new UserConvert();
		List<User> lu = uc.getUserList();
		String password = lu.get(0).getSysPassword();		
		
		Process p = null;
		String[] cmd4 = {"/bin/bash","-c","echo "+password+" | sudo -S df -h | grep \"/dev/\" | awk '{print $2}'"};
		p = Runtime.getRuntime().exec(cmd4);
		
		String msg = "";
		String emsg = "";
		String disk = "";
		BufferedReader inOut = new BufferedReader(new InputStreamReader(p.getInputStream()));
		BufferedReader inErr = new BufferedReader(new InputStreamReader(p.getErrorStream()));
		
		while ((msg = inOut.readLine()) != null) {
			disk = returnDisk(msg);
			
		}
		while ((emsg = inErr.readLine()) != null) {
			if (emsg.charAt(0) == 'E' && emsg.charAt(1) == 'R'
					&& emsg.charAt(2) == 'R' && emsg.charAt(3) == 'O'
					&& emsg.charAt(4) == 'R') {
				p.destroy();
			}
			System.out.println("Error = " + emsg);
		}
		p.destroy();
		return disk;
	}
	
	public String getUsingDisk() throws IOException{
		
		UserConvert uc = new UserConvert();
		List<User> lu = uc.getUserList();
		String password = lu.get(0).getSysPassword();		
		
		Process p = null;
		String[] cmd4 = {"/bin/bash","-c","echo "+password+" | sudo -S df -h | grep \"/dev/\" | awk '{print $3}'"};
		p = Runtime.getRuntime().exec(cmd4);
		
		String msg = "";
		String emsg = "";
		String disk = "";
		BufferedReader inOut = new BufferedReader(new InputStreamReader(p.getInputStream()));
		BufferedReader inErr = new BufferedReader(new InputStreamReader(p.getErrorStream()));
		
		while ((msg = inOut.readLine()) != null) {
			disk = returnDisk(msg);
			
		}
		while ((emsg = inErr.readLine()) != null) {
			if (emsg.charAt(0) == 'E' && emsg.charAt(1) == 'R'
					&& emsg.charAt(2) == 'R' && emsg.charAt(3) == 'O'
					&& emsg.charAt(4) == 'R') {
				p.destroy();
			}
			System.out.println("Error = " + emsg);
		}
		p.destroy();
		return disk;
	}
	
	public String getLeftDisk() throws IOException{
		
		UserConvert uc = new UserConvert();
		List<User> lu = uc.getUserList();
		String password = lu.get(0).getSysPassword();		
		
		Process p = null;
		String[] cmd4 = {"/bin/bash","-c","echo "+password+" | sudo -S df -h | grep \"/dev/\" | awk '{print $4}'"};
		p = Runtime.getRuntime().exec(cmd4);
		
		String msg = "";
		String emsg = "";
		String disk = "";
		BufferedReader inOut = new BufferedReader(new InputStreamReader(p.getInputStream()));
		BufferedReader inErr = new BufferedReader(new InputStreamReader(p.getErrorStream()));
		
		while ((msg = inOut.readLine()) != null) {
			disk = returnDisk(msg);
			
		}
		while ((emsg = inErr.readLine()) != null) {
			if (emsg.charAt(0) == 'E' && emsg.charAt(1) == 'R'
					&& emsg.charAt(2) == 'R' && emsg.charAt(3) == 'O'
					&& emsg.charAt(4) == 'R') {
				p.destroy();
			}
			System.out.println("Error = " + emsg);
		}
		p.destroy();
		return disk;
	}
	
	public String returnDisk(String msg){
		String disk = "";
		for(int i=0;i<msg.length();i++){
			if(msg.charAt(i) != 'G'){
				disk += msg.charAt(i);
			}
		}
		return disk;
	}
	
	public String getDiskPercent() throws IOException{
		
		UserConvert uc = new UserConvert();
		List<User> lu = uc.getUserList();
		String password = lu.get(0).getSysPassword();		
		
		Process p = null;
		String[] cmd4 = {"/bin/bash","-c","echo "+password+" | sudo -S df -h | grep \"/dev/\" | awk '{print $5}'"};
		p = Runtime.getRuntime().exec(cmd4);
		
		String msg = "";
		String emsg = "";
		String disk = "";
		BufferedReader inOut = new BufferedReader(new InputStreamReader(p.getInputStream()));
		BufferedReader inErr = new BufferedReader(new InputStreamReader(p.getErrorStream()));
		
		while ((msg = inOut.readLine()) != null) {
			disk = getDiskPercent(msg);
			
		}
		while ((emsg = inErr.readLine()) != null) {
			if (emsg.charAt(0) == 'E' && emsg.charAt(1) == 'R'
					&& emsg.charAt(2) == 'R' && emsg.charAt(3) == 'O'
					&& emsg.charAt(4) == 'R') {
				p.destroy();
			}
			System.out.println("Error = " + emsg);
		}
		p.destroy();
		return disk;
	}
	
	public String getDiskPercent(String msg){
		String percent ="";
		for(int i=0;i<msg.length();i++){
			if(msg.charAt(i) != '%'){
				percent += msg.charAt(i);
			}
		}
		return percent;
	}
	
	public String getCpu() throws IOException{

		UserConvert uc = new UserConvert();
		List<User> lu = uc.getUserList();
		String password = lu.get(0).getSysPassword();		
		
		String cpu = "";
		try {
			String msg="", emsg = "";
			Process p = null;
			String[] cmd = {
					"/bin/bash",
					"-c",
					"echo "
							+ password
							+ " | sudo -S mpstat | tail -1 | awk '{print 100-$11}'" };

			p = Runtime.getRuntime().exec(cmd);
			p.waitFor();
			BufferedReader inOut = new BufferedReader(
					new InputStreamReader(p.getInputStream()));
			BufferedReader inErr = new BufferedReader(
					new InputStreamReader(p.getErrorStream()));
			while ((msg = inOut.readLine()) != null) {
				cpu = returnStr(msg);
			}
			while ((emsg = inErr.readLine()) != null) {
				System.out.println("Error = "+ emsg);
			}
			p.destroy();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return cpu;
	}
	
	public String getMemory() throws IOException{
		
		UserConvert uc = new UserConvert();
		List<User> lu = uc.getUserList();
		String password = lu.get(0).getSysPassword();		
		
		String memory = "";
		try {
			String msg = "", emsg = "";
			Process p = null;
			String[] cmd = {
					"/bin/bash",
					"-c",
					"echo "
							+ password
							+ " | sudo -S free | grep Mem | tail -1 | awk '{print $3/$2*100}'" };
			p = Runtime.getRuntime().exec(cmd);
			p.waitFor();
			BufferedReader inOut = new BufferedReader(
					new InputStreamReader(p.getInputStream()));
			BufferedReader inErr = new BufferedReader(
					new InputStreamReader(p.getErrorStream()));
			while ((msg = inOut.readLine()) != null) {
				memory = returnStr(msg);
			}
			while ((emsg = inErr.readLine()) != null) {
				System.out.println("Error = " + emsg);
			}
			p.destroy();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return memory;
	}

	public String returnStr(String msg){
		return msg;
	}
	
}
