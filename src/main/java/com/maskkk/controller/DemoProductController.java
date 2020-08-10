package com.maskkk.controller;

import java.io.InputStream; 
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import com.maskkk.dao.UserDao;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 

@Controller
@RequestMapping(value="/spring")
public class DemoProductController
{
	// Define a static logger variable so that it references the
	private static final Logger logger = LogManager.getLogger(DemoProductController.class);
	//上传的文件就转存到相关的目录路径下，文件名保持不变
	@Autowired
	public UserDao userDao;
	@RequestMapping(value="/save-product", method = RequestMethod.POST)  
    public void upload(@RequestParam ("file") CommonsMultipartFile  file, HttpServletRequest req, HttpServletResponse response) throws IOException{  
        String basepath="F:/HTML/SpringMVC/wtpwebapps/Upload/fileupload";
    	PrintWriter printWriter = null;
    	try{
    		    HttpSession session = req.getSession();
        	    String username = session.getAttribute("username").toString();
        	    String firstname = session.getAttribute("firstname").toString();
        	    String curdirid = session.getAttribute("curdirid").toString();
            	String curdirname = userDao.getCurDirName(curdirid);
            	String wholePath = getWholePath(curdirname, curdirid, username);
		    	String path =basepath+"/"+wholePath;  
		        System.out.println(req.getSession().getServletContext().getRealPath("/") );  
    		    System.out.println(path);
		        System.out.println(req.getServletContext().getRealPath("/WEB-INF/downloads/pdf/"));
    		    /*String rootPath = "/home/upload";
    	        String filePath = rootPath + "/";
    	        File dir = new File(filePath);
    	        if (!dir.isDirectory())
    	            dir.mkdir();*/
		        InputStream is=file.getInputStream();  
		         
		        OutputStream os =new FileOutputStream(new File(path ,file.getOriginalFilename()));  
		        
		        int length=0;  
		        byte [] buffer=new byte[128];  
		        while((length=is.read(buffer))!=-1)  
		        {  
		            os.write(buffer,0, length);  
		        }  
		        is.close();  
		        os.close();  
		        JSONObject obj = new JSONObject();
		        //return obj;
		        printWriter = response.getWriter();
		        printWriter.print(obj);
		        //
		        //ModelAndView mView=new ModelAndView();  
		        //mView.setViewName("upload");  
		        //
		        
		        //return "uploaded";
        }catch(Exception e){
        	printWriter = response.getWriter();
            printWriter.print(e.toString());
        }
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
	
    //上传文件相关的
    @RequestMapping(value = "/product-input-form")
    public String inputProduct(Model model) {
        return "productForm";
    }
    
 
 	 //上传的文件就转存到相关的目录路径下，文件名保持不变
     @RequestMapping(value="/{dirName}/save-multi-product", method = RequestMethod.POST)  
     public void multiupload(@PathVariable("dirName") String dirName, @RequestParam ("file[]") CommonsMultipartFile  file[], HttpServletRequest req, HttpServletResponse response) throws IOException
     {  
        String basepath="F:/HTML/SpringMVC/wtpwebapps/Upload/fileupload";
     	PrintWriter printWriter = null;
     	try{
     		    HttpSession session = req.getSession();
         	    String username = session.getAttribute("username").toString();
         	    String firstname = session.getAttribute("firstname").toString();
         	    String curdirid = session.getAttribute("curdirid").toString();
           	    String curdirname = userDao.getCurDirName(curdirid);
           	    String wholePath = getWholePath(curdirname, curdirid, username);
 		    	String path =basepath+"/"+wholePath;  
 		        System.out.println(req.getSession().getServletContext().getRealPath("/") );  
     		    System.out.println(path);
 		        System.out.println(req.getServletContext().getRealPath("/WEB-INF/downloads/pdf/"));
     		    /*String rootPath = "/home/upload";
     	        String filePath = rootPath + "/";
     	        File dir = new File(filePath);
     	        if (!dir.isDirectory())
     	            dir.mkdir();*/
 		        for(int i = 0;i<file.length; i++){
 		        	InputStream is=file[i].getInputStream();   	 		         
 	 		        OutputStream os =new FileOutputStream(new File(path ,file[i].getOriginalFilename()));   	 		        
 	 		        int length=0;  
 	 		        byte [] buffer=new byte[128];  
 	 		        while((length=is.read(buffer))!=-1)  
 	 		        {  
 	 		            os.write(buffer,0, length);  
 	 		        }  
 	 		        is.close();  
 	 		        os.close();  
 	 		        JSONObject obj = new JSONObject();
 	 		        //return obj;
 	 		        printWriter = response.getWriter();
 	 		        printWriter.print(obj);
 	 		        //
 	 		        //ModelAndView mView=new ModelAndView();  
 	 		        //mView.setViewName("upload");  
 	 		        //
 	 		        
 	 		        //return "uploaded";
 		        }
 		        
         }catch(Exception e){
         	printWriter = response.getWriter();
             printWriter.print(e.toString());
         }
       }  
}