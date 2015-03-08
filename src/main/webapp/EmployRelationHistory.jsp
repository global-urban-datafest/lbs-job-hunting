<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<c:if test="${!empty sessionScope.loginUser}">
<!DOCTYPE html>
<html lang="zh-cn">
<jsp:include page="common.jsp" />
<head>
<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
<script type="text/javascript">

</script>
<title>投递详情</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
		<div class="container">
			<div class="row">
				<div class="col-md-12" role="main">
					<h3>企业信息</h3>
					<div class="bs-example ">
						<div class="table-responsive">
						  <table class="table">
						    <thead>
						    	<tr>
						    		<th>投递职位</th><th>投递日期</th><th>投递状态</th>
						    	</tr>
						    </thead>
						    <tbody>
						    	<c:if test="${!empty requestScope.employees}">
						    		<c:forEach var="employee" items="${requestScope.employees}">
								    	<tr>
								    		<td>${employee.pk.hireinfo.positionName}</td>
								    		<td><fmt:formatDate value='${employee.sendDate}' pattern='MM/dd/yyyy'/></td>
	  								    	<c:if test="${employee.viewFlag eq 3}">
								    			<td>应聘成功</td>
								    		</c:if>
								    		<c:if test="${employee.viewFlag eq 2}">
								    			<td>应聘失败</td>
								    		</c:if>
								    		<c:if test="${employee.viewFlag eq 1}">
								    			<td>企业审核中</td>
								    		</c:if>
								    	</tr>
						    		</c:forEach>
						    	</c:if>
						    	<c:if test="${empty requestScope.employees}">
								    	<tr>
								    		<td colspan="3">你没有任何投递记录.</td>
								    	</tr>
						    	</c:if>
						    </tbody>
						  </table>
						</div>
					</div>
				</div>	
			</div>
		</div>
	<jsp:include page="buttom.jsp" flush="true" />
</body>
</html>
</c:if>
<c:if test="${empty sessionScope.loginUser}">
		<script type="text/javascript">
			window.location.href="<%=basePath%>user_loginOut.do";
		</script>
</c:if>