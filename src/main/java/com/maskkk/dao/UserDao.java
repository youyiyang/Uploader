package com.maskkk.dao;
 
import com.maskkk.model.Login;
 
import com.maskkk.model.User;
 
public interface UserDao {
 
  void register(User user);
  void makeNewDir(String dirname, String fatherid, String username);
  void deleteDir(User user);
  void renameDir(User user);
  String getCurDirName(String curdirid);
  User validateUser(Login login);
  String getCurDirIdByUsername(String username);
  String getCurDirIdByDirname(String curdirid);
  String getCurDirIdByDirname(String dirname, String curdirid);
  Integer getFatherId(String curdirid);

 
}
