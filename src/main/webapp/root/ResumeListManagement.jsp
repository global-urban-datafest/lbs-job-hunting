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
<c:if test="${!empty sessionScope.loginUser}"> 
<html lang="zh-cn">
<jsp:include page="/common.jsp" />
<head>
<title>应聘须知</title>
<link rel="stylesheet" type="text/css" href="<%=basePath%>easyui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>easyui/themes/icon.css">
<script type="text/javascript" src="<%=basePath%>easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
<script type="text/javascript" src="<%=basePath%>js/popwin.js"></script>
<script type="text/javascript" src="<%=basePath%>js/messi.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>css/messi.css">
<script type="text/javascript">
$(document).ready(function(){
	$("#resumeList").datagrid({
		url:'<%=basePath%>root/rootUser_findAllResume.do',
		pageNumber:1
 	});
	$('#updateUser').on('hidden.bs.modal', function (e) {
		$("#resumeList").datagrid("reload");
	});
});
function formatFlag(val ,row){
	if(val==true)
		return "是";
	else
		return "否";
}
function formatDefaultFlag(val ,row){
	if(val==true)
		return "<button class='btn btn-info btn-xs' onclick='unSetDefautResume("+row.resumeId+")'>取消默认</button>";
	else
		return "<button class='btn btn-info btn-xs' onclick='setDefautResume("+row.resumeId+","+row.userId+")'>设置为默认</button>";
}
function setDefautResume(resumeId,userId){
	if(notEmpty(userId)){
  		 if(notEmpty(resumeId)){
			 $.post('<%=basePath%>root/rootUser_setDefautResume.do',{'id':resumeId,'user.id':userId},function(data){
				 if(data.success){
					 alert('设置为默认成功!');
					 $("#resumeList").datagrid("reload");
				 }else{
					 alert(data.msg);
				 }
			 });
		 }else{
			 alert('未选择任何resume.');
		 }
	}else{
		alert('该条简历的用户信息不能为空');
	}

}
function unSetDefautResume(resumeId){
 	if(notEmpty(resumeId)){
	 $.post('<%=basePath%>root/rootUser_unSetDefautResume.do',{'id':resumeId},function(data){
		 if(data.success){
			 alert('取消设置为默认成功!');
			 $("#resumeList").datagrid("reload");
		 }else{
			 alert(data.msg);
		 }
	 });
	 }else{
		 alert('未选择任何resume.');
	 }
}
function updateResumeForward(){
	$('#updateUser').modal();
}

function updateResume(){
	
}
</script>
</head>
<body style="background: none;">
	<div class="container" style="background: none;">
		<div class="row">
			<div class="col-md-12" role="main">
					<div class="page-header">
					  <h1>企业列表</h1>
					</div>
                	<div  id="toolbar">
						    <div style="padding:5px;">
						        <a href="#" class="easyui-linkbutton" data-options="iconCls:'glyphicon glyphicon-floppy-disk'" onclick="updateResumeForward();">更新简历</a>
						        <a href="#" class="easyui-linkbutton" data-options="iconCls:'glyphicon glyphicon-trash'" onclick="deleteCompany()">删除简历</a>
						    </div>
					</div>
                    <table  data-options="rownumbers:true,pagination:true,singleSelect:true,method:'post',toolbar:'#toolbar',height:450" id="resumeList">
					        <thead>
					            <tr>
						          <th data-options="field:'resumeId',width:20,align:'right'" hidden="hidden">;
						          <th data-options="field:'userId',width:20,align:'right'" hidden="hidden">;
						          <th data-options="field:'resumeDetailId',width:20,align:'right'" hidden="hidden">;
								  <th data-options="field:'userName',width:100,align:'right'">用户名</th>
								  <th data-options="field:'name',width:100,align:'right'">简历名</th>
								  <th data-options="field:'compeletepercent',width:100,align:'right'">简历完成百分比</th>
								  <th data-options="field:'creationdate',width:100,align:'right'">简历创建日期</th>
								  <th data-options="field:'public_flag',width:90,align:'right',formatter:formatFlag">简历是否公开</th>
								  <th data-options="field:'defaultResumeFlag',width:100,align:'right',formatter:formatDefaultFlag">是否设为默认</th>
					            </tr>
					        </thead>
					</table>      
			</div>
		</div>
		<div class="row">
			<div id="updateUser" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
			  <div class="modal-dialog">
			    <div class="modal-content">
			       <div class="modal-header">
			         <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			         <h4 class="modal-title" id="myModalLabel">更新简历信息</h4>
			       </div>
			       <div class="modal-body">
                           	<form action="<%=basePath%>root/rootUser_addResume.do" id="resumeGen" name="resumeGen" method="post">
			                                        <table class="table table-bordered">
			                                        	<tr>
			                                        		<td>
			                                        			简历名称
															</td>
															<td>
																<input type='text' id='resumeName' name='resume.name'>
															</td>
															<td>是否公开</td>
															<td>
																<select id='public_flag' name='resume.public_flag'>
																	<option value='1'>是</option>
																	<option value='0'>否</option>
																</select>
															</td>
														</tr>
														<tr>
															<td>用户名</td>
															<td colspan="3">
																<input id="cc" class="easyui-combogrid" name="dept" data-options="rownumbers:true,pagination:true,singleSelect:true">
																<input type="hidden" name="user.id"  id="userId">
															</td>
			                                        	</tr>
			                                            <tr>
			                                                <td width="12%">真实名</td>
			                                                     <td>
			                                                            <input type="text" id="realname" name="resumeDetail.realname" >
			                                                     </td>
			                                                	 <td>性别</td>
			                                                     <td>
			                                                         <select id="sex" name="resumeDetail.sex">
			                                                             <option value="-1">请选择</option>
			                                                             <c:if test="${!empty sessionScope.sexs}">
			                                                                 <c:forEach var="c" items="${sessionScope.sexs}">
			                                                                     <option value="${c.id}">${c.tableDesc}</option>
			                                                                 </c:forEach>
			                                                             </c:if>
			                                                         </select>
			                                                     </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">出生日期</td>
			                                                <td>
																	<div class="input-append date" data-date="01/01/1900" data-date-format="mm/dd/yyyy">
																		<input style="height: 30px;" id="birthday" size="16" type="text"  placeholder="生日" name="resumeDetail.birthday">
																	</div>
			                                                </td>
			                                                <td>工作年限</td>
			                                                <td>
			                                                   <select id="workyear" name="resumeDetail.workyear">
			                                                         <option value="-1">请选择</option>
			                                                         <c:if test="${!empty sessionScope.workyears}">
			                                                                <c:forEach var="c" items="${sessionScope.workyears}">
			                                                                      <option value="${c.id}">${c.tableDesc}</option>
			                                                                </c:forEach>
			                                                         </c:if>
			                                                   </select>
			                                                </td>
			                                            </tr>
			                                                                             
			                                            
			                                            <tr>
			                                            	<td width="12%">证件类型</td>
			                                                <td>
			                                                    <select id="documenttype" name="resumeDetail.documenttype">
			                                                         <option value="-1">请选择</option>
			                                                         <c:if test="${!empty sessionScope.documenttypes}">
			                                                             <c:forEach var="c" items="${sessionScope.documenttypes}">
			                                                                 <option value="${c.id}">${c.tableDesc}</option>
			                                                             </c:forEach>
			                                                         </c:if>
			                                                    </select>
			                                                </td>
			                                                <td>证件号码</td>
			                                                <td>
			                                                    <input type="text" id="documentcode" name="resumeDetail.documentcode">
			                                                </td>
			                                            </tr>
			                                            
			                                            <tr>
			                                                <td width="12%">QQ</td>
			                                                <td>
			                                                        <input type="text" id="qq" name="resumeDetail.qq">
			                                                </td>
			                                                <td>Email</td>
			                                                <td>
			                                                        <input type="text" id="email" name="resumeDetail.email" >
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td>微信</td>
			                                                <td >
			                                                    <input type="text" id="wechat" name="resumeDetail.wechat">
			                                                </td>
			                                                <td>手机号码</td>
			                                                <td>
			                                                    <input type="text" id="mobile" name="resumeDetail.mobile" >
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">家庭电话</td>
			                                                <td>
			                                                    <input type="text" id="hometel" name="resumeDetail.hometel">
			                                                </td>
			                                                <td>公司电话</td>
			                                                <td>
			                                                    <input type="text" id="companytel" name="resumeDetail.companytel">
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">求职状态</td>
			                                                <td>
			                                                    <select id="jobstatus" name="resumeDetail.jobstatus" >
			                                                        <option value="-1">请选择</option>
			                                                        <c:if test="${!empty sessionScope.jobstatuses}">
			                                                            <c:forEach var="c" items="${sessionScope.jobstatuses}">
			                                                                <option value="${c.id}">${c.tableDesc}</option>
			                                                            </c:forEach>
			                                                        </c:if>
			                                                    </select>
			                                                </td>
			                                                <td>政治面貌</td>
			                                                <td>
			                                                    <select id="politicstatus" name="resumeDetail.politicstatus">
			                                                        <option value="-1">请选择</option>
			                                                        <c:if test="${!empty sessionScope.polictictypes}">
			                                                            <c:forEach var="c" items="${sessionScope.polictictypes}">
			                                                                <option value="${c.id}">${c.tableDesc}</option>
			                                                            </c:forEach>
			                                                        </c:if>
			                                                    </select>
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">婚姻状态</td>
			                                                <td>
			                                                    <select  id="marriagestatus" name="resumeDetail.marriagestatus">
			                                                        <option value="-1">请选择</option>
			                                                        <c:if test="${!empty sessionScope.marriagestatuses}">
			                                                            <c:forEach var="c" items="${sessionScope.marriagestatuses}">
			                                                                <option value="${c.id}">${c.tableDesc}</option>
			                                                            </c:forEach>
			                                                        </c:if>
			                                                    </select>
			                                                </td>
			                                                <td>邮编</td>
			                                                <td>
			                                                    <input type="text" id="zip" name="resumeDetail.zip">
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">目前年薪</td>
			                                                <td>
			                                                    <select id="salary" name="resumeDetail.salary">
			                                                        <option value="-1">请选择</option>
			                                                        <c:if test="${!empty sessionScope.salarys}">
			                                                            <c:forEach var="c" items="${sessionScope.salarys}">
			                                                                <option value="${c.id}">${c.tableDesc}</option>
			                                                            </c:forEach>
			                                                        </c:if>
			                                                    </select>
			                                                </td>
			                                                <td >身高</td>
			                                                <td>
			                                                    <input type="text" name="resumeDetail.height" id="height">厘米
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td>家庭地址</td>
			                                                <td colspan="4">
			                                                    <textarea id="hometown" name="resumeDetail.hometown" ></textarea>
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                            	<td>期望工作类型</td>
			                                            	<td>
			                                            		<select name="resumeDetail.worktype" id="worktype">
			                                                        <option value="-1">请选择</option>
			                                                        <c:if test="${!empty sessionScope.worktypes}">
			                                                            <c:forEach var="c" items="${sessionScope.worktypes}">
			                                                                <option value="${c.id}">${c.tableDesc}</option>
			                                                            </c:forEach>
			                                                        </c:if>
			                                            		</select>
			                                            	</td>
			                                            	<td>期望工作地点</td><td colspan="2">
			                                            		<textarea name="resumeDetail.workspace" id="workspace"></textarea>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>现居地</td>
			                                            	<td colspan="3">
			                                            			<textarea name="resumeDetail.livingaddress" id="livingaddress"></textarea> 
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>期望职业角色</td>
			                                            	<td>
			                                            		<select name="resumeDetail.positiontype" id="positiontype">
			                                                        <option value="-1">请选择</option>
			                                                        <c:if test="${!empty sessionScope.positiontypes}">
			                                                            <c:forEach var="c" items="${sessionScope.positiontypes}">
			                                                                <option value="${c.id}">${c.tableDesc}</option>
			                                                            </c:forEach>
			                                                        </c:if>
			                                            		</select>
			                                            	</td>
			                                            	<td>期望薪水</td>
			                                            	<td>
			                                            			<input type="text" name="resumeDetail.exceptsalary" id="exceptsalary"> 
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>自我介绍</td>
			                                            	<td>
			                                            		<textarea name="resumeDetail.selfIntrodution" id="selfIntrodution"></textarea>
			                                            	</td>
			                                            	<td>就职日期</td>
			                                            	<td>
			                                            		<input type="text" name="resumeDetail.onboardingdate" id="onboardingdate">
			                                            	</td>
			                                            </tr>
			                                            
			                                            <tr>
			                                            	<td>技能介绍</td>
			                                            	<td colspan="3">
			                                            		<textarea style="width:70%;heigth:30px;" name="resumeDetail.skills" id="skills"></textarea>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>工作经历介绍</td>
			                                            	<td colspan="3">
			                                            		<textarea style="width:70%;heigth:30px;" name="resumeDetail.companys" id="companys"></textarea>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>项目经验介绍</td>
			                                            	<td colspan="3">
			                                            		<textarea style="width:70%;heigth:30px;" name="resumeDetail.awards" id="awards"></textarea>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>奖惩介绍</td>
			                                            	<td colspan="3">
			                                            		<textarea style="width:70%;heigth:30px;" name="resumeDetail.experiences" id="experiences"></textarea>
			                                            	</td>
			                                            </tr>
			                                        </table>
		                                        </form>
						<div class="highlight text-center">
							<pre>
							     <button type="button" class="btn btn-default" onclick="updateUser()">更新简历信息</button>
	                            <span id="Tip" style="display: none"></span>
							</pre>
						</div>
						<span id="Tip" style="display: none"></span>
			 		</div>
			       <div class="modal-footer">
			         <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			       </div>
			    </div>
			  </div>
			 </div>
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