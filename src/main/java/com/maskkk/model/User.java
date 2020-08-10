package com.maskkk.model;
 
public class User {
 
  private String username;
 
  private String password;
 
  private String firstname;
 
  private String lastname;
 
  private String email;
 
  private String address;
 
  private int phone;
  
  private int curdirid; //当前目录id, 这个字段是与directory表的id字段相关联的
 
  public String getUsername() {
 
  return username;
 
  }
 
  public void setUsername(String username) {
 
  this.username = username;
 
  }
 
  public String getPassword() {
 
  return password;
 
  }
 
  public void setPassword(String password) {
 
  this.password = password;
 
  }
 
  public String getFirstname() {
 
  return firstname;
 
  }
 
  public void setFirstname(String firstname) {
 
  this.firstname = firstname;
 
  }
 
  public String getLastname() {
 
  return lastname;
 
  }
 
  public void setLastname(String lastname) {
 
  this.lastname = lastname;
 
  }
 
  public String getEmail() {
 
  return email;
 
  }
 
  public void setEmail(String email) {
 
  this.email = email;
 
  }
 
  public String getAddress() {
 
  return address;
 
  }
 
  public void setAddress(String address) {
 
  this.address = address;
 
  }
 
  public int getPhone() {
 
  return phone;
 
  }
 
  public void setPhone(int phone) {
 
  this.phone = phone;
 
  }

public int getCurdirid() {
	return curdirid;
}

public void setCurdirid(int curdirid) {
	this.curdirid = curdirid;
}
 
}
