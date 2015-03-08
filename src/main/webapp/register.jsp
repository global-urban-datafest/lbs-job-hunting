<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-cn">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<jsp:include page="common.jsp"/>
<head>
    <title>用户注册页面</title>
    <script type="text/javascript">
        function checkName(dom){
            var obj=$(dom);
            var val=obj.val();
            var controlGroup = obj.parents('.form-group');
            if(notEmpty(val)){
                $.ajax({
                    url: '/user_verifyLoginName.do',
                    data:{'user.name' :val,'type':'1'},
                    async:false,
                    success: function(objstr) {
                        if(notEmpty(objstr)){
                            var flag=objstr.data.success;
                            var msg=objstr.data.msg;
                            controlGroup.find("#valierr1").remove();
                            controlGroup.removeClass('has-error has-success');
                            controlGroup.addClass(flag=='true'?'has-success':'has-error');
                            if(flag=='true'){
                            	return true;
                            }
                            else{
                            	obj.parent().after('<span class="help-block" id="valierr1">' + msg +'</span>');
                            	return false;
                            }        
                        }else{
                            controlGroup.find("#valierr1").remove();
                            controlGroup.removeClass('has-error has-success');
                            controlGroup.addClass('has-error');
                            obj.parent().after('<span class="help-block" id="valierr1">程序未有返回</span>');
                            return false;
                        }
                    }
                });
            }else{
                controlGroup.find("#valierr1").remove();
                controlGroup.removeClass('has-error has-success');
                controlGroup.addClass('has-error');
                obj.parent().after('<span class="help-block" id="valierr1">用户名不能为空</span>');
                return false;
            }
        }
        function checkEmail(dom){
            var obj=$(dom);
            var val=obj.val();
            var controlGroup = obj.parents('.form-group');
            if(notEmpty(val)){
                if(Emailmatch(val)){
                    $.ajax({
                        url: '/user_verifyEmail.do',
                        data:{'user.registeremail' :val,'type':'1'},
                        async:false,
                        success: function(objstr) {
                            if(notEmpty(objstr)){
                                var flag=objstr.data.success;
                                var msg=objstr.data.msg;
                                controlGroup.find("#valierr2").remove();
                                controlGroup.removeClass('has-error has-success');
                                controlGroup.addClass(flag=='true'?'has-success':'has-error');
                                if(flag=='true'){
                                	return true;
                                }
                                else{
                                	obj.parent().after('<span class="help-block" id="valierr1">' + msg +'</span>');
                                	return false;
                                }   
                            }else{
                                controlGroup.find("#valierr2").remove();
                                controlGroup.removeClass('has-error has-success');
                                controlGroup.addClass('has-error');
                                obj.parent().after('<span class="help-block" id="valierr2">程序未有返回</span>');
                                return false;
                            }
                        }
                    });
                }else{
                    controlGroup.find("#valierr2").remove();
                    controlGroup.removeClass('has-error has-success');
                    controlGroup.addClass('has-error');
                    obj.parent().after('<span class="help-block" id="valierr2">请输入正确的email</span>');
                    return false;
                }

            }else{
                controlGroup.find("#valierr2").remove();
                controlGroup.removeClass('has-error has-success');
                controlGroup.addClass('has-error');
                obj.parent().after('<span class="help-block" id="valierr2">email不能为空</span>');
                return false;
            }
        }
        function checkpass(dom){
            var obj=$(dom);
            var val=obj.val();
            var controlGroup = obj.parents('.form-group');
            if(notEmpty(val)){
                if(matchLength(val,6)){
                    var el=$('#userrepass');
                    var repass =el.val();
                    var recontrolGroup = el.parents('.form-group');
                    if(val==repass){
                        controlGroup.find("#valierr3").remove();
                        controlGroup.removeClass('has-error has-success');
                        controlGroup.addClass('has-success');
                        recontrolGroup.find("#valierr4").remove();
                        recontrolGroup.removeClass('has-error has-success');
                        recontrolGroup.addClass('has-success');
                        return true;
                    }else{
                        controlGroup.find("#valierr3").remove();
                        controlGroup.removeClass('has-error has-success');
                        controlGroup.addClass('has-error');
                        obj.parent().after('<span class="help-block" id="valierr3">两次输入的密码不一致</span>');
                        return false;
                    }
                }else{
                    controlGroup.find("#valierr3").remove();
                    controlGroup.removeClass('has-error has-success');
                    controlGroup.addClass('has-error');
                    obj.parent().after('<span class="help-block" id="valierr3">请输入不少于6位数的密码</span>');
                    return false;
                }

            }else{
                controlGroup.find("#valierr3").remove();
                controlGroup.removeClass('has-error has-success');
                controlGroup.addClass('has-error');
                obj.parent().after('<span class="help-block" id="valierr3">密码不能为空</span>');
                return false;
            }
        }
        function checkrepass(dom){
            var obj=$(dom);
            var val=obj.val();
            var controlGroup = obj.parents('.form-group');
            if(notEmpty(val)){
                if(matchLength(val,6)){
                    var el=$('#userpass');
                    var pass =el.val();
                    var recontrolGroup = el.parents('.form-group');
                      if(val!=pass){
                          controlGroup.find("#valierr4").remove();
                          controlGroup.removeClass('has-error has-success');
                          controlGroup.addClass('has-error');
                          obj.parent().after('<span class="help-block" id="valierr4">两次输入的密码不一致</span>');
                          return false;
                      }else{
                          controlGroup.find("#valierr4").remove();
                          controlGroup.removeClass('has-error has-success');
                          controlGroup.addClass('has-success');
                          recontrolGroup.find("#valierr3").remove();
                          recontrolGroup.removeClass('has-error has-success');
                          recontrolGroup.addClass('has-success');
                          return true;
                      }
                }else{
                    controlGroup.find("#valierr4").remove();
                    controlGroup.removeClass('has-error has-success');
                    controlGroup.addClass('has-error');
                    obj.parent().after('<span class="help-block" id="valierr4">请输入不少于6位数的密码</span>');
                    return false;
                }

            }else{
                controlGroup.find("#valierr4").remove();
                controlGroup.removeClass('has-error has-success');
                controlGroup.addClass('has-error');
                obj.parent().after('<span class="help-block" id="valierr4">密码不能为空</span>');
                return false;
            }
        }
        $(function(){
            $('#userRegister').on('click',function(){
                checkName(document.getElementById('username'));
                checkEmail(document.getElementById('useremail'));
                checkpass(document.getElementById('userpass'));
                checkrepass(document.getElementById('userrepass'));
                var bb=$('.help-block');
                if(bb.length<=0){
                          return true;
                }else{
                          return false;
                }
            });
            $('#companyRegister').on('click',function(){
            	checkCompanyName(document.getElementById('companyName'));
            	checkCompanyPass(document.getElementById('companyPass'));
            	checkReComapnyPass(document.getElementById('recompanypass'));
                var bb=$('.help-block');
                if(bb.length<=0){
                          return true;
                }else{
                          return false;
                }
            })
        });
    </script>
</head>
<body>
<jsp:include page="header.jsp" flush="true"/>
<div class="container">
    <div class="row">
        <ul class="nav nav-pills">
            <li><a href="#home" data-toggle="tab">求职者</a></li>
            <li><a href="#profile" data-toggle="tab">企业用户</a></li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane active" id="home">
                <div class="panel panel-default">
                    <div class="panel-heading">求职者注册</div>
                    <div class="panel-body">
                        <form class="form-horizontal" role="form" action="user_register.do"  id="userform" method="post">
                            <div class="form-group">
                                <label for="username" class="col-sm-2 control-label">用户名</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="username" name="user.name" placeholder="用户名" onkeyup="checkName(this)">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="userpass" class="col-sm-2 control-label">密码</label>
                                <input type="hidden" name="loginType" value="1">
                                <div class="col-sm-4">
                                    <input type="password" class="form-control" id="userpass" name="user.password" placeholder="密码" onkeyup="checkpass(this)">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="userrepass" class="col-sm-2 control-label">重复密码</label>
                                <div class="col-sm-4">
                                    <input type="password" class="form-control" id="userrepass"  placeholder="重复密码" onkeyup="checkrepass(this)">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="useremail" class="col-sm-2 control-label">Email</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="useremail" name="user.registeremail" placeholder="Email" check-type="mail required"
                                           required-message="请输入正确的Email."  onkeyup="checkEmail(this)">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-3 col-sm-10">
                                    <button type="submit" class="btn btn-default" id="userRegister">注册</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

            </div>


            <%--公司登录模块--%>
            <div class="tab-pane" id="profile">
                 <div class="panel panel-default">
                    <div class="panel-heading">企业注册</div>
                    	<div class="panel-body">
							<form class="form-horizontal" action="<%=basePath%>company_saveCompany.do" method="post" id="companyForm"">
								       <div class="form-group">
			                                <label for="userpass" class="col-sm-2 control-label">会员名:</label>
			                                <input type="hidden" name="loginType" value="1">
			                                <div class="col-sm-4">
			                                    <input type="text" class="form-control" id="companyName" name="company.cpy_loginName" placeholder="会员名" onkeyup="checkCompanyName(this)">
			                                </div>
			                            </div>
								       <div class="form-group">
			                                <label for="userpass" class="col-sm-2 control-label">会员密码:</label>
			                                <input type="hidden" name="loginType" value="2">
			                                <div class="col-sm-4">
			                                    <input type="password" class="form-control" id="companyPass" name="company.cpy_loginPass" placeholder="密码" onkeyup="checkCompanyPass(this)">
			                                </div>
			                            </div>
								       <div class="form-group">
			                                <label for="userpass" class="col-sm-2 control-label">重复会员密码:</label>
			                                <input type="hidden" name="loginType" value="1">
			                                <div class="col-sm-4">
			                                    <input type="password" class="form-control" id="recompanypass" name="recompanypass" placeholder="重复密码" onkeyup="checkReComapnyPass(this)">
			                                </div>
			                            </div>
			                            <div class="form-group">
			                                <div class="col-sm-offset-3 col-sm-10">
			                                    <input type="submit" class="btn btn-default" id="companyRegister"  value="企业注册">
			                                </div>
			                            </div>
							</form>
						</div>
					</div>
				</div>
            </div>
            <script type="text/javascript">
            function checkCompanyName(dom){
                var obj=$(dom);
                var val=obj.val();
                var controlGroup = obj.parents('.form-group');
                if(notEmpty(val)){
                    $.ajax({
                        url: '<%=basePath%>/company_verifyLoginName.do',
                        data:{'company.cpy_loginName' :val},
                        async:false,
                        success: function(objstr) {
                            if(notEmpty(objstr)){
                                var flag=objstr.data.success;
                                var msg=objstr.data.msg;
                                controlGroup.find("#valierr5").remove();
                                controlGroup.removeClass('has-error has-success');
                                controlGroup.addClass(flag=='true'?'has-success':'has-error');
                                if(flag==true){
                                    controlGroup.addClass('has-success');
                                	return true;
                                }
                                else{
                                	obj.parent().after('<span class="help-block" id="valierr5">' + msg +'</span>');
                                	return false;
                                }        
                            }else{
                                controlGroup.find("#valierr5").remove();
                                controlGroup.removeClass('has-error has-success');
                                controlGroup.addClass('has-error');
                                obj.parent().after('<span class="help-block" id="valierr5">程序未有返回</span>');
                                return false;
                            }
                        }
                    });
                }else{
                    controlGroup.find("#valierr5").remove();
                    controlGroup.removeClass('has-error has-success');
                    controlGroup.addClass('has-error');
                    obj.parent().after('<span class="help-block" id="valierr5">用户名不能为空</span>');
                    return false;
                }
            }
            function checkCompanyPass(dom){
                var obj=$(dom);
                var val=obj.val();
                var controlGroup = obj.parents('.form-group');
                if(notEmpty(val)){
                    if(matchLength(val,6)){
                        var el=$('#recompanypass');
                        var repass =el.val();
                        var recontrolGroup = el.parents('.form-group');
                        if(val==repass){
                            controlGroup.find("#valierr6").remove();
                            controlGroup.removeClass('has-error has-success');
                            controlGroup.addClass('has-success');
                            recontrolGroup.find("#valierr7").remove();
                            recontrolGroup.removeClass('has-error has-success');
                            recontrolGroup.addClass('has-success');
                            return true;
                        }else{
                            controlGroup.find("#valierr6").remove();
                            controlGroup.removeClass('has-error has-success');
                            controlGroup.addClass('has-error');
                            obj.parent().after('<span class="help-block" id="valierr6">两次输入的密码不一致</span>');
                            return false;
                        }
                    }else{
                        controlGroup.find("#valierr6").remove();
                        controlGroup.removeClass('has-error has-success');
                        controlGroup.addClass('has-error');
                        obj.parent().after('<span class="help-block" id="valierr6">请输入不少于6位数的密码</span>');
                        return false;
                    }

                }else{
                    controlGroup.find("#valierr6").remove();
                    controlGroup.removeClass('has-error has-success');
                    controlGroup.addClass('has-error');
                    obj.parent().after('<span class="help-block" id="valierr6">密码不能为空</span>');
                    return false;
                }
            }
            function checkReComapnyPass(dom){
                var obj=$(dom);
                var val=obj.val();
                var controlGroup = obj.parents('.form-group');
                if(notEmpty(val)){
                    if(matchLength(val,6)){
                        var el=$('#companyPass');
                        var pass =el.val();
                        var recontrolGroup = el.parents('.form-group');
                          if(val!=pass){
                              controlGroup.find("#valierr7").remove();
                              controlGroup.removeClass('has-error has-success');
                              controlGroup.addClass('has-error');
                              obj.parent().after('<span class="help-block" id="valierr7">两次输入的密码不一致</span>');
                              return false;
                          }else{
                              controlGroup.find("#valierr7").remove();
                              controlGroup.removeClass('has-error has-success');
                              controlGroup.addClass('has-success');
                              recontrolGroup.find("#valierr6").remove();
                              recontrolGroup.removeClass('has-error has-success');
                              recontrolGroup.addClass('has-success');
                              return true;
                          }
                    }else{
                        controlGroup.find("#valierr7").remove();
                        controlGroup.removeClass('has-error has-success');
                        controlGroup.addClass('has-error');
                        obj.parent().after('<span class="help-block" id="valierr7">请输入不少于6位数的密码</span>');
                        return false;
                    }

                }else{
                    controlGroup.find("#valierr7").remove();
                    controlGroup.removeClass('has-error has-success');
                    controlGroup.addClass('has-error');
                    obj.parent().after('<span class="help-block" id="valierr7">密码不能为空</span>');
                    return false;
                }
            }
            </script>
    </div>
    <c:if test="${request.error_message!=null}">
        <div class="row">
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