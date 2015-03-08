<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + path + "/";
    %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理员主界面</title>
<link rel="stylesheet" href="<%=basePath%>root/resources/css/reset.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath%>root/resources/css/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath%>root/resources/css/invalid.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath%>js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="<%=basePath%>root/resources/scripts/simpla.jquery.configuration.js"></script>
<script type="text/javascript" src="<%=basePath%>root/resources/scripts/facebox.js"></script>
<script type="text/javascript" src="<%=basePath%>root/resources/scripts/jquery.wysiwyg.js"></script>
<script type="text/javascript">
				    
				    function reinitIframe(){

						var iframe = document.getElementById("mainFrame");

						try{

						var bHeight = iframe.contentWindow.document.body.scrollHeight;

						var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
                          
						 if(bHeight>1500)
                    	        bHeight=1500;
                        if(dHeight>1500)
                        	   dHeight=1500;
						var height = Math.max(bHeight, dHeight);

						iframe.height =  height;

						}catch (ex){}

						}

					window.setInterval("reinitIframe()", 200);
				    
				    </script>
</head>
<body>
<div id="body-wrapper">
  <!-- Wrapper for the radial gradient background -->
  <div id="sidebar">
    <div id="sidebar-wrapper">
      <!-- Sidebar with logo and menu -->
      <h1 id="sidebar-title"><a href="#">Simpla Admin</a></h1>
      <!-- Logo (221px wide) -->
      <a href="#"><img id="logo" src="<%=basePath%>root/resources/images/logo.png" alt="Simpla Admin logo" /></a>
      <!-- Sidebar Profile links -->
      <div id="profile-links"> 
         <a href="<%=basePath%>root/rootUser_loginOut.do" title="Sign Out">登出</a> </div>
      <ul id="main-nav">
        <!-- Accordion Menu -->
        <li> <a href="#" class="nav-top-item no-submenu current">主页 </a> </li>
        <li> <a href="#" class="nav-top-item">管理员管理</a>
          <ul>
            <li><a href="<%=basePath%>root/rootUser_addRootUserForward.do" target="mainFrame">添加管理员</a></li>
            <li><a href="<%=basePath%>root/rootUser_rootUserList.do" target="mainFrame">查询管理员</a></li>
            <li><a href="<%=basePath%>root/updateUserPass.jsp" target="mainFrame">修改密码</a></li>
          </ul>
        </li>
        <li> <a href="#" class="nav-top-item" target="mainFrame">用户管理</a>
          <ul>
            <li><a href="<%=basePath%>root/addUser.jsp" target="mainFrame">增加用户</a></li>
            <li><a href="<%=basePath%>root/userListManagement.jsp" target="mainFrame">查询用户</a></li>
            <li><a href="<%=basePath%>root/addResume.jsp" target="mainFrame">增加简历</a></li>
            <li><a href="<%=basePath%>root/ResumeListManagement.jsp" target="mainFrame">查询简历</a></li>
          </ul>
        </li>
        <li> <a href="#" class="nav-top-item" target="mainFrame">企业管理</a>
          <ul>
			<li><a href="<%=basePath%>root/addCompany.jsp" target="mainFrame">增加企业</a></li>
            <li><a href="<%=basePath%>root/companyListManagement.jsp" target="mainFrame">查询企业</a></li>
			<li><a href="<%=basePath%>root/addHireinfo.jsp" target="mainFrame">增加招聘</a></li>
            <li><a href="<%=basePath%>root/hireInfoListManagement.jsp" target="mainFrame">查询招聘</a></li>
          </ul>
        </li>
        <li> <a href="#" class="nav-top-item">其他</a>
          <ul>
            <li><a href="#">Add a new Event</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
  <!-- End #sidebar -->
  <div id="main-content">
  	<iframe name="mainFrame" id="mainFrame" width="100%" height="100%" scrolling="no" onload='this.height=1000' frameborder="0" src="<%=basePath%>/root/mainFrame.jsp" ></iframe>
  </div>
</div>
</body>
<!-- Download From www.exet.tk-->
</html>
