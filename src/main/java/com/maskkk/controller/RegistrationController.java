package com.maskkk.controller;
 
import java.io.File;

import javax.servlet.http.HttpServletRequest;
 
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
 
import org.springframework.stereotype.Controller;
 
import org.springframework.web.bind.annotation.ModelAttribute;
 
import org.springframework.web.bind.annotation.RequestMapping;
 
import org.springframework.web.bind.annotation.RequestMethod;
 
import org.springframework.web.servlet.ModelAndView;
 
import com.maskkk.model.User;
 
import com.maskkk.service.UserService;
 
@Controller
 
public class RegistrationController {
 
  @Autowired
 
  public UserService userService;
 
  @RequestMapping(value = "/spring/register", method = RequestMethod.GET)
 
  public ModelAndView showRegister(HttpServletRequest request, HttpServletResponse response) {
 
    ModelAndView mav = new ModelAndView("register");
 
    mav.addObject("user", new User());
 
    return mav;
 
  }
 
  @RequestMapping(value = "/spring/registerProcess", method = RequestMethod.POST)
 
  public ModelAndView addUser(HttpServletRequest request, HttpServletResponse response,
  @ModelAttribute("user") User user) {
 
  userService.register(user);
  //System.out.println("redirect:/spring/"+user.getUsername()+"makeDir.do");
  //建立主目录
  String basepath = "F:/HTML/SpringMVC/wtpwebapps/Upload/fileupload";
  File f = new File (basepath+"/"+user.getUsername());
  if (f.exists()){
		//如果目录已经存在了，就这么办：
		System.out.println(basepath+"/"+user.getUsername()+"目录已经存在了");
  }else{
		f.mkdirs();
  }
  HttpSession session = request.getSession();
  session.setAttribute("username", user.getUsername());
  session.setAttribute("curdirid", user.getCurdirid());
  session.setAttribute("firstname", user.getFirstname());
  return new ModelAndView("redirect:/spring/filelist.do");
  /*ModelAndView mav = new ModelAndView("dashboard");
  mav.addObject("firstname", user.getFirstname());
  mav.addObject("username", user.getUsername());
  return mav;*/
  //return new ModelAndView("dashboard", "firstname", user.getFirstname());
 
  }
 
}
