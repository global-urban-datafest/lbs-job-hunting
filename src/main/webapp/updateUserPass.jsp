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
<script type="text/javascript">
function checkOldPass(dom){
    var obj=$(dom);
    var val=obj.val();
    var userId=${sessionScope.loginUser.id==null?"":sessionScope.loginUser.id};
    var controlGroup = obj.parents('.form-group');
    if(notEmpty(val)){
        if(matchLength(val,6)){
            if(notEmpty(userId)){
                $.post('<%=basePath%>user_checkPass.do',{
                	'user.password' :val,
                	'user.id':userId
                },function(objstr){
                	if(notEmpty(objstr)){
                    	var flag=objstr.data.msg;
                        if(flag)
                        {
                            $('#userpass').removeAttr('disabled');
                            $('#userrepass').removeAttr('disabled');
                            obj.attr('disabled','disabled');
                            controlGroup.find("#valierr1").remove();
                            controlGroup.removeClass('has-error has-success');
                            controlGroup.addClass('has-success');
                        }else{
                            $('#userpass').attr('disabled','disabled');
                            $('#userrepass').attr('disabled','disabled');
                            obj.removeAttr('disabled');
                            controlGroup.find("#valierr1").remove();
                            controlGroup.removeClass('has-error has-success');
                            controlGroup.addClass('has-error');
                            obj.parent().after('<span class="help-block" id="valierr1">原密码不正确</span>');
                        }
                	}
                });
            }else{
                alert('登录时间过期，请重新登录');
                window.location.href='<%=basePath%>user_loginOut.do';
            }
        }else{
            controlGroup.find("#valierr1").remove();
            controlGroup.removeClass('has-error has-success');
            controlGroup.addClass('has-error');
            obj.parent().after('<span class="help-block" id="valierr1">请输入不少于6位数的密码</span>');
        }
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
                controlGroup.find("#valierr2").remove();
                controlGroup.removeClass('has-error has-success');
                controlGroup.addClass('has-success');
                recontrolGroup.find("#valierr3").remove();
                recontrolGroup.removeClass('has-error has-success');
                recontrolGroup.addClass('has-success');
                return true;
            }else{
                controlGroup.find("#valierr2").remove();
                controlGroup.removeClass('has-error has-success');
                controlGroup.addClass('has-error');
                obj.parent().after('<span class="help-block" id="valierr2">两次输入的密码不一致</span>');
                return false;
            }
        }else{
            controlGroup.find("#valierr2").remove();
            controlGroup.removeClass('has-error has-success');
            controlGroup.addClass('has-error');
            obj.parent().after('<span class="help-block" id="valierr2">请输入不少于6位数的密码</span>');
            return false;
        }

    }else{
        controlGroup.find("#valierr2").remove();
        controlGroup.removeClass('has-error has-success');
        controlGroup.addClass('has-error');
        obj.parent().after('<span class="help-block" id="valierr2">密码不能为空</span>');
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
                  controlGroup.find("#valierr3").remove();
                  controlGroup.removeClass('has-error has-success');
                  controlGroup.addClass('has-error');
                  obj.parent().after('<span class="help-block" id="valierr3">两次输入的密码不一致</span>');
                  return false;
              }else{
                  controlGroup.find("#valierr3").remove();
                  controlGroup.removeClass('has-error has-success');
                  controlGroup.addClass('has-success');
                  recontrolGroup.find("#valierr2").remove();
                  recontrolGroup.removeClass('has-error has-success');
                  recontrolGroup.addClass('has-success');
                  return true;
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
    function updateUserPass(){
        var userId=${sessionScope.loginUser.id==null?"":sessionScope.loginUser.id};
        if(notEmpty(userId)&checkpass(document.getElementById('userpass'))&checkrepass(document.getElementById('userrepass'))){
            $.post('<%=basePath%>user_updateUserPass.do',{
                'user.id':userId,
                'user.password':$('#userpass').val()
            },function(objstr){
               	if(notEmpty(objstr)){
                	var flag=objstr.data.msg;
	                if(flag)
	                {
	                    alert('密码更新成功,请重新登录!');
	                    window.location.href="<%=basePath%>user_loginOut.do";
	                }else{
	                    alert('密码更新失败,请重试!');
	                }
               	}else{
               	 alert('密码更新失败,请重试!');
               	}
            });
        }else{
            alert('登录时间过期，请重新登录');
            window.location.href='<%=basePath%>user_loginOut.do';
        }
    }
</script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<div class="container">
		<div class="row">
			<div class="col-md-3">
						<div class="col-sm-12 col-md-12">
						    <div class="thumbnail">
                                <c:if test="${requestScope.user.headImage!=null&& '' ne requestScope.user.headImage}">
                                    <img src="/images/userPhoto/${requestScope.user.headImage}" id="userHeadImage" alt="用户头像">
                                </c:if>
                                <c:if test="${requestScope.user.headImage==null || '' eq requestScope.user.headImage}">
                                    <img src="/images/userPhoto/3-13112G33911.jpg" id="userHeadImage" alt="用户头像">
                                </c:if>
						      <div class="caption">
                                  <div class="highlight text-center">
                                        <pre>
								                                              用户名:${sessionScope.loginUser.name}<br>
								                                              上次登录时间:<fmt:formatDate value="${sessionScope.loginUser.lastlogindate}" pattern="yyyy-MM-dd"/><br>
								                                              注册时间:<fmt:formatDate value="${sessionScope.loginUser.registerdate}" pattern="yyyy-MM-dd"/><br>
                                        </pre>
                                  </div>
						      </div>
						    </div>
						 </div>
			</div>
			<div class="col-md-9" role="main">
					<div class="page-header">
					  <h1>修改密码</h1>
					</div>
					<div class="bs-example ">
                        <div class="form-horizontal" role="form">
                            <div class="form-group">
                                <label for="maxim" class="col-sm-2 control-label">请输入原密码密码</label>
                                <div class="col-sm-4">
                                    <input type="password" class="form-control" id="oldpass" name="oldpass" onkeyup="checkOldPass(this)">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="maxim" class="col-sm-2 control-label">请输入新密码</label>
                                <div class="col-sm-4">
                                    <input type="password" class="form-control" id="userpass" name="userpass" onkeyup="checkpass(this)" disabled="disabled">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="userHeadImage">请重复你输入的新密码</label>
	                            <div class="col-sm-4">
	                                 <input type="password" class="form-control" id="userrepass" name="userrepass" onkeyup="checkrepass(this)" disabled="disabled">
	                            </div>
                            </div>
                        </div>
					</div>
					<div class="highlight text-center">
						<pre>
						     <button type="button" class="btn btn-default" onclick="updateUserPass()">修改密码</button>
						</pre>
					</div>
			</div>
		</div>
	</div>
	<jsp:include page="buttom.jsp" flush="true" />
</body>
</html>