<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <% 
String path = request.getContextPath(); 
// 获得本项目的地址(例如: http://localhost:8080/MyApp/)赋值给basePath变量 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
// 将 "项目路径basePath" 放入pageContext中，待以后用EL表达式读出。 
pageContext.setAttribute("basePath",basePath); 
%> 
<!doctype html>
<html>
 
    <head>
 
        <meta http-equiv="Content-Type" content="text/html; charset=utf8">
        <link rel="shortcut icon" type="image/x-icon" href="favicon.ico"  media="screen"/>
        <title>欢迎</title>
 
    </head>
 
    <body>
 
        <table align="center">
 
            <tr>
 
                <td><a href="spring/login.do">Login</a>
 
                </td>
 
                <td><a href="spring/register.do">Register</a>
 
                </td>
 
            </tr>
 
        </table>
 
    </body>
 
    </html>
