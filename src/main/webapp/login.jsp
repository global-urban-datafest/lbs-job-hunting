<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-cn">
<jsp:include page="common.jsp"/>
<head>
    <title>用户登陆页面</title>
    <script type="text/javascript">
        function refresh(obj) {
            obj.src = "imageServlet?" + Math.random();
        }
        $(function(){
            $("#userlogin").on('click',function(event){
                var username=$("#username").val();
                var userpass=$("#userpass").val();
                var usercode=$("#usercode").val();
                if(!notEmpty(username)||!notEmpty(userpass)||!notEmpty(usercode)){
                    alert("信息填写不完整");
                    return false;
                }else{
                    return true;
                }
            });
            $("#companyLogin").on('click',function(event){
                var username=$("#companyName").val();
                var userpass=$("#companyPass").val();
                var usercode=$("#companyCode").val();
                if(!notEmpty(username)||!notEmpty(userpass)||!notEmpty(usercode)){
                    alert("信息填写不完整");
                    return false;
                }else{
                    return true;
                }
            });
        })
    </script>
</head>
<body>
<jsp:include page="header.jsp" flush="true"/>
<div class="container">
    <div class="row">
        <ul class="nav nav-tabs" id="myTab">
            <li><a href="#home" data-toggle="tab">求职者</a></li>
            <li><a href="#profile" data-toggle="tab">企业用户</a></li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content bs-example-tabs">
            <div class="tab-pane active" id="home">

                <form class="form-horizontal" role="form" action="user_login.do"  id="userform" method="post" style="margin-top: 13px;">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">用户名</label>

                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="username" name="user.name" placeholder="用户名" value="aaa">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">密码</label>
                        <input type="hidden" name="loginType" value="1">
                        <div class="col-sm-4">
                            <input type="password" class="form-control" id="userpass" name="user.password" placeholder="密码" value='123456'>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="validCode" class="col-sm-2 control-label" >验证码</label>

                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="usercode" name="usercode" placeholder="验证码">
                        </div>
                        <div class="col-sm-1">
                            <img title="换一个?" onclick="javascript:refresh(this);" src="imageServlet">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-10">
                            <button type="submit" class="btn btn-default" id="userlogin">登录</button>
                        </div>
                    </div>
                </form>
            </div>


            <%--公司登录模块--%>
            <div class="tab-pane" id="profile">
                <form class="form-horizontal" role="form" action="company_login.do" method="post" style="margin-top: 13px;">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">会员名:</label>

                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="companyName" name="company.cpy_loginName" placeholder="会员名" value="bbb">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">会员密码:</label>
                        <input type="hidden" name="loginType" value="2">
                        <div class="col-sm-4">
                            <input type="password" class="form-control" id="companyPass" name="company.cpy_loginPass" placeholder="会员密码" value="123456">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="validCode" class="col-sm-2 control-label">验证码</label>

                        <div class="col-sm-2">
                            <input type="text" class="form-control" id="companyCode" name="companyCode" placeholder="验证码">
                        </div>
                        <div class="col-sm-1">
                            <img title="换一个?" onclick="javascript:refresh(this);" src="imageServlet">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-10">
                            <input type="submit" class="btn btn-default" id="companyLogin" value="企业登录">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <c:if test="${request.error_message!=null}">
        <div clss="row">
            <div class="alert alert-danger alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                ${request.error_message}
            </div>
        </div>
    </c:if>
</div>
<jsp:include page="buttom.jsp" flush="true"/>
</body>
</html>