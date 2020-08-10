package com.maskkk.controller;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.maskkk.dao.UserDao;
import com.maskkk.model.User;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//新建目录
@Controller
@RequestMapping(value="/spring")
public class MakeDir
{   // Define a static logger variable so that it references the
	private static final Logger logger = LogManager.getLogger(MakeDir.class);
	@Autowired
	public UserDao userDao;
	
	@RequestMapping(value="/{dirName}/makedir.do")  
	public void makeDir(@PathVariable("dirName") String dirName, HttpServletRequest req, HttpServletResponse response)throws IOException{
		System.out.println("开始创建一个目录");
		PrintWriter printWriter = null;
		HttpSession session = req.getSession();
    	String username 
    	//= "monkeyking123";
    	= session.getAttribute("username").toString();
    	String curdirid = session.getAttribute("curdirid").toString();
    	String curdirname = userDao.getCurDirName(curdirid);
    	String wholePath = getWholePath(curdirname, curdirid, username);
    	logger.debug("当前目录是: " + curdirname);
		String basepath = "E:/HTML/SpringMVC/wtpwebapps/Upload/fileupload"+"/"+wholePath;
		File f = new File (basepath+"/"+URLDecoder.decode(dirName,"utf-8"));
		if (f.exists()){
			//如果目录已经存在了，就这么办：
			System.out.println(dirName+"目录已经存在了");
			printWriter = response.getWriter();
            printWriter.print(dirName+"目录已经存在了");
			
		}else{
			f.mkdirs(); 
			System.out.println("这个目录："+dirName+"创建成功！");
			//将新建的文件目录记录在数据库表directory中
			userDao.makeNewDir(URLDecoder.decode(dirName,"utf-8"),curdirid, username);
			JSONObject obj = new JSONObject();
	        //return obj;
	        printWriter = response.getWriter();
	        printWriter.print(obj);
			
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
}
