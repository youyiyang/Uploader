package com.maskkk.controller;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.maskkk.dao.UserDao;

@Controller
@RequestMapping(value="/spring")
public class FileDownloadController
{
	@Autowired
	public UserDao userDao;
	 // Define a static logger variable so that it references the
	 // Logger instance named "MyApp".
	private static final Logger  download = LogManager.getLogger(FileDownloadController.class);
	private ServletContext servletContext;
	
    String something() {

    	download.info("info test");

    	download.warn("warn test");

    	download.error("error test");
        
    	download.debug("debug test");

        return "ok";
    }
    @RequestMapping(value="/{fileName:.+}/download.do")
    public void downloadPDFResource( HttpServletRequest request, 
			                          HttpServletResponse response, 
			                           @PathVariable("fileName") String fileName
			                           ) throws UnsupportedEncodingException 
    {
		String basepath="F:/HTML/SpringMVC/wtpwebapps/Upload/fileupload";
    	//If user is not authorized - he should be thrown out from here itself
		
		//Authorized user will download the file
		//String dataDirectory = request.getServletContext().getRealPath("/WEB-INF/downloads/pdf/");
    	System.setProperty("Log4jContextSelector","org.apache.logging.log4j.core.async.AsyncLoggerContextSelector");
        System.out.println("call downloading file");
    	//String dataDirectory = request.getServletContext().getRealPath("fileupload");
    	HttpSession session = request.getSession();
	    String username = session.getAttribute("username").toString();
	    String curdirid = session.getAttribute("curdirid").toString();
    	String curdirname = userDao.getCurDirName(curdirid);
    	String wholePath = getWholePath(curdirname, curdirid, username);
	    String firstname = session.getAttribute("firstname").toString();
    	String dataDirectory =basepath+"/"+wholePath;  
    	System.out.println(fileName);
    	System.out.println(URLDecoder.decode(fileName,"utf-8"));
    	Path file = Paths.get(dataDirectory, URLDecoder.decode(fileName,"utf-8"));
    	System.out.println("filepath="+file);
        if (Files.exists(file))
        {
            response.setContentType("multipart/form-data");
            response.addHeader("Content-Disposition", "attachment; filename=" + fileName);
            try
            {
                Files.copy(file, response.getOutputStream());
                response.getOutputStream().flush();
            }
            catch (IOException ex) {
                ex.printStackTrace();
            }
        }else{
        	System.out.println(dataDirectory+"/"+fileName);
        }
    }
    
    public void setServletContext(ServletContext servletContext) {   
        this.servletContext = servletContext;   
    }   
    
  //将传过来的dirName联系directory表，把从fatherid=0的根目录到dirName的完整目录链取出来
    public String getWholePath(String curdirname, String curdirid, String username){
    	System.out.println("current dir name is " + curdirname);
    	System.out.println("current dir id is "+curdirid);
    	System.out.println("username is "+username);
    	String tempDirName = curdirname;
    	//String wholePath = "";
    	if(userDao.getFatherId(curdirid).equals(0)){
    		System.out.println("return of getWholePath is "+tempDirName);
    		return tempDirName;
    	}else{
    		String fatherDirName = userDao.getCurDirName(userDao.getFatherId(curdirid).toString());
    		tempDirName=getWholePath(fatherDirName,userDao.getFatherId(curdirid).toString(),username)+"/"+tempDirName;
    		System.out.println("return of getWholePath is "+tempDirName);
    		return tempDirName;
    	}
    	
    }
}