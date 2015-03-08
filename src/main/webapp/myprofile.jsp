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
    function uploadUserImage(){
        var options = {
            target:'#Tip', //后台将把传递过来的值赋给该元素
            type:'POST',
            success: function(){
                filename=$('#Tip').text();
                //filename=str.substr(2,str.length-2);
                $('#userHeadImage').attr('src','<%=basePath%>images/userPhoto/'+filename);
            } //显示操作提示
        };
        $('#imgupdateform').ajaxSubmit(options);
        return false; //为了不刷新页面,返回false，反正都已经在后台执行完了，没事！
    }
    function updateUser(){
        var userId=${sessionScope.loginUser.id==null?"":sessionScope.loginUser.id};
        var headImage=$('#userHeadImage').attr('src');
        if(notEmpty(headImage)){
        	if(headImage.lastIndexOf('\/')>0){
            	headImage=headImage.substring(headImage.lastIndexOf('\/')+1,headImage.length);
        	}else{
        		headImage="3-13112G33911.jpg";
        	}
        }
        var maxim= $('#maxim').val();
        if(notEmpty(userId)){
            $.post('<%=basePath%>user_update.do',{
                'user.id':userId,
                'user.headImage':headImage,
                'user.Maxim':maxim
            },function(obj){
                if(obj)
                {
                    alert('基本信息更新成功！')
                    window.location.href="<%=basePath%>user_userProfileForward.do?id="+userId;
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
					  <h1>用户个人信息</h1>
					</div>
					<div class="bs-example ">
                        <div class="form-horizontal" role="form">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">用户名:</label>
                                <div class="col-sm-4">
                                    <span class="text-muted" style="position: relative;top:6px;">${requestScope.user.name}</span>.
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="registeremail" class="col-sm-2 control-label">Email:</label>
                                <div class="col-sm-4">
                                    <span class="text-muted" id="registeremail" style="position: relative;top:6px;">${requestScope.user.registeremail}</span>.
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="maxim" class="col-sm-2 control-label">格言</label>
                                <div class="col-sm-4">
                                    <textarea id="maxim" name="user.maxim" class="form-control" placeholder="格言">${requestScope.user.maxim}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="userHeadImage">头像:</label>
                                <div class="col-sm-4">
                                    <form class="form-horizontal" action="<%=basePath%>uploadAction_userHeadUpload.do"
                                          method="post" enctype="multipart/form-data"  id="imgupdateform" onsubmit="return uploadUserImage()">
                                        <input type="file" id="upload" name="myFile" class="form-control"/>
                                        <br>
                                        <input type="submit" id="updateimg" value="上传头像" class="text-center"/>
                                    </form>
                                </div>
                            </div>
                        </div>
					</div>
					<div class="highlight text-center">
						<pre>
						     <button type="button" class="btn btn-default" onclick="updateUser()">更新基本信息</button>
                            <span id="Tip" style="display: none"></span>
						</pre>
					</div>
			</div>
		</div>
	</div>
	<jsp:include page="buttom.jsp" flush="true" />
</body>
</html>