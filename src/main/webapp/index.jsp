<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<jsp:include page="common.jsp"/>
<head>
    <title>首页</title>
    <script type="text/javascript">
    $(document).ready(function(){
/*     	$.post('',{},function(data){
    		
    	});

		$.post('',{},function(data){
	
		});
*/
    });
    function showCompany(id){
    	window.location.href="<%=basePath%>user_userCompanyProfile.do?id="+id;
    }
    </script>
</head>
<body>
<jsp:include page="header.jsp" flush="true"/>
<div class="container">
    <div class="row">
        <div class="jumbotron">
            <h2>LBS Job Hunting for Disabled！</h2>
            <p>
                An LBS Tool to increase the efficiency of job-hunting for the disabled people.

            </p>
            <p><a class="btn btn-primary btn-lg" role="button" href="<%=basePath%>otherdetail.jsp">查看详情</a></p>
        </div>
    </div>
<c:if test="${sessionScope.loginType!=null && '1' eq sessionScope.loginType}">
    <div class="row">
		<div class="col-md-12">
		 	<h2>热门企业</h2>
			<div>
				<c:if test="${!empty sessionScope.companylist }">
					<c:forEach var="company" items="${sessionScope.companylist}">
					  <div class="col-sm-4 col-md-3">
					    <div class="thumbnail">
					      <img src="<%=basePath%>images/logo/${company.companyLogo}" alt="..." onclick="showCompany(${company.id});">
					    </div>
					  </div>
					 </c:forEach>
				 </c:if>
			</div>
		</div>
    </div>
    <div class="row">
		<div class="col-md-12">
			<h2>招聘列表</h2>
			<div>
				<c:if test="${!empty sessionScope.hireinfolist }">
					<c:forEach var="hireinfo" items="${sessionScope.hireinfolist}">
					  <div class="col-sm-4 col-md-3">
					    <div class="thumbnail">
					      <h3>${hireinfo.positionName}</h3>
					      <a href="<%=basePath%>user_hireinfoProfile.do?id=${hireinfo.id}">查看详情</a>
					    </div>
					  </div>
					 </c:forEach>
				 </c:if>
			</div>
		</div>
    </div>
</c:if>
<c:if test="${sessionScope.loginType!=null && '2' eq sessionScope.loginType}">
</c:if>
</div>
<jsp:include page="buttom.jsp" flush="true"/>
</body>
</html>