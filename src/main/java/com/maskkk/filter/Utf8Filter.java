package com.maskkk.filter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import java.io.IOException;
@WebFilter("/*")
public class Utf8Filter implements Filter{

	
	
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		chain.doFilter(request,response);
	}
  	
	public  void init(FilterConfig config) {}
	
	public void destroy() {}
}  
  
  