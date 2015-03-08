<%@ page language="java" pageEncoding="UTF-8" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%--[if IE]
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>js/html5.js">＜/script>
[endif]--%>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>js/jquery-1.8.3.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>js/bootstrap/bootstrap.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>js/bootstrap/bootstrap-validation.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>js/prettify.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>js/bootstrap/bootstrap-datepicker.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>js/common.js"></script>
<link type="text/css" rel="stylesheet" href="<%=basePath%>css/bootstrap/bootstrap.css"/>
<link type="text/css" rel="stylesheet" href="<%=basePath%>css/bootstrap/bootstrap-theme.css"/>
<link type="text/css" rel="stylesheet" href="<%=basePath%>css/style.css"/>
