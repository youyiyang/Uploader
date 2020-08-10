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
<title>教程</title>
<style>
        body{
			    margin:0;
			    padding:0;
			    font:12px/1.5 tahoma,arial,'Hiragino Sans GB',\5b8b\4f53,sans-serif;
			    
			    position:relative;
			    width:100%;
			    min-height:100%; 
			    
    
        }
        #container{
            min-height:100%;height:auto !important;height:100%;/*ie6不识别min-height,如上述处理*/position:relative;
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
height: 100%;
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

#fixed-footer{
color:#fff;
background-color:#312e2e;
line-height:30px !important;
margin:0;
padding:0;
clear:both; 
position:absolute;
bottom:0px;
width:100%;
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
<li><a href="${pageContext.request.contextPath}/login.jsp">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="	fa fa-file-o"></span> 文&nbsp;&nbsp;   件&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
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

  <p><center><h2>教程</h1></center></p>
  <p><h4>什么是Uploador?</h4></p>
  <p>Uploador是一个用来上传个人文件的资料仓库。用户可以在这个仓库里面进行上传文件，下载文件，删除文件/目录，新建目录，目录之间浏览等这些基本文件操作。</p>
  <p><h4>怎么使用Uploador?</h4></p>
  <p>1.	上传文件</p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/upload_click_upload_menubar.png" width="1024"/></p>
  <p>如上图所示，鼠标点击左侧操作面板下面的“上传”栏目，会在它的下面弹出两个子栏目：
“文件上传”和“目录上传”
  </p>
  <p>a.	文件上传</p>
  <p></p>
  <p>鼠标点击“文件上传”栏目，屏幕上出现一个上传文件的对话框，</p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/upload_file_upload_01.png" width="1024"/></p>
  <p>你可以把要上传的文件拖拽到上面白色的框里面，或者点击右下角的“选择”按钮，在打开的文件目录里面把要上传的文件选中</p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/upload_file_upload_02.png" width="1024"/></p>
  <p>鼠标点击“打开”按钮，你准备要上传的文件就自动进入到上传的框里面了。</p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/upload_file_upload_03.png" width="1024"/></p>
  <p>鼠标点击右下角的“上传”按钮就可以把上面5个图片上传上去了。</p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/upload_file_upload_04.png" width="1024"/></p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/upload_file_upload_05.png" width="1024"/></p>
  <p>b.	目录上传</p>
  <p>目录上传就是只要选中目录就可以把目录里面所有的文件都上传上去。
鼠标点击“目录上传”栏目，
  </p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/upload_directory_upload_01.png" width="1024"/></p>
  <p>鼠标点击右下角的“选中目录”，在弹出的文件对话框里面选择一个目录，就可以把这个目录里面的文件自动都导入到框里面，而不需要一个一个文件的选中了。</p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/upload_directory_upload_02.png" width="1024"/></p>
  <p>你也可以把目录拖拽到框里面，但是，此功能仅由一些现代浏览器支持，如Chrome，Firefox，但是IE Edge和其他浏览器暂不支持拖拽文件</p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/upload_directory_upload_03.png" width="800"/></p>
  <p>这样就会把这个目录下面所有的文件都上传上去。</p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/upload_directory_upload_04.png" width="1024"/></p>
  <p>2.	下载文件</p>
  <p>只要点击文件名的链接就会自动下载这个文件：</p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/download01.png" width="1024"/></p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/download02.png" width="800"/></p>
  <p>3.	删除文件/目录</p>
  <p>如果要删除或者目录，只需要将这个文件或者目录的最左边的勾打上，然后点击左侧操作面板的“删除”栏就可以了。删除的目录会把这个目录下面所有的文件和子目录里面的内容全部删除。</p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/delete01.png" width="1024"/></p>
  <p>4.	新建目录</p>
  <p>鼠标点击左侧操作面板的“新建”栏，在下面弹出的子菜单上再点击“目录”就可以新建一个目录，</p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/new_folder01.png" width="1024"/></p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/new_folder02.png" width="800"/></p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/new_folder03.png" width="1024"/></p>
  <p>5.	目录之间浏览</p>
  <p>在文件列表的左上方有当前目录的完整路径。</p>
  <p>进入一个子目录，只需要点击这个子目录的链接，比如上图的New Folder,就可以进入到这个叫做New Folder目录里面。</p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/browse_dir01.png" width="1024"/></p>
  <p>如果要返回到前面的目录，只需要点击左上方目录路径的链接，比如要返回到shasheng目录，只需要点击shasheng这个链接就可以了。</p>
  <p><img src="${pageContext.request.contextPath}/img/uploador_teaching/browse_dir02.png" width="1024"/></p>
  <p></p>
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
					 <label for="input-folder-2">此功能仅由一些现代浏览器支持，如Chrome和IE Edge
					 </label> 
					 <label for="input-folder-2">  （暂不支持拖拽文件）
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
   

<div id="fixed-footer" >
<div>
<!--  id="fixed-footer" -->
<footer role="contentinfo" class="bottom">
<div><div class="parsys iparsys"><div class="reference referenceComponent parbase section"><div class="cq-dd-paragraph"><div class="powerFooterNavigationComponent powerfooternavigatio columnContainer parbase"><div class="columns-wrapper bg-snow hidden-xs hidden-sm">
    
        <div class="row columns-wrapper ">
            <div class="col text-left col-sm-4 col-md-4 col-lg-4">
                <div class="footer-logo">
    
        <img class="lazy  img-responsive  margin-40-top-lg margin-20-bottom-lg  " src="${pageContext.request.contextPath}/img/logo-company.png" data-src="${pageContext.request.contextPath}/img/logo-company.png" height="70">
</div>
<div class="footer-social-links">
<div class="social-media-links margin-30-bottom-lg">
    <a href="http://www.linkedin.com/company/salesforce" target="_blank" title="LinkedIn"><span class="text-salesforce-gray icon-sfdc-icon-linkedin"></span></a>
</div>

</div>
    <div class="footer-phone-number"><div class="phoneNumberComponent_textLevel text-stratus text-left salesforce-sans-regular  " style="margin-top:30px;margin-bottom:0px;">
    <span class="text-stratus">找到我们</span>
    <a href="tel:13817760615" class="text-stratus">13817760615</a>
    
    
</div>
</div>
                <div class="footer-phone-number" id="notMobileFooterPhoneNumbers_level">
</div>
            </div>
            
        
            
            <div class="col text-left col-sm-3 col-md-3 col-lg-3"><div class="headingComponent parbase section">
              <h3 class="h4 text-night text-left salesforce-sans-regular       margin-60-top-lg margin-20-bottom-lg "> 首次接触？</h3>
            </div>
<div class="parbase section list genericLinkListComponent">
    
    
    <ul class="generic-links  ">
        <li>
            <a href="/cn/products/salesforce-advantage/">
                <span class="li-wrap">
                    关于我们
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/cn/crm/">
                <span class="li-wrap">
                    什么是SaaS?
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/cn/products/?d=70130000000YsaU">
                <span class="li-wrap">
                    所有产品
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/cn/cloudcomputing/?d=70130000000YsaZ">
                <span class="li-wrap">
                    什么是云计算?
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/cn/customers/?d=70130000000Ysae">
                <span class="li-wrap">
                    成功案列
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="pricing.php">
                <span class="li-wrap">
                    价格体系
                    
                    
                </span>
            </a>
        </li>
    </ul>



</div>

</div>
        
            
            <div class="col text-left col-sm-3 col-md-3 col-lg-3"><div class="headingComponent parbase section"><h3 class="h4 text-night text-left salesforce-sans-regular       margin-60-top-lg margin-20-bottom-lg " id="salesforce">
    
    
    
    <a name="salesforce" class="text-night preventHover ">
    	
        
        <span class=" header-text ">
            
                关于Uploador
            </span>
        	
        
    </a>
</h3>

</div>
<div class="parbase section list genericLinkListComponent">
    
    
    <ul class="generic-links  margin-40-bottom-lg">
        <li>
            <a href="ftps://www.salesforce.com/cn/company/?d=70130000000YsbD">
                <span class="li-wrap">
                   我们的故事
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftp://www.salesforce.com/company/careers/?d=70130000000YsbI">
                <span class="li-wrap">
                    在Uploador工作
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftp://www.salesforce.com/cn/company/news-press/press-releases/?d=70130000000YsbN">
                <span class="li-wrap">
                   新闻出版
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://trust.salesforce.com/trust/" target="_blank">
                <span class="li-wrap">
                    安全/质量
                    <span class="salesforce-icon icon-sfdc-icon-offsite"></span>
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.org/">
                <span class="li-wrap">
                    总部情况
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/cn/crm/top-rated/?d=70130000000YsbX">
                <span class="li-wrap">
                    最好的网站
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/company/sustainability/?d=70130000000i80J">
                <span class="li-wrap">
                    可持续发展
                    
                    
                </span>
            </a>
        </li>
    </ul>



</div>

</div>
        
            
            <div class="col text-left col-sm-2 col-md-2 col-lg-2"><div class="headingComponent parbase section"><h3 class="h4 text-night text-left salesforce-sans-regular       margin-60-top-lg margin-20-bottom-lg ">
    
    
    
    <a class="text-night preventHover ">
    	
        
        <span class=" header-text ">
            
                友情链接
            </span>
        	
        
    </a>
</h3>

</div>
<div class="parbase section list genericLinkListComponent">
    
    
    <ul class="generic-links  ">
        <li>
            <a href="ftps://www.salesforce.com/cn/mobile/overview/?d=70130000000Ysaj">
                <span class="li-wrap">
                    移动应用
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://appexchange.salesforce.com" target="_blank">
                <span class="li-wrap">
                    网上商店
                    <span class="salesforce-icon icon-sfdc-icon-offsite"></span>
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/dreamforce/DF16/?d=70130000000i808" target="_blank">
                <span class="li-wrap">
                    梦想力量
                    <span class="salesforce-icon icon-sfdc-icon-offsite"></span>
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/cn/crm/?d=70130000000Ysay">
                <span class="li-wrap">
                    SaaS软件
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://startups.salesforce.com/" target="_blank">
                <span class="li-wrap">
                    初创公司
                    <span class="salesforce-icon icon-sfdc-icon-offsite"></span>
                    
                </span>
            </a>
        </li>
    </ul>



</div>

</div>
        </div>
    
</div>
<div id="mobileFooterPhoneNumber_level" class="mobile-footer-phone-number hidden-lg hidden-md hidden-sm">
	<div id="mobileFooterPhoneNumber_levelInner">
    	<div id="mobileFooterPhoneNumber_levelInner_component" itemindex="primaryPhone"><div class="phoneNumberComponent_textLevel text-stratus text-left salesforce-sans-regular  " style="margin-top:30px;margin-bottom:0px;">
    <span class="text-stratus">联系我们</span>
    <a href="tel:13817760615" class="text-stratus">13817760615</a>
    
    
</div>
</div>
		<div id="mobileFooterPhoneNumber_levelInner_component" itemindex="additionalPhones">
</div>
	</div>
</div>
</div>
</div>
</div>
<div class="reference referenceComponent parbase section"><div class="cq-dd-paragraph"><div class="parbase footerNavigationComponent footernavigationcomp"><footer class="page-footer">
    <div class="container">
        <div class="region-selector ">
            <div class="region-selector_dialog">
                <div class="region-selector_content">
                    <div><div class="  columns-wrapper bg-default  container-fluid  ">
    
        <div class="row columns-wrapper ">
            <div class="col text-left  col-sm-4 col-md-4 col-lg-4"><div class="headingComponent parbase section"><h2 class="h4 text-night text-left salesforce-sans-regular        ">
    
    
    
    <a class="text-night preventHover ">
    	
        
        <span class=" header-text ">
            
                America
            </span>
        	
        
    </a>
</h2>

</div>
<div class="parbase section list genericLinkListComponent">
    
    
    <ul class="generic-links  ">
        <li>
            <a href="ftps://www.salesforce.com/mx/">
                <span class="li-wrap">
                    América Latina (Español)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/br/">
                <span class="li-wrap">
                    Brasil (Português)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/ca/">
                <span class="li-wrap">
                    Canada (English)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/fr-ca/">
                <span class="li-wrap">
                    Canada (Français)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/">
                <span class="li-wrap">
                    United States (English)
                    
                    
                </span>
            </a>
        </li>
    </ul>



</div>

</div>
        
            <div class="col text-left  col-sm-4 col-md-4 col-lg-4"><div class="headingComponent parbase section"><h2 class="h4 text-night text-left salesforce-sans-regular        ">
    
    
    
    <a class="text-night preventHover ">
    	
        
        <span class=" header-text ">
            
                Europe, Africa & Middle East
            </span>
        	
        
    </a>
</h2>

</div>
<div class="parbase section list genericLinkListComponent">
    
    
    <ul class="generic-links  ">
        <li>
            <a href="ftps://www.salesforce.com/es/">
                <span class="li-wrap">
                    España (Español)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/de/">
                <span class="li-wrap">
                    Deutschland (Deutsch)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/fr/">
                <span class="li-wrap">
                    France (Français)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/it/">
                <span class="li-wrap">
                    Italia (Italiano)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/nl/">
                <span class="li-wrap">
                    Nederland (Nederlands)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/se/">
                <span class="li-wrap">
                    Sverige (Svenska)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/uk/">
                <span class="li-wrap">
                    United Kingdom (English)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/eu/">
                <span class="li-wrap">
                    All Countries/Regions (English)
                    
                    
                </span>
            </a>
        </li>
    </ul>



</div>

</div>
        
            <div class="col text-left  col-sm-4 col-md-4 col-lg-4"><div class="headingComponent parbase section"><h2 class="h4 text-night text-left salesforce-sans-regular        ">
    
    
    
    <a class="text-night preventHover ">
    	
        
        <span class=" header-text ">
            
                Asian Pacific
            </span>
        	
        
    </a>
</h2>

</div>
<div class="parbase section list genericLinkListComponent">
    
    
    <ul class="generic-links  ">
        <li>
            <a href="ftps://www.salesforce.com/au/">
                <span class="li-wrap">
                    Australia (English)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/in/">
                <span class="li-wrap">
                    India (English)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/jp/">
                <span class="li-wrap">
                    日本 (日本語)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/kr/">
                <span class="li-wrap">
                    한국 (한국어)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/cn/">
                <span class="li-wrap">
                    中国 (简体中文)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/tw/">
                <span class="li-wrap">
                    台灣 (繁體中文)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/ap/">
                <span class="li-wrap">
                    All Other Countries/Regions (英语)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/my/">
                <span class="li-wrap">
                    Malaysia (English)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/th/">
                <span class="li-wrap">
                    ประเทศไทย (ไทย)
                    
                    
                </span>
            </a>
        </li>
    
        <li>
            <a href="ftps://www.salesforce.com/ap/">
                <span class="li-wrap">
                    All other countries (English)
                    
                    
                </span>
            </a>
        </li>
    </ul>



</div>

</div>
        </div>
    
</div>
</div>
                </div>
            </div>
            <div class="region-selector_button">
                <span class="region-selector_label">全球</span>
                <img src="./picture/global_white.png" width="20" height="20">
                <!--<span class="region-selector_icon icon-sfdc-icon-globe"></span>
                <span class="region-selector_caret icon-sfdc-icon-up-arrow"></span>-->
            </div>
        </div>
        <div class="page-footer_content">
            <nav class="page-footer_links">
                <ul class="page-footer_links_list">
                    <li class="page-footer_links_item">
                        <a class="page-footer_link" href="ftps://www.salesforce.com/cn/company/privacy/">隐私声明</a>
                    </li><li class="page-footer_links_item">
                        <a class="page-footer_link" href="ftps://www.salesforce.com/company/disclosure/">披露责任</a>
                    </li><li class="page-footer_links_item">
                        <a class="page-footer_link" href="ftps://trust.salesforce.com/" target="_blank">信任</a>
                    </li><li class="page-footer_links_item">
                        <a class="page-footer_link" href="contactus.php" target="_blank">联系我们</a>
                    </li>
                    
                        <li class="page-footer_links_item">
                            <div id="teconsent"></div>
                        </li>
                    
                </ul>
            </nav>
            <div class="page-footer_legal">
<p>© 版权所有 2017 Uploador有限公司 <a href=""></a> 各商标所有权由相应持有人拥有。</p>



</div>
        </div>
    </div>
</footer>
</div>
</div>
</div>
<div class="reference referenceComponent parbase section"><div class="cq-dd-paragraph"><div class="dockedContainer parbase dockedcontainer"><div class="docked-container margin-20-right-lg fixed"><div class="parbase fixedFooterCTAItemComponent section"><div class="fixed-btn-container">
    
    
    
    
    
    <div class="live-chat-container">
        <div class="liveagent-data" data-liveagent-orgid="00D000000000062" data-liveagent-btnid="57330000000DkQP" data-liveagent-depid="572300000009XhF" data-liveagent-formurl="ftps://www.salesforce.com/cn/form/contact/contactme.jsp?d=70130000000Fm5e" data-liveagent-endpointurl="ftps://d.la1-c2-dfw.salesforceliveagent.com/chat">
        </div>
        <div class="btn-container" id="liveagent_button_online_57330000000DkQP" style="display: none;">
            <a class="btn bg-cirrus text-snow salesforce-sans-regular chat-trigger btn-lg">
                在线交谈
            </a>
        </div>
        <div class="btn-container" id="liveagent_button_offline_57330000000DkQP" style="display: none;">
            <a class="btn bg-cirrus text-snow salesforce-sans-regular chat-trigger-contact btn-lg" role="button" href="contactus.php">
                联系我们
            </a>
        </div>
    </div>
</div>



</div>
<div class="parbase fixedFooterCTAItemComponent section"><div class="fixed-btn-container">
    
    
    
    
    <div>
        <div class="btn-container">
            <a href="feedback.php" target="_blank"  onclick= "window.open('feedback.php',null, 'directories=no,toolbar=no,height=700,width=560,status=no,resizable=no,scrollbars=no,location=no');" class="btn bg-cirrus text-snow salesforce-sans-regular  opinionlab-trigger btn-lg" role="button">
				反馈</a>
        </div>
    </div>
    
</div>



</div>

</div>
</div>
</div>
</div>
<div class="section"><div class="new"></div>
</div><div class="iparys_inherited"><div class="parsys iparsys"></div>
</div>
</div>
</div>
</footer>
<script>
    var SfdcWwwBase = SfdcWwwBase || {};
    SfdcWwwBase.config = {
        liveAgentOrganizationId: "00D000000000062",
        liveAgentButtonId: "57330000000DkQP",
        liveAgentDeploymentId: "572300000009XhF",
        liveAgentEndpointUrl: "ftps:\/\/d.la1\u002Dc2\u002Ddfw.salesforceliveagent.com\/chat",
        liveChatWaterfallDisabled: "true" === "true",
        liveChatWaterFallDelay: "30",
        liveChatModalPath: "\/content\/www\/en_au\/shared\/modules\/modals\/livechat\u002Dwaterfall"
    };
</script>
<div class="servicecomponents">
</div>
<script type="text/javascript" src="./js/clientlibs_analytics_bottom.min.ea05e32862ec4ae986d829409a72bf2a.js"></script>
<div aria-hidden="true">
    <script type="text/javascript">typeof _satellite !== 'undefined' && _satellite.pageBottom();</script>
</div>
<script>
    var SfdcWwwBase = SfdcWwwBase || {};
    SfdcWwwBase.config = SfdcWwwBase.config || {};
    SfdcWwwBase.config.isPublish = "true" === "true";
</script>
<script type="text/javascript" src="./js/clientlibs_base.min.6a46789d2f8dbc07d02d07ca3b016137.js"></script>
<script type="text/javascript" src="./js/clientlibs_yall.min.ded48a3646073cb853f8f12e703c27ab.js"></script>
<script type="text/javascript" src="./js/clientlibs_base.min.4596d57ec310508bfa325324e1f2f86e.js"></script>
</
>
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