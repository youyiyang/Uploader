<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
<title>文件</title>
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
<link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/fileinput.css" media="all" rel="stylesheet" type="text/css"/>
    <link href="css/font-awesome.min.css" media="all" rel="stylesheet" type="text/css"/>
    <link href="themes/explorer-fa/theme.css" media="all" rel="stylesheet" type="text/css"/>
    <script src="js/jquery.min.js"></script>
    <script src="js/plugins/sortable.js" type="text/javascript"></script>
    <script src="js/fileinput.min.js" type="text/javascript"></script>
    <script src="js/locales/fr.js" type="text/javascript"></script>
    <script src="js/locales/es.js" type="text/javascript"></script>
    <script src="themes/explorer-fa/theme.js" type="text/javascript"></script>
    <script src="themes/fa/theme.js" type="text/javascript"></script>
    <script src="js/popper.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.js" type="text/javascript"></script>
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
  height: 600px;
  float: left;  
}
#main_right{
  margin-left:190px;
  position: relative;
  height: 600px;
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
<a href="#"><img class="logo_pic"  src="img/logo-company.png"  height="70px" /></a>
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
            <span>登录</span>
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
<li>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="	fa fa-leanpub"></span> 教&nbsp;&nbsp;   程&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </li>
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

    <li>        
	  <a href="#"><span class="fa fa-file-o"></span> 新建</a>        
    </li>
    <li class="dropdown">
		<a href="#Menu=ChildMenu1"  onclick="DoMenu('ChildMenu1')">
		  <span class="fa fa-edit"></span> 
		  编辑   <b class="caret"></b>
		</a>                
		<ul id="ChildMenu1" class="collapsed">
		  <li class="first">        
			 <a href="#">
			 <span class="fa fa-pencil"></span> 
			   重命名
			 </a>        
		  </li>
		  <li class="last">        
			  <a href="#">
			  <span class="fa fa-paste"></span> 
				黏贴
			  </a>        
		  </li>
    	</ul>
    </li>
    <li>        
	    <a href="#">
		 <span class="fa fa-trash"></span>
		 删除
		</a>        
    </li>
	<li>        
	    <a href="javascript:toupload()">
		 <span class="fa fa-cloud-upload"></span>
		 上传
		</a>        
    </li>
    <li class="dropdown active">      
     	<a href="#Menu=ChildMenu2"  onclick="DoMenu('ChildMenu2')">
		  <span class="fa fa-support"></span> 
		 帮助    
		 <b class="caret"></b>
		</a>                
		<ul id="ChildMenu2" class="collapsed">
            <li class="first">        
			  <a href="#">
			   <span class="fa fa-film"></span> 
			   视频介绍
			  </a>        
            </li>
            <li>        
			   <a href="#">
			      <span class="fa fa-book"></span>
				  FAQs
				</a>        
            </li>
            <li class="active last">       
    			<a href="#">
				  <span class="fa fa-envelope-open-o"></span> 
				  联系方式
				</a>        
            </li>
        </ul>
    </li>
    <li class="visible-xs visible-sm last">        
	    <a href="#">
		  <span class="glyphicon glyphicon-scale-classic regular"></span> 
		  Imprint
		</a>        
    </li>
</ul>
</div>
</div>
<div id="main_right">
<div id="content">
  <table>
   <tr border = "1">
    <td>名称</td>
    <td>大小</td>
    <td>最后修改时间</td>
    <td>查看格式</td>
   </tr>
   <tr>
     <td>IMG_0102.JPG</td>
     <td>2.7M</td>
     <td> 13/6/2018</td>
     <td></td>
   </tr>
  </table>
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
<script type=text/javascript><!--
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
  /*
  if (_paramArr.length>0)
  {
   var _arr = new Array(_paramArr.length);
  }
  
  //取所有#后面的，菜单只需用到Menu
  //for (var i = 0; i < _paramArr.length; i++)
  {
   var _paramKeyVal = _paramArr[i].split('=');
   
   if (_paramKeyVal.length>0)
   {
    _arr[_paramKeyVal[0]] = _paramKeyVal[1];
   }  
  }
  */
 }
 
 if(MenuID!="")
 {
  DoMenu(MenuID)
 }
}
GetMenuID(); //*这两个function的顺序要注意一下，不然在Firefox里GetMenuID()不起效果
menuFix();
--></script>

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
</body>
</html>