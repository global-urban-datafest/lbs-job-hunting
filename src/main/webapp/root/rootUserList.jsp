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
function deleteRootUser(id){
	if(notEmpty(id)){
        $.post('<%=basePath%>root/rootUser_deleteRootUser.do',{
        	'id' :id
        },function(data){
        	if(data.success){
        		alert("删除管理员成功！");
        		window.location.href="<%=basePath%>root/rootUser_rootUserList.do";
        	}else{
        		alert(data.msg);
        	}
        });
	}else{
		alert("获取管理员id失败");
	}
}
</script>
</head>
<body class="container" style="background: none;">
	<div class="row">
		<div class="col-md-12" role="main">
			<table class="table table-bordered">
			  <thead>
			  		<tr>
			  			<th>登录名</th>
			  			<th>注册Email</th>
			  			<th>创建日期</th>
			  			<th>上次登录日期</th>
						<th>删除</th>
			  		</tr>
			  </thead>
			  <tbody>
			  <c:if test="${!empty requestScope.rootUsers}">
			  	<c:forEach var="root" items="${requestScope.rootUsers}">
			  			<tr>
				  			<th>${root.loginName}</th>
				  			<th>${root.registeremail}</th>
				  			<th><fmt:formatDate value='${root.creationDate}' pattern='MM/dd/yyyy'/></th>
				  			<th><fmt:formatDate value='${root.updateDate}' pattern='MM/dd/yyyy'/></th>
							<th><button class="btn btn-danger" onclick="deleteRootUser(${root.id})">删除</button></th>
			  			</tr>
			  	</c:forEach>
			  </c:if>
			  </tbody>
			</table>
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