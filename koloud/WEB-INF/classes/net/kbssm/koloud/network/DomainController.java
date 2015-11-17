package net.kbssm.koloud.network;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.List;

import net.kbssm.koloud.User.User;
import net.kbssm.koloud.User.UserConvert;

public class DomainController {

public void addDomainToHaproxy(String domain, String virtualIp,
        String portNum) {
    try {

        String msg = "", emsg = "";
        Process p = null;
        
        UserConvert uc = new UserConvert();
		List<User> lu = uc.getUserList();
        String password = lu.get(0).getSysPassword();
        
        String[] cmd = {
                "/bin/bash",
                "-c",
                "echo " + password + " | sudo -S sh /netsh/domainAdd.sh "
                        + domain +" "+virtualIp+" "+portNum };
        p = Runtime.getRuntime().exec(cmd);
        p.waitFor();
        BufferedReader inOut = new BufferedReader(new InputStreamReader(
                p.getInputStream()));
        BufferedReader inErr = new BufferedReader(new InputStreamReader(
                p.getErrorStream()));
        while ((msg = inOut.readLine()) != null) {
            System.out.println(msg);
        }
        while ((emsg = inErr.readLine()) != null) {
            System.out.println("Error = " + emsg);
        }
        p.destroy();
        refreshHaproxy();
    } catch (Exception e) {
        System.out.println(e.toString());
    }
    return;
}

public void deleteDomainToHaproxy(String domain) {
    try {

        String msg = "", emsg = "";
        Process p = null;
        
        UserConvert uc = new UserConvert();
		List<User> lu = uc.getUserList();
        String password = lu.get(0).getSysPassword();
        
        String[] cmd = {
                "/bin/bash",
                "-c",
                "echo " + password + " | sudo -S sh /netsh/domainDelete.sh " + domain };
        p = Runtime.getRuntime().exec(cmd);
        p.waitFor();
        BufferedReader inOut = new BufferedReader(new InputStreamReader(
                p.getInputStream()));
        BufferedReader inErr = new BufferedReader(new InputStreamReader(
                p.getErrorStream()));
        while ((msg = inOut.readLine()) != null) {
            System.out.println(msg);
        }
        while ((emsg = inErr.readLine()) != null) {
            System.out.println("Error = " + emsg);
        }
        p.destroy();
        refreshHaproxy();
    } catch (Exception e) {
        System.out.println(e.toString());
    }
    return;
}

public void refreshHaproxy() {
    try {

        String msg = "", emsg = "";
        Process p = null;
        
        UserConvert uc = new UserConvert();
		List<User> lu = uc.getUserList();
        String password = lu.get(0).getSysPassword();
        
        String[] cmd = {
                "/bin/bash",
                "-c",
                "echo " + password + " | sudo -S /etc/init.d/haproxy restart"};
        p = Runtime.getRuntime().exec(cmd);
        p.waitFor();
        BufferedReader inOut = new BufferedReader(new InputStreamReader(
                p.getInputStream()));
        BufferedReader inErr = new BufferedReader(new InputStreamReader(
                p.getErrorStream()));
        while ((msg = inOut.readLine()) != null) {
            System.out.println(msg);
        }
        while ((emsg = inErr.readLine()) != null) {
            System.out.println("Error = " + emsg);
        }
        p.destroy();
    } catch (Exception e) {
        System.out.println(e.toString());
    }
    return;
}

}
