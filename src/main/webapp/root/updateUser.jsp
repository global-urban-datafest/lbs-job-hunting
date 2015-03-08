<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + path + "/";
    %>
<c:if test="${!empty sessionScope.loginUser}"> 
<html>
<head>
<meta charset="utf-8" />
<jsp:include page="/common.jsp"/>
<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
<script type="text/javascript">
function addRootUser(){
	$('#loginForm').ajaxSubmit(function(data){
		if(data.success){
			alert('添加管理员成功，请关闭本窗口');
		}else{
			alert(data.msg);
		}
	});
}
</script>
</head>
<body class="container" style="background: none;">
	<div class="row">
		<div class="col-md-12" role="main">
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
</body>
</html>
</c:if>
<c:if test="${empty sessionScope.loginUser}">
		<script type="text/javascript">
		parent.location.href="<%=basePath%>root/rootUser_loginOut.do";
		</script>
</c:if>