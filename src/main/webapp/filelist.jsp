<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="sql"%> <!--数据库相关标签库-->

<%@ page isELIgnored="false"%> <!--支持EL表达式，不设的话，EL表达式不会解析-->
<% 
String path = request.getContextPath(); 
// 获得本项目的地址(例如: http://localhost:8080/MyApp/)赋值给basePath变量 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
// 将 "项目路径basePath" 放入pageContext中，待以后用EL表达式读出。 
pageContext.setAttribute("basePath",basePath); 
String baseUploadFolder = "E:/HTML/SpringMVC/wtpwebapps/Upload/fileupload";
%> 
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<link rel="shortcut icon" type="image/x-icon" href="favicon.ico"  media="screen"/>
<title>文件</title>
<style>
        #container{
            max-width: 100px;
            width: 100%;
            margin: 20px auto;
        }
        #ListOrLayout{
            width: 50px;
        }
        #ListOrLayout ul{
           width: 100px;
        }
        #Name{
            width: 150px;
            /* height: 30px; */
        }
        #Name ul{
           width: 100px;
           /* height: 30px; */
        }
        #Name ul li{
           width: 100px;
           height: 30px;
        }
        #Col1{
            width: 150px;
        }
        #Col1 ul{
           width: 100px;
        }
        
        #Col2{
            width: 150px;
        }
        #Col2 ul{
           width: 100px;
        }
       
        .fa{
            font-size: 40px;
            /* line-height: 70px; */
        }
        .fa-bars{
            color: #3498db;
        }
        pre{
            font-family: Consolas,Liberation Mono,Courier,monospace;
            font-size: 13px;
        }
        @media screen and (orientation: portrait){
            pre{
                overflow-x: scroll;
            }
        }
</style>

<style type="text/css">
@font-face {
  font-family: 'Glyphicons Halflings';
  src: url('fonts/glyphicons-halflings-regular.eot');
  src: url('fonts/glyphicons-halflings-regular.eot?#iefix') format('embedded-opentype'), url('fonts/glyphicons-halflings-regular.woff') format('woff'), url(fonts/glyphicons-halflings-regular.ttf') format('truetype'), url('fonts/glyphicons-halflings-regular.svg#glyphicons_halflingsregular') format('svg');
}
 
.glyphicon {
  position: relative;
  top: 1px;
  display: inline-block;
  font-family: 'Glyphicons Halflings';
  -webkit-font-smoothing: antialiased;
  font-style: normal;
  font-weight: normal;
  line-height: 1;
  -moz-osx-font-smoothing: grayscale;
}
</style>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/fileinput.css" media="all" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/css/font-awesome.min.css" media="all" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath}/themes/explorer-fa/theme.css" media="all" rel="stylesheet" type="text/css"/>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/fileinput.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/locales/zh.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/jquery.popmenu.js"></script>
<script src="${pageContext.request.contextPath}/js/plugins/sortable.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/locales/es.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/themes/explorer-fa/theme.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/themes/fa/theme.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/popper.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js" type="text/javascript"></script>
<style type="text/css">
*{margin: 0px; padding: 0px;}
.logo_pic {margin-top:5px; margin-left: 5px; padding-top: 5px; padding-left: 5px}
.contact-link {float:right;margin-top:40px; margin-right:10px;}
.login-link {float:right; margin-top:40px;margin-right:20px;}
ul, li {list-style:none;}
.bg{width: 100%; height: 48px; line-height:48px; background:#06C;}

.upnav{width: 1000px; height:48px; margin:0 auto;}
.upnav a:link {color:#FFF;}	
.upnav a:visited {color:#FFF;text-decoration:none;}	
.upnav a:hover {color:#FFF;text-decoration:none;}	
.upnav a:active {color:#FFF;text-decoration:none;}
.container-fluid {width: 100%; height:90px; background:#FFF;}
.allLoad {float:right;color:blue;}
li{color: #FFF; float: left;}
li:hover{background:#039;}

#nav {
 width:190px;
 padding-up: 0px;
 line-height: 48px; 
 list-style-type: none;
 text-align:left;
 float: left;
    /*定义整个ul菜单的行高和背景色*/
}
/*==================一级目录===================*/
#nav a {
 width: 190px; 
 display: block;
 padding-left:20px;
 /*Width(一定要)，否则下面的Li会变形*/
}
#nav li {
 background:#CCC; /*一级目录的背景色*/
 border-bottom:#FFF 1px solid; /*下面的一条白边*/
 float:left;
 /*float：left,本不应该设置，但由于在Firefox不能正常显示
 继承Nav的width,限制宽度，li自动向下延伸*/
}
#nav li a:hover{
 background:#CC0000; /*一级目录onMouseOver显示的背景色*/
}
#nav a:link  {
 color:#666; text-decoration:none;
}
#nav a:visited  {
 color:#666;text-decoration:none;
}
#nav a:hover  {
 color:#FFF;text-decoration:none;font-weight:bold;
}
/*==================二级目录===================*/
#nav li ul {
 list-style:none;
 text-align:left;
}
#nav li ul li{ 
 background: #EBEBEB; /*二级目录的背景色*/
}
#nav li ul a{
         padding-left:20px;
         width:190px;
         color:#666666;
 /* padding-left二级目录中文字向右移动，但Width必须重新设置=(总宽度-padding-left)*/
}
/*下面是二级目录的链接样式*/
#nav li ul a:link  {
 color:#666; text-decoration:none;
}
#nav li ul a:visited  {
 color:#666;text-decoration:none;
}
#nav li ul a:hover {
 color:#F3F3F3;
 text-decoration:none;
 font-weight:normal;
 background:#CC0000;
 /* 二级onmouseover的字体颜色、背景色*/
}
/*==============================*/
#nav li:hover ul {
 left: auto;
}
#nav li.sfhover ul {
 left: auto;
}
#content {
 clear: left; 
}
#nav ul.collapsed {
 display: none;
}
#PARENT{
 width:190px;
 padding-left:0px;
 padding-up: 0px;
}
#main {
width: 100%;
position:relative;
}
#main_left{
  width: 190px;
  height: 1200px;
  float: left;  
}
#main_right{
  margin-left:190px;
  position: relative;
  height: 1200px;
}
#content {
  position: absolute;
  margin: 1em;
}
#uppart {
}
</style>
<!-- 图标字体-->

</head>
<body>
<div class="container-fluid navbar-header-container">
<a href="#"><img class="logo_pic"  src="${pageContext.request.contextPath}/img/logo-company.png"  height="70px" /></a>
<input spellcheck="false" form="coveo-dummy-form" autocomplete="off" placeholder="搜索" />

<div class="contact-link">
 <div class="buttonCTAItemComponent parbase nav_contact">
  <div class="btn-container ">
	<a role="button" class="btn btn-lg simple-link no-caret salesforce-sans-bold    " href="https://www.salesforce.com/cn/form/contact/contactme.jsp?d=70130000000EeYa" target="_blank">
	 <span class="fa fa-handshake-o"></span>
	 <span> 联系我们</span>
	</a>
  </div>
 </div>
</div>

<div class="login-link">
  <div class="nav_login buttonCTAItemComponent parbase">   
    <div class="btn-container ">
        <a role="button" class="btn btn-lg btn-link    " href="https://login.salesforce.com/?locale=cn">
            <span class="fa fa-user"></span>
            <span>你好! ${firstname}</span>
            <span>退出</span>
        </a>
        
    </div>
   </div>
</div>
</div>

<div class="bg">
<div id="uppart">
<ul class="upnav">
<li>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="fa fa-home"></span> 主&nbsp;&nbsp;   页&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;</li>
<li><a href="${pageContext.request.contextPath}/filelist.jsp">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="	fa fa-file-o"></span> 文&nbsp;&nbsp;   件&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
<!-- <li>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;布局实例&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li> -->
<li>  <a href="${pageContext.request.contextPath}/teaching.jsp">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="	fa fa-leanpub"></span> 教&nbsp;&nbsp;   程&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </a></li>
<!-- <!-- <li>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在线手册&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </li>
<li>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;标&nbsp;&nbsp;   准&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; </li>
<li>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;教&nbsp;&nbsp;   程&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </li> --> 
</ul>
</div>
</div>
<div id="main">
<div id="main_left">
 <div id="PARENT">
   <ul id="nav">
    <li class="first">        
	  <a href="#"> <span class="fa fa-dashboard"></span> 操作面板</a>      
    </li>

    <li class="dropdown">        
	  <a href="#Menu=ChildMenu1" onclick="DoMenu('ChildMenu1')">
		  <span class="fa fa-file-o"></span> 
		          新建<b class="caret"></b>
	  </a>  
	  <ul id="ChildMenu1" class="collapsed">
		  <li class="first">        
			 <a href="javascript:addFolder();">
			 <span class="fa fa-folder"></span> 
			 
			   文件夹
			 </a>        
		  </li>   
	  </ul>   
    </li>
<!--     <li class="dropdown">
		<a href="#Menu=ChildMenu2"  onclick="DoMenu('ChildMenu2')">
		  <span class="fa fa-edit"></span> 
		  编辑   <b class="caret"></b>
		</a>                
		<ul id="ChildMenu1" class="collapsed">
		  <li class="first">        
			 <a href="#">
			 <span class="fa fa-i-cursor"></span> 
			   重命名
			 </a>        
		  </li>
		  <li class="first">        
			  <a href="#">
			  <span class="fa fa-copy"></span> 
				复制
			  </a>        
		  </li>
		  <li class="last">        
			  <a href="#">
			  <span class="fa fa-paste"></span> 
				黏贴
			  </a>        
		  </li>
    	</ul>
    </li> -->
    <li>        
	    <a href="javascript:deleteFileDir();">
		 <span class="fa fa-trash"></span>
		 删除
		</a>        
    </li>
	<li class="dropdown active">        
	    <a href="#Menu=ChildMenu2"  onclick="DoMenu('ChildMenu2')">
		 <span class="fa fa-cloud-upload"></span>
		 上传
		</a>   
		
		<ul id="ChildMenu2" class="collapsed">
            <li>        
			   <a data-toggle="modal" data-target="#myModal">
			   <span class="fa fa-file"></span> 
			           文件上传
			   </a>        
            </li>
            <li>        
			    <a data-toggle="modal" data-target="#myModal1">
			     <span class="fa fa-folder"></span>
			     
				    目录上传
			    </a>        
            </li>
            
        </ul>     
    </li>
    <li class="dropdown active">      
     	<a href="#Menu=ChildMenu3"  onclick="DoMenu('ChildMenu3')">
		  <span class="fa fa-support"></span> 
		 帮助    
		 <b class="caret"></b>
		</a>                
		<ul id="ChildMenu3" class="collapsed">
            <li class="first">        
			  <a href="${pageContext.request.contextPath}/introduce.jsp">
			   <span class="fa fa-film"></span> 
			   视频介绍
			  </a>        
            </li>
            <li>        
			   <a href="${pageContext.request.contextPath}/faq.jsp">
			      <span class="fa fa-book"></span>
				  FAQs
				</a>        
            </li>
            <li class="active last">       
    			<a href="${pageContext.request.contextPath}/contact.jsp">
				  <span class="fa fa-envelope-open-o"></span> 
				  联系方式
				</a>        
            </li>
        </ul>
    </li>
    <!-- <li class="visible-xs visible-sm last">        
	    <a href="#">
		  <span class="glyphicon glyphicon-scale-classic regular"></span> 
		  Imprint
		</a>        
    </li> -->
</ul>
</div>
</div>
<div id="main_right">
<div id="content" style="width:95%">

  <table  class="table table-hover" border = "0" width="100%">
  当前目录名称：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="current_directory">
  <c:forEach items="${curdirname}" var="dir"  varStatus="vs">
  ><c:choose>
  <c:when test="${!vs.last}"> <a href="${pageContext.request.contextPath}/spring/${dir.value}/filelist_id.do">${dir.key}</a> </c:when>
  <c:otherwise> ${dir.key} </c:otherwise>
  </c:choose><input type="hidden" value="${dir.value}" id="dirid${vs.index}">
  </c:forEach></span>

  
   <tr>
    <td><input type="checkbox" id="maincheck" name="maincheck"/></td>
    <td width="16%">目录/文件</td>
    <td width="30%">
           <div id="Name">
            <span>名称</span>
            <span class="pop_ctrl"><i class="fa fa-caret-down"></i></span>
            <ul>
                <li><span style="font-size: 12px; color:gray;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</span></li>
                <li><a href="javascript:getFileName('asc','大小','最后修改时间');"><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></a></li>
                <li><a href="javascript:getFileName('desc','大小','最后修改时间');"><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></a></li>
               
            </ul>
         </div>   
    </td>
    <td width="16%">
          <div id="Col1">
            <span>大小</span>
            <span class="pop_ctrl"><i class="fa fa-caret-down"></i></span>
            <ul>
                <li><div style="font-size: 12px; color:gray">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>
                <li><a href="javascript:getCol1UpDown('asc')"><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></a></li>
                <li><a href="javascript:getCol1UpDown('desc')"><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></a></li>
                <li><hr/></li>
                <li><span style="font-size: 12px; color:gray">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>
                <li><span style="color:gray;">&nbsp;&nbsp;&nbsp;&nbsp;最后修改时间</span></li>
                <li><a href="javascript:getCol(null,'owner','lastmodifytime');"><span>&nbsp;&nbsp;&nbsp;&nbsp;成员</span></a></li>
                <li><a href="javascript:getCol(null,'type','lastmodifytime');"><span>&nbsp;&nbsp;&nbsp;&nbsp;类型</span></a></li>
                <li><a href="javascript:getCol(null,'ext','lastmodifytime');"><span>&nbsp;&nbsp;&nbsp;&nbsp;扩展名</span></a></li>
                <li><a href="javascript:getCol(null,'length','lastmodifytime');"><span><i class="fa fa-check"></i>大小</span></a></li>
            </ul>
         </div>   
         
    </td>      
    <td width="30%">
          <div id="Col2">
            <span>最后修改时间</span>
            <span class="pop_ctrl"><i class="fa fa-caret-down"></i></span>
            <ul>
                <li><div style="font-size: 12px; color:gray">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>
                <li><a href="javascript:getCol2UpDown('asc')"><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></a></li>
                <li><a href="javascript:getCol2UpDown('desc')"><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></a></li>
                <li><hr/></li>
                <li><span style="font-size: 12px; color:gray">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>
                <li><a href="javascript:getCol2(null,'length','lastmodifytime');"><span><i class="fa fa fa-check"></i>最后修改时间</span></a></li>
                <li><a href="javascript:getCol2(null,'length','owner');"><span>&nbsp;&nbsp;&nbsp;&nbsp;成员</span></a></li>
                <li><a href="javascript:getCol2(null,'length','type');"><span>&nbsp;&nbsp;&nbsp;&nbsp;类型</span></a></li>
                <li><a href="javascript:getCol2(null,'length','ext');"><span>&nbsp;&nbsp;&nbsp;&nbsp;扩展名</span></a></li>
                <li><span style="color:gray;">&nbsp;&nbsp;&nbsp;&nbsp;大小</span></li>
            </ul>
         </div> 
    </td>
    <td width="8%">
    <div id="ListOrLayout"><span class="fa fa-list-ul"></span> 
    <span class="pop_ctrl"><i class="fa fa-caret-down"></i></span>
            <ul>
                <li><div style="font-size: 12px; color:gray">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查看格式</div></li>
                <li><i class="fa fa-check" aria-hidden="true"></i><span>列表</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class="fa fa-list-ul"></i></span></li>
                <li>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:getFileLayout();"><span>网格</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class="fa fa-th"></i></span></a></li>
                
            </ul>
    </div> 
    </td>
   </tr>
   <c:set var="j" value="0"/>
   <c:set var="folder" value="true"/>
   <c:forEach var="i" items="${fileattr}">
   <tr>
     <td><input type="checkbox" id="subBox${j}" name="subBox" /></td>
      <c:forTokens items="${i}" delims="@#￥" var="attr" varStatus="status">
       <%String littleimg=""; %>
        <c:choose>
               <c:when test="${status.index == 0}">
                 <td>
                 <c:if test="${attr == 'file'}">
                 <c:set var="folder" value="false"/>
                   <span class="fa fa-file"></span>
                 </c:if>
                 <c:if test="${attr != 'file'}">
                   <c:set var="folder" value="true"/>
                   <!-- 把目录id取出来 -->
                   <c:set var="dirid" value="${attr}" />
                   <span class="fa fa-folder"></span>
                 </c:if>
                 </td>
               </c:when>
               
              <c:when test="${status.index == 1}">
                <c:forTokens items="${attr}" delims="^^^^^^" var="nameAttr" varStatus="sta">
	                <c:choose>
	                    <c:when test="${sta.index == 0}">
	                        <c:set var="filename" value="${nameAttr}" />
	                    </c:when>
	                </c:choose>
	                <c:choose>
	                    <c:when test="${sta.index == 1}">
	                        <% littleimg = java.net.URLDecoder.decode((String)pageContext.findAttribute("nameAttr"),"utf-8"); %>
	                    </c:when>
	                </c:choose>
                </c:forTokens>
                <td>
                  <c:set var="lcaseName" value="${fn:toLowerCase(filename)}" />
                  
                 <%-- 如果文件的后缀名是jpg,png,gif,bmp这4种，显示该图片文件的缩略图  --%>
                   <c:choose>
                          <c:when test="${fn:endsWith(lcaseName,'jpg')
                                 || fn:endsWith(lcaseName,'png') 
                                 || fn:endsWith(lcaseName,'gif') 
                                 || fn:endsWith(lcaseName,'bmp')}">
		                           
		                           <% String EncodeAttr = java.net.URLEncoder.encode(java.net.URLEncoder.encode((String)pageContext.findAttribute("filename"),"utf-8"),"utf-8");  %>
		                           <%-- <c:choose>
		                           <c:when test="${status.index == 4}">
		                           <img src="data:image/png;base64,${attr}" width="30" height="30"></img>
		                           </c:when>
		                           </c:choose>
		                           <c:choose>
		                           <c:when test="${status.index == 1}">
		                           <a href="${pageContext.request.contextPath}/spring/<%=EncodeAttr%>/download.do">${attr}</a>
		                           </c:when>
		                           </c:choose>  --%>
		                            <img src="data:image/png;base64,<%=littleimg %>" width="50" height="50"></img> 
		                           <a href="${pageContext.request.contextPath}/spring/<%=EncodeAttr%>/download.do">${filename}</a> 
		                  </c:when>
		                  <c:otherwise>
		                      <c:choose>
		                        
		                         <c:when test="${folder == 'false'}"><!-- 文件 -->
		                          <% String EncodeAttr = java.net.URLEncoder.encode(java.net.URLEncoder.encode((String)pageContext.findAttribute("attr"),"utf-8"),"utf-8"); %>
		                          <a href="${pageContext.request.contextPath}/spring/<%=EncodeAttr%>/download.do">${filename}</a>
		                         </c:when>
		                         <c:otherwise><!-- 目录 -->
		                          <% String EncodeAttr = java.net.URLEncoder.encode(java.net.URLEncoder.encode((String)pageContext.findAttribute("attr"),"utf-8"),"utf-8"); %>
		                          <a href="${pageContext.request.contextPath}/spring/${dirid}/filelist_id.do">${filename}</a>
		                         </c:otherwise>
		                      </c:choose>
		                           
		                  </c:otherwise>
                  </c:choose>
                 
                  </td>
                </c:when>
			        
			    <c:otherwise>
			        <td>${attr}</td>
			    </c:otherwise> 
         </c:choose>
        
      </c:forTokens>
      <td><span class="fa fa-ellipsis-h"></span> </td>
   </tr>
   <c:set var="j" value="${j+1}"/>
   
   </c:forEach>
   <!-- <tr>
     <td>IMG_0102.JPG</td>
     <td>2.7M</td>
     <td> 13/6/2018</td>
     <td></td>
   </tr> -->
   <p class="allLoad">已全部加载，共${j}个项目</p> 
  </table>
  
</div>
<div id="content_extra_1">
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:920px;max-width:920px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">文件上传</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
					<form enctype="multipart/form-data">
					
					<div class="file-loading">
						<input id="file-4" name="file" type="file" class="file" 
						data-upload-url="${pageContext.request.contextPath}/spring/save-product.do" 
						multiple>
					</div>
					
					</form>
					<script>


					$("#file-4").fileinput({
						
						theme: 'fa',
						language: 'zh',
					    uploadUrl: 'spring/save-product.do', // you must set a valid URL here else you will get an error
					    //allowedFileExtensions: ['jpg', 'png', 'gif'],
					    overwriteInitial:true,
					    maxFileSize: 1000000000000,
					    maxFilesNum: -1,
					    //language: 'zh', 
					    //previewFileIcon: "<iclass='glyphicon glyphicon-king'></i>",
					    //allowedFileTypes: ['image', 'video', 'flash'],
					    slugCallback: function (filename) {
					        return filename.replace('(', '_').replace(']', '_');
					    }
					});
					/*
					$(".file").on('fileselect', function(event, n, l) {
					alert('File Selected. Name: ' + l + ', Num: ' + n);
					});
					*/
					
					
					
					
					$(document).ready(function () {
					   $("#test-upload").fileinput({
						   'theme': 'fa',
					       'showPreview': false,
					       'allowedFileExtensions': ['jpg', 'png', 'gif'],
					       'elErrorContainer': '#errorBlock'
					   });
					   $("#kv-explorer").fileinput({
					       'theme': 'explorer-fa',
					       'uploadUrl': '#',
					       overwriteInitial: false,
					       initialPreviewAsData: true,
					       initialPreview: [
					           "http://lorempixel.com/1920/1080/nature/1",
					           "http://lorempixel.com/1920/1080/nature/2",
					           "http://lorempixel.com/1920/1080/nature/3"
					       ],
					       initialPreviewConfig: [
					           {caption: "nature-1.jpg", size: 329892, width: "120px", url: "{$url}", key: 1},
					           {caption: "nature-2.jpg", size: 872378, width: "120px", url: "{$url}", key: 2},
					           {caption: "nature-3.jpg", size: 632762, width: "120px", url: "{$url}", key: 3}
					       ]
					   });
					   /*
					    $("#test-upload").on('fileloaded', function(event, file, previewId, index) {
					    alert('i = ' + index + ', id = ' + previewId + ', file = ' + file.name);
					    });
					    */
					});
					
					
					</script>
			</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <!-- <button type="button" class="btn btn-primary">提交更改</button> -->
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</div>
<div id="content_extra_2">
<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width:920px;max-width:920px;">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">目录上传</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
					 <label for="input-folder-2">此功能仅由一些现代浏览器支持，如Chrome，Firefox
					 </label> 
					 <label for="input-folder-2">  但是IE Edge和其他浏览器暂不支持拖拽文件
					 </label> 
					<div class="file-loading">
					    <input id="input-folder-2" name="file[]" type="file" multiple webkitdirectory accept="image/*">
					</div>
					<div id="errorBlock" class="help-block"></div>
					<script>
					$(document).on('ready', function() {
					    $("#input-folder-2").fileinput({
					    	theme: 'fa',
					    	language: 'zh',
					        browseLabel: '选择目录...',
					        uploadUrl: 'save-multi-product.do',
					        previewFileIcon: '<i class="fa fa-file"></i>',
					        allowedPreviewTypes: null, // set to empty, null or false to disable preview for all types
					        previewFileIconSettings: {
					            'doc': '<i class="fa fa-file-word-o text-primary"></i>',
					            'xls': '<i class="fa fa-file-excel-o text-success"></i>',
					            'ppt': '<i class="fa fa-file-powerpoint-o text-danger"></i>',
					            'jpg': '<i class="fa fa-file-photo-o text-warning"></i>',
					            'pdf': '<i class="fa fa-file-pdf-o text-danger"></i>',
					            'zip': '<i class="fa fa-file-archive-o text-muted"></i>',
					            'htm': '<i class="fa fa-file-code-o text-info"></i>',
					            'txt': '<i class="fa fa-file-text-o text-info"></i>',
					            'mov': '<i class="fa fa-file-movie-o text-warning"></i>',
					            'mp3': '<i class="fa fa-file-audio-o text-warning"></i>',
					        },
					        previewFileExtSettings: {
					            'doc': function(ext) {
					                return ext.match(/(doc|docx)$/i);
					            },
					            'xls': function(ext) {
					                return ext.match(/(xls|xlsx)$/i);
					            },
					            'ppt': function(ext) {
					                return ext.match(/(ppt|pptx)$/i);
					            },
					            'jpg': function(ext) {
					                return ext.match(/(jp?g|png|gif|bmp)$/i);
					            },
					            'zip': function(ext) {
					                return ext.match(/(zip|rar|tar|gzip|gz|7z)$/i);
					            },
					            'htm': function(ext) {
					                return ext.match(/(php|js|css|htm|html)$/i);
					            },
					            'txt': function(ext) {
					                return ext.match(/(txt|ini|md)$/i);
					            },
					            'mov': function(ext) {
					                return ext.match(/(avi|mpg|mkv|mov|mp4|3gp|webm|wmv)$/i);
					            },
					            'mp3': function(ext) {
					                return ext.match(/(mp3|wav)$/i);
					            },
					        }
					    });
					});
					</script>			</div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <!-- <button type="button" class="btn btn-primary">提交更改</button> -->
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</div>
</div>

</div>
   

<div id="fixed-footer" data-action-label="Select an action">
    <div id="fixed-footer-content">
         <div class="visible-md visible-lg footer-copyright pull-right">
            <a href="http://www.testbirds.com/" target="_blank">&copy; Uploador</a> 2018 |
            <a href="/legal">Imprint</a>
             <!-- Social icons/links -->
             <span class="socials">
				 <!-- Facebook -->
				 <a target="_blank" href="https://www.facebook.com/Testbirds">
				   <img src="https://nest.testbirds.com/bundles/testbirdsweb/images/footer_icon_facebook_new.png?version=18-21-23-0849" alt="Testbirds on Facebook">
				 </a>
				 <!-- Twitter -->
				 <a target="_blank" href="https://twitter.com/testbirds">
				   <img src="https://nest.testbirds.com/bundles/testbirdsweb/images/footer_icon_twitter_new.png?version=18-21-23-0849" alt="Testbirds on Twitter">
				 </a>
				 <!-- Blog -->
				 <a target="_blank" href="http://blog.testbirds.com/">
				   <img src="https://nest.testbirds.com/bundles/testbirdsweb/images/footer_icon_blog_new.png?version=18-21-23-0849" alt="Testbird's Blog">
				 </a>
            </span>
         </div>
         <div class="visible-xs visible-sm dropup pull-right">
            <button class="btn btn-default dropdown-toggle btn-sm" type="button" id="footer-legal-dropup"
              data-toggle="dropdown" aria-expanded="true">
               <i class="glyphicon glyphicon-paragraph regular"></i>
                  <span class="caret"></span>
            </button>
            <ul class="dropdown-menu" role="menu" aria-labelledby="footer-legal-dropup">
              <li role="presentation">
                <a href="http://www.testbirds.com/" target="_blank">
                  &copy;  Uploador 2018
                </a>
              </li>
              <li role="presentation">
                <a href="/legal">Imprint</a>
              </li>
            </ul>
         </div>
    </div>
</div>
<script type=text/javascript>
var LastLeftID = "";
function menuFix() {
 var obj = document.getElementById("nav").getElementsByTagName("li");
 
 for (var i=0; i<obj.length; i++) {
  obj[i].onmouseover=function() {
   this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  obj[i].onMouseDown=function() {
   this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  obj[i].onMouseUp=function() {
   this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  obj[i].onmouseout=function() {
   this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"), "");
  }
 }
}
function DoMenu(emid)
{
 var obj = document.getElementById(emid); 
 obj.className = (obj.className.toLowerCase() == "expanded"?"collapsed":"expanded");
 if((LastLeftID!="")&&(emid!=LastLeftID)) //关闭上一个Menu
 {
  document.getElementById(LastLeftID).className = "collapsed";
 }
 LastLeftID = emid;
}
function GetMenuID()
{
 var MenuID="";
 var _paramStr = new String(window.location.href);
 var _sharpPos = _paramStr.indexOf("#");
 
 if (_sharpPos >= 0 && _sharpPos < _paramStr.length - 1)
 {
  _paramStr = _paramStr.substring(_sharpPos + 1, _paramStr.length);
 }
 else
 {
  _paramStr = "";
 }
 
 if (_paramStr.length > 0)
 {
  var _paramArr = _paramStr.split("&");
  if (_paramArr.length>0)
  {
   var _paramKeyVal = _paramArr[0].split("=");
   if (_paramKeyVal.length>0)
   {
    MenuID = _paramKeyVal[1];
   }
  }
  
  if (_paramArr.length>0)
  {
   var _arr = new Array(_paramArr.length);
  }
  
   //取所有#后面的，菜单只需用到Menu
  for (var i = 0; i < _paramArr.length; i++)
  {
   var _paramKeyVal = _paramArr[i].split('=');
   
   if (_paramKeyVal.length>0)
   {
    _arr[_paramKeyVal[0]] = _paramKeyVal[1];
   }  
  }
  
 }
 
 if(MenuID!="")
 {
  DoMenu(MenuID)
 }
}
GetMenuID(); //*这两个function的顺序要注意一下，不然在Firefox里GetMenuID()不起效果
menuFix();
</script>

<script>
function toupload(){
	alert ("upload now...");
	uploadString= new String('<form enctype="multipart/form-data"><hr><div class="file-loading"><input id="file-4" name="file" type="file" class="file" data-upload-url="spring/save-product.do" multiple></div><hr></form>');
	 $("#content").text("");// 清空数据
	 $("#content").append(uploadString);
}
</script>

<script>


$("#file-4").fileinput({
    theme: 'fa',
    uploadUrl: 'spring/save-product.do', // you must set a valid URL here else you will get an error
    //allowedFileExtensions: ['jpg', 'png', 'gif'],
    overwriteInitial:true,
    maxFileSize: 1000000000000,
    maxFilesNum: -1,
    //language: 'zh', 
    //previewFileIcon: "<iclass='glyphicon glyphicon-king'></i>",
    //allowedFileTypes: ['image', 'video', 'flash'],
    slugCallback: function (filename) {
        return filename.replace('(', '_').replace(']', '_');
    }
});
</script>
<script>  
        $(document).ready(function() {  
            $("#maincheck").click(function() {  
                if(this.checked==true){  
                    $('input[name="subBox"]').prop("checked",this.checked);  
                }else{  
                    $('input[name="subBox"]').prop("checked",false);  
                }  
            });  
            var $subBox = $("input[name='subBox']");  
            $subBox.click(function(){  
                $("#maincheck").prop("checked",$subBox.length == $("input[name='subBox']:checked").length ? true : false);  
            });  
        });  
</script>  


<script>
  function getFileList(){
	  window.location.href="${pageContext.request.contextPath}/spring/filelist.do";
  }
</script> 
<script>
   function getOthersUpDown(a0,a1,a2,a3){
	   alert("direciton="+a0+",col="+a1+",col1="+a2+",col2="+a3);
	   var urlstr = "";
	   var theHtml = "";
	   alert( "${pageContext.request.contextPath}/spring/col12Sort.do?name="+a1+"&direction="+a0+"&col1="+a2+"&col2="+a3);
	   $.ajax({
		      url: "${pageContext.request.contextPath}/spring/col12Sort.do?name="+a1+"&direction="+a0+"&col1="+a2+"&col2="+a3,
		      type: 'GET',
		      dataType: "json", 
		      async: true,
		      success: function(data) {
		    	  alert(data);
		    	  row=data[data.length-1].split("@#￥");
		    	  theHtml += "<table  border = \"0\" width=\"100%\">";
		          //文件网格布局的表头
		          theHtml += "<tr>";
		          theHtml += "<td><input type=\"checkbox\" id=\"maincheck\" name=\"maincheck\"/></td>";
		          theHtml += "<td width=\"16%\">目录/文件</td>";
		          theHtml += "<td>"+"<div id=\"Name\">";
		          theHtml += "<span>名称</span>";
		          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
		          theHtml += "<ul><li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>";
		          theHtml += "<li><a href=\"javascript:getFileName('asc','" + row[1] + "','" + row[2] + "');\"><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getFileName('desc','" + row[1] + "','" + row[2] + "');\"><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></a></li></ul>";
		          theHtml += "</div>";
		          theHtml += "</td>";
		          theHtml += "<td><div id=\"Col1\">";
		          theHtml += "<span>"+row[1]+"</span>";
		          if(a1=="col1"){
		        	  if(row[0]=="asc"){
		 	        	  namecheck1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		 	              namecheck2="&nbsp;&nbsp;&nbsp;&nbsp;";
	 	              }else if(row[0]=="desc"){
		 	    	      namecheck2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		 	              namecheck1="&nbsp;&nbsp;&nbsp;&nbsp;";
	 	              }
		          }else{
		        	  namecheck1=namecheck2="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }
		         
		          
		          if(a1=="col1"){
		        	  if(row[0]=="asc"){
		 	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-up\"></i></span>";
		 	           }else if(row[0]=="desc"){
		 	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-down\"></i></span>";
		 	           }
		          }else{
		        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>"
		          }
		          
		          theHtml += "<ul>";
		          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>";
		          theHtml += "<li><a href=\"javascript:getCol1UpDown('asc')\"><span>"+namecheck1+"升序</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol1UpDown('desc')\"><span>"+namecheck2+"降序</span></a></li>";
		          theHtml += "<li><hr/></li>";
		          theHtml += "<li><span style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>";
		          if(row[1]=="最后修改时间"){
		        	  ok1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok2=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[1]=="成员"){
		        	  ok2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		              ok1=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[1]=="类型"){
		        	  ok3="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[1]=="扩展名"){
		              ok4="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok3=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[1]=="大小"){
		        	  ok5="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok3=ok4="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else{
		        	 
		          }
		          var graycolor=" style=\"color:gray;\"";
		          var col1color1=col1color2=col1color3=col1color4=col1color5="";
		          var col2color1=col2color2=col2color3=col2color4=col2color5="";
		          if(row[2]=="最后修改时间"){
		        	  col1color1=graycolor;
		          }else if(row[2]=="成员"){
		        	  col1color2=graycolor;
		          }else if(row[2]=="类型"){
		        	  col1color3=graycolor;
		          }else if(row[2]=="扩展名"){
		        	  col1color4=graycolor;
		          }else if(row[2]=="大小"){
		        	  col1color5=graycolor;
		          }
		          
		          if(row[1]=="最后修改时间"){
		        	  col2color1=graycolor;
		          }else if(row[1]=="成员"){
		        	  col2color2=graycolor;
		          }else if(row[1]=="类型"){
		        	  col2color3=graycolor;
		          }else if(row[1]=="扩展名"){
		        	  col2color4=graycolor;
		          }else if(row[1]=="大小"){
		        	  col2color5=graycolor;
		          }
		          theHtml += "<li><a href=\"javascript:";
		          if(a1=="col1"){
		        	  theHtml+="getCol('"+row[0]+"','lastmodifytime','"+english(row[2])+"');\">" + ok1 + "<span"+col1color1+">最后修改时间</span></a></li>";
		          }else if (a1=="col2"){
		        	  theHtml+="getCol2('"+row[0]+"','lastmodifytime','"+english(row[2])+"');\">" + ok1 + "<span"+col1color1+">最后修改时间</span></a></li>"
		          }
		          if(a1=="col1"){
		        	  theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','owner','"+english(row[2])+"');\">" + ok2 + "<span"+col1color2+">成员</span></a></li>";
		          }else if (a1=="col2"){
		        	  theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','owner','"+english(row[2])+"');\">" + ok2 + "<span"+col1color2+">成员</span></a></li>";
		          }
		          if(a1=="col1"){
		        	  theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','type','"+english(row[2])+"');\">" + ok3 + "<span"+col1color3+">类型</span></a></li>";
		          }else if(a1=="col2"){
		        	  theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','type','"+english(row[2])+"');\">" + ok3 + "<span"+col1color3+">类型</span></a></li>";
		          }
		          if(a1=="col1"){
		        	  theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','ext','"+english(row[2])+"');\">" + ok4 + "<span"+col1color4+">扩展名</span></a></li>"; 
		          }else if(a1=="col2"){
		        	  theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','ext','"+english(row[2])+"');\">" + ok4 + "<span"+col1color4+">扩展名</span></a></li>";
		          }
		          if(a1=="col1"){
		        	  theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','length','"+english(row[2])+"');\">" + ok5 + "<span"+col1color5+">大小</span></a></li>";
		          }else if(a1=="col2"){
		        	  theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','length','"+english(row[2])+"');\">" + ok5 + "<span"+col1color5+">大小</span></a></li>";
		          }
		          
		          theHtml += "</ul></div>";
		          theHtml += "</td>";
		          theHtml += "<td>";
		          theHtml += "<div id=\"Col2\">";
		          if(a1=="col2"){
		        	  if(row[0]=="asc"){
		 	        	  namecheck1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		 	              namecheck2="&nbsp;&nbsp;&nbsp;&nbsp;";
	 	              }else if(row[0]=="desc"){
		 	    	      namecheck2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		 	              namecheck1="&nbsp;&nbsp;&nbsp;&nbsp;";
	 	              }
		          }else{
		        	  namecheck1=namecheck2="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }
		         
		          
		          
		          theHtml += "<span>"+row[2]+"</span>";

		          if(a1=="col2"){
		        	  if(row[0]=="asc"){
		 	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-up\"></i></span>";
		 	           }else if(row[0]=="desc"){
		 	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-down\"></i></span>";
		 	           }
		          }else{
		        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>"
		          }
		          theHtml += "<ul>";
		          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>"
		          theHtml += "<li><a href=\"javascript:getCol2UpDown('asc')\"><span>"+namecheck1+"升序</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol2UpDown('desc')\"><span>"+namecheck2+"降序</span></a></li>";
		          theHtml += "<li><hr/></li>";
		          if(row[2]=="最后修改时间"){
		        	  ok1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok2=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[2]=="成员"){
		        	  ok2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		              ok1=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[2]=="类型"){
		        	  ok3="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[2]=="扩展名"){
		              ok4="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok3=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[2]=="大小"){
		        	  ok5="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok3=ok4="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else{
		        	 
		          }
		          theHtml += "<li><span style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>";
		          if(a1=="col1"){
		        	  theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','lastmodifytime');\">" + ok1 + "<span"+col2color1+">最后修改时间</span></a></li>";
		          }else if(a1=="col2"){
		        	  theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','lastmodifytime');\">" + ok1 + "<span"+col2color1+">最后修改时间</span></a></li>";
		          }
		          if(a1=="col1"){
		        	  theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','owner');\">" + ok2 + "<span"+col2color2+">成员</span></a></li>";
		          }else if(a1=="col2"){
		        	  theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','owner');\">" + ok2 + "<span"+col2color2+">成员</span></a></li>";
		          }
		          if(a1=="col1"){
		        	  theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','type');\">" + ok3 + "<span"+col2color3+">类型</span></a></li>";
		          }else if(a1=="col2"){
		        	  theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','type');\">" + ok3 + "<span"+col2color3+">类型</span></a></li>";
		          }
		          if(a1=="col1"){
		        	  theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','ext');\">" + ok4 + "<span"+col2color4+">扩展名</span></a></li>";
		          }else if(a1=="col2"){
		        	  theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','ext');\">" + ok4 + "<span"+col2color4+">扩展名</span></a></li>";
		          }
		          if(a1=="col1"){
		        	  theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','length');\">" + ok5 + "<span"+col2color5+">大小</span></a></li>";
		          }else if(a1=="col2"){
		        	  theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','length');\">" + ok5 + "<span"+col2color5+">大小</span></a></li>";
		          }
		          
		          theHtml += "</td>";
		          theHtml += "<td>";
		          theHtml += "<div id=\"ListOrLayout\"><span class=\"fa fa-list-ul\"></span> ";
		          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
		          theHtml += "<ul>";
		          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查看格式</div></li>";
		          theHtml += "<li><i class=\"fa fa-check\" aria-hidden=\"true\"></i><a href=\"javascript:getFileList();\"><span>列表</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-list-ul\"></i></span></a></li>";
		          theHtml += "<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:getFileLayout();\"><span>网格</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-th\"></i></span></a></li>";
		          theHtml += "</ul>";
		          theHtml += "</div>";
		          theHtml += "</td>";
		          for (i=0; i<data.length-1; i++){
		        	   var n=data[i].split("@#￥");
		         	   theHtml += "<tr>";
		         	   theHtml += "<td><input type=\"checkbox\" id=\"subBox"+i+"\" name=\"subBox\" /></td>";
		         	  theHtml += "<td>";
		              if( n[0] == "file" ){
		           	   theHtml += "<span class=\"fa fa-file\"></span>";
		              }else{
		           	   theHtml += "<span class=\"fa fa-folder\"></span>";
		              }
		              theHtml += "</td>";
		              theHtml += "<td>";
		              var fname = n[1].split("^^^^^^");
    	              if( fname[0].substr(fname[0].length-3,3).toLowerCase() == "jpg"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "png"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "gif"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "bmp"){
    	               	   theHtml += "<img src=\"data:image/png;base64,"+fname[1]+"\" width=\"50\" height=\"50\"></img><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
    	              }else{
    	               	   theHtml += "<a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
    	              }
		              theHtml += "</td>";
		              theHtml += "<td>";
		              theHtml += n[2];
		              theHtml += "</td>";
		              theHtml += "<td>";
		              theHtml += n[3];
		              theHtml += "</td>";
		              theHtml += "<td>";
		              theHtml += "<span class=\"fa fa-ellipsis-h\"></span>";
		              theHtml += "</td>";
		              theHtml +="</tr>";   
		          }   
		          
		          theHtml += "<p class=\"allLoad\">已全部加载，共"+data.length-1+"个项目</p> ";
		          theHtml += "</table>";
		          alert("theHtml="+theHtml);
		          $("#content").html("");
		          $("#content").html(theHtml);
		          needReloadInAsyncLoad();
		            
		      },
		      error: function() {
		        alert("error");
		      }
		    });
   }
</script>

<script>
   function getCol1UpDown(arg){
	    alert('col1 updown is ' + arg);
	    var col1=$("#Col1").find("i").parent().text();
	    //alert(col1);
	    if((col1.indexOf("升序")!=-1)||(col1.indexOf("降序")!=-1)){
	    	col1=col1.substring(2);
	    }  
	    alert('col1='+col1);
		var col2=$("#Col2").find("i").parent().text();
		if((col2.indexOf("升序")!=-1)||(col2.indexOf("降序")!=-1)){
	    	col2=col2.substring(2);
	    } 
		alert('col2='+col2);
	    var urlstr="";
	    var theHtml = "";
	    alert( "${pageContext.request.contextPath}/spring/col12Sort.do?name=col1&direction="+arg+"&col1="+english(col1)+"&col2="+english(col2));
	    $.ajax({
		      url: "${pageContext.request.contextPath}/spring/col12Sort.do?name=col1&direction="+arg+"&col1="+english(col1)+"&col2="+english(col2),
		      type: 'GET',
		      dataType: "json", 
		      async: true,
		      success: function(data) {
		    	  alert(data);
		    	  row=data[data.length-1].split("@#￥");
		    	  theHtml += "<table  border = \"0\" width=\"100%\">";
		          //文件网格布局的表头
		          theHtml += "<tr>";
		          theHtml += "<td><input type=\"checkbox\" id=\"maincheck\" name=\"maincheck\"/></td>";
		          theHtml += "<td width=\"16%\">目录/文件</td>";
		          theHtml += "<td>"+"<div id=\"Name\">";
		          //名称
		          theHtml += "<span>名称</span>";
		          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
		          theHtml += "<ul><li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>";
		          theHtml += "<li><a href=\"javascript:getFileName('asc','" + row[1] + "','" + row[2] + "');\"><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getFileName('desc','" + row[1] + "','" + row[2] + "');\"><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></a></li></ul>";
		          theHtml += "</div>";
		          theHtml += "</td>";
		          //Col1
		          theHtml += "<td><div id=\"Col1\">";
		          theHtml += "<span>"+row[1]+"</span>";
		          if(row[0]=="asc"){
    	        	  namecheck1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
    	              namecheck2="&nbsp;&nbsp;&nbsp;&nbsp;";
    	          }else if(row[0]=="desc"){
    	    	      namecheck2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
    	              namecheck1="&nbsp;&nbsp;&nbsp;&nbsp;";
    	          }
		          if(row[0]=="asc"){
	 	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-up\"></i></span>";
	 	           }else if(row[0]=="desc"){
	 	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-down\"></i></span>";
	 	           }
		          theHtml += "<ul>";
		          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>";
		          theHtml += "<li><a href=\"javascript:getCol1UpDown('asc')\"><span>"+namecheck1+"升序</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol1UpDown('desc')\"><span>"+namecheck2+"降序</span></a></li>";
		          theHtml += "<li><hr/></li>";
		          theHtml += "<li><span style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>";
		          if(row[1]=="最后修改时间"){
		        	  ok1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok2=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[1]=="成员"){
		        	  ok2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		              ok1=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[1]=="类型"){
		        	  ok3="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[1]=="扩展名"){
		              ok4="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok3=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[1]=="大小"){
		        	  ok5="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok3=ok4="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else{
		        	 
		          }
		          var graycolor=" style=\"color:gray;\"";
		          var col1color1=col1color2=col1color3=col1color4=col1color5="";
		          var col2color1=col2color2=col2color3=col2color4=col2color5="";
		          if(row[2]=="最后修改时间"){
		        	  col1color1=graycolor;
		          }else if(row[2]=="成员"){
		        	  col1color2=graycolor;
		          }else if(row[2]=="类型"){
		        	  col1color3=graycolor;
		          }else if(row[2]=="扩展名"){
		        	  col1color4=graycolor;
		          }else if(row[2]=="大小"){
		        	  col1color5=graycolor;
		          }
		          
		          if(row[1]=="最后修改时间"){
		        	  col2color1=graycolor;
		          }else if(row[1]=="成员"){
		        	  col2color2=graycolor;
		          }else if(row[1]=="类型"){
		        	  col2color3=graycolor;
		          }else if(row[1]=="扩展名"){
		        	  col2color4=graycolor;
		          }else if(row[1]=="大小"){
		        	  col2color5=graycolor;
		          }
		          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','lastmodifytime','"+english(row[2])+"');\">" + ok1 + "<span"+col1color1+">最后修改时间</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','owner','"+english(row[2])+"');\">" + ok2 + "<span"+col1color2+">成员</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','type','"+english(row[2])+"');\">" + ok3 + "<span"+col1color3+">类型</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','ext','"+english(row[2])+"');\">" + ok4 + "<span"+col1color4+">扩展名</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','length','"+english(row[2])+"');\">" + ok5 + "<span"+col1color5+">大小</span></a></li>";
		          theHtml += "</ul></div>";
		          theHtml += "</td>";
		          theHtml += "<td>";
		          //Col2
		          theHtml += "<div id=\"Col2\">";
		          theHtml += "<span>"+row[2]+"</span>";
		          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
		          theHtml += "<ul>";
		          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>"
		          theHtml += "<li><a href=\"javascript:getCol2UpDown('asc')\"><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol2UpDown('desc')\"><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></a></li>";
		          theHtml += "<li><hr/></li>";
		          if(row[2]=="最后修改时间"){
		        	  ok1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok2=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[2]=="成员"){
		        	  ok2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		              ok1=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[2]=="类型"){
		        	  ok3="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[2]=="扩展名"){
		              ok4="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok3=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[2]=="大小"){
		        	  ok5="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok3=ok4="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else{
		        	 
		          }
		          theHtml += "<li><span style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>";
		          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','lastmodifytime');\">" + ok1 + "<span"+col2color1+">最后修改时间</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','owner');\">" + ok2 + "<span"+col2color2+">成员</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','type');\">" + ok3 + "<span"+col2color3+">类型</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','ext');\">" + ok4 + "<span"+col2color4+">扩展名</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','length');\">" + ok5 + "<span"+col2color5+">大小</span></a></li>";
		          theHtml += "</td>";
		          theHtml += "<td>";
		          theHtml += "<div id=\"ListOrLayout\"><span class=\"fa fa-list-ul\"></span> ";
		          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
		          theHtml += "<ul>";
		          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查看格式</div></li>";
		          theHtml += "<li><i class=\"fa fa-check\" aria-hidden=\"true\"></i><a href=\"javascript:getFileList();\"><span>列表</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-list-ul\"></i></span></a></li>";
		          theHtml += "<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:getFileLayout();\"><span>网格</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-th\"></i></span></a></li>";
		          theHtml += "</ul>";
		          theHtml += "</div>";
		          theHtml += "</td>";
		          for (i=0; i<data.length-1; i++){
		        	   var n=data[i].split("@#￥");
		         	   theHtml += "<tr>";
		         	   theHtml += "<td><input type=\"checkbox\" id=\"subBox"+i+"\" name=\"subBox\" /></td>";
		         	  theHtml += "<td>";
		              if( n[0] == "file" ){
		           	   theHtml += "<span class=\"fa fa-file\"></span>";
		              }else{
		           	   theHtml += "<span class=\"fa fa-folder\"></span>";
		              }
		              theHtml += "</td>";
		              theHtml += "<td>";
		              var fname = n[1].split("^^^^^^");
    	              if( fname[0].substr(fname[0].length-3,3).toLowerCase() == "jpg"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "png"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "gif"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "bmp"){
    	               	   theHtml += "<img src=\"data:image/png;base64,"+fname[1]+"\" width=\"50\" height=\"50\"></img><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
    	              }else{
    	               	   theHtml += "<a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
    	              }
		              theHtml += "</td>";
		              theHtml += "<td>";
		              theHtml += n[2];
		              theHtml += "</td>";
		              theHtml += "<td>";
		              theHtml += n[3];
		              theHtml += "</td>";
		              theHtml += "<td>";
		              theHtml += "<span class=\"fa fa-ellipsis-h\"></span>";
		              theHtml += "</td>";
		              theHtml +="</tr>";   
		          }   
		          
		          theHtml += "<p class=\"allLoad\">已全部加载，共"+data.length-1+"个项目</p> ";
		          theHtml += "</table>";
		          alert("theHtml="+theHtml);
		          $("#content").html("");
		          $("#content").html(theHtml);
		          needReloadInAsyncLoad();
		            
		      },
		      error: function() {
		        alert("error");
		      }
		    });
		
   }

</script>
<script>
   function getCol2UpDown(arg){
	    alert('col2 updown is ' + arg);
	    var col1=$("#Col1").find("i").parent().text();
	    //alert(col1);
	    if((col1.indexOf("升序")!=-1)||(col1.indexOf("降序")!=-1)){
	    	col1=col1.substring(2);
	    }  
	    alert('col1='+col1);
		var col2=$("#Col2").find("i").parent().text();
		if((col2.indexOf("升序")!=-1)||(col2.indexOf("降序")!=-1)){
	    	col2=col2.substring(2);
	    } 
		alert('col2='+col2);
	    var urlstr="";
	    var theHtml = "";
	    alert( "${pageContext.request.contextPath}/spring/col12Sort.do?name=col2&direction="+arg+"&col1="+english(col1)+"&col2="+english(col2));
	    $.ajax({
		      url: "${pageContext.request.contextPath}/spring/col12Sort.do?name=col2&direction="+arg+"&col1="+english(col1)+"&col2="+english(col2),
		      type: 'GET',
		      dataType: "json", 
		      async: true,
		      success: function(data) {
		    	  alert(data);
		    	  row=data[data.length-1].split("@#￥");
		    	  theHtml += "<table  border = \"0\" width=\"100%\">";
		          //文件网格布局的表头
		          theHtml += "<tr>";
		          theHtml += "<td><input type=\"checkbox\" id=\"maincheck\" name=\"maincheck\"/></td>";
		          theHtml += "<td width=\"16%\">目录/文件</td>";
		          theHtml += "<td>"+"<div id=\"Name\">";
		          //名称
		          theHtml += "<span>名称</span>";
		          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
		          theHtml += "<ul><li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>";
		          theHtml += "<li><a href=\"javascript:getFileName('asc','" + row[1] + "','" + row[2] + "');\"><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getFileName('desc','" + row[1] + "','" + row[2] + "');\"><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></a></li></ul>";
		          theHtml += "</div>";
		          theHtml += "</td>";
		          
		          //Col1
		          theHtml += "<td><div id=\"Col1\">";
		          theHtml += "<span>"+row[1]+"</span>";
		          
		          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
		          theHtml += "<ul>";
		          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>";
		          theHtml += "<li><a href=\"javascript:getCol1UpDown('asc')\"><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol1UpDown('desc')\"><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></a></li>";
		          theHtml += "<li><hr/></li>";
		          theHtml += "<li><span style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>";
		          alert(theHtml);
		          if(row[1]=="最后修改时间"){
		        	  ok1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok2=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[1]=="成员"){
		        	  ok2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		              ok1=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[1]=="类型"){
		        	  ok3="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[1]=="扩展名"){
		              ok4="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok3=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[1]=="大小"){
		        	  ok5="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok3=ok4="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else{
		        	 
		          }
		          var graycolor=" style=\"color:gray;\"";
		          var col1color1=col1color2=col1color3=col1color4=col1color5="";
		          var col2color1=col2color2=col2color3=col2color4=col2color5="";
		          if(row[2]=="最后修改时间"){
		        	  col1color1=graycolor;
		          }else if(row[2]=="成员"){
		        	  col1color2=graycolor;
		          }else if(row[2]=="类型"){
		        	  col1color3=graycolor;
		          }else if(row[2]=="扩展名"){
		        	  col1color4=graycolor;
		          }else if(row[2]=="大小"){
		        	  col1color5=graycolor;
		          }
		          
		          if(row[1]=="最后修改时间"){
		        	  col2color1=graycolor;
		          }else if(row[1]=="成员"){
		        	  col2color2=graycolor;
		          }else if(row[1]=="类型"){
		        	  col2color3=graycolor;
		          }else if(row[1]=="扩展名"){
		        	  col2color4=graycolor;
		          }else if(row[1]=="大小"){
		        	  col2color5=graycolor;
		          }
		          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','lastmodifytime','"+english(row[2])+"');\">" + ok1 + "<span"+col1color1+">最后修改时间</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','owner','"+english(row[2])+"');\">" + ok2 + "<span"+col1color2+">成员</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','type','"+english(row[2])+"');\">" + ok3 + "<span"+col1color3+">类型</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','ext','"+english(row[2])+"');\">" + ok4 + "<span"+col1color4+">扩展名</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','length','"+english(row[2])+"');\">" + ok5 + "<span"+col1color5+">大小</span></a></li>";
		          theHtml += "</ul></div>";
		          theHtml += "</td>";
		          theHtml += "<td>";
		          
		          //Col2
		          if(row[0]=="asc"){
    	        	  namecheck1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
    	              namecheck2="&nbsp;&nbsp;&nbsp;&nbsp;";
    	          }else if(row[0]=="desc"){
    	    	      namecheck2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
    	              namecheck1="&nbsp;&nbsp;&nbsp;&nbsp;";
    	          }
		          theHtml += "<div id=\"Col2\">";
		          theHtml += "<span>"+row[2]+"</span>";
		          if(row[0]=="asc"){
	 	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-up\"></i></span>";
	 	          }else if(row[0]=="desc"){
	 	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-down\"></i></span>";
	 	          }
		          
		          theHtml += "<ul>";
		          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>"
		          theHtml += "<li><a href=\"javascript:getCol2UpDown('asc')\"><span>"+namecheck1+"升序</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol2UpDown('desc')\"><span>"+namecheck2+"降序</span></a></li>";
		          theHtml += "<li><hr/></li>";
		          if(row[2]=="最后修改时间"){
		        	  ok1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok2=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[2]=="成员"){
		        	  ok2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		              ok1=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[2]=="类型"){
		        	  ok3="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[2]=="扩展名"){
		              ok4="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok3=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else if(row[2]=="大小"){
		        	  ok5="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
		        	  ok1=ok2=ok3=ok4="&nbsp;&nbsp;&nbsp;&nbsp;";
		          }else{
		        	 
		          }
		          theHtml += "<li><span style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>";
		          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','lastmodifytime');\">" + ok1 + "<span"+col2color1+">最后修改时间</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','owner');\">" + ok2 + "<span"+col2color2+">成员</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','type');\">" + ok3 + "<span"+col2color3+">类型</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','ext');\">" + ok4 + "<span"+col2color4+">扩展名</span></a></li>";
		          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','length');\">" + ok5 + "<span"+col2color5+">大小</span></a></li>";
		          theHtml += "</td>";
		          theHtml += "<td>";
		          theHtml += "<div id=\"ListOrLayout\"><span class=\"fa fa-list-ul\"></span> ";
		          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
		          theHtml += "<ul>";
		          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查看格式</div></li>";
		          theHtml += "<li><i class=\"fa fa-check\" aria-hidden=\"true\"></i><a href=\"javascript:getFileList();\"><span>列表</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-list-ul\"></i></span></a></li>";
		          theHtml += "<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:getFileLayout();\"><span>网格</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-th\"></i></span></a></li>";
		          theHtml += "</ul>";
		          theHtml += "</div>";
		          theHtml += "</td>";
		          for (i=0; i<data.length-1; i++){
		        	   var n=data[i].split("@#￥");
		         	   theHtml += "<tr>";
		         	   theHtml += "<td><input type=\"checkbox\" id=\"subBox"+i+"\" name=\"subBox\" /></td>";
		         	  theHtml += "<td>";
		              if( n[0] == "file" ){
		           	   theHtml += "<span class=\"fa fa-file\"></span>";
		              }else{
		           	   theHtml += "<span class=\"fa fa-folder\"></span>";
		              }
		              theHtml += "</td>";
		              theHtml += "<td>";
		              //alert("the point is "+theHtml);
		              var fname = n[1].split("^^^^^^");
    	              if( fname[0].substr(fname[0].length-3,3).toLowerCase() == "jpg"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "png"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "gif"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "bmp"){
    	               	   theHtml += "<img src=\"data:image/png;base64,"+fname[1]+"\" width=\"50\" height=\"50\"></img><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
    	              }else{
    	               	   theHtml += "<a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
    	              }
		              theHtml += "</td>";
		              theHtml += "<td>";
		              theHtml += n[2];
		              theHtml += "</td>";
		              theHtml += "<td>";
		              theHtml += n[3];
		              theHtml += "</td>";
		              theHtml += "<td>";
		              theHtml += "<span class=\"fa fa-ellipsis-h\"></span>";
		              theHtml += "</td>";
		              theHtml +="</tr>";   
		          }   
		          
		          theHtml += "<p class=\"allLoad\">已全部加载，共"+data.length-1+"个项目</p> ";
		          theHtml += "</table>";
		          alert("theHtml="+theHtml);
		          $("#content").html("");
		          $("#content").html(theHtml);
		          needReloadInAsyncLoad();
		            
		      },
		      error: function() {
		        alert("error");
		      }
		    });
		
   }
</script>
<script>
   function english(arg1){
		  switch(arg1)
		  {
		  case '最后修改时间':
		    return 'lastmodifytime';
		  case '类型':
		    return 'type';
		  case '成员':
			    return 'owner';
		  case '大小':
			    return 'length';
		  case '扩展名':
			    return 'ext';
		  case 'lastmodifytime':
			    return 'lastmodifytime';
	      case 'type':
			    return 'type';
	      case 'owner':
				return 'owner';
		  case 'length':
				return 'length';
		  case 'ext':
				return 'ext';
		  default:
		    return 'error';  
		  }
	  }

</script>

<script>
function getCol(a0,a1,a2) {
	var arg0, arg1, arg2;
	var urlstring;
	arg0=a0;
	arg1=a1;
	arg2=a2;
	if(arg0=='asc'){
		getOthersUpDown('asc', 'col1', a1, a2);
	    return 1;
	}else if(arg0=='desc'){
		getOthersUpDown('desc', 'col1', a1, a2);
	    return 1;
	}
	var theHtml = "";
	var ok1=ok2=ok3=ok4=ok5="";
	alert("${pageContext.request.contextPath}/spring/fileNameSort.do?name="+arg0+"&col1="+arg1+"&col2="+arg2);
	$.ajax({
	      url: "${pageContext.request.contextPath}/spring/fileNameSort.do?name=null&col1="+arg1+"&col2="+arg2,
	      type: 'GET',
	      dataType: "json", 
	      async: true,
	      success: function(data) {
	    	  alert(data);
	    	  //row[1]和row[2]是返回来要在页面上显示的col1和col2的列标题
	    	  var row=data[data.length-1].split("@#￥");
	    	  theHtml += "<table  border = \"0\" width=\"100%\">";
	    	  //alert(theHtml);
	          //文件网格布局的表头
	          theHtml += "<tr>";
	          theHtml += "<td><input type=\"checkbox\" id=\"maincheck\" name=\"maincheck\"/></td>";
	          theHtml += "<td width=\"16%\">目录/文件</td>";
	          theHtml += "<td>"+"<div id=\"Name\">";
	          //名称
	          theHtml += "<span>名称</span>";
	          if(row[0]=="asc"){
	        	  namecheck1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	              namecheck2="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[0]=="desc"){
	    	      namecheck2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	              namecheck1="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[0]=="null"){
	        	  namecheck1=namecheck2="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }
              
               if(row[0]=="asc"){
	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-up\"></i></span>";
	           }else if(row[0]=="desc"){
	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-down\"></i></span>";
	           }else if(row[0]=="null"){
	        	   theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
	           }
               
	          theHtml += "<ul><li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>";
	          
	          theHtml += "<li><a href=\"javascript:getFileName('asc','" + row[1] + "','" + row[2] + "');\"><span>"+namecheck1+"升序</span></a></li>";
	          //alert(theHtml);
	          theHtml += "<li><a href=\"javascript:getFileName('desc','" + row[1] + "','" + row[2] + "');\"><span>"+namecheck2+"降序</span></a></li></ul>";
	          
	          
	          theHtml += "</div>";
	          theHtml += "</td>";
	          //Col1
	          theHtml += "<td><div id=\"Col1\">";
	          theHtml += "<span>"+row[1]+"</span>";
	          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
	          theHtml += "<ul>";
	          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>";
	          theHtml += "<li><a href=\"javascript:getCol1UpDown('asc')\"><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol1UpDown('desc')\"><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></a></li>";
	          theHtml += "<li><hr/></li>";
	          theHtml += "<li><span style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>";
	          
	          if(row[1]=="最后修改时间"){
	        	  ok1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok2=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[1]=="成员"){
	        	  ok2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	              ok1=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[1]=="类型"){
	        	  ok3="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[1]=="扩展名"){
	              ok4="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok3=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[1]=="大小"){
	        	  ok5="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok3=ok4="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else{
	        	 
	          }
	          
	          var graycolor=" style=\"color:gray;\"";
	          var col1color1=col1color2=col1color3=col1color4=col1color5="";
	          var col2color1=col2color2=col2color3=col2color4=col2color5="";
	          if(row[2]=="最后修改时间"){
	        	  col1color1=graycolor;
	          }else if(row[2]=="成员"){
	        	  col1color2=graycolor;
	          }else if(row[2]=="类型"){
	        	  col1color3=graycolor;
	          }else if(row[2]=="扩展名"){
	        	  col1color4=graycolor;
	          }else if(row[2]=="大小"){
	        	  col1color5=graycolor;
	          }
	          
	          if(row[1]=="最后修改时间"){
	        	  col2color1=graycolor;
	          }else if(row[1]=="成员"){
	        	  col2color2=graycolor;
	          }else if(row[1]=="类型"){
	        	  col2color3=graycolor;
	          }else if(row[1]=="扩展名"){
	        	  col2color4=graycolor;
	          }else if(row[1]=="大小"){
	        	  col2color5=graycolor;
	          }
	          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','lastmodifytime','"+english(row[2])+"');\">" + ok1 + "<span"+col1color1+">最后修改时间</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','owner','"+english(row[2])+"');\">" + ok2 + "<span"+col1color2+">成员</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','type','"+english(row[2])+"');\">" + ok3 + "<span"+col1color3+">类型</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','ext','"+english(row[2])+"');\">" + ok4 + "<span"+col1color4+">扩展名</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','length','"+english(row[2])+"');\">" + ok5 + "<span"+col1color5+">大小</span></a></li>";
	          theHtml += "</ul></div>";
	          theHtml += "</td>";
	          theHtml += "<td>";
	          //Col2
	          theHtml += "<div id=\"Col2\">";
	          theHtml += "<span>"+row[2]+"</span>";
	          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
	          theHtml += "<ul>";
	          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>"
	          theHtml += "<li><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></li>";
	          theHtml += "<li><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></li>";
	          theHtml += "<li><hr/></li>";
	          if(row[2]=="最后修改时间"){
	        	  ok1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok2=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[2]=="成员"){
	        	  ok2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	              ok1=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[2]=="类型"){
	        	  ok3="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[2]=="扩展名"){
	              ok4="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok3=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[2]=="大小"){
	        	  ok5="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok3=ok4="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else{
	        	 
	          }
	          theHtml += "<li><span style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>";
	          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','lastmodifytime');\">" + ok1 + "<span"+col2color1+">最后修改时间</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','owner');\">" + ok2 + "<span"+col2color2+">成员</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','type');\">" + ok3 + "<span"+col2color3+">类型</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','ext');\">" + ok4 + "<span"+col2color4+">扩展名</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol('"+row[0]+"','"+english(row[1])+"','length');\">" + ok5 + "<span"+col2color5+">大小</span></a></li>";
	          theHtml += "</td>";
	          theHtml += "<td>";
	          theHtml += "<div id=\"ListOrLayout\"><span class=\"fa-list-ul\"></span> ";
	          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
	          theHtml += "<ul>";
	          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查看格式</div></li>";
	          theHtml += "<li><i class=\"fa fa-check\" aria-hidden=\"true\"></i><a href=\"javascript:getFileList();\"><span>列表</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-list-ul\"></i></span></a></li>";
	          theHtml += "<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:getFileLayout();\"><span>网格</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-th\"></i></span></a></li>";
	          theHtml += "</ul>";
	          theHtml += "</div>";
	          theHtml += "</td>";
	          for (i=0; i<data.length-1; i++){
	        	   var n=data[i].split("@#￥");
	         	   theHtml += "<tr>";
	         	   theHtml += "<td><input type=\"checkbox\" id=\"subBox"+i+"\" name=\"subBox\" /></td>";
	         	  theHtml += "<td>";
	              if( n[0] == "file" ){
	           	   theHtml += "<span class=\"fa fa-file\"></span>";
	              }else{
	           	   theHtml += "<span class=\"fa fa-folder\"></span>";
	              }
	              theHtml += "</td>";
	              theHtml += "<td>";
	              var fname = n[1].split("^^^^^^");
	              if( fname[0].substr(fname[0].length-3,3).toLowerCase() == "jpg"
	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "png"
	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "gif"
	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "bmp"){
	               	   theHtml += "<img src=\"data:image/png;base64,"+fname[1]+"\" width=\"50\" height=\"50\"></img><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
	              }else{
	               	   theHtml += "<a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
	              }
	              theHtml += "</td>";
	              theHtml += "<td>";
	              theHtml += n[2];
	              theHtml += "</td>";
	              theHtml += "<td>";
	              theHtml += n[3];
	              theHtml += "</td>";
	              theHtml += "<td>";
	              theHtml += "<span class=\"fa fa-ellipsis-h\"></span>";
	              theHtml += "</td>";
	              theHtml +="</tr>";   
	          }   
	          
	          theHtml += "<p class=\"allLoad\">已全部加载，共"+data.length-1+"个项目</p> ";
	          theHtml += "</table>";
	          alert(theHtml);
	          $("#content").html("");
	          $("#content").html(theHtml);
	          needReloadInAsyncLoad();
	            
	      },
	      error: function() {
	        alert("error");
	      }
	    });
  }
  
</script>
<script>
function getCol2(a0,a1,a2) {
	var arg0, arg1, arg2;
	var urlstring;
	arg0=a0;
	arg1=a1;
	arg2=a2;
	if(arg0=='asc'){
		getOthersUpDown('asc', 'col2', a1, a2);
	    return 1;
	}else if(arg0=='desc'){
		getOthersUpDown('desc', 'col2', a1, a2);
	    return 1;
	}
	var theHtml = "";
	var ok1=ok2=ok3=ok4=ok5="";
	alert("${pageContext.request.contextPath}/spring/fileNameSort.do?name="+arg0+"&col1="+arg1+"&col2="+arg2);
	$.ajax({
	      url: "${pageContext.request.contextPath}/spring/fileNameSort.do?name=null&col1="+arg1+"&col2="+arg2,
	      type: 'GET',
	      dataType: "json", 
	      async: true,
	      success: function(data) {
	    	  alert(data);
	    	  //row[1]和row[2]是返回来要在页面上显示的col1和col2的列标题
	    	  var row=data[data.length-1].split("@#￥");
	    	  theHtml += "<table  border = \"0\" width=\"100%\">";
	    	  //alert(theHtml);
	          //文件网格布局的表头
	          theHtml += "<tr>";
	          theHtml += "<td><input type=\"checkbox\" id=\"maincheck\" name=\"maincheck\"/></td>";
	          theHtml += "<td width=\"16%\">目录/文件</td>";
	          theHtml += "<td>"+"<div id=\"Name\">";
	          //名称
	          theHtml += "<span>名称</span>";
	          if(row[0]=="asc"){
	        	  namecheck1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	              namecheck2="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[0]=="desc"){
	    	      namecheck2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	              namecheck1="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[0]=="null"){
	        	  namecheck1=namecheck2="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }
              
               if(row[0]=="asc"){
	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-up\"></i></span>";
	           }else if(row[0]=="desc"){
	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-down\"></i></span>";
	           }else if(row[0]=="null"){
	        	   theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
	           }
               
	          theHtml += "<ul><li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>";
	          
	          theHtml += "<li><a href=\"javascript:getFileName('asc','" + row[1] + "','" + row[2] + "');\"><span>"+namecheck1+"升序</span></a></li>";
	          //alert(theHtml);
	          theHtml += "<li><a href=\"javascript:getFileName('desc','" + row[1] + "','" + row[2] + "');\"><span>"+namecheck2+"降序</span></a></li></ul>";
	          
	          
	          theHtml += "</div>";
	          theHtml += "</td>";
	          //Col1
	          theHtml += "<td><div id=\"Col1\">";
	          theHtml += "<span>"+row[1]+"</span>";
	          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
	          theHtml += "<ul>";
	          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>";
	          theHtml += "<li><a href=\"javascript:getCol1UpDown('asc')\"><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol1UpDown('desc')\"><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></a></li>";
	          theHtml += "<li><hr/></li>";
	          theHtml += "<li><span style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>";
	          
	          if(row[1]=="最后修改时间"){
	        	  ok1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok2=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[1]=="成员"){
	        	  ok2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	              ok1=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[1]=="类型"){
	        	  ok3="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[1]=="扩展名"){
	              ok4="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok3=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[1]=="大小"){
	        	  ok5="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok3=ok4="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else{
	        	 
	          }
	          
	          var graycolor=" style=\"color:gray;\"";
	          var col1color1=col1color2=col1color3=col1color4=col1color5="";
	          var col2color1=col2color2=col2color3=col2color4=col2color5="";
	          if(row[2]=="最后修改时间"){
	        	  col1color1=graycolor;
	          }else if(row[2]=="成员"){
	        	  col1color2=graycolor;
	          }else if(row[2]=="类型"){
	        	  col1color3=graycolor;
	          }else if(row[2]=="扩展名"){
	        	  col1color4=graycolor;
	          }else if(row[2]=="大小"){
	        	  col1color5=graycolor;
	          }
	          
	          if(row[1]=="最后修改时间"){
	        	  col2color1=graycolor;
	          }else if(row[1]=="成员"){
	        	  col2color2=graycolor;
	          }else if(row[1]=="类型"){
	        	  col2color3=graycolor;
	          }else if(row[1]=="扩展名"){
	        	  col2color4=graycolor;
	          }else if(row[1]=="大小"){
	        	  col2color5=graycolor;
	          }
	          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','lastmodifytime','"+english(row[2])+"');\">" + ok1 + "<span"+col1color1+">最后修改时间</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','owner','"+english(row[2])+"');\">" + ok2 + "<span"+col1color2+">成员</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','type','"+english(row[2])+"');\">" + ok3 + "<span"+col1color3+">类型</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','ext','"+english(row[2])+"');\">" + ok4 + "<span"+col1color4+">扩展名</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','length','"+english(row[2])+"');\">" + ok5 + "<span"+col1color5+">大小</span></a></li>";
	          theHtml += "</ul></div>";
	          theHtml += "</td>";
	          theHtml += "<td>";
	          //Col2
	          theHtml += "<div id=\"Col2\">";
	          theHtml += "<span>"+row[2]+"</span>";
	          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
	          theHtml += "<ul>";
	          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>"
	          theHtml += "<li><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></li>";
	          theHtml += "<li><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></li>";
	          theHtml += "<li><hr/></li>";
	          if(row[2]=="最后修改时间"){
	        	  ok1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok2=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[2]=="成员"){
	        	  ok2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	              ok1=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[2]=="类型"){
	        	  ok3="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[2]=="扩展名"){
	              ok4="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok3=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[2]=="大小"){
	        	  ok5="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok3=ok4="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else{
	        	 
	          }
	          theHtml += "<li><span style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>";
	          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','lastmodifytime');\">" + ok1 + "<span"+col2color1+">最后修改时间</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','owner');\">" + ok2 + "<span"+col2color2+">成员</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','type');\">" + ok3 + "<span"+col2color3+">类型</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','ext');\">" + ok4 + "<span"+col2color4+">扩展名</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getCol2('"+row[0]+"','"+english(row[1])+"','length');\">" + ok5 + "<span"+col2color5+">大小</span></a></li>";
	          theHtml += "</td>";
	          theHtml += "<td>";
	          theHtml += "<div id=\"ListOrLayout\"><span class=\"fa fa-list-ul\"></span> ";
	          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
	          theHtml += "<ul>";
	          theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查看格式</div></li>";
	          theHtml += "<li><i class=\"fa fa-check\" aria-hidden=\"true\"></i><a href=\"javascript:getFileList();\"><span>列表</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-list-ul\"></i></span></a></li>";
	          theHtml += "<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:getFileLayout();\"><span>网格</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-th\"></i></span></a></li>";
	          theHtml += "</ul>";
	          theHtml += "</div>";
	          theHtml += "</td>";
	          for (i=0; i<data.length-1; i++){
	        	   var n=data[i].split("@#￥");
	         	   theHtml += "<tr>";
	         	   theHtml += "<td><input type=\"checkbox\" id=\"subBox"+i+"\" name=\"subBox\" /></td>";
	         	  theHtml += "<td>";
	              if( n[0] == "file" ){
	           	   theHtml += "<span class=\"fa fa-file\"></span>";
	              }else{
	           	   theHtml += "<span class=\"fa fa-folder\"></span>";
	              }
	              theHtml += "</td>";
	              theHtml += "<td>";
	              var fname = n[1].split("^^^^^^");
	              if( fname[0].substr(fname[0].length-3,3).toLowerCase() == "jpg"
	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "png"
	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "gif"
	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "bmp"){
	               	   theHtml += "<img src=\"data:image/png;base64,"+fname[1]+"\" width=\"50\" height=\"50\"></img><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
	              }else{
	               	   theHtml += "<a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
	              }
	              theHtml += "</td>";
	              theHtml += "<td>";
	              theHtml += n[2];
	              theHtml += "</td>";
	              theHtml += "<td>";
	              theHtml += n[3];
	              theHtml += "</td>";
	              theHtml += "<td>";
	              theHtml += "<span class=\"fa fa-ellipsis-h\"></span>";
	              theHtml += "</td>";
	              theHtml +="</tr>";   
	          }   
	          
	          theHtml += "<p class=\"allLoad\">已全部加载，共"+data.length-1+"个项目</p> ";
	          theHtml += "</table>";
	          alert(theHtml);
	          $("#content").html("");
	          $("#content").html(theHtml);
	          needReloadInAsyncLoad();
	            
	      },
	      error: function() {
	        alert("error");
	      }
	    });
  }
</script>

<script>
function getFileLayout() {
	//alert("getFileLayout");
	var theHtml = "";
    $.ajax({
      url: "${pageContext.request.contextPath}/spring/filelayout.do",
      type: 'POST',
      dataType: "json", 
      async: true,
      success: function(data) {
    	  //alert(data);
    	  var tHeight = parseInt(data.length/6);
          //alert("height: "+tHeight);
          theHtml += "<table  border = \"0\" width=\"100%\">";
          
          //文件网格布局的表头
          theHtml += "<tr>";
          theHtml += "<td>";
          theHtml += "Uploador";
          theHtml += "</td>";
          theHtml += "<td>";
          theHtml += "</td>";
          theHtml += "<td>";
          theHtml += "</td>";
          theHtml += "<td>";
          theHtml += "</td>";
          theHtml += "<td>";
          theHtml += "</td>";
          theHtml += "<td align=\"right\">";
          theHtml += "<div id=\"ListOrLayout\"><span class=\"fa fa fa-th\"></span> ";
          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
          theHtml += "<ul>";
          theHtml += " <li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查看格式</div></li>";
          theHtml += "<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:getFileList();\"><span>列表</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-list-ul\"></i></span></a></li>";
          theHtml += "<li><i class=\"fa fa-check\" aria-hidden=\"true\"></i><span>网格</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-th\"></i></span></li>";
          theHtml += "</ul>";
          theHtml += "</div>";
          theHtml += "</td>";
          theHtml += "</tr>";
          //文件网格布局一共有tHeight个行，每个行有6个单元来显示文件或者文件夹
          for (i=0; i<tHeight; i++){
       	   theHtml += "<tr>";
                 for(j=0; j<6; j++){
               	  theHtml += "<td width=\"16.66%\">";
               	  var str=data[i*6+j];
               	  var n=str.split("@#￥");
               	  var fname = n[1].split("^^^^^^");
               	  if(n[0] == "file"){
               		  if( fname[0].substr(fname[0].length-3,3).toLowerCase() == "jpg"
		               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "png"
		               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "gif"
		               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "bmp"){
		               	   theHtml += "<img src=\"data:image/png;base64,"+fname[1]+"\" width=\"200\" height=\"200\"></img><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
		              }else{
		               	   theHtml += "<a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
		              }
               	  }else{
               		theHtml +="<div class=\"fa fa-folder fa-5x\"  style=\"color:#21a0df;\"></div><div><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">" + fname[0]+"</a></div>";
               	  }
               	  theHtml += "</td>";
                 }
                 theHtml += "</tr>";
          }
          theHtml += "<tr>";
          for (i=tHeight*6; i<data.length; i++){
        	  theHtml += "<td width=\"16.66%\">";
           	  var str=data[i];
           	  var n=str.split("@#￥");
              var fname = n[1].split("^^^^^^");
           	  if(n[0] == "file"){
           		if( fname[0].substr(fname[0].length-3,3).toLowerCase() == "jpg"
	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "png"
	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "gif"
	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "bmp"){
	               	   theHtml += "<img src=\"data:image/png;base64,"+fname[1]+"\" width=\"200\" height=\"200\"></img><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
	              }else{
	               	   theHtml += "<a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
	              }
           	  }else{
           		  theHtml +="<div class=\"fa fa-folder fa-5x\"  style=\"color:#21a0df;\"></div><div><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">" + fname[0] +"</a></div>";
           	  }
           	  theHtml += "</td>";
          }
          for(i=0; i < (tHeight+1)*6-data.length;i++)
        	  theHtml +="<td width=\"16.66%\"></td>"
          theHtml += "</tr>";
          theHtml += "</table>";
          //alert(theHtml);
          $("#content").html("");
          $("#content").html(theHtml);
          needReloadInAsyncLoad();
            
      },
      error: function() {
        alert("error");
      }
    });
  }
</script>
<script>
    //这个函数是涌过来让用户删除选中的文件或者文件夹
    function deleteFileDir(){
    	var $subBox = $("input[name='subBox']"); 
    	$subBox.each(function(){
    		if ( $(this).prop("checked")){
    			//调用deletThis()Ajax函数来把文件或者文件夹删除
    			var fname=$(this).parent().siblings().find("a").html();
    			//alert (encodeURI(fname));
    			toDelete(fname);
    		}
    	});

    }
  
    function toDelete(filename){
    	//alert("${pageContext.request.contextPath}/spring/"+encodeURI(filename)+"/delete.do");
    	 $.ajax({
            url: "${pageContext.request.contextPath}/spring/"+encodeURI(encodeURI(filename))+"/delete.do",
            type: 'GET',
            dataType: "json", 
            async: true,
            success: function(data) {
            	alert(data);
            },
            error: function() {
              alert("error");
            }
        });
    }
</script>
<script>
    //这个函数是用来让用户新增目录
    function addFolder(){
    	var listOrLayout=$("#ListOrLayout").find("i").parent().text();
    	//alert(listOrLayout);
    	if (listOrLayout.trim() == "列表"){
    		addFolderWithFileList();
    	}else if(listOrLayout.trim() == "网格"){
    		addFolderWithFileLayout();
    	}
    }
    //在列表的情况下新增目录
    function addFolderWithFileList(){
    	//alert("addFolderWithFilelist");
    	var insertNewFolder //= document.createTextNode("你好");
    	   ="<tr><td colspan=\"2\"><span class=\"fa fa-folder fa-2x \" style=\"color:#21a0df;\"></span></td><td colspan=\"3\"><input type=\"text\" size=\"40\" id=\"newFolder\"></td></tr>";
    	var c = $("#content").children().last().children().children().first().next();
    	//alert(c.html());
    	c.before(insertNewFolder);
    	$("#newFolder").focus();
    	needReloadInAsyncLoad();
     }
    //在网格的情况下新增目录
    function addFolderWithFileLayout() {
    	//alert("addFolderWithFileLayout");
    	var theHtml = "";
        $.ajax({
          url: "${pageContext.request.contextPath}/spring/filelayout.do",
          type: 'POST',
          dataType: "json", 
          async: true,
          success: function(data) {
        	  //alert(data);
        	  var tHeight = parseInt((data.length+1)/6);
        	  //alert("原来目录里面一共有"+data.length+"个文件");
              //alert("加上新建的一个文件夹，共有"+String(data.length+1)+"个文件和文件夹，每行6个单位，共有"+tHeight+"层");
              theHtml += "<table  border = \"0\" width=\"100%\">";
              
              //文件网格布局的表头
              theHtml += "<tr>";
              theHtml += "<td>";
              theHtml += "Uploador";
              theHtml += "</td>";
              theHtml += "<td>";
              theHtml += "</td>";
              theHtml += "<td>";
              theHtml += "</td>";
              theHtml += "<td>";
              theHtml += "</td>";
              theHtml += "<td>";
              theHtml += "</td>";
              theHtml += "<td align=\"right\">";
              theHtml += "<div id=\"ListOrLayout\"><span class=\"fa fa fa-th\"></span> ";
              theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
              theHtml += "<ul>";
              theHtml += " <li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查看格式</div></li>";
              theHtml += "<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:getFileList();\"><span>列表</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-list-ul\"></i></span></a></li>";
              theHtml += "<li><i class=\"fa fa-check\" aria-hidden=\"true\"></i><span>网格</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-th\"></i></span></li>";
              theHtml += "</ul>";
              theHtml += "</div>";
              theHtml += "</td>";
              theHtml += "</tr>";
              //文件网格布局一共有tHeight个行，每个行有6个单元来显示文件或者文件夹
              theHtml += "<tr>";
              //第一个单元是新建文件夹图样
              theHtml += "<td width=\"16.66%\">";
              theHtml += "<span class=\"fa fa-folder fa-5x \" style=\"color:#21a0df;\"></span>";
           	  theHtml += "<input type=\"text\" size=\"20\" id=\"newFolder\">";
           	  theHtml += "</td>";
              for (i=0; i<tHeight; i++){
           	        if(i==0){
           	        	
           	        }else{
           	        	theHtml += "<tr>";
           	        }
           	        
           	         
                    for(j=0; j<6; j++){
                    	 if(i*6+j==0){
                    		 
                    	 }else{
                    		 
                    		 theHtml += "<td width=\"16.66%\">";
                    		 
                          	  var str=data[i*6+j-1];
                          	  var n=str.split("@#￥");
                          	  var fname = n[1].split("^^^^^^");
                          	  if(n[0] == "file"){
                          		  if( fname[0].substr(fname[0].length-3,3).toLowerCase() == "jpg"
           		               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "png"
           		               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "gif"
           		               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "bmp"){
           		               	   theHtml += "<img src=\"data:image/png;base64,"+fname[1]+"\" width=\"200\" height=\"200\"></img><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
           		              }else{
           		               	   theHtml += "<a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
           		              }
                          	  }else{
                          		theHtml +="<div class=\"fa fa-folder\"></div><div><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">" + fname[0]+"</a></div>";
                          	  }
                          	  theHtml += "</td>";
                            }
                    		 
                     }
                   	  
                    theHtml += "</tr>";
              }
              theHtml += "<tr>";
              for (i=tHeight*6; i<data.length+1; i++){
            	  theHtml += "<td width=\"16.66%\">";
               	  var str=data[i-1];
               	  var n=str.split("@#￥");
                  var fname = n[1].split("^^^^^^");
               	  if(n[0] == "file"){
               		if( fname[0].substr(fname[0].length-3,3).toLowerCase() == "jpg"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "png"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "gif"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "bmp"){
    	               	   theHtml += "<img src=\"data:image/png;base64,"+fname[1]+"\" width=\"200\" height=\"200\"></img><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
    	              }else{
    	               	   theHtml += "<a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
    	              }
               	  }else{
               		  theHtml +="<div class=\"fa fa-folder\"></div><div><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">" + fname[0] +"</a></div>";
               	  }
               	  theHtml += "</td>";
              }
              for(i=0; i < (tHeight+1)*6-(data.length+1); i++)
            	  theHtml +="<td width=\"16.66%\"></td>"
              theHtml += "</tr>";
              theHtml += "</table>";
              //alert(theHtml);
              $("#content").html("");
              $("#content").html(theHtml);
              $("#newFolder").focus();  
              needReloadInAsyncLoad();
              
          },
          error: function() {
            alert("error");
          }
        });
      }
</script>

<script>
//新建文件夹的 on focus和 lost focus事件触发的Ajax
     $(document).ready(function(){ 
     	$("#newFolder").blur(function(){
     		//如果newFolder文本框里面有内容并且合法，那么就在后台生成一个目录
     		if($("#newFolder").val()!= ""){
     			alert("可以新增一个目录！");
     			alert("${pageContext.request.contextPath}/spring/"+$("#newFolder").val()+"/makedir.do");
     			  $.ajax({
     				  
     			      url: "${pageContext.request.contextPath}/spring/"+$("#newFolder").val()+"/makedir.do",
     			      type: 'GET',
     			      dataType: "json", 
     			      async: true,
     			      success: function(data) {
     			    	  alert(data);
     			    	 
     			            
     			      },
     			      error: function() {
     			        alert("error");
     			      }
     			    });
     		}
     		//如果newFolder文本框里面没有任何内容，那么重新调用FileLayout函数
     		else{
     			alert("你 需要写点东西！");
     		}
     		});
     });

</script>
<script>
function getFileName(a1,a2,a3) {
	//alert("name="+a1+",col1="+a2+",col2="+a3);
	var arg1 = a1;
	var theHtml = "";
	//名称升序排列
    if(arg1=="asc"){
    	$.ajax({
    	      url: "${pageContext.request.contextPath}/spring/fileNameSort.do?name=asc&col1="+english(a2)+"&col2="+english(a3),
    	      type: 'GET',
    	      dataType: "json", 
    	      async: true,
    	      success: function(data) {
    	    	  //alert(data);
    	    	  //row[1]和row[2]是返回来要在页面上显示的col1和col2的列标题
    	    	  var row=data[data.length-1].split("@#￥");
    	    	   theHtml += "<table  border = \"0\" width=\"100%\">";
    	    	  //alert(theHtml);
    	          //文件网格布局的表头
    	           theHtml += "<tr>";
	               theHtml += "<td><input type=\"checkbox\" id=\"maincheck\" name=\"maincheck\"/></td>";
	               theHtml += "<td width=\"16%\">目录/文件</td>";
	               theHtml += "<td>"+"<div id=\"Name\">";
	               if(row[0]=="asc"){
	    	        	  namecheck1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	    	              namecheck2="&nbsp;&nbsp;&nbsp;&nbsp;";
	    	       }else if(row[0]=="desc"){
	    	    	      namecheck2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	    	              namecheck1="&nbsp;&nbsp;&nbsp;&nbsp;";
	    	       }
	               theHtml += "<span>名称</span>";
	               if(row[0]=="asc"){
	 	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-up\"></i></span>";
	 	           }else if(row[0]=="desc"){
	 	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-down\"></i></span>";
	 	           }
	 	           
	               theHtml += "<ul><li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>";
	               theHtml += "<li><a href=\"javascript:getFileName('asc','" + row[1] + "','" + row[2] + "');\"><span>"+namecheck1+"升序</span></a></li>";
	               theHtml += "<li><a href=\"javascript:getFileName('desc','" + row[1] + "','" + row[2] + "');\"><span>"+namecheck2+"降序</span></a></li></ul>";
	               theHtml += "</div>";
	               theHtml += "</td>";
    	          theHtml += "<td><div id=\"Col1\">";
    	          theHtml += "<span>"+row[1]+"</span>";
    	          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
    	          theHtml += "<ul>";
	              theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>";
	              theHtml += "<li><a href=\"javascript:getCol1UpDown('asc')\"><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></a></li>";
	              theHtml += "<li><a href=\"javascript:getCol1UpDown('desc')\"><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></a></li>";
	              theHtml += "<li><hr/></li>";
	              //alert(theHtml);
    	          if(row[1]=="最后修改时间"){
    	        	  ok1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
    	        	  ok2=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
    	          }else if(row[1]=="成员"){
    	        	  ok2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
    	              ok1=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
    	          }else if(row[1]=="类型"){
    	        	  ok3="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
    	        	  ok1=ok2=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
    	          }else if(row[1]=="扩展名"){
    	              ok4="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
    	        	  ok1=ok2=ok3=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
    	          }else if(row[1]=="大小"){
    	        	  ok5="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
    	        	  ok1=ok2=ok3=ok4="&nbsp;&nbsp;&nbsp;&nbsp;";
    	          }else{
    	        	 
    	          }
    	          var graycolor=" style=\"color:gray;\"";
    	          var col1color1=col1color2=col1color3=col1color4=col1color5="";
    	          var col2color1=col2color2=col2color3=col2color4=col2color5="";
    	          if(row[2]=="最后修改时间"){
    	        	  col1color1=graycolor;
    	          }else if(row[2]=="成员"){
    	        	  col1color2=graycolor;
    	          }else if(row[2]=="类型"){
    	        	  col1color3=graycolor;
    	          }else if(row[2]=="扩展名"){
    	        	  col1color4=graycolor;
    	          }else if(row[2]=="大小"){
    	        	  col1color5=graycolor;
    	          }
    	          
    	          if(row[1]=="最后修改时间"){
    	        	  col2color1=graycolor;
    	          }else if(row[1]=="成员"){
    	        	  col2color2=graycolor;
    	          }else if(row[1]=="类型"){
    	        	  col2color3=graycolor;
    	          }else if(row[1]=="扩展名"){
    	        	  col2color4=graycolor;
    	          }else if(row[1]=="大小"){
    	        	  col2color5=graycolor;
    	          }
    	          theHtml += "<li><span style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>";
    	          theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','lastmodifytime','"+english(row[2])+"');\">" + ok1 + "<span"+col1color1+">最后修改时间</span></a></li>";
	              theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','owner','"+english(row[2])+"');\">" + ok2 + "<span"+col1color2+">成员</span></a></li>";
	              theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','type','"+english(row[2])+"');\">" + ok3 + "<span"+col1color3+">类型</span></a></li>";
	              theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','ext','"+english(row[2])+"');\">" + ok4 + "<span"+col1color4+">扩展名</span></a></li>";
	              theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','length','"+english(row[2])+"');\">" + ok5 + "<span"+col1color5+">大小</span></a></li>";
    	          theHtml += "</ul></div>";
    	          theHtml += "</td>";
    	          theHtml += "<td>";
    	          theHtml += "<div id=\"Col2\">";
    	          theHtml += "<span>"+row[2]+"</span>";
    	          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
    	          theHtml += "<ul>";
	              theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>"
	              theHtml += "<li><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></li>";
	              theHtml += "<li><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></li>";
	              theHtml += "<li><hr/></li>";
				  if(row[2]=="最后修改时间"){
					  ok1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
					  ok2=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	              }else if(row[2]=="成员"){
					  ok2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
					  ok1=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	              }else if(row[2]=="类型"){
					  ok3="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
					  ok1=ok2=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	              }else if(row[2]=="扩展名"){
					  ok4="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
					  ok1=ok2=ok3=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	              }else if(row[2]=="大小"){
					  ok5="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
					  ok1=ok2=ok3=ok4="&nbsp;&nbsp;&nbsp;&nbsp;";
	              }else{
	        	 
	              }
    	          theHtml += "<li><span style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>";
	              theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','"+english(row[1])+"','lastmodifytime');\">" + ok1 + "<span"+col2color1+">最后修改时间</span></a></li>";
	              theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','"+english(row[1])+"','owner');\">" + ok2 + "<span"+col2color2+">成员</span></a></li>";
	              theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','"+english(row[1])+"','type');\">" + ok3 + "<span"+col2color3+">类型</span></a></li>";
	              theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','"+english(row[1])+"','ext');\">" + ok4 + "<span"+col2color4+">扩展名</span></a></li>";
	              theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','"+english(row[1])+"','length');\">" + ok5 + "<span"+col2color5+">大小</span></a></li>";
	              theHtml += "</td>";
    	          theHtml += "<td>";
	              theHtml += "<div id=\"ListOrLayout\"><span class=\"fa fa-list-ul\"></span> ";
	              theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
	              theHtml += "<ul>";
	              theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查看格式</div></li>";
	              theHtml += "<li><i class=\"fa fa-check\" aria-hidden=\"true\"></i><a href=\"javascript:getFileList();\"><span>列表</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-list-ul\"></i></span></a></li>";
	              theHtml += "<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:getFileLayout();\"><span>网格</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-th\"></i></span></a></li>";
	              theHtml += "</ul>";
	              theHtml += "</div>";
	              theHtml += "</td>";
    	          for (i=0; i<data.length-1; i++){
    	        	   var n=data[i].split("@#￥");
    	         	   theHtml += "<tr>";
    	         	   theHtml += "<td><input type=\"checkbox\" id=\"subBox"+i+"\" name=\"subBox\" /></td>";
    	         	  theHtml += "<td>";
    	              if( n[0] == "file" ){
    	           	   theHtml += "<span class=\"fa fa-file\"></span>";
    	              }else{
    	           	   theHtml += "<span class=\"fa fa-folder\"></span>";
    	              }
    	              theHtml += "</td>";
    	              theHtml += "<td>";
    	              var fname = n[1].split("^^^^^^");
    	              if( fname[0].substr(fname[0].length-3,3).toLowerCase() == "jpg"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "png"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "gif"
    	               	  || fname[0].substr(fname[0].length-3,3).toLowerCase() == "bmp"){
    	               	   theHtml += "<img src=\"data:image/png;base64,"+fname[1]+"\" width=\"50\" height=\"50\"></img><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
    	              }else{
    	               	   theHtml += "<a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
    	              }
    	              theHtml += "</td>";
    	              theHtml += "<td>";
    	              theHtml += n[2];
    	              theHtml += "</td>";
    	              theHtml += "<td>";
    	              theHtml += n[3];
    	              theHtml += "</td>";
    	              theHtml += "<td>";
    	              theHtml += "<span class=\"fa fa-ellipsis-h\"></span>";
    	              theHtml += "</td>";
    	              theHtml +="</tr>";   
    	          }   
    	          
    	          theHtml += "<p class=\"allLoad\">已全部加载，共"+data.length-1+"个项目</p> ";
    	          theHtml += "</table>";
    	          //alert("show the html");
    	          //alert(theHtml);
    	          $("#content").html("");
    	          $("#content").html(theHtml);
    	          needReloadInAsyncLoad();
    	            
    	      },
    	      error: function() {
    	        alert("error");
    	      }
    	    });
    //名称降序排列	
    }else if(arg1=="desc"){
    	$.ajax({
  	      url: "${pageContext.request.contextPath}/spring/fileNameSort.do?name=desc&col1="+english(a2)+"&col2="+english(a3),
  	      type: 'GET',
  	      dataType: "json", 
  	      async: true,
  	      success: function(data) {
  	    	alert(data);
	    	  //row[1]和row[2]是返回来要在页面上显示的col1和col2的列标题
	    	  var row=data[data.length-1].split("@#￥");
	    	  theHtml += "<table  border = \"0\" width=\"100%\">";
	          //文件网格布局的表头
	          theHtml += "<tr>";
	          theHtml += "<td><input type=\"checkbox\" id=\"maincheck\" name=\"maincheck\"/></td>";
	          theHtml += "<td width=\"16%\">目录/文件</td>";
	          theHtml += "<td>"+"<div id=\"Name\">";
	          theHtml += "<span>名称</span>";
	          if(row[0]=="asc"){
	        	  namecheck1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	              namecheck2="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[0]=="desc"){
	    	      namecheck2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	              namecheck1="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }
	          if(row[0]=="asc"){
	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-up\"></i></span>";
	          }else if(row[0]=="desc"){
	        	  theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-arrow-down\"></i></span>";
	          }
	          
	          theHtml += "<ul><li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>";
	          theHtml += "<li><a href=\"javascript:getFileName('asc','" + row[1] + "','" + row[2] + "');\"><span>"+namecheck1+"升序</span></a></li>";
	          theHtml += "<li><a href=\"javascript:getFileName('desc','" + row[1] + "','" + row[2] + "');\"><span>"+namecheck2+"降序</span></a></li></ul>";
	          theHtml += "</div>";
	          theHtml += "</td>";
	          theHtml += "<td><div id=\"Col1\">";
	          theHtml += "<span>"+row[1]+"</span>";
	          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
	          theHtml += "<ul>";
            theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>";
            theHtml += "<li><a href=\"javascript:getCol1UpDown('asc')\"><span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></a></li>";
            theHtml += "<li><a href=\"javascript:getCol1UpDown('desc')\"><span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></a></li>";
            theHtml += "<li><hr/></li>";
	          if(row[1]=="最后修改时间"){
	        	  ok1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok2=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[1]=="成员"){
	        	  ok2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	              ok1=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[1]=="类型"){
	        	  ok3="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[1]=="扩展名"){
	              ok4="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok3=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else if(row[1]=="大小"){
	        	  ok5="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
	        	  ok1=ok2=ok3=ok4="&nbsp;&nbsp;&nbsp;&nbsp;";
	          }else{
	        	 
	          }
	          var graycolor=" style=\"color:gray;\"";
	          var col1color1=col1color2=col1color3=col1color4=col1color5="";
	          var col2color1=col2color2=col2color3=col2color4=col2color5="";
	          if(row[2]=="最后修改时间"){
	        	  col1color1=graycolor;
	          }else if(row[2]=="成员"){
	        	  col1color2=graycolor;
	          }else if(row[2]=="类型"){
	        	  col1color3=graycolor;
	          }else if(row[2]=="扩展名"){
	        	  col1color4=graycolor;
	          }else if(row[2]=="大小"){
	        	  col1color5=graycolor;
	          }
	          
	          if(row[1]=="最后修改时间"){
	        	  col2color1=graycolor;
	          }else if(row[1]=="成员"){
	        	  col2color2=graycolor;
	          }else if(row[1]=="类型"){
	        	  col2color3=graycolor;
	          }else if(row[1]=="扩展名"){
	        	  col2color4=graycolor;
	          }else if(row[1]=="大小"){
	        	  col2color5=graycolor;
	          }
	          theHtml += "<li><span style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>";
	          theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','lastmodifytime','"+english(row[2])+"');\">" + ok1 + "<span"+col1color1+">最后修改时间</span></a></li>";
              theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','owner','"+english(row[2])+"');\">" + ok2 + "<span"+col1color2+">成员</span></a></li>";
              theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','type','"+english(row[2])+"');\">" + ok3 + "<span"+col1color3+">类型</span></a></li>";
              theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','ext','"+english(row[2])+"');\">" + ok4 + "<span"+col1color4+">扩展名</span></a></li>";
              theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','length','"+english(row[2])+"');\">" + ok5 + "<span"+col1color5+">大小</span></a></li>";
	          theHtml += "</ul></div>";
	          theHtml += "</td>";
	          theHtml += "<td>";
	          theHtml += "<div id=\"Col2\">";
	          theHtml += "<span>"+row[2]+"</span>";
	          theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
	          theHtml += "<ul>";
              theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;排序</div></li>"
              theHtml += "<li><a href=\"javascript:getCol2UpDown('asc')\"<span>&nbsp;&nbsp;&nbsp;&nbsp;升序</span></a></li>";
              theHtml += "<li><a href=\"javascript:getCol2UpDown('desc')\"<span>&nbsp;&nbsp;&nbsp;&nbsp;降序</span></a></li>";
              theHtml += "<li><hr/></li>";
			  if(row[2]=="最后修改时间"){
				  ok1="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
				  ok2=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
              }else if(row[2]=="成员"){
				  ok2="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
				  ok1=ok3=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
              }else if(row[2]=="类型"){
				  ok3="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
				  ok1=ok2=ok4=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
              }else if(row[2]=="扩展名"){
				  ok4="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
				  ok1=ok2=ok3=ok5="&nbsp;&nbsp;&nbsp;&nbsp;";
              }else if(row[2]=="大小"){
				  ok5="<i class=\"fa fa-check\" aria-hidden=\"true\"></i>";
				  ok1=ok2=ok3=ok4="&nbsp;&nbsp;&nbsp;&nbsp;";
              }else{
      	 
              }
	        theHtml += "<li><span style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;显示</span></li>";
            theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','"+english(row[1])+"','lastmodifytime');\">" + ok1 + "<span"+col2color1+">最后修改时间</span></a></li>";
            theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','"+english(row[1])+"','owner');\">" + ok2 + "<span"+col2color2+">成员</span></a></li>";
            theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','"+english(row[1])+"','type');\">" + ok3 + "<span"+col2color3+">类型</span></a></li>";
            theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','"+english(row[1])+"','ext');\">" + ok4 + "<span"+col2color4+">扩展名</span></a></li>";
            theHtml += "<li><a href=\"javascript:getFileName('"+row[0]+"','"+english(row[1])+"','length');\">" + ok5 + "<span"+col2color5+">大小</span></a></li>";
            theHtml += "</td>";
	        theHtml += "<td>";
            theHtml += "<div id=\"ListOrLayout\"><span class=\"fa fa-list-ul\"></span> ";
            theHtml += "<span class=\"pop_ctrl\"><i class=\"fa fa-caret-down\"></i></span>";
            theHtml += "<ul>";
            theHtml += "<li><div style=\"font-size: 12px; color:gray\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;查看格式</div></li>";
            theHtml += "<li><i class=\"fa fa-check\" aria-hidden=\"true\"></i><a href=\"javascript:getFileList();\"><span>列表</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-list-ul\"></i></span></a></li>";
            theHtml += "<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"javascript:getFileLayout();\"><span>网格</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><i class=\"fa fa-th\"></i></span></a></li>";
            theHtml += "</ul>";
            theHtml += "</div>";
            theHtml += "</td>";
	          for (i=0; i<data.length-1; i++){
	        	   var n=data[i].split("@#￥");
	         	   theHtml += "<tr>";
	         	   theHtml += "<td><input type=\"checkbox\" id=\"subBox"+i+"\" name=\"subBox\" /></td>";
	         	  theHtml += "<td>";
	              if( n[0] == "file" ){
	           	   theHtml += "<span class=\"fa fa-file\"></span>";
	              }else{
	           	   theHtml += "<span class=\"fa fa-folder\"></span>";
	              }
	              theHtml += "</td>";
	              theHtml += "<td>";
	              var fname = n[1].split("^^^^^^");
	              if( fname[0].substr(fname[0].length-3,3) == "jpg"
	               	  || fname[0].substr(fname[0].length-3,3) == "png"
	               	  || fname[0].substr(fname[0].length-3,3) == "gif"
	               	  || fname[0].substr(fname[0].length-3,3) == "bmp"){
	               	   theHtml += "<img src=\"data:image/png;base64,"+fname[1]+"\" width=\"50\" height=\"50\"></img><a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
	              }else{
	               	   theHtml += "<a href=\"${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent(fname[0]))+"/download.do\">"+fname[0]+"</a>";
	              }
	              theHtml += "</td>";
	              theHtml += "<td>";
	              theHtml += n[2];
	              theHtml += "</td>";
	              theHtml += "<td>";
	              theHtml += n[3];
	              theHtml += "</td>";
	              theHtml += "<td>";
	              theHtml += "<span class=\"fa fa-ellipsis-h\"></span>";
	              theHtml += "</td>";
	              theHtml +="</tr>";   
	          }   
	          
	          theHtml += "<p class=\"allLoad\">已全部加载，共"+data.length-1+"个项目</p> ";
	          theHtml += "</table>";
	          //alert("show the html");
	          alert(theHtml);
	          $("#content").html("");
	          $("#content").html(theHtml);
	          needReloadInAsyncLoad();
  	            
  	      },
  	      error: function() {
  	        alert("error");
  	      }
  	    });
    	
    }
	
  }
</script>

<script>
        $(function(){
            /* $('#demo_box').popmenu(); */
            $('#ListOrLayout').popmenu(
     		        {
		     		'background':'#fff',
		     		'color':'#000',
		     		'focusColor':'#21a0df',
		     		'borderRadius':'0',
		     		'top': '0', 
		     		'left': '165',
		     		'border':'1px solid gray'
     		}
     		);
            $('#Name').popmenu(
            		{
            		'background':'#fff',
            		'color':'#000',
            		'focusColor':'#21a0df',
            		'borderRadius':'0',
            		'top': '0', 
            		'left': '0',
            		'height' : '30px',
            		'border':'1px solid gray'
             }
             );
            $('#Col1').popmenu(
            		{
            		'background':'#fff',
            		'color':'#000',
            		'focusColor':'#21a0df',
            		'borderRadius':'0',
            		'top': '0', 
            		'left': '0',
            		'border':'1px solid gray'
            }
            );
            $('#Col2').popmenu(
            		{
            		'background':'#fff',
            		'color':'#000',
            		'focusColor':'#21a0df',
            		'borderRadius':'0',
            		'top': '0', 
            		'left': '0',
            		'border':'1px solid gray'
            }
            );
           /*  $('#demo_box_3').popmenu({'width': '200px', 'background':'#223','focusColor':'#ee5','borderRadius':'10px', 'top': '70', 'left': '-40', 'color':'#1265fe','border':'3px solid #0035fe'}); */
        })
</script> 

<%-- <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script> 
<script src="${pageContext.request.contextPath}/js/jquery.popmenu.js"></script> 
<script>
$("#content").on("#ListOrLayout", "load",function()
   {
	popmenu({
			'background':'#fff',
		 
		    'color':'#000',
		 
		    'focusColor':'#21a0df',
		 
		    'borderRadius':'0',
		 
		    'top': '0', 
		    'left': '0',
		    'border':'1px solid #211d1d'})
   });
</script> --%>
</body>
<script>
function needReloadInAsyncLoad()
{
    //ajax异步回发需要重新执行的js函数
    //alert("async");
	new_element=document.createElement("script");
	new_element.setAttribute("type","text/javascript");
	new_element.setAttribute("src","${pageContext.request.contextPath}/js/jquery.min.js");// 在这里引入了jquery.min.js
	document.body.appendChild(new_element);
	new_element=document.createElement("script");
	new_element.setAttribute("type","text/javascript");
	new_element.setAttribute("src","${pageContext.request.contextPath}/js/jquery.popmenu.js");// 在这里引入了jquery.popmenu.js
	document.body.appendChild(new_element);
	 $('#ListOrLayout').popmenu(
     		{
     		'background':'#fff',
     		'color':'#000',
     		'focusColor':'#21a0df',
     		'borderRadius':'0',
     		'top': '0', 
     		'left': '165',
     		'border':'1px solid gray'
     		}
     		);
	 $('#Name').popmenu(
     		{
     		'background':'#fff',
     		'color':'#000',
     		'focusColor':'#21a0df',
     		'borderRadius':'0',
     		'top': '0', 
     		'left': '0',
     		'height' : '30px',
     		'border':'1px solid gray'
     		}
     		);
     $('#Col1').popmenu(
     		{
     		'background':'#fff',
     		'color':'#000',
     		'focusColor':'#21a0df',
     		'borderRadius':'0',
     		'top': '0', 
     		'left': '0',
     		'border':'1px solid gray'
     		}
     		);
     $('#Col2').popmenu(
     		{
     		'background':'#fff',
     		'color':'#000',
     		'focusColor':'#21a0df',
     		'borderRadius':'0',
     		'top': '0', 
     		'left': '0',
     		'border':'1px solid gray'
     		});
     $("#maincheck").click(function() {  
         if(this.checked==true){  
             $('input[name="subBox"]').prop("checked",this.checked);  
         }else{  
             $('input[name="subBox"]').prop("checked",false);  
         }  
     });  
     var $subBox = $("input[name='subBox']");  
     $subBox.click(function(){  
         $("#maincheck").prop("checked",$subBox.length == $("input[name='subBox']:checked").length ? true : false);  
     }); 
     
     //新建文件夹的 on focus和 lost focus事件触发的Ajax
     $(document).ready(function(){ 
     	$("#newFolder").blur(function(){
     		//如果newFolder文本框里面有内容并且合法，那么就在后台生成一个目录
     		if($("#newFolder").val()!= ""){
     			//alert("可以新增一个目录！");
     			//alert("${pageContext.request.contextPath}/spring/"+$("#newFolder").val()+"/makedir.do");
     			  $.ajax({
     				  
     			      url: "${pageContext.request.contextPath}/spring/"+encodeURIComponent(encodeURIComponent($("#newFolder").val()))+"/makedir.do",
     			      type: 'GET',
     			      dataType: "json", 
     			      async: true,
     			      success: function(data) {
     			    	  alert("创建目录成功！");
     			    	 
     			            
     			      },
     			      error: function() {
     			        alert("创建目录失败！");
     			      }
     			    });
     			 var listOrLayout=$("#ListOrLayout").find("i").parent().text();
      			 if(listOrLayout.trim()=="列表"){
      				var c = $("#content").children().last().children().children().first().next();
      				//alert (c.html());
      				c.detach();
      			}
      			//如果是在网格的情况下
      			else if(listOrLayout.trim()=="网格"){
      				getFileLayout();
      			}
     		}
     		//如果newFolder文本框里面没有任何内容，那么重新调用FileLayout函数
     		else{
     			//alert("你 需要写点东西！");
     			//如果是在列表的情况下
     			var listOrLayout=$("#ListOrLayout").find("i").parent().text();
     			if(listOrLayout.trim()=="列表"){
     				var c = $("#content").children().last().children().children().first().next();
     				//alert (c.html());
     				c.detach();
     			}
     			//如果是在网格的情况下
     			else if(listOrLayout.trim()=="网格"){
     				getFileLayout();
     			}
     		}
     		});
     });
}
</script>
<script>
function validatePathName() {
    var path = /^[a-zA-Z]:[\\]((?! )(?![^\\/]*\s+[\\/])[\w -]+[\\/])*(?! )(?![^.]*\s+\.)[\w -]+$/;
    var backuppath = document.getElementById("xxx");
    if (path.test(backuppath)) {
        return true;
    } else {
        alert("请填写正确路径!");
        return false;
    }
    return true;
}
</script>
</html>