<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
</script>
<header id="header">
    <div class="container">
        <p class="navbar-text navbar-right">当前访客身份:
            <c:if test="${sessionScope.loginUser==null}">
             		   游客
                <a href="register.jsp" class="navbar-link">注册</a>
                <a href="login.jsp" class="navbar-link">登录</a>
            </c:if>
            <c:if test="${sessionScope.loginUser!=null && sessionScope.loginType!=null}">
                    <c:if test="${'1' eq sessionScope.loginType}">
                   			个人用户,欢迎您,${sessionScope.loginUser.name}   
                   		 <a href="user_loginOut.do" class="navbar-link">注销</a>
                     </c:if>
                    <c:if test="${'2' eq sessionScope.loginType}">
                       		 企业用户,欢迎您,${sessionScope.loginUser.cpy_loginName}
                       	 <a href="company_loginOut.do" class="navbar-link">注销</a>
                    </c:if>
            </c:if>
        </p>
    </div>
    <div class="navbar">
        <nav class="navbar navbar-default" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.jsp">HR</a>
            </div>
			<c:if test="${sessionScope.loginType!=null && '1' eq sessionScope.loginType}">
	            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	                <ul class="nav navbar-nav">
	                    <li class="dropdown">
	                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">个人服务<b class="caret"></b></a>
	                        <ul class="dropdown-menu">
	                            <li>
	                                <a href="/user_userProfileForward.do?id=${sessionScope.loginUser.id}">个人信息</a>
	                            </li>
	                            <li>
	                                <a href="/user_findAllResumes.do?id=${sessionScope.loginUser.id}">个人简历</a>
	                            </li>
	                            <li>
	                                <a href="/user_EmployRelationHistory.do">历史投递信息</a>
	                            </li>
	                            <li>
	                                <a href="/user_userPassForward.do?id=${sessionScope.loginUser.id}">修改密码</a>
	                            </li>
	                        </ul>
	                    </li>
 	                    <li class="dropdown">
	                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">职场<b class="caret"></b></a>
	                        <ul class="dropdown-menu">
	                            <li>
	                                <a href="/userCompanyList.jsp">企业列表</a>
	                            </li>
	                            <li>
	                                <a href="/userHireinfoList.jsp">职位列表</a>
	                            </li>
	                        </ul>
	                    </li>
	                    <li class="dropdown">
	                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">应聘技巧<b class="caret"></b></a>
	                        <ul class="dropdown-menu">
	                            <li>
	                                <a href="requiredInfo.jsp">应聘须知</a>
	                            </li>
	                        </ul>
	                    </li>
	                </ul>
	            </div>
          </c:if>
          <c:if test="${sessionScope.loginType!=null && '2' eq sessionScope.loginType}">
	            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	                <ul class="nav navbar-nav">
	                    <li class="dropdown">
	                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">企业服务<b class="caret"></b></a>
	                        <ul class="dropdown-menu">
	                            <li>
	                                <a href="/company_userProfileForward.do?id=${sessionScope.loginUser.id}">企业信息</a>
	                            </li>
	                            <li>
	                                <a href="/company_userPassForward.do?id=${sessionScope.loginUser.id}">修改密码</a>
	                            </li>
	                            <li>
	                                <a href="/companyAnalytics.jsp">企业分析</a>
	                            </li>
	                        </ul>
	                    </li>
	                    <li class="dropdown">
	                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">招聘管理<b class="caret"></b></a>
	                        <ul class="dropdown-menu">
	                        	<li>
	                                <a href="/employReLationList.jsp">投递简历管理</a>
	                            </li>
	                            <li>
	                                <a href="/company_hireinfoListForward.do">职位管理</a>
	                            </li>
	                        </ul>
	                    </li>
	                </ul>
	                <form class="navbar-form navbar-right col-lg-4 " role="search">
	                    <div class="form-group">
	                        <input type="text" class="form-control search-input" onkeyup="hideImage(this);">
	                    </div>
	                </form>
	            </div>
          </c:if>
        </nav>
    </div>
</header>
