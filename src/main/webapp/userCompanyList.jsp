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
function showCompany(id){
	window.location.href="<%=basePath%>user_userCompanyProfile.do?id="+id;
}
	$(document).ready(function(){
		$.post('<%=basePath%>user_userCompanyList.do',{},function(data){
			$('#appendBody').empty();
			if(notEmpty(data.rows)){
				$.each(data.rows,function(index,val){
					var i=1;
					$('#appendBody').fadeIn("slow",function(){
						$('#appendBody').append("<div class='col-md-3'><img src='<%=basePath%>images/logo/"+val.companyLogo+"' class='img-rounded' onclick='showCompany("+val.id+");'></div>");
						i++;
						if(i==4){
							$('#appendBody').append("<div style='clear:clear'></div>");
							i=1;
						}
					});
				});
			}else{
				$('#appendBody').append('对不起，么有任何企业信息');
			}
		});
	});
	
	function searchCompany(){
		$('#searchform').ajaxSubmit(function(data){
			$('#appendBody').empty();
			if(notEmpty(data.rows)){
				$.each(data.rows,function(index,val){
					var i=1;
					$('#appendBody').fadeIn("slow",function(){
						$('#appendBody').append("<div class='col-md-3'><img src='<%=basePath%>images/logo/"+val.companyLogo+"' class='img-rounded' onclick='showCompany("+val.id+");'></div>");
						i++;
						if(i==4){
							$('#appendBody').append("<div style='clear:clear'></div>");
							i=1;
						}
					});
				});
			}else{
				$('#appendBody').append('对不起，么有任何企业信息');
			}
		});
	}
</script>
<title>企业信息列表</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
		<div class="container">
			<div class="row">
				<div class="col-md-12" role="main">
					<div class="highlight">
						<form class="form-horizontal" action="<%=basePath%>user_userCompanyList.do" id="searchform" role="form">
						  	<div class="form-group">
						  		<label class="col-sm-1 control-label">公司名:</label>
						  		<div class="col-sm-2">
						  			<input type="text"  id="CompanyName" name="CompanyName" class="form-control">
						  		</div>
						    	<label class="col-sm-1 control-label">地点:</label>
						    	<div class="col-sm-2">
						    		<input type="text"  id="address"  name="address" class="form-control">
						    	</div>
						    	<div class="col-sm-2">
						    		<button type="button" class="btn btn-default" onclick="searchCompany();" >搜索</button>
								</div>
						  	</div>
						</form> 
					</div>
					<h3>企业信息列表</h3>
					<div class="row" id="appendBody">
					
					
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