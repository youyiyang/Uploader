package com.maskkk.controller;
 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired; 
import org.springframework.stereotype.Controller; 
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping; 
import org.springframework.web.bind.annotation.RequestMethod; 
import org.springframework.web.servlet.ModelAndView;
import com.maskkk.dao.UserDao;
import com.maskkk.model.Login; 
import com.maskkk.model.User; 
import com.maskkk.service.UserService;
 
@Controller
 
public class LoginController {
 
  @Autowired
  UserService userService;
  @Autowired
  public UserDao userDao;
  @RequestMapping(value = "/spring/login", method = RequestMethod.GET)
 
  public ModelAndView showLogin(HttpServletRequest request, HttpServletResponse response) {
 
    ModelAndView mav = new ModelAndView("login");
 
    mav.addObject("login", new Login());
 
    return mav;
 
  }
 
  @RequestMapping(value = "/spring/loginProcess", method = RequestMethod.POST)
 
  public ModelAndView loginProcess(HttpServletRequest request, HttpServletResponse response,
  @ModelAttribute("login") Login login) {
 
    ModelAndView mav = null;
 
    User user = userService.validateUser(login);
 
    if (null != user) {
          HttpSession session = request.getSession();
    	  session.setAttribute("username", user.getUsername());
    	  session.setAttribute("curdirid",userDao.getCurDirIdByUsername(user.getUsername()));
    	  String curDirName=userDao.getCurDirName(userDao.getCurDirIdByUsername(user.getUsername()));
    	  System.out.println(user.getFirstname());
    	  session.setAttribute("firstname", user.getFirstname());
    	  mav = new ModelAndView("redirect:/spring/"+curDirName+"/filelist.do");
    //mav = new ModelAndView("welcome");
 
    //mav.addObject("firstname", user.getFirstname());
 
    } else {
 
    mav = new ModelAndView("login");
 
    mav.addObject("message", "Username or Password is wrong!!");
 
    }
 
    return mav;
 
  }
 
}
