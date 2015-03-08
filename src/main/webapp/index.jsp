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
<head>

<jsp:include page="common.jsp"/>

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
    <script src="http://api.map.baidu.com/api?v=2.0&ak=r2jbbgbfMXILwI8TMNbsGgak"></script>
    <link type="text/css" rel="stylesheet" href="<%=basePath%>css/map.css"/>
</head>
<body>
<jsp:include page="header.jsp" flush="true"/>
<div class="container">
    <div class="row">
        <div class="hotmap" id="hotmapbody">
            <div class="hotmapl">
                <div class="menu m0 active" data="all"><span></span>
                    <p>全部</p>

                </div>
                <div class="menu m1 active" data="user"><span></span>
                    <p>求职者</p>

                </div>
                <div class="menu m6" data="comp"><span></span>
                    <p>企业</p>
                </div>
            </div>
            <div class="hotmapc" id="hotmapc"> <span class="full_Btn"></span>
                <div id="hotmap"></div>
            </div>
            <div class="hotmapr">
                <div class="hotmapr_contnet" id="hotmapRightBar">
                </div>
            </div>
        </div>
        <jsp:include page="mapfunc.jsp"/>
        <input type="hidden" name="userCheck" class="checkValue" id="userCheck" value="1"/>
        <input type="hidden" name="compCheck" class="checkValue" id="compCheck" value="0"/>
    </div>
<c:if test="${sessionScope.loginType!=null && '1' eq sessionScope.loginType}">
    <div class="row">
		<div class="col-md-12">
		 	<h2>推荐企业</h2>
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