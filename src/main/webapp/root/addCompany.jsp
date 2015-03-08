<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + path + "/";
    %>
<c:if test="${!empty sessionScope.loginUser}"> 
<html>
<head>
<meta charset="utf-8" />
<jsp:include page="/common.jsp"/>
<script type="text/javascript" src="<%=basePath%>js/jquery.form.js"></script>
<script type="text/javascript">
function addCompany(){
	$('#companyForm').ajaxSubmit(function(data){
		if(data.success){
			alert('添加企业成功，请关闭本窗口');
		}else{
			alert(data.msg);
		}
	});
}
</script>
</head>
<body class="container" style="background: none;">
	<div class="row">
		<div class="col-md-12" role="main">
					<div class="page-header">
					  <h1>添加企业信息</h1>
					</div>
					<div class="bs-example " style="background: none">
						<form class="form-horizontal" role="form" action="<%=basePath%>root/rootUser_addCompany.do" id="companyForm" method="post">
						   <div class="form-group">
								<label class="col-sm-2 control-label">头像:</label>
								<div class="col-sm-4">
									<img src="<%=basePath%>images/logo/#" id="userHeadImage" alt="公司Logo(点击上传)" data-toggle="modal" data-target="#myModal">
								</div>
							</div>
                           <div class="form-group">
                                <label class="col-sm-2 control-label">公司名:</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="company.companyName" id="companyName" value="${requestScope.company.companyName}" placeholder="公司名">
                                </div>
                            </div>
                           <div class="form-group">
                                <label class="col-sm-2 control-label">登录名:</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="company.cpy_loginName" id="cpy_loginName" value="${requestScope.company.companyName}" placeholder="公司名">
                                </div>
                            </div>
                           <div class="form-group">
                                <label class="col-sm-2 control-label">登录密码:</label>
                                <div class="col-sm-4">
                                    <input type="password" class="form-control" name="company.cpy_loginPass" id="cpy_loginPass" value="${requestScope.company.companyName}" placeholder="公司名">
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
                            		<input type="hidden" name="company.companyLogo" id="companyLogo" value="${requestScope.company.companyLogo}">
                                </div>
                            </div>
						</form>
						<div class="highlight text-center" style="background: none">
									<pre>
									     <button type="button" class="btn btn-default" onclick="addCompany()">更新会员信息</button>
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
				            	<h4>上传公司LOGO</h4>
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
</body>
</html>
</c:if>
<c:if test="${empty sessionScope.loginUser}">
		<script type="text/javascript">
		parent.location.href="<%=basePath%>root/rootUser_loginOut.do";
		</script>
</c:if>