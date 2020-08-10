package com.maskkk.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maskkk.dao.UserDao;
import com.maskkk.util.Base64Img;

/*@SessionAttributes(value={"username","firstname"})*/
@Controller
@RequestMapping("/spring")
public class ListFileController
{   
	@Autowired
	public UserDao userDao;
	// Define a static logger variable so that it references the
	private static final Logger logger = LogManager.getLogger(ListFileController.class);
    private Base64Img bimg = new Base64Img();
	 //返回文件列表
    @RequestMapping(value="/{dirName}/filelist", method = RequestMethod.GET)  
    public ModelAndView fileList(@PathVariable("dirName") String dirName, HttpServletRequest req) throws IOException{  
    	System.out.println("call my fileList");
    	//Map modelMap = model.asMap();
    	HttpSession session = req.getSession();
    	String username = session.getAttribute("username").toString();
    	//test
    	//String username = "ttt";
    	String curdirname = URLDecoder.decode(dirName,"utf-8");
    	//test
    	String curdirid =userDao.getCurDirIdByDirname(curdirname); 
    	session.setAttribute("curdirid", curdirid);
    	//将传过来的dirName联系directory表，把从fatherid=0的根目录到dirName的完整目录链取出来
    	String dirPath = getWholePath(curdirname, curdirid, username);
    	System.out.println(dirPath);
    	String firstname = session.getAttribute("firstname").toString();
    	/*String username = user.getUsername();
    	String firstname = user1.getFirstname();*/
    	logger.debug(username);
    	logger.debug("current dir id is: "+ curdirid);
    	logger.debug(firstname);
    	File f = new File("F:/HTML/SpringMVC/wtpwebapps/Upload/fileupload/" + dirPath);
    	String baseFolder = "F:/HTML/SpringMVC/wtpwebapps/Upload/fileupload/" + dirPath;
    	logger.debug("baseFolder = "+baseFolder);
    	String attr = "";
    	ArrayList al = new ArrayList();
    	
    	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	if(f.isDirectory()) {  
            File[] files = f.listFiles();  
            for (File ff : files) { 
            	System.out.println(ff.toString());
                //判断是否是文件对象  
                if(ff.isFile()) 
                	attr += "file";
                else if(ff.isDirectory())
                	attr += userDao.getCurDirIdByDirname(ff.getName(),curdirid);
                if("jpg".equals(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase())
                	|| "gif".equals(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase())
                	|| "png".equals(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase())
                	|| "bmp".equals(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase()))
                {
                	attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");	
                }else{
                	attr += "@#￥" + ff.getName();
                }
                //attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                attr += "@#￥" + String.valueOf(ff.length());
                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                al.add(attr);
                attr = "";
                   
            }  
        }  
    	ModelAndView mav = new ModelAndView("filelist");
    	mav.addObject("fileattr", al);
    	mav.addObject("firstname",firstname);
    	mav.addObject("baseUploadFolder", baseFolder);
    	Map<String,String> map_return = new LinkedHashMap<String, String>();
    	String singledir[] = dirPath.split("/");
    	for(int i=0; i<singledir.length; i++){
    		map_return.put(singledir[i], userDao.getCurDirIdByDirname(singledir[i]));
    		System.out.println(singledir[i]+" : "+userDao.getCurDirIdByDirname(singledir[i]));
    	}
    	mav.addObject("curdirname", map_return);
    	return mav;
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
    
@RequestMapping(value="/{dirid}/filelist_id", method = RequestMethod.GET)  
    
    public ModelAndView fileList_id(@PathVariable("dirid") Integer dirid, HttpServletRequest req) throws IOException{  
    	System.out.println("call my fileList");
    	//Map modelMap = model.asMap();
    	HttpSession session = req.getSession();
    	String username = session.getAttribute("username").toString();
    	String curdirid =dirid.toString(); 
    	String curdirname = userDao.getCurDirName(curdirid);
    	session.setAttribute("curdirid", curdirid);
    	//将传过来的dirName联系directory表，把从fatherid=0的根目录到dirName的完整目录链取出来
    	String dirPath = getWholePath(curdirname, curdirid, username);
    	System.out.println(dirPath);
    	String firstname = session.getAttribute("firstname").toString();
    	/*String username = user.getUsername();
    	String firstname = user1.getFirstname();*/
    	logger.debug(username);
    	logger.debug("current dir id is: "+ curdirid);
    	logger.debug(firstname);
    	File f = new File("F:/HTML/SpringMVC/wtpwebapps/Upload/fileupload/" + dirPath);
    	String baseFolder = "F:/HTML/SpringMVC/wtpwebapps/Upload/fileupload/" + dirPath;
    	logger.debug("baseFolder = "+baseFolder);
    	String attr = "";
    	ArrayList al = new ArrayList();
    	
    	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	if(f.isDirectory()) {  
            File[] files = f.listFiles();  
            for (File ff : files) { 
            	System.out.println(ff.toString());
                //判断是否是文件对象  
                if(ff.isFile()) 
                	attr += "file";
                else if(ff.isDirectory())
                	attr += userDao.getCurDirIdByDirname(ff.getName(),curdirid);
                if("jpg".equals(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase())
                	|| "gif".equals(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase())
                	|| "png".equals(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase())
                	|| "bmp".equals(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase()))
                {
                	attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");	
                }else{
                	attr += "@#￥" + ff.getName();
                }
                //attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                attr += "@#￥" + String.valueOf(ff.length());
                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                al.add(attr);
                attr = "";                   
            }  
        }  
    	ModelAndView mav = new ModelAndView("filelist");
    	mav.addObject("fileattr", al);
    	mav.addObject("firstname",firstname);
    	mav.addObject("baseUploadFolder", baseFolder);
    	Map<String,String> map_return = new LinkedHashMap<String, String>();
    	String singledir[] = dirPath.split("/");
    	for(int i=0; i<singledir.length; i++){
    		map_return.put(singledir[i], userDao.getCurDirIdByDirname(singledir[i]));
    		System.out.println(singledir[i]+" : "+userDao.getCurDirIdByDirname(singledir[i]));
    	}
    	mav.addObject("curdirname", map_return);
    	return mav;
    }   
    
   //返回文件网格布局方式
    @RequestMapping(value="/filelayout", method = RequestMethod.POST)  
    
    @ResponseBody  
    public List<String> filelayout(HttpServletRequest req) throws IOException{  
    	HttpSession session = req.getSession();
    	String username = session.getAttribute("username").toString();
    	System.out.println("call my fileLayout");
    	File f = new File("F:/HTML/SpringMVC/wtpwebapps/Upload/fileupload/" + username);
    	String attr = "";
    	ArrayList al = new ArrayList();
    	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	if(f.isDirectory()) {  
            File[] files = f.listFiles();  
            for (File ff : files) {  
                //判断是否是文件对象  
                if(ff.isFile()) 
                	attr += "file";
                else if(ff.isDirectory())
                	attr += "directory";
                if("jpg".equals(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase())
                    	|| "gif".equals(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase())
                    	|| "png".equals(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase())
                    	|| "bmp".equals(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase()))
                    {
                    	attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");	
                    }else{
                    	attr += "@#￥" + ff.getName();
                    }
                attr += "@#￥" + String.valueOf(ff.length());
                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                al.add(attr);
                attr = "";
                   
            }  
        }  
    	//ModelAndView mav = new ModelAndView("filelist");
    	//mav.addObject("fileattr", al);
    	//mav.addObject("basePath", "D/Work_Now/workspace_jee/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/Upload/fileupload");
        return al;
    }   
    
    //返回按照col1或者col2升降序排列的文件列表
    @RequestMapping(value="/col12Sort", method = RequestMethod.GET)  
    @ResponseBody  
    public List<String> col12Sort(HttpServletRequest req) throws IOException{
    	HttpSession session = req.getSession();
    	String username = session.getAttribute("username").toString();
    	String namesort = req.getParameter("name");
    	String direction = req.getParameter("direction");
    	String col1 = req.getParameter("col1");
    	String col2 = req.getParameter("col2");
    	String attr = "";
    	logger.debug("name="+namesort);
    	logger.debug("direction="+direction);
    	logger.debug("col1="+col1);
    	logger.debug("col2="+col2);
    	File f = new File("F:/HTML/SpringMVC/wtpwebapps/Upload/fileupload/" + username);
    	ArrayList al = new ArrayList();
    	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	if(f.isDirectory()) { 
    		if (namesort.equals("col1")){
    			//升序
    			if(direction.equals("asc")){
    				File[] files = this.sort_ext(f.listFiles(),col1,"asc",username);
    				logger.debug("files="+files);
    				if(col1.equals("lastmodifytime")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
    	                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                               
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + username;
                                al.add(attr);
                                attr = "";
        					}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                                al.add(attr);
                                attr = "";
        					}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
                                
                                al.add(attr);
                                attr = "";
        					}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + String.valueOf(ff.length());
                                
                                al.add(attr);
                                attr = "";
        					}
        				}
    				}else if(col1.equals("owner")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + username;
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}else if(col1.equals("type")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" +String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + username;
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}else if(col1.equals("ext")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" +String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + f.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + username;
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}else if(col1.equals("length")){
    					if(col2.equals("lastmodifytime")){
    				        logger.debug("进入了！！！！！");
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        logger.debug(String.valueOf(ff.length()));
    	                        attr += "@#￥" +String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){        					
        						for (File ff : files) {  
        	                        //判断是否是文件对象  
        	                        if(ff.isFile()) 
        	                        	attr += "file";
        	                        else if(ff.isDirectory())
        	                        	attr += "directory";
        	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
        	                        attr += "@#￥" + String.valueOf(ff.length());
        	                        attr += "@#￥" + username;
        	                        al.add(attr);
        	                        attr = "";
        						}
        				}else if(col2.equals("type")){
        					
        						for (File ff : files) {  
        	                        //判断是否是文件对象  
        	                        if(ff.isFile()) 
        	                        	attr += "file";
        	                        else if(ff.isDirectory())
        	                        	attr += "directory";
        	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
        	                        attr += "@#￥" + String.valueOf(ff.length());
        	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
        	                        al.add(attr);
        	                        attr = "";
        						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}
        			/*for (File ff : files) {  
                        //判断是否是文件对象  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName();
                        attr += "@#￥" + String.valueOf(ff.length());
                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                        al.add(attr);
                        attr = "";
        			}*/
    			//降序	
    			}else if(direction.equals("desc")){
    				File[] files = this.sort_ext(f.listFiles(),col1,"desc",username);
    				logger.debug("files="+files);
    				if(col1.equals("lastmodifytime")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
    	                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");                               
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + username;
                                al.add(attr);
                                attr = "";
        					}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                                
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                                al.add(attr);
                                attr = "";
        					}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
                                
                                al.add(attr);
                                attr = "";
        					}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + String.valueOf(ff.length());
                                
                                al.add(attr);
                                attr = "";
        					}
        				}
    				}else if(col1.equals("owner")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + username;
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}else if(col1.equals("type")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" +String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + username;
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}else if(col1.equals("ext")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" +String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + username;
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}else if(col1.equals("length")){
    					if(col2.equals("lastmodifytime")){
    				        logger.debug("进入了！！！！！");
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        logger.debug(String.valueOf(ff.length()));
    	                        attr += "@#￥" +String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					
        						for (File ff : files) {  
        	                        //判断是否是文件对象  
        	                        if(ff.isFile()) 
        	                        	attr += "file";
        	                        else if(ff.isDirectory())
        	                        	attr += "directory";
        	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
        	                        attr += "@#￥" + String.valueOf(ff.length());
        	                        attr += "@#￥" + username;
        	                        al.add(attr);
        	                        attr = "";
        						}
        				}else if(col2.equals("type")){
        					
        						for (File ff : files) {  
        	                        //判断是否是文件对象  
        	                        if(ff.isFile()) 
        	                        	attr += "file";
        	                        else if(ff.isDirectory())
        	                        	attr += "directory";
        	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
        	                        attr += "@#￥" + String.valueOf(ff.length());
        	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
        	                        al.add(attr);
        	                        attr = "";
        						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}
        			/*for (File ff : files) {  
                        //判断是否是文件对象  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName();
                        attr += "@#￥" + String.valueOf(ff.length());
                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                        al.add(attr);
                        attr = "";
        			}*/
    			//降序	
    			
    		    }
				
			}else if(namesort.equals("col2")){

    			//升序
    			if(direction.equals("asc")){
    				File[] files = this.sort_ext(f.listFiles(),col2,"asc",username);
    				logger.debug("files="+files);
    				if(col1.equals("lastmodifytime")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
    	                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                               
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + username;
                                al.add(attr);
                                attr = "";
        					}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                                
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                                al.add(attr);
                                attr = "";
        					}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
                                
                                al.add(attr);
                                attr = "";
        					}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + String.valueOf(ff.length());
                                
                                al.add(attr);
                                attr = "";
        					}
        				}
    				}else if(col1.equals("owner")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + username;
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}else if(col1.equals("type")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" +String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + username;
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}else if(col1.equals("ext")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" +String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + f.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + username;
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}else if(col1.equals("length")){
    					if(col2.equals("lastmodifytime")){
    				        logger.debug("进入了！！！！！");
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        logger.debug(String.valueOf(ff.length()));
    	                        attr += "@#￥" +String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					
        						for (File ff : files) {  
        	                        //判断是否是文件对象  
        	                        if(ff.isFile()) 
        	                        	attr += "file";
        	                        else if(ff.isDirectory())
        	                        	attr += "directory";
        	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
        	                        attr += "@#￥" + String.valueOf(ff.length());
        	                        attr += "@#￥" + username;
        	                        al.add(attr);
        	                        attr = "";
        						}
        				}else if(col2.equals("type")){
        					
        						for (File ff : files) {  
        	                        //判断是否是文件对象  
        	                        if(ff.isFile()) 
        	                        	attr += "file";
        	                        else if(ff.isDirectory())
        	                        	attr += "directory";
        	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
        	                        attr += "@#￥" + String.valueOf(ff.length());
        	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
        	                        al.add(attr);
        	                        attr = "";
        						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}
        			/*for (File ff : files) {  
                        //判断是否是文件对象  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName();
                        attr += "@#￥" + String.valueOf(ff.length());
                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                        al.add(attr);
                        attr = "";
        			}*/
    			//降序	
    			}else if(direction.equals("desc")){

    				File[] files = this.sort_ext(f.listFiles(),col2,"desc",username);
    				logger.debug("files="+files);
    				if(col1.equals("lastmodifytime")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
    	                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                               
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + username;
                                al.add(attr);
                                attr = "";
        					}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                                
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                                al.add(attr);
                                attr = "";
        					}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
                                
                                al.add(attr);
                                attr = "";
        					}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
                                //判断是否是文件对象  
                                if(ff.isFile()) 
                                	attr += "file";
                                else if(ff.isDirectory())
                                	attr += "directory";
                                attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                                attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                                attr += "@#￥" + String.valueOf(ff.length());
                                
                                al.add(attr);
                                attr = "";
        					}
        				}
    				}else if(col1.equals("owner")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + username;
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + username;
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}else if(col1.equals("type")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" +String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + username;
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}else if(col1.equals("ext")){
    					if(col2.equals("lastmodifytime")){
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" +String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + f.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + username;
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("type")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}else if(col1.equals("length")){
    					if(col2.equals("lastmodifytime")){
    				        logger.debug("进入了！！！！！");
    						for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        logger.debug(String.valueOf(ff.length()));
    	                        attr += "@#￥" +String.valueOf(df.format(ff.lastModified()));
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("owner")){
        					
        						for (File ff : files) {  
        	                        //判断是否是文件对象  
        	                        if(ff.isFile()) 
        	                        	attr += "file";
        	                        else if(ff.isDirectory())
        	                        	attr += "directory";
        	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
        	                        attr += "@#￥" + String.valueOf(ff.length());
        	                        attr += "@#￥" + username;
        	                        al.add(attr);
        	                        attr = "";
        						}
        				}else if(col2.equals("type")){
        					
        						for (File ff : files) {  
        	                        //判断是否是文件对象  
        	                        if(ff.isFile()) 
        	                        	attr += "file";
        	                        else if(ff.isDirectory())
        	                        	attr += "directory";
        	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
        	                        attr += "@#￥" + String.valueOf(ff.length());
        	                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
        	                        al.add(attr);
        	                        attr = "";
        						}
        				}else if(col2.equals("ext")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}else if(col2.equals("length")){
        					for (File ff : files) {  
    	                        //判断是否是文件对象  
    	                        if(ff.isFile()) 
    	                        	attr += "file";
    	                        else if(ff.isDirectory())
    	                        	attr += "directory";
    	                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        attr += "@#￥" + String.valueOf(ff.length());
    	                        al.add(attr);
    	                        attr = "";
    						}
        				}
    				}
        			/*for (File ff : files) {  
                        //判断是否是文件对象  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName();
                        attr += "@#￥" + String.valueOf(ff.length());
                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                        al.add(attr);
                        attr = "";
        			}*/
    			//降序	
    			
    		    }
				
			
			}
			
		}
    	attr=direction+"@#￥"+colName(col1)+"@#￥"+colName(col2);
    	al.add(attr);
        return al;	
	   }	
              
    
    //返回按照文件名升降序排列的文件列表
    @RequestMapping(value="/fileNameSort", method = RequestMethod.GET)  
    @ResponseBody  
    public List<String> fileNameSort(HttpServletRequest req) throws IOException{
    	HttpSession session = req.getSession();
    	String username = session.getAttribute("username").toString();
    	String namesort = req.getParameter("name");
    	String col1sort = req.getParameter("col1");
    	String col2sort = req.getParameter("col2");
    	logger.debug("******************************************");
    	logger.debug("name="+namesort);
    	logger.debug("col1="+col1sort);
    	logger.debug("col2="+col2sort);
    	File f = new File("F:/HTML/SpringMVC/wtpwebapps/Upload/fileupload/" + username);
    	String attr = "";
    	ArrayList al = new ArrayList();
    	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	
    	if(f.isDirectory()) {  
    		//名称升序
    		if (namesort.equals("asc")){
    			File[] files = this.sort(f.listFiles(),"asc");
    			for (File ff : files) {  
                    //判断是否是文件对象  
                    if(ff.isFile()) 
                    	attr += "file";
                    else if(ff.isDirectory())
                    	attr += "directory";
                    attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                    if(col1sort.equals("lastmodifytime")){
                    	attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                    }else if(col1sort.equals("owner")){
                    	attr += "@#￥" + username;
                    }else if(col1sort.equals("type")){
                    	attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                    }else if(col1sort.equals("ext")){
                    	attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1);
                    }else if(col1sort.equals("length")){
                    	attr += "@#￥" + String.valueOf(ff.length());
                    }
                    if(col2sort.equals("lastmodifytime")){
                    	attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                    }else if(col2sort.equals("owner")){
                    	attr += "@#￥" + username;
                    }else if(col2sort.equals("type")){
                    	attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                    }else if(col2sort.equals("ext")){
                    	attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1);
                    }else if(col2sort.equals("length")){
                    	attr += "@#￥" + String.valueOf(ff.length());
                    }
                    al.add(attr);
                    attr = "";
                     
                }  
    			attr = namesort+"@#￥"+colName(col1sort)+"@#￥"+colName(col2sort);
    		//名称降序
        	}else if(namesort.equals("desc")) {
        		File[] files = this.sort(f.listFiles(),"desc");
        		for (File ff : files) {  
                    //判断是否是文件对象  
                    if(ff.isFile()) 
                    	attr += "file";
                    else if(ff.isDirectory())
                    	attr += "directory";
                    attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                    if(col1sort.equals("lastmodifytime")){
                    	attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                    }else if(col1sort.equals("owner")){
                    	attr += "@#￥" + username;
                    }else if(col1sort.equals("type")){
                    	attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                    }else if(col1sort.equals("ext")){
                    	attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1);
                    }else if(col1sort.equals("length")){
                    	attr += "@#￥" + String.valueOf(ff.length());
                    }
                    if(col2sort.equals("lastmodifytime")){
                    	attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                    }else if(col2sort.equals("owner")){
                    	attr += "@#￥" + username;
                    }else if(col2sort.equals("type")){
                    	attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                    }else if(col2sort.equals("ext")){
                    	attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1);
                    }else if(col2sort.equals("length")){
                    	attr += "@#￥" + String.valueOf(ff.length());
                    }
                    al.add(attr);
                    attr = "";
                       
                }  
        		attr = namesort+"@#￥"+colName(col1sort)+"@#￥"+colName(col2sort);
        	}
            //在Col这个列下面按照文件扩展名来排列
    		if(col1sort.equals("ext") && namesort.equals("null")){
    			if(col2sort.equals("lastmodifytime")){
    				File[] files = f.listFiles();
        			for (File ff : files) {  
                        //判断是否是文件对象  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1);
                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                        al.add(attr);
                        attr = "";
    			    }
        			attr = namesort+"@#￥"+colName(col1sort)+"@#￥"+colName(col2sort);
    			}
                if(col2sort.equals("owner")){
                	File[] files = f.listFiles();
        			for (File ff : files) {  
                        //判断是否是文件对象  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1);
                        attr += "@#￥" + username;
                        al.add(attr);
                        attr = "";
						
					}	
        			attr = namesort+"@#￥扩展名@#￥成员";
    			}
                
                if(col2sort.equals("type")){
                	File[] files = f.listFiles();
                	for (File ff : files) {  
                        //判断是否是文件对象  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1);
                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                        al.add(attr);
                        attr = "";
					} 
                	attr = namesort+"@#￥扩展名@#￥类型";
				}
                
                if(col2sort.equals("ext")){
                	File[] files = f.listFiles();
                	for (File ff : files) {  
                        //判断是否是文件对象  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1);
                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
                        al.add(attr);
                        attr = "";
					}
                	attr = namesort+"@#￥扩展名@#￥扩展名";
    			}
                
                if(col2sort.equals("length")){
                	File[] files = f.listFiles();
                	for (File ff : files) {  
                        //判断是否是文件对象  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1);
                        attr += "@#￥" + ff.length();
                        al.add(attr);
                        attr = "";
					}
                	attr = namesort+"@#￥扩展名@#￥大小";
    			}
    			
                       
            }else if (col1sort.equals("owner") && namesort.equals("null")){
                if(col2sort.equals("lastmodifytime")){
                	File[] files = f.listFiles();
                	for (File ff : files) {  
                        //判断是否是文件对象  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                        attr += "@#￥" + username;
                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                        al.add(attr);
                        attr = "";
					}	
                	attr = namesort+"@#￥成员@#￥最后修改时间";
    			}
    			
                if(col2sort.equals("owner")){
                	File[] files = f.listFiles();
                	for (File ff : files) {  
                        //判断是否是文件对象  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                        attr += "@#￥" + username;
                        attr += "@#￥" + username;
                        al.add(attr);
                        attr = "";
					}
                	attr = namesort+"@#￥成员@#￥成员";
    			}
                
                if(col2sort.equals("type")){
                	File[] files = f.listFiles();
                	for (File ff : files) {  
                        //判断是否是文件对象  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                        attr += "@#￥" + username;
                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                        al.add(attr);
                        attr = "";
					}
                	attr = namesort+"@#￥成员@#￥类型";
    			}
                
                if(col2sort.equals("ext")){
                	File[] files = f.listFiles();
                	for (File ff : files) {  
                        //判断是否是文件对象  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                        attr += "@#￥" + username;
                        attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase();
                        al.add(attr);
                        attr = "";
					}
                	attr = namesort+"@#￥成员@#￥扩展名";
    			}
                
                if(col2sort.equals("length")){
                	File[] files = f.listFiles();
                	for (File ff : files) {  
                        //判断是否是文件对象  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                        attr += "@#￥" + username;
                        attr += "@#￥" + ff.length();
                        al.add(attr);
                        attr = "";
					}	
                	attr = namesort+"@#￥成员@#￥大小";
    			}
    			
    			
          //按照文件类型排序  
          } else if (col1sort.equals("type") && namesort.equals("null")){
        	  if(col2sort.equals("lastmodifytime")){
        		  File[] files = f.listFiles();
        		  for (File ff : files) {  
                        if(ff.isFile()) 
                        	attr += "file";
                        else if(ff.isDirectory())
                        	attr += "directory";
                        attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                        attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                        attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                        al.add(attr);
                        attr = "";
        		  }
        		  attr = namesort+"@#￥类型@#￥最后修改时间";
  			  }
  			
              if(col2sort.equals("owner")){ 
            	  File[] files = f.listFiles();
            	  for (File ff : files) {  
                      if(ff.isFile()) 
                      	attr += "file";
                      else if(ff.isDirectory())
                      	attr += "directory";
                      attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                      attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                      attr += "@#￥" + username;
                      al.add(attr);
                      attr = "";
      		       }
            	  attr = namesort+"@#￥类型@#￥成员";
      		 
  			  }
              
              if(col2sort.equals("type")){
            	  File[] files = f.listFiles();
            	  for (File ff : files) {  
                      if(ff.isFile()) 
                      	attr += "file";
                      else if(ff.isDirectory())
                      	attr += "directory";
                      attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                      attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                      attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                      al.add(attr);
                      attr = "";
				  }  
            	  attr = namesort+"@#￥类型@#￥类型";
			 
  			}
              
              if(col2sort.equals("ext")){
            	  File[] files = f.listFiles();
            	  for (File ff : files) {  
                      if(ff.isFile()) 
                      	attr += "file";
                      else if(ff.isDirectory())
                      	attr += "directory";
                      attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                      attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                      attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1);
                      al.add(attr);
                      attr = "";
				  }
            	  attr = namesort+"@#￥类型@#￥扩展名";
  			}
              
              if(col2sort.equals("length")){
            	  File[] files = f.listFiles();
            	  for (File ff : files) {  
                      if(ff.isFile()) 
                      	attr += "file";
                      else if(ff.isDirectory())
                      	attr += "directory";
                      attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                      attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                      attr += "@#￥" + ff.length();
                      al.add(attr);
                      attr = "";
				  }
            	  attr = namesort+"@#￥类型@#￥大小";
  			}
  			
  			
          //按照文件最后修改时间排序
          }else if(col1sort.equals("lastmodifytime") && namesort.equals("null")){
        	  if(col2sort.equals("lastmodifytime")){
        		  File[] files = f.listFiles();
        		  for (File ff : files) {  
                      //判断是否是文件对象  
                      if(ff.isFile()) 
                      	attr += "file";
                      else if(ff.isDirectory())
                      	attr += "directory";
                      attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                      attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                      attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                      al.add(attr);
                      attr = "";
			      }		  
        		  attr = namesort+"@#￥最后修改时间@#￥最后修改时间";
  			}
  			
              if(col2sort.equals("owner")){
            	  File[] files = f.listFiles();
            		  for (File ff : files) {  
                          //判断是否是文件对象  
                          if(ff.isFile()) 
                          	attr += "file";
                          else if(ff.isDirectory())
                          	attr += "directory";
                          attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                          attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                          attr += "@#￥" + username;
                          al.add(attr);
                          attr = "";
            		  }
               attr = namesort+"@#￥最后修改时间@#￥成员";
  			  }
              
              if(col2sort.equals("type")){
            	  File[] files = f.listFiles();
            		  for (File ff : files) {  
                          //判断是否是文件对象  
                          if(ff.isFile()) 
                          	attr += "file";
                          else if(ff.isDirectory())
                          	attr += "directory";
                          attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                          attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                          attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1));
                          al.add(attr);
                          attr = "";
            		  }
            		  attr = namesort+"@#￥最后修改时间@#￥类型";
  			  }
              
              if(col2sort.equals("ext")){
            	  File[] files = f.listFiles();
            	  for (File ff : files) {  
                      //判断是否是文件对象  
                      if(ff.isFile()) 
                      	attr += "file";
                      else if(ff.isDirectory())
                      	attr += "directory";
                      attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                      attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                      attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1);
                      al.add(attr);
                      attr = "";
        		  }
            	  attr = namesort+"@#￥最后修改时间@#￥扩展名";
  			  }
              
              if(col2sort.equals("length")){
            	  File[] files = f.listFiles();
            	  for (File ff : files) {  
                      //判断是否是文件对象  
                      if(ff.isFile()) 
                      	attr += "file";
                      else if(ff.isDirectory())
                      	attr += "directory";
                      attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                      attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                      attr += "@#￥" + ff.length();
                      al.add(attr);
                      attr = "";
        		  }
            	  attr = namesort+"@#￥最后修改时间@#￥大小";
  			   }
        	 
    		
      	  //按照文件大小排序	
    	  }else if(col1sort.equals("length") && namesort.equals("null")){
    		  if(col2sort.equals("lastmodifytime")){
    			  File[] files = f.listFiles();
    			  for (File ff : files) {  
                      //判断是否是文件对象  
                      if(ff.isFile()) 
                      	attr += "file";
                      else if(ff.isDirectory())
                      	attr += "directory";
                      attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                      attr += "@#￥" + ff.length();
                      attr += "@#￥" + String.valueOf(df.format(ff.lastModified()));
                      al.add(attr);
                      attr = "";
    			  }
    			  attr = namesort+"@#￥大小@#￥最后修改时间"; 
    		  }
  			
              if(col2sort.equals("owner")){
            	  File[] files = f.listFiles();
            	  for (File ff : files) {  
                      //判断是否是文件对象  
                      if(ff.isFile()) 
                      	attr += "file";
                      else if(ff.isDirectory())
                      	attr += "directory";
                      attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                      attr += "@#￥" + ff.length();
                      attr += "@#￥" + username;
                      al.add(attr);
                      attr = "";
    			  }
            	  attr = namesort+"@#￥大小@#￥成员"; 
  			  }
              
              if(col2sort.equals("type")){
            	  File[] files = f.listFiles();
            	  for (File ff : files) {  
                      //判断是否是文件对象  
                      if(ff.isFile()) 
                      	attr += "file";
                      else if(ff.isDirectory())
                      	attr += "directory";
                      attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                      attr += "@#￥" + ff.length();
                      attr += "@#￥" + this.type(ff.getName().substring(ff.getName().indexOf(".")+1).toLowerCase());
                      al.add(attr);
                      attr = "";
    			  }
            	  attr = namesort+"@#￥大小@#￥类型"; 
  			   }
              
              if(col2sort.equals("ext")){
            	  File[] files = f.listFiles();
            	  for (File ff : files) {  
                      //判断是否是文件对象  
                      if(ff.isFile()) 
                      	attr += "file";
                      else if(ff.isDirectory())
                      	attr += "directory";
                      attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                      attr += "@#￥" + ff.length();
                      attr += "@#￥" + ff.getName().substring(ff.getName().indexOf(".")+1);
                      al.add(attr);
                      attr = "";
    			  }
            	  attr = namesort+"@#￥大小@#￥扩展名"; 
  			   }
              
              if(col2sort.equals("length")){
            	  File[] files = f.listFiles();
            	  for (File ff : files) {  
                      //判断是否是文件对象  
                      if(ff.isFile()) 
                      	attr += "file";
                      else if(ff.isDirectory())
                      	attr += "directory";
                      attr += "@#￥" + ff.getName()+"^^^^^^"+URLEncoder.encode(bimg.GetImageStrFromPath(ff.toString()),"utf-8");
                      attr += "@#￥" + ff.length();
                      attr += "@#￥" + ff.length();
                      al.add(attr);
                      attr = "";
    			  }
            	  attr = namesort+"@#￥大小@#￥大小"; 
  			  }
    	   
           }
    		
		} 
    		al.add(attr);
            return al;
    }
    
    @RequestMapping("/Hello")
    public String FC() {
       return "Hello"  ; 
    }
    public static File[] sort_asc(File[] s, int index, int length){
    	//中间值
        File temp =null;
        //外循环:我认为最小的数,从0~长度-1
        for(int j = 0; j<s.length-1;j++){
            //最小值:假设第一个数就是最小的
        	logger.debug(s[j].getName());
            String min = s[j].getName();
            //记录最小数的下标的
            int minIndex=j;
            //内循环:拿我认为的最小的数和后面的数一个个进行比较
            for(int k=j+1;k<s.length;k++){
                    //找到最小值
                    if (min.substring(0,min.indexOf(".")).toLowerCase().compareTo(s[k].getName().substring(0,s[k].getName().indexOf(".")).toLowerCase())>0) 
                    {    //修改最小
                        min=s[k].getName();
                        minIndex=k;
                    }
            }
            
            temp = s[j];
            s[j]=s[minIndex];
            s[minIndex]=temp;
        }
        
        return s;
    }
    public static File[] sort(File[] s, String sort){
        //中间值
        File temp =null;
        //外循环:我认为最小的数,从0~长度-1
        for(int j = 0; j<s.length-1;j++){
            //最小值:假设第一个数就是最小的
        	logger.debug(s[j].getName());
            String min = s[j].getName();
            //记录最小数的下标的
            int minIndex=j;
            //内循环:拿我认为的最小的数和后面的数一个个进行比较
            //升序
            if(sort.equals("asc")){
            	for(int k=j+1;k<s.length;k++){
                    //找到最小值
                    if (min.substring(0,min.indexOf(".")).toLowerCase().compareTo(s[k].getName().substring(0,s[k].getName().indexOf(".")).toLowerCase())>0) 
                    {    //修改最小
                        min=s[k].getName();
                        minIndex=k;
                    }
                }
            //降序
            }else{
            	for(int k=j+1;k<s.length;k++){
                    //找到最大值
                    if (min.substring(0,min.indexOf(".")).toLowerCase().compareTo(s[k].getName().substring(0,s[k].getName().indexOf(".")).toLowerCase())<0) 
                    {    //修改最大
                        min=s[k].getName();
                        minIndex=k;
                    }
                }
            }
            
            //当退出内层循环就找到这次的最大/小值
            //交换位置
            temp = s[j];
            s[j]=s[minIndex];
            s[minIndex]=temp;
        }
        return s;
       }
    
    public static File[] sort_ext_type(File[] s, String col, String sort, String username){
    	if(col.equals("类型")){
    		int j=1;
    		ListTest lltt = new ListTest();
    		//ListTest lltt;
    		lltt.addListTest(type(s[0].getName().substring(s[j].getName().indexOf(".")+1).toLowerCase()), 0, 1);
    		while(j<s.length){
    			for(int i=0;i<lltt.allCategorys.size(); i++){
    				category ca = (category) lltt.allCategorys.get(i);
    				//当类型相同的时候
    				if(type(s[j].getName().substring(s[j].getName().indexOf(".")+1).toLowerCase()).equals(ca.getName())){
    					//该类型的长度+1
    					ca.setLength(ca.getLength()+1);
    					//比较s[j]和ArrayList里面同类型的文件名ASCII长度大小
    					//如果小就把s[j]放到左边
    					File temp =null;
    			        //外循环:我认为最小的数,从0~长度-1
    			        for(int jj = ca.getIndex(); jj<ca.getLength()-1; jj++){
    			            //最小值:假设s[j]就是最小的
    			        	String min = s[j].getName();
    			            //记录最小数的下标的
    			            int minIndex=j;
    			            //内循环:拿我认为的最小的数和后面的数一个个进行比较
    			                    //找到最小值
    			                    if (min.substring(0,min.indexOf(".")).toLowerCase().compareTo(s[jj].getName().substring(0,s[jj].getName().indexOf(".")).toLowerCase())>0) 
    			                    {    //修改最小
    			                        min=s[jj].getName();
    			                        minIndex=jj;
    			                    }
    			            
    			            
    			            temp = s[jj];
    			            for(int kk = jj; kk<j;kk++ ){
    			            	//s[jj]=s[]
    			            }
    			            s[jj]=s[minIndex];
    			            s[minIndex]=temp;
    			        }
    					//如果大就把s[j]放到右边
    				}
    			}
    			
    			j++;
    		}
    	}
		return s;
    }
    
    public static File[] sort_ext(File[] s, String col, String sort, String username){
    	logger.debug("sort="+sort+",col="+col);
    	//中间值
    	String min ="";
    	long min_long=-1;
        File temp =null;
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        //外循环:我认为最小的数,从0~长度-1
        for(int j = 0; j<s.length-1; j++){
            //最小值:假设第一个数就是最小的
        	//logger.debug(s[j].getName());
        	if(col.equals("lastmodifytime")){
        		min=String.valueOf(df.format(s[j].lastModified()));
        	}else if(col.equals("owner")){
        		min=username;
        	}else if(col.equals("type")){
        		min = type(s[j].getName().substring(s[j].getName().indexOf(".")+1).toLowerCase());
        	}else if(col.equals("ext")){
        		min = s[j].getName().substring(s[j].getName().indexOf(".")+1).toLowerCase();
        	}else if(col.equals("length")){
        	    min_long = s[j].length();
        	}
            //记录最小数的下标的
            int minIndex=j;
            //文件大小的比较
            if(min_long != -1){
            	 //升序
            	 if(sort.equals("asc")){
                 	for(int k=j+1;k<s.length;k++){
                         //找到最小值
                         if (min_long>s[k].length()) 
                         {    //修改最小
                             min_long=s[k].length();
                             minIndex=k;
                         }
                     }
                 //降序
                 }else if(sort.equals("desc")){
                 	for(int k=j+1;k<s.length;k++){
                         //找到最大值
                 		 if (min_long<s[k].length()) 
                         {    //修改最大
                             min_long=s[k].length();
                             minIndex=k;
                         }
                     }
                 }
            	/* temp = s[j];
                 s[j]=s[minIndex];
                 logger.debug("s["+j+"] = " + s[j]);
                 s[minIndex]=temp;*/
            //最后修改时间、成员、类型、扩展名的比较
            }else{
            	//升序
            	if(sort.equals("asc")){
                	for(int k=j+1;k<s.length;k++){
                        //找到最小值
                		if(col.equals("ext")){
               			 if (min.compareTo(s[k].getName().substring(s[k].getName().indexOf(".")+1).toLowerCase())>0) 
                            {    //修改最大
                                min=s[k].getName().substring(s[k].getName().indexOf(".")+1).toLowerCase();
                                minIndex=k;
                            }
               		   }else if(col.equals("type")){
               			if (min.compareTo(type(s[k].getName().substring(s[k].getName().indexOf(".")+1).toLowerCase()))>0) 
                           {    //修改最大
                               min=type(s[k].getName().substring(s[k].getName().indexOf(".")+1).toLowerCase());
                               minIndex=k;
                           }
               			
               		   }else if (col.equals("owner")){
               			if (min.compareTo(username)>0) 
                           {    //修改最大
                               min=username;
                               minIndex=k;
                           }
               		   }else if (col.equals("lastmodifytime")){
               			   if(min.compareTo(String.valueOf(df.format(s[k].lastModified())))>0){
               				   min=String.valueOf(df.format(s[k].lastModified()));
               				   minIndex=k;
               			   }
               		   }
                    }
                //降序
                }else if(sort.equals("desc")){
                	for(int k=j+1;k<s.length;k++){
                        //找到最大值
                		if(col.equals("ext")){
                			if (min.compareTo(s[k].getName().substring(s[k].getName().indexOf(".")+1).toLowerCase())<0) 
                             {    //修改最大
                                 min=s[k].getName().substring(s[k].getName().indexOf(".")+1).toLowerCase();
                                 minIndex=k;
                             }
                		}else if(col.equals("type")){
                			if(min.compareTo(type(s[k].getName().substring(s[k].getName().indexOf(".")+1).toLowerCase()))<0) 
                            {    //修改最大
                                min=type(s[k].getName().substring(s[k].getName().indexOf(".")+1).toLowerCase());
                                minIndex=k;
                            }
                			
                		}else if (col.equals("owner")){
                			if (min.compareTo(username)<0) 
                            {    //修改最大
                                min=username;
                                minIndex=k;
                            }
                		}else if (col.equals("lastmodifytime")){
                			   if(min.compareTo(String.valueOf(df.format(s[k].lastModified())))<0){
                   				   min=String.valueOf(df.format(s[k].lastModified()));
                   				   minIndex=k;
                   			   }
                   		   
                        }
                	}
                }
                
                
            }
            
            //当退出内层循环就找到这次的最大/小值
            //交换位置
            temp = s[j];
            s[j]=s[minIndex];
            s[minIndex]=temp;  
        }
        return s;
       }
    
    public String colName(String arg){
    	String type="";
    	if(arg.equals("lastmodifytime"))
    	{
    		type="最后修改时间";
    	}else if(arg.equals("owner"))
    	{
    		type="成员";
    	}else if(arg.equals("type"))
        {
        		type="类型";
        }else if(arg.equals("ext"))
        {
        		type="扩展名";
        }else if(arg.equals("length"))
        {
        		type="大小";
        }
    	return type;
    }
    public static String type(String arg){
    	String type="";
    	if(arg.equals("png")
    		||arg.equals("jpg")
    		||arg.equals("gif")
    		||arg.equals("bmp")
    		||arg.equals("tif")
    	  )
    	{
    		type="图片";
    	}else if(arg.equals("doc")
    		|| arg.equals("docx")
    		|| arg.equals("xls")
    		|| arg.equals("xlsx")
    		|| arg.equals("pdf")
    		|| arg.equals("txt")
    	  )
    	{
    		type="文件";
    	}else if(arg.equals("mp4")
        		|| arg.equals("avi")
        		|| arg.equals("flv")
        		
        	  )
        {
        		type="视频";
        }else if(arg.equals("sql")
        		|| arg.equals("cpp")
        		|| arg.equals("c")
        		|| arg.equals("php")
        		|| arg.equals("java")
        		|| arg.equals("class")
        		|| arg.equals("db")
        	  )
        {
        		type="代码";
        }else if(arg.equals("htm")
        		|| arg.equals("html")
        		|| arg.equals("xml")
        	
        	  )
        {
        		type="网页";
        }else if(arg.equals("mp3")
        		|| arg.equals("wav")
        		
        	  )
        {
        		type="音频";
        }else{
    		type="其他未知类型";
    	}
    	return type;
    }

     
    public static String typeEnglish(String arg){
    	String type="";
    	if(arg.equals("png")
    		||arg.equals("jpg")
    		||arg.equals("gif")
    		||arg.equals("bmp")
    		||arg.equals("tif")
    	  )
    	{
    		type="picture";
    	}else if(arg.equals("doc")
    		|| arg.equals("docx")
    		|| arg.equals("xls")
    		|| arg.equals("xlsx")
    		|| arg.equals("pdf")
    		|| arg.equals("txt")
    	  )
    	{
    		type="document";
    	}else if(arg.equals("mp4")
        		|| arg.equals("avi")
        		|| arg.equals("flv")
        		
        	  )
        {
        		type="video";
        }else if(arg.equals("sql")
        		|| arg.equals("cpp")
        		|| arg.equals("c")
        		|| arg.equals("php")
        		|| arg.equals("java")
        		|| arg.equals("class")
        		|| arg.equals("db")
        	  )
        {
        		type="code";
        }else if(arg.equals("htm")
        		|| arg.equals("html")
        		|| arg.equals("xml")
        	
        	  )
        {
        		type="web_page";
        }else if(arg.equals("mp3")
        		|| arg.equals("wav")
        		
        	  )
        {
        		type="audio";
        }else{
    		type="unknown";
    	}
    	return type;
    }
    
    public static class category{
    	private String name;
    	private int index;
    	private int length;
    	//get  set方法
        public int getIndex() {
            return index;
        }
        public void setIndex(int id) {
            this.index = id;
        }
        public int getLength(){
        	return length;
        }
        public void setLength(int len){
        	this.length = len;
        }
        public String getName() {
            return name;
        }
        public void setName(String name) {
            this.name = name;
        }
    }
    
    public static class ListTest {
    	private List allCategorys;
    	//构造函数，初始化allCourses
        public ListTest() {         
            this.allCategorys = new ArrayList();
        }
        public void addListTest(String name, int index, int length) {
        	category cg = new category();  //创建一个Category对象，并设置其参数
            cg.setIndex(index);   
            cg.setName(name);
            cg.setLength(length);
            allCategorys.add(cg); 
        } 
    }

   
    

}

