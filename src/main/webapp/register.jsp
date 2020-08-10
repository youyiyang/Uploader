<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<% 
String path = request.getContextPath(); 
// 获得本项目的地址(例如: http://localhost:8080/MyApp/)赋值给basePath变量 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
// 将 "项目路径basePath" 放入pageContext中，待以后用EL表达式读出。 
pageContext.setAttribute("basePath",basePath); 
%>  
        <html>
 
        <head>
 
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <link rel="shortcut icon" type="image/x-icon" href="favicon.ico"  media="screen"/>
            <title>注册</title>
 
        </head>
 
        <body>
 
            <form:form id="regForm" modelAttribute="user" action="registerProcess.do" method="post">
 
                <table align="center">
                    注册名首字母必须是字母或者数字
                    <tr>
 
                        <td>
 
                            <form:label path="username">Username</form:label>
 
                        </td>
 
                        <td>
 
                            <form:input path="username" name="username" id="username" />
 
                        </td>
 
                    </tr>
 
                    <tr>
 
                        <td>
 
                            <form:label path="password">Password</form:label>
 
                        </td>
 
                        <td>
 
                            <form:password path="password" name="password" id="password" />
 
                        </td>
 
                    </tr>
 
                    <tr>
 
                        <td>
 
                            <form:label path="firstname">FirstName</form:label>
 
                        </td>
 
                        <td>
 
                            <form:input path="firstname" name="firstname" id="firstname" />
 
                        </td>
 
                    </tr>
 
                    <tr>
 
                        <td>
 
                            <form:label path="lastname">LastName</form:label>
 
                        </td>
 
                        <td>
 
                            <form:input path="lastname" name="lastname" id="lastname" />
 
                        </td>
 
                    </tr>
 
                    <tr>
 
                        <td>
 
                            <form:label path="email">Email</form:label>
 
                        </td>
 
                        <td>
 
                            <form:input path="email" name="email" id="email" />
 
                        </td>
 
                    </tr>
 
                    <tr>
 
                        <td>
 
                            <form:label path="address">Address</form:label>
 
                        </td>
 
                        <td>
 
                            <form:input path="address" name="address" id="address" />
 
                        </td>
 
                    </tr>
 
                    <tr>
 
                        <td>
 
                            <form:label path="phone">Phone</form:label>
 
                        </td>
 
                        <td>
 
                            <form:input path="phone" name="phone" id="phone" />
 
                        </td>
 
                    </tr>
 
                    <tr>
 
                        <td></td>
 
                        <td>
 
                            <form:button id="register" name="register">注    册</form:button>
 
                        </td>
 
                    </tr>
 
                    <tr></tr>
 
                    <tr>
 
                        <td></td>
 
                        <td><a href="${pageContext.request.contextPath}/home.jsp">Home</a>
 
                        </td>
 
                    </tr>
 
                </table>
 
            </form:form>
 
        </body>
 
        </html>
