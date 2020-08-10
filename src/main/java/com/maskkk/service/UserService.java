package com.maskkk.service;

import com.maskkk.model.Login;
import com.maskkk.model.User;

public interface UserService {

  void register(User user);

  User validateUser(Login login);
}