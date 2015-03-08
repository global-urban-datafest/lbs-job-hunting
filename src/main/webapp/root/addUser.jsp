<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + path + "/";
    %>
<c:if test="${!empty sessionScope.loginUser}"> 
<html lang="zh-cn">
<jsp:include page="/common.jsp" />
<head>
<title>应聘须知</title>
<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
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
        checkpass(document.getElementById('userpass'));
        checkrepass(document.getElementById('userrepass'));
        var bb=$('.help-block');
        if(bb.length<=0){
			$('#userform').ajaxSubmit(function(data){
				if(data.success){
					alert('更新招聘信息成功，请关闭本窗口');
					window.location.href="<%=basePath%>root/userListManagement.jsp";
				}else{
					alert(data.msg);
				}
			});
        }else{
            return false;
        }
        return false;
    });
});
</script>
</head>
<body style="background: none">
	<div class="container" style="background: none;">
		<div class="row">
			<div class="col-md-12" role="main">
					<div class="page-header">
					  <h1>增加用户</h1>
					</div>
                        <form class="form-horizontal" role="form" action="<%=basePath%>root/rootUser_addUser.do"  id="userform" method="post">
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
                                    <button type="submit" class="btn btn-default" id="userRegister">增加用户</button>
                                </div>
                            </div>
                        </form>
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