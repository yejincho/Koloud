package net.kbssm.koloud;


import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/confirmOK", method = {RequestMethod.GET, RequestMethod.POST})
	public String confirmOK(Locale locale, Model model) {
		//return "redirect:/resources/index.html";
		return "before/confirmOK";
	}
	@RequestMapping(value = "/guest_account_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String guest_account_temp(Locale locale, Model model) {
		//return "redirect:/resources/index.html";
		return "before/guest_account_temp";
	}@RequestMapping(value = "/mail_resource_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String mail_resource_temp(Locale locale, Model model) {
		//return "redirect:/resources/index.html";
		return "before/mail_resource_temp";
	}
	@RequestMapping(value = "/login_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String login_temp(Locale locale, Model model) {
		//return "redirect:/resources/index.html";
		return "before/login_temp";
	}
	@RequestMapping(value = "/findPw_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String findPw_temp(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/findPw_temp";
	}
	@RequestMapping(value = "/register_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String register_temp(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/register_tempp";
	}
	@RequestMapping(value = "/server_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String server_temp(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/server_temp";
	}
	@RequestMapping(value = "/logout_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String logout_temp(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/logout_temp";
	}
	@RequestMapping(value = "/setting_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String setting_temp(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/setting_temp";
	}
	@RequestMapping(value = "/server_status_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String server_status_temp(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/server_status_temp";
	}
	@RequestMapping(value = "/account_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String account_temp(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/account_temp";
	}
	@RequestMapping(value = "/request_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String request_temp(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/request_temp";
	}
	@RequestMapping(value = "/server_change_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String server_change_temp(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/server_change_temp";
	}
	@RequestMapping(value = "/request_server_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String request_server_temp(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/request_server_temp";
	}
	@RequestMapping(value = "/reason_resource", method = {RequestMethod.GET, RequestMethod.POST})
	public String reason_resource(Locale locale, Model model) {
		//return "redirect:/resources/index.html";
		return "before/reason_resource";
	}
	@RequestMapping(value = "/intro_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String intro_temp(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/domain/intro_temp";
	}
	@RequestMapping(value = "/subdomain_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String subdomain_temp(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/domain/subdomain_temp";
	}
	@RequestMapping(value = "/subdomain_temp_dashboard", method = {RequestMethod.GET, RequestMethod.POST})
	public String subdomain_temp_dashboard(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/domain/subdomain_temp_dashboard";
	}
	@RequestMapping(value = "/create_server_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String create_server_temp(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/create_server_temp";
	}
	@RequestMapping(value = "/request_resource_temp", method = {RequestMethod.GET, RequestMethod.POST})
	public String request_resource_temp(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "before/request_resource_temp";
	}
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "Login";
	}
	@RequestMapping(value = "/findPw", method = RequestMethod.GET)
	public String findPw(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "findPw";
	}
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String login(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "home";
	}
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "test";
	}
	@RequestMapping(value = "/register", method = {RequestMethod.GET, RequestMethod.POST})
	public String register(Locale locale, Model model) {
		
		//return "redirect:/resources/index.html";
		return "register";
	}
	@RequestMapping(value = "/about", method = RequestMethod.GET)
	public String about(Locale locale, Model model) {		
		
		return "/navbar_nav/about";
	}
	@RequestMapping(value = "/contact", method = RequestMethod.GET)
	public String contact(Locale locale, Model model) {		
		
		return "/navbar_nav/contact";
	}
	@RequestMapping(value = "/update_account", method = RequestMethod.GET)
	public String update_account(Locale locale, Model model) {		
		
		return "/navbar_nav/update_account";
	}
	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public String profile(Locale locale, Model model) {		
		
		return "/navbar_nav/profile";
	}
	@RequestMapping(value = "/tables", method = {RequestMethod.GET, RequestMethod.POST})
	public String tables(Model model){	
		return "/contents/tables";
	}
	@RequestMapping(value = "/all_tables", method = RequestMethod.GET)
	public String all_tables(Model model){	
		return "/contents/all_tables";
	}
	@RequestMapping(value = "/charts", method = RequestMethod.GET)
	public String charts(Model model){	
		return "/contents/charts";
	}
	@RequestMapping(value = "/VMcharts", method = RequestMethod.GET)
	public String VMcharts(Model model){	
		return "/contents/VMcharts";
	}
	@RequestMapping(value = "/tables_Setting", method = RequestMethod.GET)
	public String tables_Setting(Model model){	
		return "/contents/tables_Setting";
	}
	@RequestMapping(value = "/create_server", method = RequestMethod.GET)
	public String forms(Model model){	
		return "/contents/create_server";
	}
	@RequestMapping(value = "/blank", method = RequestMethod.GET)
	public String blank(Model model){	
		return "/contents/blank-page";
	}
	@RequestMapping(value = "/DNS_setting", method = RequestMethod.GET)
	public String DNS_setting(Model model){	
		return "/contents/DNS_setting";
	}
	@RequestMapping(value = "/aboutus", method = RequestMethod.GET)
	public String aboutus(Model model){	
		return "/contents/aboutus";
	}
	@RequestMapping(value = "/developer", method = RequestMethod.GET)
	public String developer(Model model){	
		return "/contents/developer";
	}
	@RequestMapping(value = "/request", method = RequestMethod.GET )
	public String request(Model model){	
		return "/contents/request";
	}
	@RequestMapping(value = "/reason", method = RequestMethod.GET)
	public String reason(Model model){	
		return "/contents/reason";
	}
	@RequestMapping(value = "/mail", method = RequestMethod.GET)
	public String mail(Model model){	
		return "/contents/mail";
	}
	@RequestMapping(value = "/create_server_guest", method = RequestMethod.GET)
	public String create_server_guest(Model model){	
		return "/contents/create_server_guest";
	}
	@RequestMapping(value = "/server_auto", method = RequestMethod.GET)
	public String server_auto(Model model){	
		return "/contents/server_auto";
	}
	@RequestMapping(value = "/users", method = RequestMethod.GET)
	public String users(Model model){	
		return "/contents/users";
	}
	@RequestMapping(value = "/request_resources", method = RequestMethod.GET)
	public String request_resources(Model model){	
		return "/contents/request_resources";
	}
	@RequestMapping(value = "/index_first", method = RequestMethod.GET)
	public String index_first(Model model){	
		return "/Intro/First";
	}
	@RequestMapping(value = "/index_second", method = RequestMethod.GET)
	public String index_second(Model model){	
		return "/Intro/Second";
	}
	@RequestMapping(value = "/index_third", method = RequestMethod.GET)
	public String index_third(Model model){	
		return "/Intro/Third";
	}
	@RequestMapping(value = "/progress", method = RequestMethod.GET)
	public String progressbar(Model model){	
		return "/etc/progress";
	}
	@RequestMapping(value = "/OSCreateInfo", method = RequestMethod.GET)
	public String OSCreateInfo(Model model){	
		return "/etc/OSCreateInfo";
	}
	@RequestMapping(value = "/mailContent", method = RequestMethod.GET)
	public String mailContent(Model model){	
		return "/etc/mailContent";
	}
	@RequestMapping(value = "/ServerCreateInfo", method = RequestMethod.GET)
	public String ServerCreateInfo(Model model){	
		return "/etc/ServerCreateInfo";
	}
}
