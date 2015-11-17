package net.kbssm.koloud.ssh;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;

public class connectSSH {

	
	///////////////////////////////////// UBUNTU + FTP + Tomcat 6

    public void connect_U_tomcat6(String ip, String user, String password)
            throws IOException, InterruptedException {
        JSch jSch = new JSch();

        try {

            System.out.println("Connected");
            Session session = jSch.getSession(user, ip, 22);
            session.setPassword(password);
            // Required if not a trusted host
            java.util.Properties config = new java.util.Properties();
            config.put("StrictHostKeyChecking", "no");
            session.setConfig(config);
            System.out.println("Connecting SSH to " + user
                    + " - Please wait for few minutes... ");
            session.connect();
            // Open a shell
            Channel channel = session.openChannel("shell");
            channel.setOutputStream(System.out);
            // Create a Shell Script
            File shellScript = create_U_tom6_Script();
            // Convert the shell script to byte stream
            FileInputStream fin = new FileInputStream(shellScript);
            byte fileContent[] = new byte[(int) shellScript.length()];
            fin.read(fileContent);
            InputStream in = new ByteArrayInputStream(fileContent);
            // Set the shell script to the channel as input stream
            channel.setInputStream(in);
            // Connect and have fun!
            channel.connect();
            try{Thread.sleep(150000);}catch(Exception ee){}
            channel.disconnect();
            session.disconnect();
        } catch (JSchException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    public File create_U_tom6_Script() {
        String filename = "/netsh/Utomcat6.sh";
        File fstream = new File(filename);

        try {
            // Create file
            PrintStream out = new PrintStream(new FileOutputStream(fstream));
            out.println("#!/bin/bash");
            out.println("apt-get install -y --force-yes tomcat6");
            out.println("/etc/init.d/tomcat6 restart");
            out.println("/etc/init.d/vsftpd restart");
            out.println("echo \"Success\"");

            // Close the output stream
            out.close();
        } catch (Exception e) {// Catch exception if any
            System.err.println("Error: " + e.getMessage());
        }
        return fstream;

    }
    
    
	// ///////////////////////////////////// UBUNTU + FTP + Tomcat 7
	
	public void connect_U_tomcat7(String ip, String user, String password)
			throws IOException, InterruptedException {
		JSch jSch = new JSch();

		try {

			System.out.println("Connected");
			Session session = jSch.getSession(user, ip, 22);
			session.setPassword(password);
			// Required if not a trusted host
			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			System.out.println("Connecting SSH to " + user
					+ " - Please wait for few minutes... ");
			session.connect();
			// Open a shell
			Channel channel = session.openChannel("shell");
			channel.setOutputStream(System.out);
			// Create a Shell Script
			File shellScript = create_U_tom7_Script();
			// Convert the shell script to byte stream
			FileInputStream fin = new FileInputStream(shellScript);
			byte fileContent[] = new byte[(int) shellScript.length()];
			fin.read(fileContent);
			InputStream in = new ByteArrayInputStream(fileContent);
			// Set the shell script to the channel as input stream
			channel.setInputStream(in);
			// Connect and have fun!
			channel.connect();
			try{Thread.sleep(150000);}catch(Exception ee){}
			channel.disconnect();
		    session.disconnect();
		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public File create_U_tom7_Script() {
		String filename = "/netsh/Utomcat7.sh";
		File fstream = new File(filename);

		try {
			// Create file
			PrintStream out = new PrintStream(new FileOutputStream(fstream));
			out.println("#!/bin/bash");
			out.println("apt-get install -y --force-yes tomcat7");
			out.println("/etc/init.d/tomcat7 restart");
			out.println("/etc/init.d/vsftpd restart");
			out.println("echo \"Success\"");

			// Close the output stream
			out.close();
		} catch (Exception e) {// Catch exception if any
			System.err.println("Error: " + e.getMessage());
		}
		return fstream;

	}

	// ///////////////////////////////////// UBUNTU + FTP + Django

	public void connect_U_django_First(String ip, String user, String password)
			throws IOException {
		JSch jSch = new JSch();

		try {

			System.out.println("Connected");
			Session session = jSch.getSession(user, ip, 22);
			session.setPassword(password);
			// Required if not a trusted host
			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			System.out.println("Connecting SSH to " + user
					+ " - Please wait for few minutes... ");
			session.connect();
			// Open a shell
			Channel channel = session.openChannel("shell");
			channel.setOutputStream(System.out);
			// Create a Shell Script
			File shellScript = create_U_django_First_Script();
			// Convert the shell script to byte stream
			FileInputStream fin = new FileInputStream(shellScript);
			byte fileContent[] = new byte[(int) shellScript.length()];
			fin.read(fileContent);
			InputStream in = new ByteArrayInputStream(fileContent);
			// Set the shell script to the channel as input stream
			channel.setInputStream(in);
			// Connect and have fun!
			channel.connect();
		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public File create_U_django_First_Script() {
		String filename = "/netsh/Udjango1.sh";
		File fstream = new File(filename);

		try {
			// Create file
			PrintStream out = new PrintStream(new FileOutputStream(fstream));
			out.println("#!/bin/bash");
			out.println("apt-get install -y --force-yes python python-django");
			out.println("apt-get install -y --force-yes python-setuptools");

			// Close the output stream
			out.close();
		} catch (Exception e) {// Catch exception if any
			System.err.println("Error: " + e.getMessage());
		}
		return fstream;

	}
	
	public void connect_U_django_Second(String ip, String user, String password)
			throws IOException {
		JSch jSch = new JSch();

		try {

			System.out.println("Connected");
			Session session = jSch.getSession(user, ip, 22);
			session.setPassword(password);
			// Required if not a trusted host
			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			System.out.println("Connecting SSH to " + user
					+ " - Please wait for few minutes... ");
			session.connect();
			// Open a shell
			Channel channel = session.openChannel("shell");
			channel.setOutputStream(System.out);
			// Create a Shell Script
			File shellScript = create_U_django_Second_Script(ip);
			// Convert the shell script to byte stream
			FileInputStream fin = new FileInputStream(shellScript);
			byte fileContent[] = new byte[(int) shellScript.length()];
			fin.read(fileContent);
			InputStream in = new ByteArrayInputStream(fileContent);
			// Set the shell script to the channel as input stream
			channel.setInputStream(in);
			// Connect and have fun!
			channel.connect();
		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public File create_U_django_Second_Script(String ip) {
		String filename = "/netsh/Udjango2.sh";
		File fstream = new File(filename);

		try {
			// Create file
			PrintStream out = new PrintStream(new FileOutputStream(fstream));
			out.println("#!/bin/bash");
			//out.println("apt-get install -y --force-yes python-django");
			out.println("mkdir /etc/djangoTest");
			out.println("cd /etc/djangoTest");
			out.println("django-admin startproject djangoTest");

			// Close the output stream
			out.close();
		} catch (Exception e) {// Catch exception if any
			System.err.println("Error: " + e.getMessage());
		}
		return fstream;

	}
	
	public void connect_U_django_Third(String ip, String user, String password)
			throws IOException {
		JSch jSch = new JSch();

		try {

			System.out.println("Connected");
			Session session = jSch.getSession(user, ip, 22);
			session.setPassword(password);
			// Required if not a trusted host
			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			System.out.println("Connecting SSH to " + user
					+ " - Please wait for few minutes... ");
			session.connect();
			// Open a shell
			Channel channel = session.openChannel("shell");
			channel.setOutputStream(System.out);
			// Create a Shell Script
			File shellScript = create_U_django_Third_Script(ip);
			// Convert the shell script to byte stream
			FileInputStream fin = new FileInputStream(shellScript);
			byte fileContent[] = new byte[(int) shellScript.length()];
			fin.read(fileContent);
			InputStream in = new ByteArrayInputStream(fileContent);
			// Set the shell script to the channel as input stream
			channel.setInputStream(in);
			// Connect and have fun!
			channel.connect();
			try{Thread.sleep(150000);}catch(Exception ee){}
			channel.disconnect();
		    session.disconnect();
		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public File create_U_django_Third_Script(String ip) {
		String filename = "/netsh/Udjango3.sh";
		File fstream = new File(filename);

		try {
			// Create file
			PrintStream out = new PrintStream(new FileOutputStream(fstream));
			out.println("#!/bin/bash");
			//out.println("apt-get install -y --force-yes python-django");
			out.println("cd /etc/djangoTest/djangoTest");
			out.println("python manage.py runserver "+ip+":8000");
			out.println("echo \"Success\"");

			// Close the output stream
			out.close();
		} catch (Exception e) {// Catch exception if any
			System.err.println("Error: " + e.getMessage());
		}
		return fstream;

	}

	// /////////////////////////////////////////////// UBUNU + FTP + APM

	public void connect_U_apm_First(String ip, String user, String password)
			throws IOException {
		JSch jSch = new JSch();

		try {

			System.out.println("Connected");
			Session session = jSch.getSession(user, ip, 22);
			session.setPassword(password);
			// Required if not a trusted host
			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			System.out.println("Connecting SSH to " + user
					+ " - Please wait for few minutes... ");
			session.connect();
			// Open a shell
			Channel channel = session.openChannel("shell");
			channel.setOutputStream(System.out);
			// Create a Shell Script
			File shellScript = create_U_apm_First_Script();
			// Convert the shell script to byte stream
			FileInputStream fin = new FileInputStream(shellScript);
			byte fileContent[] = new byte[(int) shellScript.length()];
			fin.read(fileContent);
			InputStream in = new ByteArrayInputStream(fileContent);
			// Set the shell script to the channel as input stream
			channel.setInputStream(in);
			// Connect and have fun!
			channel.connect();
			
		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}


	
	public File create_U_apm_First_Script() {
	String filename = "/netsh/Uapm1.sh";
	File fstream = new File(filename);
	
	    try {
	        // Create file
	        PrintStream out = new PrintStream(new FileOutputStream(fstream));
	
	        // ftp install
	        out.println("#!/bin/bash");
	        out.println("export DEBIAN_FRONTEND=noninteractive");
	        out.println("apt-get -q -y install apache2 curl");
	       
	        // Close the output stream
	        out.close();
	    } catch (Exception e) {// Catch exception if any
	        System.err.println("Error: " + e.getMessage());
	    }
	    return fstream;
	
	}
	
	public void connect_U_apm_Second(String ip, String user, String password)
			throws IOException {
		JSch jSch = new JSch();

		try {

			System.out.println("Connected");
			Session session = jSch.getSession(user, ip, 22);
			session.setPassword(password);
			// Required if not a trusted host
			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			System.out.println("Connecting SSH to " + user
					+ " - Please wait for few minutes... ");
			session.connect();
			// Open a shell
			Channel channel = session.openChannel("shell");
			channel.setOutputStream(System.out);
			// Create a Shell Script
			File shellScript = create_U_apm_Second_Script();
			// Convert the shell script to byte stream
			FileInputStream fin = new FileInputStream(shellScript);
			byte fileContent[] = new byte[(int) shellScript.length()];
			fin.read(fileContent);
			InputStream in = new ByteArrayInputStream(fileContent);
			// Set the shell script to the channel as input stream
			channel.setInputStream(in);
			// Connect and have fun!
			channel.connect();
			
		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}


	
	public File create_U_apm_Second_Script() {
	String filename = "/netsh/Uapm2.sh";
	File fstream = new File(filename);
	
	    try {
	        // Create file
	        PrintStream out = new PrintStream(new FileOutputStream(fstream));
	
	        // ftp install
	        out.println("#!/bin/bash");
	        out.println("export DEBIAN_FRONTEND=noninteractive");
	        out.println("cp /vagrant/shell/apache2-conf-fqdn /etc/apache2/conf.d/fqdn");
	        out.println("mkdir -p /vagrant/www");
	        out.println("ls -ld /vagrant/www/apache2/sites-available/development");
	        out.println("a2ensite development");
	        out.println("a2enmod rewrite");
	        out.println("service apache2 reload");
	        out.println("cp /vagrant/shell/apache2-www-index.html /vagrant/www/index.html");
	        out.println("apt-get -q -y install libapache2-mod-php5 php5 debconf-utils ");
	        // Close the output stream
	        out.close();
	    } catch (Exception e) {// Catch exception if any
	        System.err.println("Error: " + e.getMessage());
	    }
	    return fstream;
	
	}
	
	public void connect_U_apm_Third(String ip, String user, String password)
			throws IOException {
		JSch jSch = new JSch();

		try {

			System.out.println("Connected");
			Session session = jSch.getSession(user, ip, 22);
			session.setPassword(password);
			// Required if not a trusted host
			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			System.out.println("Connecting SSH to " + user
					+ " - Please wait for few minutes... ");
			session.connect();
			// Open a shell
			Channel channel = session.openChannel("shell");
			channel.setOutputStream(System.out);
			// Create a Shell Script
			File shellScript = create_U_apm_Third_Script();
			// Convert the shell script to byte stream
			FileInputStream fin = new FileInputStream(shellScript);
			byte fileContent[] = new byte[(int) shellScript.length()];
			fin.read(fileContent);
			InputStream in = new ByteArrayInputStream(fileContent);
			// Set the shell script to the channel as input stream
			channel.setInputStream(in);
			// Connect and have fun!
			channel.connect();			
		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}


	
	public File create_U_apm_Third_Script() {
	String filename = "/netsh/Uapm3.sh";
	File fstream = new File(filename);
	
	    try {
	        // Create file
	        PrintStream out = new PrintStream(new FileOutputStream(fstream));
	        // // Orignal is comment
	        out.println("debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'");
	        out.println("debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'");
	        // ///
	        out.println("echo \"mysql-server mysql-server/root_password password root\" | debconf-set-selections");
	        out.println("echo \"mysql-server mysql-server/root_password_again password root\" | debconf-set-selections");
	        out.println("echo \"# apt-get -q -y install mysql-server libapache2-mod-auth-mysql php5-mysql\"");
	        out.println("apt-get -q -y install mysql-server mysql-client libapache2-mod-auth-mysql php5-mysql");
	        out.println("#mysqladmin -u root password mysql");
	        out.println("service apache2 restart ");
	        out.println("echo \"[PHPMYADMIN]\"");
	        out.println("echo \"phpmyadmin phpmyadmin/dbconfig-install boolean true\" | debconf-set-selections");
	        out.println("echo \"phpmyadmin phpmyadmin/app-password-confirm password root\" | debconf-set-selections");
	        out.println("echo \"phpmyadmin phpmyadmin/mysql/admin-pass password root\" | debconf-set-selections");
	        out.println("echo \"phpmyadmin phpmyadmin/mysql/app-pass password root\" | debconf-set-selections");
	        out.println("echo \"phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2\" | debconf-set-selections");
	        out.println("echo \"# apt-get -q -y install phpmyadmin\"");
	        out.println("apt-get -q -y install phpmyadmin");
	        out.println("/etc/init.d/vsftpd restart");
	        // Close the output stream
	        out.close();
	    } catch (Exception e) {// Catch exception if any
	        System.err.println("Error: " + e.getMessage());
	    }
	    return fstream;
	
	}
	
	public void connect_U_apm_Fourth(String ip, String user, String password)
			throws IOException {
		JSch jSch = new JSch();

		try {

			System.out.println("Connected");
			Session session = jSch.getSession(user, ip, 22);
			session.setPassword(password);
			// Required if not a trusted host
			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			System.out.println("Connecting SSH to " + user
					+ " - Please wait for few minutes... ");
			session.connect();
			// Open a shell
			Channel channel = session.openChannel("shell");
			channel.setOutputStream(System.out);
			// Create a Shell Script
			File shellScript = create_U_apm_Fourth_Script();
			// Convert the shell script to byte stream
			FileInputStream fin = new FileInputStream(shellScript);
			byte fileContent[] = new byte[(int) shellScript.length()];
			fin.read(fileContent);
			InputStream in = new ByteArrayInputStream(fileContent);
			// Set the shell script to the channel as input stream
			channel.setInputStream(in);
			// Connect and have fun!
			channel.connect();
			try{Thread.sleep(120000);}catch(Exception ee){}
			channel.disconnect();
		    session.disconnect();
			
		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}


	
	public File create_U_apm_Fourth_Script() {
	String filename = "/netsh/Uapm4.sh";
	File fstream = new File(filename);
	
	    try {
	        // Create file
	        PrintStream out = new PrintStream(new FileOutputStream(fstream));
	        // // Orignal is comment
	        out.println("debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'");
	        out.println("debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'");
	        // ///
	        out.println("echo \"mysql-server mysql-server/root_password password root\" | debconf-set-selections");
	        out.println("echo \"mysql-server mysql-server/root_password_again password root\" | debconf-set-selections");
	        out.println("echo \"# apt-get -q -y install mysql-server libapache2-mod-auth-mysql php5-mysql\"");
	        out.println("apt-get -q -y install mysql-server mysql-client libapache2-mod-auth-mysql php5-mysql");
	        out.println("#mysqladmin -u root password mysql");
	        out.println("service apache2 restart ");
	        out.println("echo \"[PHPMYADMIN]\"");
	        out.println("echo \"phpmyadmin phpmyadmin/dbconfig-install boolean true\" | debconf-set-selections");
	        out.println("echo \"phpmyadmin phpmyadmin/app-password-confirm password root\" | debconf-set-selections");
	        out.println("echo \"phpmyadmin phpmyadmin/mysql/admin-pass password root\" | debconf-set-selections");
	        out.println("echo \"phpmyadmin phpmyadmin/mysql/app-pass password root\" | debconf-set-selections");
	        out.println("echo \"phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2\" | debconf-set-selections");
	        out.println("echo \"# apt-get -q -y install phpmyadmin\"");
	        out.println("apt-get -q -y install phpmyadmin");
	        out.println("/etc/init.d/vsftpd restart");
	        // Close the output stream
	        out.close();
	    } catch (Exception e) {// Catch exception if any
	        System.err.println("Error: " + e.getMessage());
	    }
	    return fstream;
	
	}
	


	// ///////////////////////////////////// UBUNTU + FTP

		public void connect_U_FTP_Frist(String ip, String user, String password)
				throws IOException {
			JSch jSch = new JSch();
			try {

				System.out.println("Connected");
				Session session = jSch.getSession(user, ip, 22);
				session.setPassword(password);
				// Required if not a trusted host
				java.util.Properties config = new java.util.Properties();
				config.put("StrictHostKeyChecking", "no");
				session.setConfig(config);
				System.out.println("Connecting SSH to " + user
						+ " - Please wait for few minutes... ");
				session.connect();
				// Open a shell
				Channel channel = session.openChannel("shell");
				channel.setOutputStream(System.out);
				// Create a Shell Script
				File shellScript = create_U_FTP_First_Script();
				// Convert the shell script to byte stream
				FileInputStream fin = new FileInputStream(shellScript);
				byte fileContent[] = new byte[(int) shellScript.length()];
				fin.read(fileContent);
				InputStream in = new ByteArrayInputStream(fileContent);
				// Set the shell script to the channel as input stream
				channel.setInputStream(in);
				// Connect and have fun!
				channel.connect();
			} catch (JSchException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
				

		}



		public File create_U_FTP_First_Script() {
			String filename = "/netsh/Uftp.sh";
			File fstream = new File(filename);
			
			    try {
			        // Create file
			        PrintStream out = new PrintStream(new FileOutputStream(fstream));
			        out.println("#!/bin/bash");
			        out.println("apt-get install -y --force-yes vsftpd");
			        out.println("/etc/init.d/vsftpd restart");
			        out.println("echo \"Success\"");
			
			        // Close the output stream
			        out.close();
			    } catch (Exception e) {// Catch exception if any
			        System.err.println("Error: " + e.getMessage());
			    }
			    return fstream;
			
			}
		
		
		// ///////////////////////////////////// UBUNTU + FTP

		public void connect_U_FTP_Second(String ip, String user, String password)
				throws IOException {
			JSch jSch = new JSch();
			
			try {

				System.out.println("Connected");
				Session session = jSch.getSession(user, ip, 22);
				session.setPassword(password);
				// Required if not a trusted host
				java.util.Properties config = new java.util.Properties();
				config.put("StrictHostKeyChecking", "no");
				session.setConfig(config);
				System.out.println("Connecting SSH to " + user
						+ " - Please wait for few minutes... ");
				session.connect();
				// Open a shell
				Channel channel = session.openChannel("shell");
				channel.setOutputStream(System.out);
				// Create a Shell Script
				File shellScript = create_U_FTP_Second_Script();
				// Convert the shell script to byte stream
				FileInputStream fin = new FileInputStream(shellScript);
				byte fileContent[] = new byte[(int) shellScript.length()];
				fin.read(fileContent);
				InputStream in = new ByteArrayInputStream(fileContent);
				// Set the shell script to the channel as input stream
				channel.setInputStream(in);
				// Connect and have fun!
				channel.connect();
				try{Thread.sleep(1000);}catch(Exception ee){}
				channel.disconnect();
			    session.disconnect();
			} catch (JSchException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 

		}



		public File create_U_FTP_Second_Script() {
			String filename = "/netsh/Uftp.sh";
			File fstream = new File(filename);
			
			    try {
			        // Create file
			        PrintStream out = new PrintStream(new FileOutputStream(fstream));
			        out.println("#!/bin/bash");
			        out.println("chmod 777 /etc/vsftpd.conf");
			        out.println("sed 's/anonymous_enable=YES/anonymous_enable=NO/g' /etc/vsftpd.conf >> /etc/vsftpda.conf");
			        out.println("sed 's/#local_enable/local_enable/g' /etc/vsftpda.conf >> /etc/vsftpdb.conf");
			        out.println("rm /etc/vsftpd.conf");
			        out.println("sed 's/#write_enable/write_enable/g' /etc/vsftpdb.conf >> /etc/vsftpd.conf");
			        out.println("rm /etc/vsftpda.conf");
			        out.println("rm /etc/vsftpdb.conf");
			        out.println("sed -r -i 's/root/kk/' /etc/ftpusers");
			        out.println("/etc/init.d/vsftpd restart");
			        out.println("echo \"Success\"");
			
			        // Close the output stream
			        out.close();
			    } catch (Exception e) {// Catch exception if any
			        System.err.println("Error: " + e.getMessage());
			    }
			    return fstream;
			
			}
		
		public void connect_U_FTP_Second_Nodiscon(String ip, String user, String password)
				throws IOException {
			JSch jSch = new JSch();
			
			try {

				System.out.println("Connected");
				Session session = jSch.getSession(user, ip, 22);
				session.setPassword(password);
				// Required if not a trusted host
				java.util.Properties config = new java.util.Properties();
				config.put("StrictHostKeyChecking", "no");
				session.setConfig(config);
				System.out.println("Connecting SSH to " + user
						+ " - Please wait for few minutes... ");
				session.connect();
				// Open a shell
				Channel channel = session.openChannel("shell");
				channel.setOutputStream(System.out);
				// Create a Shell Script
				File shellScript = create_U_FTP_Second_Nodiscon_Script();
				// Convert the shell script to byte stream
				FileInputStream fin = new FileInputStream(shellScript);
				byte fileContent[] = new byte[(int) shellScript.length()];
				fin.read(fileContent);
				InputStream in = new ByteArrayInputStream(fileContent);
				// Set the shell script to the channel as input stream
				channel.setInputStream(in);
				// Connect and have fun!
				channel.connect();
			} catch (JSchException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 

		}



		public File create_U_FTP_Second_Nodiscon_Script() {
			String filename = "/netsh/Uftp.sh";
			File fstream = new File(filename);
			
			    try {
			        // Create file
			        PrintStream out = new PrintStream(new FileOutputStream(fstream));
			        out.println("#!/bin/bash");
			        out.println("chmod 777 /etc/vsftpd.conf");
			        out.println("sed 's/anonymous_enable=YES/anonymous_enable=NO/g' /etc/vsftpd.conf >> /etc/vsftpda.conf");
			        out.println("sed 's/#local_enable/local_enable/g' /etc/vsftpda.conf >> /etc/vsftpdb.conf");
			        out.println("rm /etc/vsftpd.conf");
			        out.println("sed 's/#write_enable/write_enable/g' /etc/vsftpdb.conf >> /etc/vsftpd.conf");
			        out.println("rm /etc/vsftpda.conf");
			        out.println("rm /etc/vsftpdb.conf");
			        out.println("sed -r -i 's/root/kk/' /etc/ftpusers");
			        out.println("/etc/init.d/vsftpd restart");
			        out.println("echo \"Success\"");
			
			        // Close the output stream
			        out.close();
			    } catch (Exception e) {// Catch exception if any
			        System.err.println("Error: " + e.getMessage());
			    }
			    return fstream;
			
			}
		


	// ///////////////////////////////////// CentOS + FTP

	public void connect_C_FTP(String ip, String user, String password)
			throws IOException {
		JSch jSch = new JSch();

		try {

			System.out.println("Connected");
			Session session = jSch.getSession(user, ip, 22);
			session.setPassword(password);
			// Required if not a trusted host
			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			System.out.println("Connecting SSH to " + user
					+ " - Please wait for few minutes... ");
			session.connect();
			// Open a shell
			Channel channel = session.openChannel("shell");
			channel.setOutputStream(System.out);
			// Create a Shell Script
			File shellScript = create_C_FTP_Script();
			// Convert the shell script to byte stream
			FileInputStream fin = new FileInputStream(shellScript);
			byte fileContent[] = new byte[(int) shellScript.length()];
			fin.read(fileContent);
			InputStream in = new ByteArrayInputStream(fileContent);
			// Set the shell script to the channel as input stream
			channel.setInputStream(in);
			// Connect and have fun!
			channel.connect();

		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public File create_C_FTP_Script() {
		String filename = "/netsh/Cftp.sh";
		File fstream = new File(filename);

		try {
			// Create file
			PrintStream out = new PrintStream(new FileOutputStream(fstream));
			out.println("#!/bin/bash");
			out.println("yum install -y vsftpd");
			out.println("yum install -y ftp");
			out.println("sed -r -i 's/anonymous_enable=YES/anonymous_enable=NO/' /etc/vsftpd/vsftpd.conf");
			out.println("sed -r -i 's/root/kk/' /etc/vsftpd/ftpusers");
			out.println("sed -r -i 's/root/kk/' /etc/vsftpd/user_list");
			out.println("chkconfig --level 2345 vsftpd on");
			out.println("chkconfig vsftpd on");
			out.println("/usr/sbin/setsebool -P ftp_home_dir=1");
			out.println("/usr/sbin/setsebool allow_ftpd_full_access on");
			out.println("iptables -F");
			out.println("iptables -A INPUT -p tcp --dport 20 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 21 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 22 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 23 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 80 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 8000 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 8080 -j ACCEPT");
			out.println("service iptables save");
			out.println("service iptables restart");
			out.println("service vsftpd restart");

			// Close the output stream
			out.close();
		} catch (Exception e) {// Catch exception if any
			System.err.println("Error: " + e.getMessage());
		}
		return fstream;

	}

	// ///////////////////////////////////// CentOS + FTP + tomcat6

	public void connect_C_tomcat6(String ip, String user, String password)
			throws IOException {
		JSch jSch = new JSch();

		try {

			System.out.println("Connected");
			Session session = jSch.getSession(user, ip, 22);
			session.setPassword(password);
			// Required if not a trusted host
			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			System.out.println("Connecting SSH to " + user
					+ " - Please wait for few minutes... ");
			session.connect();
			// Open a shell
			Channel channel = session.openChannel("shell");
			channel.setOutputStream(System.out);
			// Create a Shell Script
			File shellScript = create_C_tomcat6_Script();
			// Convert the shell script to byte stream
			FileInputStream fin = new FileInputStream(shellScript);
			byte fileContent[] = new byte[(int) shellScript.length()];
			fin.read(fileContent);
			InputStream in = new ByteArrayInputStream(fileContent);
			// Set the shell script to the channel as input stream
			channel.setInputStream(in);
			// Connect and have fun!
			channel.connect();

		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public File create_C_tomcat6_Script() {
		String filename = "/netsh/Ctomcat6.sh";
		File fstream = new File(filename);

		try {
			// Create file
			PrintStream out = new PrintStream(new FileOutputStream(fstream));
			out.println("#!/bin/bash");
			out.println("yum install -y vsftpd");
			out.println("yum install -y ftp");
			out.println("sed -r -i 's/anonymous_enable=YES/anonymous_enable=NO/' /etc/vsftpd/vsftpd.conf");
			out.println("sed -r -i 's/root/kk/' /etc/vsftpd/ftpusers");
			out.println("sed -r -i 's/root/kk/' /etc/vsftpd/user_list");
			out.println("chkconfig --level 2345 vsftpd on");
			out.println("chkconfig vsftpd on");
			out.println("/usr/sbin/setsebool -P ftp_home_dir=1");
			out.println("/usr/sbin/setsebool allow_ftpd_full_access on");
			out.println("iptables -F");
			out.println("iptables -A INPUT -p tcp --dport 20 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 21 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 22 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 23 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 80 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 8000 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 8080 -j ACCEPT");

			out.println("yum install -y --nogpgcheck tomcat6 tomcat6-admin-webapps tomcat6-webapps");
			out.println("service iptables save");
			out.println("service iptables restart");
			out.println("service vsftpd restart");
			out.println("service tomcat6 restart");
			out.println("echo \"Success\"");

			// Close the output stream
			out.close();
		} catch (Exception e) {// Catch exception if any
			System.err.println("Error: " + e.getMessage());
		}
		return fstream;

	}

	// ///////////////////////////////////// CentOS + FTP + tomcat7

	public void connect_C_tomcat7(String ip, String user, String password)
			throws IOException {
		JSch jSch = new JSch();

		try {

			System.out.println("Connected");
			Session session = jSch.getSession(user, ip, 22);
			session.setPassword(password);
			// Required if not a trusted host
			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			System.out.println("Connecting SSH to " + user
					+ " - Please wait for few minutes... ");
			session.connect();
			// Open a shell
			Channel channel = session.openChannel("shell");
			channel.setOutputStream(System.out);
			// Create a Shell Script
			File shellScript = create_C_tomcat7_Script();
			// Convert the shell script to byte stream
			FileInputStream fin = new FileInputStream(shellScript);
			byte fileContent[] = new byte[(int) shellScript.length()];
			fin.read(fileContent);
			InputStream in = new ByteArrayInputStream(fileContent);
			// Set the shell script to the channel as input stream
			channel.setInputStream(in);
			// Connect and have fun!
			channel.connect();

		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public File create_C_tomcat7_Script() {
		String filename = "/netsh/Ctomcat7.sh";
		File fstream = new File(filename);

		try {
			// Create file
			PrintStream out = new PrintStream(new FileOutputStream(fstream));
			out.println("#!/bin/bash");
			out.println("yum install -y vsftpd");
			out.println("yum install -y ftp");
			out.println("sed -r -i 's/anonymous_enable=YES/anonymous_enable=NO/' /etc/vsftpd/vsftpd.conf");
			out.println("sed -r -i 's/root/kk/' /etc/vsftpd/ftpusers");
			out.println("sed -r -i 's/root/kk/' /etc/vsftpd/user_list");
			out.println("chkconfig --level 2345 vsftpd on");
			out.println("chkconfig vsftpd on");
			out.println("/usr/sbin/setsebool -P ftp_home_dir=1");
			out.println("/usr/sbin/setsebool allow_ftpd_full_access on");
			out.println("iptables -F");
			out.println("iptables -A INPUT -p tcp --dport 20 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 21 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 22 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 23 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 80 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 8000 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 8080 -j ACCEPT");

			out.println("yum install -y --nogpgcheck tomcat7 tomcat7-admin-webapps tomcat7-webapps");
			out.println("service tomcat7 restart");
			out.println("service iptables save");
			out.println("service iptables restart");
			out.println("service vsftpd restart");
			out.println("echo \"Success\"");

			// Close the output stream
			out.close();
		} catch (Exception e) {// Catch exception if any
			System.err.println("Error: " + e.getMessage());
		}
		return fstream;

	}

	// ///////////////////////////////////// CentOS + FTP + apm

	public void connect_C_apm(String ip, String user, String password)
			throws IOException {
		JSch jSch = new JSch();

		try {

			System.out.println("Connected");
			Session session = jSch.getSession(user, ip, 22);
			session.setPassword(password);
			// Required if not a trusted host
			java.util.Properties config = new java.util.Properties();
			config.put("StrictHostKeyChecking", "no");
			session.setConfig(config);
			System.out.println("Connecting SSH to " + user
					+ " - Please wait for few minutes... ");
			session.connect();
			// Open a shell
			Channel channel = session.openChannel("shell");
			channel.setOutputStream(System.out);
			// Create a Shell Script
			File shellScript = create_C_apm_Script(ip);
			// Convert the shell script to byte stream
			FileInputStream fin = new FileInputStream(shellScript);
			byte fileContent[] = new byte[(int) shellScript.length()];
			fin.read(fileContent);
			InputStream in = new ByteArrayInputStream(fileContent);
			// Set the shell script to the channel as input stream
			channel.setInputStream(in);
			// Connect and have fun!
			channel.connect();
		} catch (JSchException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public File create_C_apm_Script(String virtIp) {
		String filename = "/netsh/Capm.sh";
		File fstream = new File(filename);

		try {
			// Create file
			PrintStream out = new PrintStream(new FileOutputStream(fstream));
			out.println("#!/bin/bash");
			out.println("yum install -y vsftpd");
			out.println("yum install -y ftp");
			out.println("sed -r -i 's/anonymous_enable=YES/anonymous_enable=NO/' /etc/vsftpd/vsftpd.conf");
			out.println("sed -r -i 's/root/kk/' /etc/vsftpd/ftpusers");
			out.println("sed -r -i 's/root/kk/' /etc/vsftpd/user_list");
			// out.println("sed -r -i 's/--dport 22 -j ACCEPT/--dport 22 -j ACCEPT -A INPUT -m state --state NEW -m tcp -p tcp --dport 21 -j ACCEPT -A INPUT -m state --state NEW -m tcp -p tcp --dport 20 -j ACCEPT -A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT -A INPUT -m state --state NEW -m tcp -p tcp --dport 8080 -j ACCEPT /' /etc/sysconfig/iptables");
			out.println("chkconfig --level 2345 vsftpd on");
			out.println("chkconfig vsftpd on");
			out.println("/usr/sbin/setsebool -P ftp_home_dir=1");
			out.println("/usr/sbin/setsebool allow_ftpd_full_access on");

			out.println("yum install -y httpd");
			out.println("yum install -y mysql");
			out.println("yum install -y mysql-server");
			out.println("yum install -y php");
			out.println("yum -y install gd gd-devel");
			out.println("yum -y install libxml2 libxml2-devel");
			out.println("yum -y install openssl openssl-devel");
			out.println("yum -y install gmp gmp-devel");
			out.println("yum -y install mhash mhash-devel");
			out.println("yum -y install libmcrypt libmcrypt-devel");
			out.println("yum -y install mysql-server");
			out.println("yum -y install php-mysql");
			out.println("yum -y install php-devel");
			out.println("yum -y install php-gd");
			out.println("yum -y install php-mbstring");

			out.println("service httpd status");
			out.println("service mysqld status");
			out.println("php -v");
			out.println("service httpd restart");
			out.println("service mysqld restart");

			out.println("mysqladmin -u root password centos");

			out.println("rpm -ivh http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/i386/epel-release-6-8.noarch.rpm");
			out.println("yum check-update");
			out.println("yum install -y phpmyadmin");
			out.println("service httpd restart");

			out.println("iptables -F");
			out.println("iptables -A INPUT -p tcp --dport 20 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 21 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 22 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 23 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 80 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 8000 -j ACCEPT");
			out.println("iptables -A INPUT -p tcp --dport 8080 -j ACCEPT");

			out.println("sed -r -i 's/127.0.0.1/ALL/' /etc/httpd/conf.d/phpMyAdmin.conf");

			out.println("/etc/init.d/httpd restart");
			out.println("service iptables save");
			out.println("service iptables restart");
			out.println("service vsftpd restart");
			out.println("echo \"Success\"");

			// Close the output stream
			out.close();
		} catch (Exception e) {// Catch exception if any
			System.err.println("Error: " + e.getMessage());
		}
		return fstream;

	}
}
