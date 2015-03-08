<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-cn">
<jsp:include page="common.jsp" />
<head>
<title>应聘须知</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + path + "/";
    %>
<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
<script type="text/javascript" src="<%=basePath%>js/Chart.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	    var userId=${sessionScope.loginUser.id==null?"":sessionScope.loginUser.id};
	    $.post('<%=basePath%>company_companyAnalytics.do?id='+userId,{},function(data){
			var barChartData = data.data;

			var myLine = new Chart(document.getElementById("canvas").getContext("2d")).Bar(barChartData);
	    });
	});
</script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<div class="container">
		<div class="row">
			<div class="col-md-3">
						<div class="col-sm-12 col-md-12">
						    <div class="thumbnail">
						    ${requestScope.user.companyLogo}
						     <c:if test="${requestScope.company.companyLogo!=null&& '' ne requestScope.company.companyLogo}">
                                  <img src="<%=basePath%>images/logo/${requestScope.company.companyLogo}" id="userHeadImage" alt="公司Logo">
                              </c:if>
                              <c:if test="${requestScope.company.companyLogo==null || '' eq requestScope.company.companyLogo}">
                                    <img src="" id="userHeadImage" alt="公司Logo">
                              </c:if>
						      <div class="caption">
                                  <div class="highlight text-center">
                                        <pre>
								                                              用户名:${sessionScope.loginUser.cpy_loginName}<br>
								                                             上次登录时间:<fmt:formatDate value="${sessionScope.loginUser.lastLoginDate}" pattern="yyyy-MM-dd"/><br>
								                                              注册时间:<fmt:formatDate value="${sessionScope.loginUser.creationDate}" pattern="yyyy-MM-dd"/><br>
                                        </pre>
                                  </div>
						      </div>
						    </div>
						 </div>
			</div>
			<div class="col-md-9" role="main">
					<div class="page-header">
					  <h1>招聘职位投递柱状图</h1>
					</div>
					<div class="bs-example ">
							<canvas id="canvas" height="450" width="600"></canvas>
					</div>
			</div>
		</div>
	</div>
	<jsp:include page="buttom.jsp" flush="true" />
</body>
</html>