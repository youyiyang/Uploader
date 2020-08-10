package com.maskkk.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.maskkk.dao.UserDao;
import com.maskkk.model.Login;
import com.maskkk.model.User;

public class UserServiceImpl implements UserService {

  @Autowired
  public UserDao userDao;

  public void register(User user) {
    userDao.register(user);
  }

  public User validateUser(Login login) {
    return userDao.validateUser(login);
  }

}