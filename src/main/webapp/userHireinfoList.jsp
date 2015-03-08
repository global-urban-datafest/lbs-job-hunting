<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<c:if test="${!empty sessionScope.loginUser}">
<!DOCTYPE html>
<html lang="zh-cn">
<jsp:include page="common.jsp" />
<head>
<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$.post('<%=basePath%>user_userHireinfoList.do',{},function(data){
		$('#appendBody').empty();
		if(notEmpty(data.rows)){
			$.each(data.rows,function(index,val){
				$('#appendBody').fadeIn("slow",function(){
					$('#appendBody').append("<div class='panel-group' id='accordion'><div class='panel-heading'><h4 class='panel-title'><a data-toggle='collapse' data-parent='#accordion' href='#collapse"+index+"'>"+val.positionName+"</a></h4></div><div id='collapse"+index+"' class='panel-collapse collapse in'><div class='panel-body'><table class='table'><tr><td>工作地点:</td><td>"+val.workplace+"</td><td>招聘人数:</td><td>"+val.jobpeopleNum+"</td></tr></table><h5>职位描述</h5><div class='bs-callout bs-callout-warning'>"+val.hireDesc+"</div><h5>职位需求</h5><div class='bs-callout bs-callout-warning'>"+val.jobRequried+"</div><h5>职位待遇</h5><div class='bs-callout bs-callout-warning'>"+val.jobTreatment+"</div></div><div class='text-center' style='margin-top:5px;'><a class='btn btn-info' onclick='sendResume("+val.id+",this);'>应聘该职位</a></div></div></div>");
				});
			});
		}else{
			$('#appendBody').append('对不起，么有任何企业信息');
		}
	});
});
function searchHireinfo(){
	$('#searchform').ajaxSubmit(function(data){
		$('#appendBody').empty();
		if(notEmpty(data.rows)){
			$.each(data.rows,function(index,val){
				$('#appendBody').fadeIn("slow",function(){
					$('#appendBody').append("<div class='panel-group' id='accordion'><div class='panel-heading'><h4 class='panel-title'><a data-toggle='collapse' data-parent='#accordion' href='#collapse"+index+"'>"+val.positionName+"</a></h4></div><div id='collapse"+index+"' class='panel-collapse collapse in'><div class='panel-body'><table class='table'><tr><td>工作地点:</td><td>"+val.workplace+"</td><td>招聘人数:</td><td>"+val.jobpeopleNum+"</td></tr></table><h5>职位描述</h5><div class='bs-callout bs-callout-warning'>"+val.hireDesc+"</div><h5>职位需求</h5><div class='bs-callout bs-callout-warning'>"+val.jobRequried+"</div><h5>职位待遇</h5><div class='bs-callout bs-callout-warning'>"+val.jobTreatment+"</div></div><div class='text-center' style='margin-top:5px;'><a class='btn btn-info' onclick='sendResume("+val.id+",this);'>应聘该职位</a></div></div></div>");
				});
			});
		}else{
			$('#appendBody').append('对不起，么有任何企业信息');
		}
	});
}
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
<title>职位详情</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
		<div class="container">
			<div class="row">
				<div class="col-md-12" role="main">
					<h3>职位列表</h3>
					<div class="highlight">
						<form class="form-horizontal" action="<%=basePath%>user_userHireinfoList.do" id="searchform" role="form">
						  	<div class="form-group">
						  		<label class="col-sm-1 control-label">职位名称:</label>
						  		<div class="col-sm-2">
						  			<input type="text"  id="positionName" name="positionName" class="form-control">
						  		</div>
						    	<label class="col-sm-1 control-label">工作地点:</label>
						    	<div class="col-sm-2">
						    		<input type="text"  id="workplace"  name="workplace" class="form-control">
						    	</div>
						    	<label class="col-sm-1 control-label">工作类型:</label>
						    	<div class="col-sm-2">
									<select class="form-control" id="worktype" name="worktype">
			                              <option value="-1">请选择</option>
			                              <c:if test="${!empty sessionScope.worktypes}">
			                                    <c:forEach var="c" items="${sessionScope.worktypes}">
			                                        <option value="${c.id}">${c.tableDesc}</option>
			                                    </c:forEach>
			                              </c:if>
									</select>
								</div>
						    	<div class="col-sm-1">
						    		<button type="button" class="btn btn-default" onclick="searchHireinfo();" >搜索</button>
								</div>
						  	</div>
						</form> 
					</div>
				</div>
				<div class="col-md-9" role="main">
					<h3>职位列表</h3>
					<div class="bs-example" id="appendBody">
						
					</div>
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