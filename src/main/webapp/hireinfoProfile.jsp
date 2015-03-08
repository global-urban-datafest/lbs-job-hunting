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
<c:if test="${!empty sessionScope.loginUser }">
<html lang="zh-cn">
<jsp:include page="common.jsp" flush="true" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>easyui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>easyui/themes/icon.css">
<script type="text/javascript" src="<%=basePath%>easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
<script type="text/javascript" src="<%=basePath%>js/popwin.js"></script>
<head>
<title>招聘信息列表</title>

<script type="text/javascript">
function sendResume(hireinfoId,dom){
    var userId=${sessionScope.loginUser.id==null?"":sessionScope.loginUser.id};
    if(notEmpty(userId)){
	 	if(notEmpty(hireinfoId)){
			 $.post('<%=basePath%>user_sendResume.do',{'id':hireinfoId},function(data){
				 if(data.success){
					alert('投递简历成功!');
					$(dom).attr('disabled','disabled');
				 }else{
					 alert(data.msg);
				 }
			 });
		 }else{
			 alert('未选择任何职位！');
		 }
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
			<div class="col-md-12" role="main">
				<c:if test="${!empty requestScope.hireinfo}">
					<div class="panel-heading">
			            <h4 class="panel-title">
			                ${requestScope.hireinfo.positionName}
			            </h4>
			        </div>
			        <div class="panel-body">
						<table class="table">
						    <tr>
						    	<td>工作地点:</td>
						    		<td>${requestScope.hireinfo.workplace}</td>
						    	<td>招聘人数:</td>
						    		<td>${requestScope.hireinfo.jobpeopleNum}</td>
						    	<td>工作类型:</td>
						    		<td>
										<c:if test="${!empty sessionScope.worktypes}">
			                                    <c:forEach var="c" items="${sessionScope.worktypes}">
			                                    		<c:if test="${c.id eq requestScope.hireinfo.positionName}">
			                                             ${c.tableDesc}
			                                          </c:if>
			                                    </c:forEach>
			                              </c:if>    		
						    		</td>
						    </tr>
					  </table>
					 <h5>职位描述</h5>
					 <div class="bs-callout bs-callout-warning">
					 	${requestScope.hireinfo.hireDesc}
					 </div>
					 <h5>职位需求</h5>
					 <div class="bs-callout bs-callout-warning">
					 	${requestScope.hireinfo.jobRequried}
					 </div>
					 <h5>职位待遇</h5>
					 <div class="bs-callout bs-callout-warning">
					 	${requestScope.hireinfo.jobTreatment}
					 </div>
			         </div>
			         <div class="text-center" style="margin-top:5px;">
			       		<a class="btn btn-info" onclick="sendResume(${requestScope.hireinfo.id},this);">应聘该职位</a>
			      	 </div>
				</c:if>
				<c:if test="${empty requestScope.hireinfo}">
					<script type="text/javascript">
						window.location.href="<%=basePath%>index.jsp";
					</script>
				</c:if>
            </div>
		</div>
	</div>
	<jsp:include page="buttom.jsp" flush="true" />
</body>
</html>
</c:if>
<c:if test="${empty sessionScope.loginUser}">
		<script type="text/javascript">
		window.location.href="<%=basePath%>user_loginOut.do";
		</script>
</c:if>