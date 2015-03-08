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
<c:if test="${!empty sessionScope.loginUser}"> 
<html>
<head>
<meta charset="utf-8" />
<jsp:include page="/common.jsp"/>
<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
<script type="text/javascript">
function addRootUser(){
	$('#loginForm').ajaxSubmit(function(data){
		if(data.success){
			alert('添加管理员成功，请关闭本窗口');
		}else{
			alert(data.msg);
		}
	});
}
</script>
</head>
<body class="container" style="background: none;">
	<div class="row">
		<div class="col-md-12" role="main">
	        <form action="<%=basePath%>root/rootUser_addRootUser.do" method="post" id="loginForm" name="loginForm" >
			  <div class="form-group">
			    <label for="loginName" class="col-sm-2 control-label">用户名:</label>
			    <div class="col-sm-10">
			      <input type="text" class="form-control" id="loginName" placeholder="用户名" name="rootUser.loginName" >
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="loginPass" class="col-sm-2 control-label">密码:</label>
			    <div class="col-sm-10">
			      <input type="password" class="form-control" id="loginPass" placeholder="密码" name="rootUser.loginPass" >
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="registeremail" class="col-sm-2 control-label">注册Email:</label>
			    <div class="col-sm-10">
			      <input type="email" class="form-control" id="registeremail" placeholder="注册Email" name="rootUser.registeremail">
			    </div>
			  </div>
			</form>
			<div class="form-group text-center">
			    <div class="col-sm-offset-2 col-sm-10">
			      <button type="submit" class="btn btn-default" onclick="addRootUser();">添加管理员</button>
			    </div>
			</div>
		</div>
	</div>
</body>
</html>
</c:if>
<c:if test="${empty sessionScope.loginUser}">
		<script type="text/javascript">
		parent.location.href="<%=basePath%>root/rootUser_loginOut.do";
		</script>
</c:if>