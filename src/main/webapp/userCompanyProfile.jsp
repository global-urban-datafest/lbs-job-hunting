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
function formatFlag(val,row){
	if(val==true){
		return "是";
	}else{
		return "否";
	}
}
</script>
<title>简历详情</title>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
		<div class="container">
			<div class="row">
				<div class="col-md-12" role="main">
					<h3>企业信息</h3>
					<div class="bs-example ">
                           <table class="table table-striped">
                           		<tr>
                                	<td>公司名称:</td>
                                	<td>${requestScope.company.companyName}</td>
                                	<td>公司规模:</td>
                                	<td>
											<c:if test="${!empty sessionScope.companysizes}">
			                                      <c:forEach var="c" items="${sessionScope.companysizes}">
			                                      		<c:if test="${c.id eq requestScope.company.companySize}">
			                                               ${c.tableDesc}
			                                            </c:if>
			                                      </c:forEach>
			                                </c:if>
			                        </td>
                                	<td>公司性质:</td>
                                	<td>
											<c:if test="${!empty sessionScope.companytypes}">
			                                      <c:forEach var="c" items="${sessionScope.companytypes}">
			                                      		<c:if test="${c.id eq requestScope.company.companyType}">
			                                               ${c.tableDesc}
			                                            </c:if>
			                                      </c:forEach>
			                                </c:if>
									</td>
                                </tr>
                                <tr>
                                	<td>法人代表:</td>
									<td>${requestScope.company.legalPerson}</td>
									<td>公司网址:</td>
									<td>${requestScope.company.companyURL}</td>
									<td>公司电话:</td>
									<td>${requestScope.company.companyTel}</td>
                                </tr>
                                <tr>
                                	<td>公司email:</td>
									<td>${requestScope.company.companyEmail}</td>
									<td>公司地址:</td>
									<td colspan="3">${requestScope.company.companyAddress}</td>
                                </tr>
                                <tr>
                                	<td>公司描述:</td>
									<td colspan="5">${requestScope.company.companyDesc}</td>
                                </tr> 
                           </table>
					</div>
				</div>
				<div class="col-md-9" role="main">
					<h3>企业旗下招聘信息</h3>
					<div class="bs-example">
						<c:if test="${empty requestScope.HireInfolist}">
							对不起，该企业下么有任何招聘信息
						</c:if>
						<c:if test="${!empty requestScope.HireInfolist}">
							<c:forEach var="hireinfo" items="${requestScope.HireInfolist}" varStatus="status">
								<div class="panel-group" id="accordion">
									<div class="panel-heading">
							            <h4 class="panel-title">
							              <a data-toggle="collapse" data-parent="#accordion" href="#collapse${status.index}">
							                ${hireinfo.positionName}
							              </a>
							            </h4>
							        </div>
									<div id="collapse${status.index}" class="panel-collapse collapse in">
							            <div class="panel-body">
											<table class="table">
											    <tr>
											    	<td>工作地点:</td>
											    		<td>${hireinfo.workplace}</td>
											    	<td>招聘人数:</td>
											    		<td>${hireinfo.jobpeopleNum}</td>
											    	<td>工作类型:</td>
											    		<td>
															<c:if test="${!empty sessionScope.worktypes}">
							                                      <c:forEach var="c" items="${sessionScope.worktypes}">
							                                      		<c:if test="${c.id eq hireinfo.positionName}">
							                                               ${c.tableDesc}
							                                            </c:if>
							                                      </c:forEach>
							                                </c:if>    		
											    		</td>
											    </tr>
										  </table>
										 <h5>职位描述</h5>
										 <div class="bs-callout bs-callout-warning">
										 	${hireinfo.hireDesc}
										 </div>
										 <h5>职位需求</h5>
										 <div class="bs-callout bs-callout-warning">
										 	${hireinfo.jobRequried}
										 </div>
										 <h5>职位待遇</h5>
										 <div class="bs-callout bs-callout-warning">
										 	${hireinfo.jobTreatment}
										 </div>
							            </div>
							            <div class="text-center" style="margin-top:5px;">
							         		<a class="btn btn-info" onclick="sendResume(${hireinfo.id},this);">应聘该职位</a>
							        	</div>
							         </div>
								</div>
							</c:forEach>
						</c:if>
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