package com.tibame.tga105.user.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	@Autowired
	UserDetailsService userDetailsService;
	
	@Bean
	PasswordEncoder passwodEncoder() {
		return new BCryptPasswordEncoder(11);
	}
	
	@Autowired
	AccessDeniedHandler accessDeniedHandler ;

	
	@Bean
	AuthenticationProvider authProvider() {
		DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
		provider.setUserDetailsService(userDetailsService);
		provider.setPasswordEncoder(passwodEncoder());
		
		return provider;
	}
	
//	@Bean
	//自行設定登入者的身分,權限,密碼
//	public InMemoryUserDetailsManager userdetail() {
//		UserDetails user = User.withDefaultPasswordEncoder()
//				.username("nero")
//				.password("123")
//				.roles("USER")
//				.build();
//		return new InMemoryUserDetailsManager(user);
//	}
	
//	@Bean
//    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//        http.csrf().disable()
//        
//                .authorizeHttpRequests()
//				.antMatchers("/userpage/**")
//				.hasAnyAuthority("USER","ADMIN","UNCERTIFIED")
//				.antMatchers("/admin/**")
//				.hasAuthority("ADMIN")
//				.antMatchers("/","/login","/**")
//                .permitAll()
//                .and()
//                .exceptionHandling().accessDeniedHandler(accessDeniedHandler)
//				.and()
//		        .formLogin()
//                  	.loginPage("/login")
//                  	.usernameParameter("useremail")
//                  	.passwordParameter("userpassword")
//					.defaultSuccessUrl("/", true)
//					.loginProcessingUrl("/perfomlogin")
//					.failureUrl("/login?error=true")
//					.permitAll()
//				;
//			return http.build();
//	}
	@Order(1)
	@Bean                                                       
	  public SecurityFilterChain adminLoginFilterChain(HttpSecurity http) throws Exception {
	      http.csrf().disable()
	      	  	.mvcMatcher("/admin/**") 
	      	  	.authorizeHttpRequests()                                  
	      	  	.antMatchers("/admin/**")
	      	  	.hasAuthority("ADMIN")
	      	  	.and()
	      	  	.exceptionHandling().accessDeniedHandler(accessDeniedHandler)
	      	  	.and()
	      	  	.formLogin()
		      		.loginPage("/admin/user/login")
		        	.usernameParameter("useremail")
		        	.passwordParameter("userpassword")
				.defaultSuccessUrl("/admin/user/userlist/1", true)
				.loginProcessingUrl("/admin/user/perfomlogin")
				.failureUrl("/admin/user/login?error=true")
				.permitAll()
				;
	      return http.build();
	  }

	  @Bean      
	  public SecurityFilterChain userLoginFilterChain(HttpSecurity http) throws Exception {
	      http.csrf().disable()
	      		.authorizeHttpRequests()
			.antMatchers("/userpage/**")
			.hasAnyAuthority("USER","ADMIN","UNCERTIFIED")
			.antMatchers("/restOrder.do/**")
			.hasAnyAuthority("USER","ADMIN")
			.antMatchers("/","/login","/Shopping","/**")
			.permitAll()
			.and()
			.exceptionHandling().accessDeniedHandler(accessDeniedHandler)
			.and()
			.formLogin()
			      	.loginPage("/login")
			      	.usernameParameter("useremail")
			      	.passwordParameter("userpassword")
				.defaultSuccessUrl("/", true)
				.loginProcessingUrl("/perfomlogin")
				.failureUrl("/login?error=true")
				.permitAll()
				.and()
				.logout()
				.logoutUrl("/user/logout")
				.logoutSuccessUrl("/?loggedout")
				.invalidateHttpSession(true)
				.deleteCookies("JSESSIONID")
				;
	      return http.build();
	  }

	
}
