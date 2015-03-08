<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="zh-cn">
<jsp:include page="common.jsp" />
<head>
<title>企业信息</title>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + path + "/";
    %>
<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
<script type="text/javascript">
   $(document).ready(function(){
       $("#companySize").val(${requestScope.company.companySize});
       $("#companyType").val(${requestScope.company.companyType});
   });
   function updateCompany(){
	   var id=$('#companyId').val();
	   if(notEmpty(id)){
			$('#companyForm').ajaxSubmit(function(data){
				if(data.data.success){
					alert('更新公司信息成功!');
				}else{
					alert(data.data.msg);
				}
			});
	   }else{
		   alert('公司id不能为空!');
	   }
   }
</script>
</head>
<body>
<c:if test="${!empty sessionScope.loginUser}">
	<jsp:include page="header.jsp" flush="true" />
	<div class="container">
		<div class="row">
			<div class="col-md-3">
						<div class="col-sm-12 col-md-12">
						    <div class="thumbnail">
						     <c:if test="${requestScope.company.companyLogo!=null&& '' ne requestScope.company.companyLogo}">
                                  <img src="<%=basePath%>images/logo/${requestScope.company.companyLogo}" id="userHeadImage" alt="公司Logo" data-toggle="modal" data-target="#myModal">
                              </c:if>
                              <c:if test="${requestScope.company.companyLogo==null || '' eq requestScope.company.companyLogo}">
                                    <img src="" id="userHeadImage" alt="公司Logo" data-toggle="modal" data-target="#myModal">
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
					  <h1>企业信息详情</h1>
					</div>
					<div class="bs-example ">
						<form class="form-horizontal" role="form" action="<%=basePath%>company_updateCompany.do" id="companyForm" method="post">
                           <div class="form-group">
                                <label class="col-sm-2 control-label">公司名:</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="company.companyName" id="companyName" value="${requestScope.company.companyName}" placeholder="公司名">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="registeremail" class="col-sm-2 control-label">公司规模:</label>
                                <div class="col-sm-4">
                                    <select class="form-control" name="company.companySize" id="companySize">
			                                 <option value="-1">请选择</option>
			                                 <c:if test="${!empty sessionScope.companysizes}">
			                                      <c:forEach var="c" items="${sessionScope.companysizes}">
			                                               <option value="${c.id}">${c.tableDesc}</option>
			                                      </c:forEach>
			                                </c:if>
                                    </select>
                                </div>
                            </div>
                            <input type="hidden" id="companyId" name="company.id" value="${requestScope.company.id}">
                            <div class="form-group">
                                <label for="maxim" class="col-sm-2 control-label">公司性质:</label>
                                <div class="col-sm-4">
                                    <select class="form-control" name="company.companyType" id="companyType">
			                                 <option value="-1">请选择</option>
			                                 <c:if test="${!empty sessionScope.companytypes}">
			                                      <c:forEach var="c" items="${sessionScope.companytypes}">
			                                               <option value="${c.id}">${c.tableDesc}</option>
			                                      </c:forEach>
			                                </c:if>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="maxim" class="col-sm-2 control-label">法人代表:</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="company.legalPerson" id="legalPerson" value="${requestScope.company.legalPerson}" placeholder="法人代表">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="maxim" class="col-sm-2 control-label">公司网址:</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="company.companyURL" id="companyURL" value="${requestScope.company.companyURL}" placeholder="公司网址">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="maxim" class="col-sm-2 control-label">公司电话:</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="company.companyTel" id="companyTel" value="${requestScope.company.companyTel}" placeholder="公司电话">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="maxim" class="col-sm-2 control-label">公司email:</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="company.companyEmail" id="companyEmail" value="${requestScope.company.companyEmail}" placeholder="公司email">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="maxim" class="col-sm-2 control-label">公司地址:</label>
                                <div class="col-sm-4">
                                    <textarea class="form-control" id="companyAddress" name="company.companyAddress" placeholder="公司地址">${requestScope.company.companyAddress}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="maxim" class="col-sm-2 control-label">公司描述:</label>
                                <div class="col-sm-4">
                                    <textarea class="form-control" id="companyDesc" name="company.companyDesc" style="height: 400px;height: 90px;" placeholder="公司描述">${requestScope.company.companyDesc}</textarea>
                                </div>
                            </div>
                            <input type="hidden" name="company.companyLogo" id="companyLogo" value="${requestScope.company.companyLogo}">
						</form>
						<div class="highlight text-center">
									<pre>
									     <button type="button" class="btn btn-default" onclick="updateCompany()">更新会员信息</button>
									</pre>
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
				            <h4 class="modal-title" id="myModalLabel">公司Logo上传</h4>
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
													$('#userHeadImage').attr('src','<%=basePath%>images/logo/'+filename);
													$('#companyLogo').val(filename);
													alert('公司Logo上传成功！');
													$('#myModal').modal('hide');
												} //显示操作提示
											};
											$('#imgupdateform').ajaxSubmit(options);
											return false; //为了不刷新页面,返回false，反正都已经在后台执行完了，没事！
								}
								</script>
				            	<h4>上传照片</h4>
								    <form class="form-horizontal" action="<%=basePath%>uploadAction_companyLogoUpload.do" method="post" enctype="multipart/form-data"  id="imgupdateform">
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
	<jsp:include page="buttom.jsp" flush="true" />
</c:if>
<c:if test="${empty sessionScope.loginUser}">
		<script type="text/javascript">
		window.location.href="<%=basePath%>user_loginOut.do";
		</script>
</c:if>
</body>
</html>