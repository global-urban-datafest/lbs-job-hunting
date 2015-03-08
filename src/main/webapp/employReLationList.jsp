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
<script type="text/javascript" src="<%=basePath%>js/messi.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/messi.css">
<head>
<title>投递信息管理</title>
<script type="text/javascript">
	function search(){
		var companyId=${sessionScope.loginUser.id}
		if(notEmpty(companyId)){
			var workplace = $("#workplace").val();
			var workyear = $("#workyear").val();
			var positionName = $("#positionName").val();    
			var hotflag =$('input[name="hotflag"]:checked').val();
			$("#hireInfoList").datagrid({
				url:'<%=basePath%>company_employReLationList.do',
				queryParams:{'id':companyId,'workplace':workplace,'workyear':workyear,'positionName':positionName,'hotflag':hotflag},
				pageNumber:1
		 	});
		}else{
			window.location.href="<%=basePath%>company_loginOut.do";
		}	
	}
	$(document).ready(function(){
		search();
	});
	function formatHotFlag(val,row){
		if(val==true){
			return "是";
		}else{
			return "否";
		}
	}
	function formatButton(val,row){
		if(val==3){
			return "<a class='btn btn-info btn-xs' onclick='deApplyJob("+row.hireinfoId+","+row.resumeId+")'>取消录取</a>";
		}else{
			return "<a class='btn btn-info btn-xs' onclick='applyJob("+row.hireinfoId+","+row.resumeId+")'>录取</a>";
		}
	}
	function deApplyJob(hireinfoId,resumeId){
		if(notEmpty(hireinfoId)&&notEmpty(resumeId)){
			$.post('<%=basePath%>company_deApplyJob.do',{'hireinfoId':hireinfoId,'resumeId':resumeId},function(data){
				if(data.success){
					alert('取消录取成功!');
				}else{
					alert(data.msg);
				}
			});
		}else{
			alert('获取该条投递信息失败!');
		}
		search();
	}
	function applyJob(hireinfoId,resumeId){
		if(notEmpty(hireinfoId)&&notEmpty(resumeId)){
			$.post('<%=basePath%>company_applyJob.do',{'hireinfoId':hireinfoId,'resumeId':resumeId},function(data){
				if(data.success){
					alert('录取成功!');
					$('#hireInfoList').datagrid('reload');
				}else{
					alert(data.msg);
				}
			});
		}else{
			alert('获取该条投递信息失败!');
		}
		search();
	}
	function formatResume(val,row){
			return "<a class='btn btn-info btn-xs' onclick='showResume("+row.resumeId+")'>查看简历</a>";
	}
	function showResume(resumeId){
		if(notEmpty(resumeId))
			 window.open("<%=basePath%>user_viewResume.do?id="+resumeId,'_blank');
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
						    ${requestScope.user.companyLogo}
						     <c:if test="${requestScope.company.companyLogo!=null&& '' ne requestScope.company.companyLogo}">
                                  <img src="<%=basePath%>images/logo/${requestScope.company.companyLogo}" id="userHeadImage" alt="公司Logo">
                              </c:if>
                              <c:if test="${requestScope.company.companyLogo==null || '' eq requestScope.company.companyLogo}">
                                    <img src="" id="userHeadImage" alt="公司Logo">
                              </c:if>
						      <div class="caption">
                                  <div class="highlight text-center">
                                        <pre>
								                                              用户名:${sessionScope.loginUser.cpy_loginName}<br>
								                                             上次登录时间:<fmt:formatDate value="${sessionScope.loginUser.lastLoginDate}" pattern="yyyy-MM-dd"/><br>
								                                              注册时间:<fmt:formatDate value="${sessionScope.loginUser.creationDate}" pattern="yyyy-MM-dd"/><br>
                                        </pre>
                                  </div>
						      </div>
						    </div>
						 </div>
            </div>
			<div class="col-md-9" role="main">
                <div class="page-header">
                    <h1>招聘列表</h1>
                </div>
                <div class="highlight">
	                <form class="form-horizontal" action="<%=basePath%>user_userCompanyList.do" id="searchform" role="form">
						<div class="form-group">
					    	<label class="col-sm-3 control-label">工作地点:</label>
					    	<div class="col-sm-2">
					    		<input type="text"  id="workplace"  name="workplace" class="form-control">
					    	</div>
					    	<label class="col-sm-3 control-label">是否为热门职位:</label>
					    	<div class="col-sm-2">
					    		是<input type="radio"  name="hotflag"  value="1" checked="checked">
					    		否<input type="radio"  name="hotflag"  value="0">
					    	</div>
						</div>
						<div class="form-group">
					  		<label class="col-sm-3 control-label">工作年限(应聘者):</label>
					  		<div class="col-sm-2">
			                     <select id="workyear" name="workyear" class="form-control">
			                           <option value="-1">请选择</option>
			                           <c:if test="${!empty sessionScope.workyears}">
			                                  <c:forEach var="c" items="${sessionScope.workyears}">
			                                        <option value="${c.id}">${c.tableDesc}</option>
			                                  </c:forEach>
			                           </c:if>
			                     </select>
					  		</div>
					  		<label class="col-sm-3 control-label">职位名称:</label>
					  		<div class="col-sm-2">
					  			<input type="text"  id="positionName" name="positionName" class="form-control">
					  		</div>
					  	</div>
						<div class="form-group">
					    	<div class="text-center">
					    		<button type="button" class="btn btn-default" onclick="search();" >搜索</button>
							</div>
						</div>
					</form>
				</div>
                <div class="bs-example">
						    <table  data-options="rownumbers:true,pagination:true,singleSelect:true,method:'post',height:450" id="hireInfoList">
							        <thead>
							            <tr>
							            	<th hidden="hidden" data-options="field:'companyId'"></th>
							            	<th hidden="hidden" data-options="field:'hireinfoId'"></th>
							                <th data-options="field:'positionName',width:100">职位名称</th>
							                <th data-options="field:'workplace',width:100,align:'right'">工作地点</th>
							                <th data-options="field:'hotflag',width:100,align:'center',formatter:formatHotFlag">热门职位</th>
							                <th data-options="field:'realname',width:100">应聘者姓名</th>
											<th data-options="field:'refdesc',width:100">工作年限</th>
							                <th data-options="field:'sendDate',width:80,align:'right'">应聘日期</th>
							                <th data-options="field:'resumeId',width:100,align:'center',formatter:formatResume">查看简历</th>
							                <th data-options="field:'viewFlag',width:100,align:'center',formatter:formatButton">操作</th>
							            </tr>
							        </thead>
							</table>  
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
		window.location.href="<%=basePath%>company_loginOut.do";
		</script>
</c:if>