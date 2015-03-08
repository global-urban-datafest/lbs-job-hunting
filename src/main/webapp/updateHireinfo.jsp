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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(document).ready(function(){
		$("#updateworkyear").val(${requestScope.hireinfo.workyear});
		$("#updateworktype").val(${requestScope.hireinfo.worktype});
	});
	function updateHireInfo(){
		var id=$('#hireinfoId').val();
		if(notEmpty(id)){
				$('#updateHireForm').ajaxSubmit(function(data){
					if(data.success){
						alert('更新招聘信息成功，请关闭本窗口');
					}else{
						alert(data.msg);
					}
  				});
		}else{
			alert('招聘信息的id不能为空');
		}
	}
</script>
</head>
<body>
	<div style="height:20px;"></div>
	<form class="form-horizontal col-md-9" role="form" id="updateHireForm" action="<%=basePath%>company_updateHireInfo.do" method="post">
	  <div class="form-group">
	  	<input type="hidden" name="hr.company.id" id="updatehireinfoId" value="${sessionScope.loginUser.id}">
	    <label for="positionName" class="col-sm-3 control-label">职位名称</label>
	    <div class="col-sm-6">
	      <input type="text" class="form-control" id="updatepositionName" name="hr.positionName" placeholder="职位名称" value="${requestScope.hireinfo.positionName}">
	      <input type="hidden" name="hr.id" id="hireinfoId" value="${requestScope.hireinfo.id}">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="workplace" class="col-sm-3 control-label">工作地点</label>
	    <div class="col-sm-6">
	      <input type="text" class="form-control" id="updateworkplace" name="hr.workplace" placeholder="工作地点" value="${requestScope.hireinfo.workplace}">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="jobpeopleNum" class="col-sm-3 control-label">招聘人数</label>
	    <div class="col-sm-6"> 
	      <input type="text" class="form-control" id="updatejobpeopleNum" name="hr.jobpeopleNum" placeholder="招聘人数" value="${requestScope.hireinfo.jobpeopleNum}">
	    </div>
	  </div>
	  <div class="form-group">
		<label for="worktype" class="col-sm-3 control-label">工作年限</label>
		<div class="col-sm-6">
			 <select id="updateworkyear" name="hr.workyear" class="form-control">
			       <option value="-1">请选择</option>
			       <c:if test="${!empty sessionScope.workyears}">
			             <c:forEach var="c" items="${sessionScope.workyears}">
			                      <option value="${c.id}">${c.tableDesc}</option>
			       </c:forEach>
			 </c:if>
			 </select>
		</div>
	  </div>
	  <div class="form-group">
	    <label for="worktype" class="col-sm-3 control-label">工作类型</label>
	    <div class="col-sm-6">
	      <select class="form-control" id="updateworktype" name="hr.worktype">
                         <option value="-1">请选择</option>
                         <c:if test="${!empty sessionScope.worktypes}">
                            <c:forEach var="c" items="${sessionScope.worktypes}">
                                <option value="${c.id}">${c.tableDesc}</option>
                            </c:forEach>
                         </c:if>
	      </select>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="salary" class="col-sm-3 control-label">薪资待遇</label>
	    <div class="col-sm-6">
	      <input type="text" class="form-control" id="updatesalary" name="hr.salary" placeholder="薪资待遇" value="${requestScope.hireinfo.salary}">
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="hireDesc" class="col-sm-3 control-label">职位描述</label>
	    <div class="col-sm-6">
	      <textarea rows="2" cols="60" id="updatehireDesc" name="hr.hireDesc">${requestScope.hireinfo.hireDesc}</textarea>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="jobRequried" class="col-sm-3 control-label">职位需求</label>
	    <div class="col-sm-6">
	      <textarea rows="2" cols="60" id="updatejobRequried" name="hr.jobRequried">${requestScope.hireinfo.jobRequried}</textarea>
	    </div>
	  </div>
	  <div class="form-group">
	    <label for="jobTreatment" class="col-sm-3 control-label">职位待遇</label>
	    <div class="col-sm-6">
	      <textarea rows="2" cols="60" id="updatejobTreatment" name="hr.jobTreatment">${requestScope.hireinfo.jobTreatment}</textarea>
	    </div>
	  </div>
	  <div class=" text-center">
		      <a href="#" class="btn btn-info" onclick="updateHireInfo();">更新招聘信息</a>
	  </div>
	</form>
</body>
</html>
</c:if>
<c:if test="${empty sessionScope.loginUser}">
		<script type="text/javascript">
		window.location.href="<%=basePath%>company_loginOut.do";
		</script>
</c:if>