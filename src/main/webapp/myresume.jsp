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
<title>简历详情</title>
<script type="text/javascript">
	$(document).ready(function(){
			$('#myDatepicker').click(function(){
				$('#myDatepicker').datepicker().on('changeDate', function(ev) {
						$(this).datepicker('hide');
			});
		});
        $("#resdetailSex").val(${requestScope.resume.resumeDetail.sex});
        $("#resdetailWorkyear").val(${requestScope.resume.resumeDetail.workyear});
        $("#resdetailDocumenttype").val(${requestScope.resume.resumeDetail.documenttype});
        $("#resdetailJobstatus").val(${requestScope.resume.resumeDetail.jobstatus});
        $("#resdetailPoliticstatus").val(${requestScope.resume.resumeDetail.politicstatus});
        $("#resdetailMarriagestatus").val(${requestScope.resume.resumeDetail.marriagestatus});
        $("#resdetailSalary").val(${requestScope.resume.resumeDetail.salary});
        $("#resdetailworktype").val(${requestScope.resume.resumeDetail.worktype});
        $("#resdetailpositiontype").val(${requestScope.resume.resumeDetail.positiontype});
	});
	function updateResume(){
		$('#resumeGen').ajaxSubmit(function(data){
			if(data.data.success){
				alert('更新简历信息成功!')
			}else{
				alert(data.data.msg);
			}
		});
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp" flush="true" />
	<c:if test="${!empty requestScope.resume.resumeDetail}">
		<div class="container">
			<div class="row">
				<div class="col-md-12" role="main">
					<div class="bs-docs-section">
							<div class="page-header">
									<h1 id="glyphicons">简历详情</h1>
							</div>
		                    <div class="panel-group" id="resume_person">
		                            <div class="panel panel-default">
		                                <div class="panel-heading">
		                                    <h4 class="panel-title">
		                                        <a data-toggle="collapse" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
		                                        &nbsp;
		                                        </a>
		                                    </h4>
		                                </div>
		                                <div id="collapseOne" class="panel-collapse collapse in">
		                                    <div class="panel-body">
		                                    	<form action="<%=basePath%>user_updateResumeDetail.do" id="resumeGen" name="resumeGen" method="post">
			                                        <table class="table table-bordered">
			                                            <tr>
			                                                <td width="12%">真实名</td>
			                                                     <td>
			                                                            <input type="text" value="${requestScope.resume.resumeDetail.realname}" id="resdetailName" name="resumeDetail.realname" >
			                                                     </td>
			                                                	 <td>性别</td>
			                                                     <td>
			                                                         <select id="resdetailSex" name="resumeDetail.sex">
			                                                             <option value="-1">请选择</option>
			                                                             <c:if test="${!empty sessionScope.sexs}">
			                                                                 <c:forEach var="c" items="${sessionScope.sexs}">
			                                                                     <option value="${c.id}">${c.tableDesc}</option>
			                                                                 </c:forEach>
			                                                             </c:if>
			                                                         </select>
			                                                     </td>
			                                                     <td rowspan="4" width="20%">
			                                                         <c:if test="${!empty requestScope.resume.resumeDetail.photo}">
			                                                         	 <input type="hidden" id="photopath" name="resumeDetail.photo" value="${requestScope.resume.resumeDetail.photo}">
			                                                             <img src="/images/photo/${requestScope.resume.resumeDetail.photo}"  id="userHeadImage" alt="简历照片"  data-toggle="modal" data-target="#myModal">
			                                                         </c:if>
			                                                         <c:if test="${empty requestScope.resume.resumeDetail.photo}">
			                                                         	 <input type="hidden" id="photopath" name="resumeDetail.photo" value="">
			                                                             <img src="" id="userHeadImage" alt="简历照片"  data-toggle="modal" data-target="#myModal">
			                                                         </c:if>
			                                                     </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">出生日期</td>
			                                                <td>
																	<div class="input-append date" data-date="01/01/1900" data-date-format="mm/dd/yyyy">
																		<input style="height: 30px;" id="myDatepicker" size="16" type="text"  placeholder="生日" name="resumeDetail.birthday"  value="<fmt:formatDate value='${requestScope.resume.resumeDetail.birthday}' pattern='MM/dd/yyyy'/>">
																	</div>
			                                                </td>
			                                                <td>工作年限</td>
			                                                <td>
			                                                   <select id="resdetailWorkyear" name="resumeDetail.workyear">
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
			                                                    <select id="resdetailDocumenttype" name="resumeDetail.documenttype">
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
			                                                    <input type="text" id="resdetailDocumentcode" name="resumeDetail.documentcode" value="${requestScope.resume.resumeDetail.documentcode}">
			                                                </td>
			                                            </tr>
			                                            
			                                            <tr>
			                                                <td width="12%">QQ</td>
			                                                <td>
			                                                        <input type="text" id="resdetailQq" name="resumeDetail.qq"  value="${requestScope.resume.resumeDetail.qq}" check-type="number">
			                                                </td>
			                                                <td>Email</td>
			                                                <td>
			                                                        <input type="text" id="resdetailEmail" name="resumeDetail.email"  value="${requestScope.resume.resumeDetail.email}">
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td>微信</td>
			                                                <td >
			                                                    <input type="text" id="resdetailWechat" name="resumeDetail.wechat"  value="${requestScope.resume.resumeDetail.wechat}">
			                                                </td>
			                                                <td>手机号码</td>
			                                                <td colspan="2">
			                                                    <input type="text" id="resdetailMobile" name="resumeDetail.mobile"  value="${requestScope.resume.resumeDetail.mobile}">
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">家庭电话</td>
			                                                <td>
			                                                    <input type="text" id="resdetailHomtel" name="resumeDetail.hometel"  value="${requestScope.resume.resumeDetail.hometel}">
			                                                </td>
			                                                <td>公司电话</td>
			                                                <td colspan="2">
			                                                    <input type="text" id="resdetailComtel" name="resumeDetail.companytel"  value="${requestScope.resume.resumeDetail.companytel}">
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">求职状态</td>
			                                                <td>
			                                                    <select id="resdetailJobstatus" name="resumeDetail.jobstatus" >
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
			                                                    <select id="resdetailPoliticstatus" name="resumeDetail.politicstatus">
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
			                                                    <select  id="resdetailMarriagestatus" name="resumeDetail.marriagestatus">
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
			                                                    <input type="text" id="resdetailZip" name="resumeDetail.zip" value="${requestScope.resume.resumeDetail.zip}">
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">目前年薪</td>
			                                                <td>
			                                                    <select id="resdetailSalary" name="resumeDetail.salary">
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
			                                                    <input type="text" name="resumeDetail.height" id="resdetailHeight" value="${requestScope.resume.resumeDetail.height}">厘米
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td>家庭地址</td>
			                                                <td colspan="4">
			                                                    <textarea id="resdetailHometown" name="resumeDetail.hometown" >${requestScope.resume.resumeDetail.email}</textarea>
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                            	<td>期望工作类型</td>
			                                            	<td>
			                                            		<select name="resumeDetail.worktype" id="resdetailworktype">
			                                                        <option value="-1">请选择</option>
			                                                        <c:if test="${!empty sessionScope.worktypes}">
			                                                            <c:forEach var="c" items="${sessionScope.worktypes}">
			                                                                <option value="${c.id}">${c.tableDesc}</option>
			                                                            </c:forEach>
			                                                        </c:if>
			                                            		</select>
			                                            	</td>
			                                            	<td>期望工作地点</td><td colspan="2">
			                                            		<textarea name="resumeDetail.workspace" id="resdetailworkspace">${requestScope.resume.resumeDetail.workspace}</textarea>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>现居地</td>
			                                            	<td colspan="4">
			                                            			<textarea name="resumeDetail.livingaddress" id="resdetaillivingaddress">${requestScope.resume.resumeDetail.livingaddress}</textarea> 
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>期望职业角色</td>
			                                            	<td>
			                                            		<select name="resumeDetail.positiontype" id="resdetailpositiontype">
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
			                                            			<input type="text" name="resumeDetail.exceptsalary" id="resdetailexceptsalary" value="${requestScope.resume.resumeDetail.exceptsalary}"> 
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>自我介绍</td>
			                                            	<td>
			                                            		<textarea name="resumeDetail.selfIntrodution" id="resdetailselfIntrodution">${requestScope.resume.resumeDetail.selfIntrodution}</textarea>
			                                            	</td>
			                                            	<td>就职日期</td>
			                                            	<td colspan="2">
			                                            		<input type="text" name="resumeDetail.onboardingdate" id="resdetailonboardingdate" value="${requestScope.resume.resumeDetail.onboardingdate}">
			                                            	</td>
			                                            </tr>
			                                            
			                                            <tr>
			                                            	<td>技能介绍</td>
			                                            	<td colspan="4">
			                                            		<textarea style="width:70%;heigth:30px;" name="resumeDetail.skills" id="resdetailskills">${requestScope.resume.resumeDetail.skills}</textarea>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>工作经历介绍</td>
			                                            	<td colspan="4">
			                                            		<textarea style="width:70%;heigth:30px;" name="resumeDetail.companys" id="resdetailcompanys">${requestScope.resume.resumeDetail.companys}</textarea>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>项目经验介绍</td>
			                                            	<td colspan="4">
			                                            		<textarea style="width:70%;heigth:30px;" name="resumeDetail.awards" id="resdetailawards">${requestScope.resume.resumeDetail.awards}</textarea>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>奖惩介绍</td>
			                                            	<td colspan="4">
			                                            		<textarea style="width:70%;heigth:30px;" name="resumeDetail.experiences" id="resdetailexperiences">${requestScope.resume.resumeDetail.experiences}</textarea>
			                                            		<input type="hidden" value="${requestScope.resume.resumeDetail.id}" name="resumeDetail.id" id="resumeDetailId">
			                                            	</td>
			                                            </tr>
			                                        </table>
		                                        </form>
		                                    </div>
		                                    <div class="panel-footer">
		                                    	<div class="text-center">
		                                        	<a href="#" class="btn btn-info" onclick="updateResume()">更新简历信息</a>
		                                        </div>
		                                    </div>
		                                </div>
		                            </div>
		                    </div>
						
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
													$('#photopath').val(filename);
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
	</c:if>
	<c:if test="${empty requestScope.resume.resumeDetail}">
			<c:if test="${!empty requestScope.resume}">
				<script type="text/javascript">
					window.location.href="<%=basePath%>user_userResumeForward.do?id="+${requestScope.resume.id};
				</script>
			</c:if>
			<c:if test="${!empty requestScope.resume}">
				<script type="text/javascript">
					window.location.href="<%=basePath%>user_findAllResumes.do?id="+${sessionScope.loginUser.id};
				</script>
			</c:if>
	</c:if>
	<jsp:include page="buttom.jsp" flush="true" />
</body>
</html>
</c:if>
<c:if test="${empty sessionScope.loginUser}">
		<script type="text/javascript">
			window.location.href="<%=basePath%>user_loginOut.do";
		</script>
</c:if>