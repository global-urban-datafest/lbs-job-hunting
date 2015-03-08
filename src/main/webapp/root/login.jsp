<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + path + "/";
    %>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理员登录</title>
<link rel="stylesheet" href="<%=basePath%>root/resources/css/reset.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath%>root/resources/css/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath%>root/resources/css/invalid.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath%>js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="<%=basePath%>root/resources/scripts/simpla.jquery.configuration.js"></script>
<script type="text/javascript" src="<%=basePath%>root/resources/scripts/facebox.js"></script>
<script type="text/javascript" src="<%=basePath%>root/resources/scripts/jquery.wysiwyg.js"></script>
</head>
<body id="login">
<div id="login-wrapper" class="png_bg">
  <div id="login-top">
    <h1>管理员登录</h1>
    <!-- Logo (221px width) -->
    <a href="#"><img id="logo" src="<%=basePath%>root/resources/images/logo.png" alt="Simpla Admin logo" /></a> </div>
  <!-- End #logn-top -->
  <div id="login-content">
	  <c:if test="${!empty requestScope.loginMess}">
	      <div class="notification information png_bg">
	        <div> ${requestScope.loginMess}</div>
	      </div>
	  </c:if>
    <form action="<%=basePath%>root/rootUser_login.do" method="post" id="rootForm" >
      <p>
        <label>用户名:</label>
        <input class="text-input" type="text" name="rootUser.loginName" value="root"/>
      </p>
      <div class="clear"></div>
      <p>
        <label>密码:</label>
        <input class="text-input" type="password" name="rootUser.loginPass" value="123456"/>
      </p>
      <div class="clear"></div>
      <p>
        <input class="button" type="submit" value="登录"/>
      </p>
    </form>
  </div>
  <!-- End #login-content -->
</div>
<!-- End #login-wrapper -->
</body>
</html>
