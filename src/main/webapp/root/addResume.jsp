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
<title>添加简历</title>
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
	$('#cc').combogrid({
	    delay: 500,
	    panelWidth:300,
	    mode: 'remote',
	    url: '<%=basePath%>root/rootUser_findAllUser.do',
	    idField: 'id',
	    textField: 'name',
	    columns: [[
	        {field:'id',title:'id',width:20,hidden:'hidden'},
	        {field:'name',title:'登录名',width:120},
	        {field:'registeremail',title:'注册Email',width:150}
	    ]],		
	    onChange:function(rowIndex, rowData){
	    	getSingleSelectRow();
	     }
	});
	$('#birthday').click(function(){
		$('#birthday').datepicker().on('changeDate', function(ev) {
				$(this).datepicker('hide');
		});
	});
});
function getSingleSelectRow() { 
	var g = $('#cc').combogrid('grid');
	var r = g.datagrid('getSelected');
	if(r==null){
		$('#userId').val('');
		
	}else{
		$('#userId').val(r.id);
	}
}
function formatFlag(val ,row){
	if(val==true)
		return "是";
	else
		return "否";
}

function addResume(){
	var userId=$('#userId').val();
	if(notEmpty(userId)){
		$('#resumeGen').ajaxSubmit(function(data){
			if(data.success){
				alert('添加简历成功，请关闭本窗口');
			}else{
				alert(data.msg);
			}
			});
	}else{
		alert('你为选择任何用户，请先选择');
	}
}
</script>
</head>
<body style="background: none">
	<div class="container">
		<div class="row">
			<div class="col-md-12" role="main">
					<div class="page-header">
					  <h1>增加简历</h1>
					</div>   
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
															<td colspan="2">
																<select id='public_flag' name='resume.public_flag'>
																	<option value='1'>是</option>
																	<option value='0'>否</option>
																</select>
															</td>
														</tr>
														<tr>
															<td>用户名</td>
															<td colspan="4">
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
			                                                     <td rowspan="4" width="20%">
			                                                         	 <input type="hidden" id="photo" name="resumeDetail.photo">
			                                                             <img src="/images/photo/#"  id="userHeadImage" alt="简历照片"  data-toggle="modal" data-target="#myModal">
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
			                                                <td colspan="2">
			                                                    <input type="text" id="mobile" name="resumeDetail.mobile" >
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">家庭电话</td>
			                                                <td>
			                                                    <input type="text" id="hometel" name="resumeDetail.hometel">
			                                                </td>
			                                                <td>公司电话</td>
			                                                <td colspan="2">
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
			                                                <td colspan="2">
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
			                                                <td colspan="2">
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
			                                                <td  colspan="2">
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
			                                            	<td colspan="4">
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
			                                            	<td colspan="2">
			                                            			<input type="text" name="resumeDetail.exceptsalary" id="exceptsalary"> 
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>自我介绍</td>
			                                            	<td>
			                                            		<textarea name="resumeDetail.selfIntrodution" id="selfIntrodution"></textarea>
			                                            	</td>
			                                            	<td>就职日期</td>
			                                            	<td colspan="2">
			                                            		<input type="text" name="resumeDetail.onboardingdate" id="onboardingdate">
			                                            	</td>
			                                            </tr>
			                                            
			                                            <tr>
			                                            	<td>技能介绍</td>
			                                            	<td colspan="4">
			                                            		<textarea style="width:70%;heigth:30px;" name="resumeDetail.skills" id="skills"></textarea>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>工作经历介绍</td>
			                                            	<td colspan="4">
			                                            		<textarea style="width:70%;heigth:30px;" name="resumeDetail.companys" id="companys"></textarea>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>项目经验介绍</td>
			                                            	<td colspan="4">
			                                            		<textarea style="width:70%;heigth:30px;" name="resumeDetail.awards" id="awards"></textarea>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>奖惩介绍</td>
			                                            	<td colspan="4">
			                                            		<textarea style="width:70%;heigth:30px;" name="resumeDetail.experiences" id="experiences"></textarea>
			                                            	</td>
			                                            </tr>
			                                        </table>
		                                        </form>
		                                        <div class="text-center">
		                                        	<button class="btn btn-default" onclick="addResume()">添加简历</button>
		                                        </div>
			</div>
		</div>
			<div class="row">
				<div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
			      <div class="modal-dialog">
			        <div class="modal-content">
				          <div class="modal-header">
				            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				            <h4 class="modal-title" id="myModalLabel">照片上传</h4>
				          </div>
				          <div class="modal-body">
								<script type="text/javascript">
								function onUploadImgChange(fileInput) {
									var flag=false;
									var filePath = fileInput.value;
									var fileExt = filePath.substring(filePath.lastIndexOf("."))
											.toLowerCase();
					
									if (checkFileExt(fileExt))
									{
										flag=true;
									}else
									{
										alert("您上传的文件不是图片,请重新上传！");
										flag=false;
									}
									if(flag){
										uploadUserImage();
									}
								}
								function checkFileExt(ext)
					
								{
									if (!ext.match(/.jpg|.gif|.png|.bmp/i)) {
										return false;
									}
									return true;
								}
								function uploadUserImage(){
											var options = {
												target:'#Tip', //后台将把传递过来的值赋给该元素
												type:'POST',
												success: function(){
													filename=$('#Tip').text();
													//filename=str.substr(2,str.length-2);
													$('#userHeadImage').attr('src','<%=basePath%>images/photo/'+filename);
													$('#photo').val(filename);
													alert('照片上传成功！');
													$('#myModal').modal('hide');
												} //显示操作提示
											};
											$('#imgupdateform').ajaxSubmit(options);
											return false; //为了不刷新页面,返回false，反正都已经在后台执行完了，没事！
								}
								</script>
				            	<h4>上传照片</h4>
								    <form class="form-horizontal" action="<%=basePath%>uploadAction_userPhotoUpload.do" method="post" enctype="multipart/form-data"  id="imgupdateform">
										<input type="file" name="myFile" id="myFile" class="form-control"   onchange="onUploadImgChange(this);">
									</form>
									<span id="Tip" style="display: none"></span>
						  </div>
				          <div class="modal-footer">
				            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				          </div>
			        </div><!-- /.modal-content -->
			      </div><!-- /.modal-dialog -->
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