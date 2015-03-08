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
<title>招聘信息列表</title>
<script type="text/javascript">
	function refreash(){
		$('#hireInfoList').datagrid('reload');
	}
	$(document).ready(function(){
		var companyId=${sessionScope.loginUser.id}
		if(notEmpty(companyId)){
			$("#hireInfoList").datagrid({
				url:'<%=basePath%>company_findHireInfoList.do',
				queryParams:{'company.id':companyId},
				pageNumber:1,
				onDblClickRow:function(rowIndex,rowData){
					var hireinfoId=0;
					hireinfoId=rowData.id;
					if(notEmpty(hireinfoId)){
						Messi.load("<%=basePath%>company_findHireInfoById.do?id="+hireinfoId,{height:'650px',width:'600px'});
						refreash();
					}else{
						alert('招聘信息的id不能为空!');
					}
				}
		 	});
		}else{
			window.location.href="<%=basePath%>company_loginOut.do";
		}
	});

	function enabledHireInfo(hireinfoId){
			if(notEmpty(hireinfoId)){
				$.post('<%=basePath%>company_enabledHireInfo.do',{'id':hireinfoId},function(data){
					if(data.success){
						alert('恢复招聘信息成功!');
						$('#hireInfoList').datagrid('reload');
					}else{
						alert(data.msg);
					}
				});
			}else{
				alert('招聘信息的id不能为空!');
			}
	}
	function disabledHireInfo(hireinfoId){
			if(notEmpty(hireinfoId)){
				$.post('<%=basePath%>company_disabledHireInfo.do',{'id':hireinfoId},function(data){
					if(data.success){
						alert('禁用招聘信息成功!');
						$('#hireInfoList').datagrid('reload');
					}else{
						alert(data.msg);
					}
				});
			}else{
				alert('招聘信息的id不能为空!');
			}
		$("#hireInfoList").datagrid('reload');
	}
	function deleteHireinfo(){
		var hireinfoId=0;
		var el=$('#hireInfoList').datagrid("getSelected");
		if(notEmpty(el)){
			hireinfoId=el.id;
			if(notEmpty(hireinfoId)){
				$.post('<%=basePath%>company_deleteHireinfo.do',{'id':hireinfoId},function(data){
					if(data.success){
						alert('删除招聘信息成功!');
						$('#hireInfoList').datagrid('reload');
					}else{
						alert(data.msg);
					}
				});
			}else{
				alert('招聘信息的id不能为空!');
			}
		}else{
			alert('你未选择任何招聘信息!');	
		}
	}
	function formatDate(val,row){
		if(val==true){
			return "<a href='#' class='btn btn-default btn-xs' onclick='enabledHireInfo("+row.id+")'>恢复职位</a>";
		}else{
			return "<a href='#' class='btn btn-default btn-xs' onclick='disabledHireInfo("+row.id+")'>取消职位</a>";
		}
	}
	function addHireInfo(){
		$('#addHireinfoForm').resetForm();
		$('#addmodal').modal('show');	
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
                <div class="bs-example">
	                <div class="alert alert-success alert-dismissable">
	                			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	                			友情提示:双击一行即可进行更新操作.
	                </div>
                	<div  id="toolbar">
						    <div style="padding:5px;">
						        <a href="#" class="easyui-linkbutton" data-options="iconCls:'glyphicon glyphicon-floppy-disk'" onclick="addHireInfo();">发布职位</a>
						        <a href="#" class="easyui-linkbutton" data-options="iconCls:'glyphicon glyphicon-trash'" onclick="deleteHireinfo()">删除职位</a>
						    </div>
					</div>
				    <table  data-options="rownumbers:true,pagination:true,singleSelect:true,method:'post',toolbar:'#toolbar',height:450" id="hireInfoList">
					        <thead>
					            <tr>
					            	<th hidden="hidden" data-options="field:'id'"></th>
					                <th data-options="field:'positionName',width:100">职位名称</th>
					                <th data-options="field:'hireDesc',width:180">职位描述</th>
									<th data-options="field:'jobpeopleNum',width:60">招聘人数</th>
					                <th data-options="field:'workplace',width:80,align:'right'">工作地点</th>
					                <th data-options="field:'salary',width:80,align:'right'"> 薪资</th>
					                <th data-options="field:'jobRequried',width:150">职位需求</th>
					                <th data-options="field:'disabledFlag',width:100,align:'center',formatter:formatDate"">职位过期</th>
					            </tr>
					        </thead>
					</table>  
				</div>
			</div>
		</div>
	</div>
			<div id="addmodal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
			      <div class="modal-dialog">
			        <div class="modal-content">
				          <div class="modal-header">
				            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				            <h4 class="modal-title" id="myModalLabel">添加招聘信息</h4>
				          </div>
				          <div class="modal-body">
				          		<script type="text/javascript">
				          			function cancel(){
				          				$('#addmodal').modal('hide');
				          			}
				          			function saveHireInfo(){
				          				$('#addHireinfoForm').ajaxSubmit(function(data){
				          					if(data.success){
				          						alert('保存简历信息成功!');
				        						$('#hireInfoList').datagrid('reload');
				        						$('#addmodal').modal('hide');
				          					}else{
				          						alert(data.msg);
				          					}
				          				});
				          			}
				          		</script>
								<div class="bs-example">
										<form class="form-horizontal" role="form" id="addHireinfoForm" action="<%=basePath%>company_saveHireInfo.do" method="post">
										  <div class="form-group">
										  	<input type="hidden" name="hr.company.id" id="hireinfoId" value="${sessionScope.loginUser.id}">
										    <label for="positionName" class="col-sm-2 control-label">职位名称</label>
										    <div class="col-sm-10">
										      <input type="text" class="form-control" id="positionName" name="hr.positionName" placeholder="职位名称">
										    </div>
										  </div>
										  <div class="form-group">
										    <label for="workplace" class="col-sm-2 control-label">工作地点</label>
										    <div class="col-sm-10">
										      <input type="text" class="form-control" id="workplace" name="hr.workplace" placeholder="工作地点">
										    </div>
										  </div>
										  <div class="form-group">
										    <label for="jobpeopleNum" class="col-sm-2 control-label">招聘人数</label>
										    <div class="col-sm-10">
										      <input type="text" class="form-control" id="jobpeopleNum" name="hr.jobpeopleNum" placeholder="招聘人数">
										    </div>
										  </div>
										  <div class="form-group">
										    <label for="worktype" class="col-sm-2 control-label">工作年限</label>
										    <div class="col-sm-10">
			                                      <select id="workyear" name="hr.workyear" class="form-control">
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
										    <label for="worktype" class="col-sm-2 control-label">工作类型</label>
										    <div class="col-sm-10">
										      <select class="form-control" id="worktype" name="hr.worktype">
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
										    <label for="salary" class="col-sm-2 control-label">薪资待遇</label>
										    <div class="col-sm-10">
										      <input type="text" class="form-control" id="salary" name="hr.salary" placeholder="薪资待遇">
										    </div>
										  </div>
										  <div class="form-group">
										    <label for="hireDesc" class="col-sm-2 control-label">职位描述</label>
										    <div class="col-sm-10">
										      <textarea rows="5" cols="60" id="hireDesc" name="hr.hireDesc"></textarea>
										    </div>
										  </div>
										  <div class="form-group">
										    <label for="jobRequried" class="col-sm-2 control-label">职位需求</label>
										    <div class="col-sm-10">
										      <textarea rows="5" cols="60" id="jobRequried" name="hr.jobRequried"></textarea>
										    </div>
										  </div>
										  <div class="form-group">
										    <label for="jobTreatment" class="col-sm-2 control-label">职位待遇</label>
										    <div class="col-sm-10">
										      <textarea rows="5" cols="60" id="jobTreatment" name="hr.jobTreatment"></textarea>
										    </div>
										  </div>
										</form>
									</div>
				          </div>
				          <div class="modal-footer">
				            <button class="btn btn-info" onclick="cancel()">取消</button>
				          	<button class="btn btn-info" onclick="saveHireInfo();">保存</button>
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