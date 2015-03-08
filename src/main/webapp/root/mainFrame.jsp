<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + path + "/";
    %>
<html>
<head>
<meta charset="utf-8" />
</head>
<body>
				<span>登录名:</span>${sessionScope.loginUser.loginName}<br />
				<span>上次登录时间</span><fmt:formatDate value='${sessionScope.loginUser.updateDate}' pattern='MM/dd/yyyy'/><br />
				<span>账号创建日期:</span><fmt:formatDate value='${sessionScope.loginUser.creationDate}' pattern='MM/dd/yyyy'/><br />
</body>
</html>