package com.maskkk.controller;

import org.springframework.beans.factory.annotation.Autowired;

/** 文件和文件夹的删除控制器
 * @author EDDIEYOU
 *  2018-10-15
 */

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.maskkk.dao.UserDao;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value="/spring")
public class Delete {
	 @Autowired
	 public UserDao userDao;
	 @ResponseBody
	 @RequestMapping(value="/{fileName}/delete.do")
	 public String delete(@PathVariable("fileName") String fileName, HttpServletRequest req, HttpServletResponse response) throws UnsupportedEncodingException {
		    
		    HttpSession session = req.getSession();
	    	String username 
	    	//= "monkeyking123";
	    	= session.getAttribute("username").toString();
	    	String curdirid = session.getAttribute("curdirid").toString();
        	String curdirname = userDao.getCurDirName(curdirid);
        	String wholePath = getWholePath(curdirname, curdirid, username);
		    String basepath = "F:/HTML/SpringMVC/wtpwebapps/Upload/fileupload"+"/"+wholePath;
			File file = new File (basepath+"/"+URLDecoder.decode(fileName,"utf-8"));
	        System.out.println("Begin to Delete this file: "+file);
			if (!file.exists()) {
	            System.out.println("删除文件失败:" + fileName + "不存在！");
	            return "the file is not existed";
	        } else {
	            if (file.isFile())
	              return  deleteFile(basepath+"/"+URLDecoder.decode(fileName,"utf-8"));
	            else
	              return deleteDirectory(basepath+"/"+URLDecoder.decode(fileName,"utf-8"));
	        }
	    }
	 
	    /**
	     * 删除单个文件
	     *
	     * @param fileName
	     *            要删除的文件的文件名
	     * @return 单个文件删除成功返回true，否则返回false
	     */
	    public static String deleteFile(String fileName) {
	        File file = new File(fileName);
	        // 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
	        if (file.exists() && file.isFile()) {
	            if (file.delete()) {
	                System.out.println("删除单个文件" + fileName + "成功！");
	                return "success";
	            } else {
	                System.out.println("删除单个文件" + fileName + "失败！");
	                return "fail";
	            }
	        } else {
	            System.out.println("删除单个文件失败：" + fileName + "不存在！");
	            return "fail";
	        }
	    }

	    /**
	     * 删除目录及目录下的文件
	     *
	     * @param dir
	     *            要删除的目录的文件路径
	     * @return 目录删除成功返回true，否则返回false
	     */
	    public static String deleteDirectory(String dir) {
	        // 如果dir不以文件分隔符结尾，自动添加文件分隔符
	        if (!dir.endsWith(File.separator))
	            dir = dir + File.separator;
	        File dirFile = new File(dir);
	        // 如果dir对应的文件不存在，或者不是一个目录，则退出
	        if ((!dirFile.exists()) || (!dirFile.isDirectory())) {
	            System.out.println("删除目录失败：" + dir + "不存在！");
	            return "fail";
	        }
	        String flag = "success";
	        // 删除文件夹中的所有文件包括子目录
	        File[] files = dirFile.listFiles();
	        for (int i = 0; i < files.length; i++) {
	            // 删除子文件
	            if (files[i].isFile()) {
	                flag = Delete.deleteFile(files[i].getAbsolutePath());
	                if (flag != "success")
	                    break;
	            }
	            // 删除子目录
	            else if (files[i].isDirectory()) {
	                flag = Delete.deleteDirectory(files[i]
	                        .getAbsolutePath());
	                if (flag != "success")
	                    break;
	            }
	        }
	        if (flag != "success") {
	            System.out.println("删除目录失败！");
	            return "fail";
	        }
	        // 删除当前目录
	        if (dirFile.delete()) {
	            System.out.println("删除目录" + dir + "成功！");
	            return "success";
	        } else {
	            return "fail";
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
