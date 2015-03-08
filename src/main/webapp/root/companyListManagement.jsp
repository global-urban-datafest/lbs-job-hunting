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
	$("#companyList").datagrid({
		url:'<%=basePath%>root/rootUser_findAllCompany.do',
		pageNumber:1
 	});
	$('#updateUser').on('hidden.bs.modal', function (e) {
		$("#companyList").datagrid("reload");
	});
});

function setHotFlag(companyId){
	if(notEmpty(companyId)){
		$.post('<%=basePath%>root/rootUser_setHotFlag.do?id='+companyId,function(data){
			if(data.success){
				alert('设置为热门公司成功');
				$("#companyList").datagrid("reload");
			}else{
				alert(data.msg);
			}
		});
	}else{
		alert('你选择的公司id不能为空');
	}
}

function unSetHotFlag(companyId){
	if(notEmpty(companyId)){
		$.post('<%=basePath%>root/rootUser_unSetHotFlag.do?id='+companyId,function(data){
			if(data.success){
				alert('设置为热门公司成功');
				$("#companyList").datagrid("reload");
			}else{
				alert(data.msg);
			}
		});
	}else{
		alert('你选择的公司id不能为空');
	}
}
function formatFlag(val ,row){
	if(val==true)
		return "<button class='btn btn-info btn-xs' onclick='unSetHotFlag("+row.id+")'>取消热门</button>";
	else
		return "<button class='btn btn-info btn-xs' onclick='setHotFlag("+row.id+")'>设置为热门</button>";
}

function updateCompanyForward(){
	var row=$("#companyList").datagrid("getSelected");
	if(notEmpty(row)){
		var companyId=row.id;
			$('#companyId').val("");
			$('#companyName').val("");
			$('#cpy_loginName').html("");
			$('#companySize').val("");
			$('#companyType').val("");
			$('#companyDesc').text("");
			$('#legalPerson').val("");
			$('#companyURL').val("");
			$('#companyTel').val("");
			$('#companyEmail').val("");
			$('#companyAddress').text("");
			$('#companyLogo').val("");
			$('#userHeadImage').attr('src','<%=basePath%>images/logo/#');
			$.post('<%=basePath%>root/rootUser_updateCompanyForward.do?id='+companyId,function(data){
				if(notEmpty(data)){
					$('#companyId').val(data.id);
					$('#companyName').val(data.companyName);
					$('#cpy_loginName').html(data.cpy_loginName);
					$('#companySize').val(data.companySize);
					$('#companyType').val(data.companyType);
					$('#companyDesc').text(data.companyDesc);
					$('#legalPerson').val(data.legalPerson);
					$('#companyURL').val(data.companyURL);
					$('#companyTel').val(data.companyTel);
					$('#companyEmail').val(data.companyEmail);
					$('#companyAddress').text(data.companyAddress);
					$('#companyLogo').val(data.companyLogo);
					$('#userHeadImage').attr('src','<%=basePath%>images/logo/'+data.companyLogo);
					$('#updateUser').modal('show');
				}else{
					alert("获取公司信息失败，请重试！");
				}
			});
	}else{
		alert("你未选择任何行");
	}
}
function updateUser(){
	var companyId=$('#companyId').val();
	if(notEmpty(companyId)){
		$('#companyForm').ajaxSubmit(function(data){
			if(data.success){
				alert('更新企业信息成功!');
				$('#updateUser').modal('hide');
				$("#companyList").datagrid("reload");
			}else{
				alert(data.msg);
			}
		});
	}else{
		alert('获取企业id失败，无法更新');
	}
}
function deleteCompany(){
	var row=$("#companyList").datagrid("getSelected");
	if(notEmpty(row)){

	}else{
		alert("你未选择任何行");
	}
}
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
</head>
<body>
	<div class="container" style="background: none;">
		<div class="row">
			<div class="col-md-12" role="main">
					<div class="page-header">
					  <h1>企业列表</h1>
					</div>
                	<div  id="toolbar">
						    <div style="padding:5px;">
						        <a href="#" class="easyui-linkbutton" data-options="iconCls:'glyphicon glyphicon-floppy-disk'" onclick="updateCompanyForward();">更新企业</a>
						        <a href="#" class="easyui-linkbutton" data-options="iconCls:'glyphicon glyphicon-trash'" onclick="deleteCompany()">删除企业</a>
						    </div>
					</div>
                    <table  data-options="rownumbers:true,pagination:true,singleSelect:true,method:'post',toolbar:'#toolbar',height:450" id="companyList">
					        <thead>
					            <tr>
						          <th data-options="field:'id',width:100,align:'right'" hidden="hidden">;
								  <th data-options="field:'cpy_loginName',width:100,align:'right'">登录名</th>
								  <th data-options="field:'companyName',width:100,align:'right'">公司名</th>
								  <th data-options="field:'companyDesc',width:100,align:'right'">公司描述</th>
								  <th data-options="field:'legalPerson',width:100,align:'right'">法人代表</th>
								  <th data-options="field:'companyURL',width:100,align:'right'">公司网址</th>
								  <th data-options="field:'companyTel',width:100,align:'right'">公司电话</th>
								  <th data-options="field:'companyEmail',width:100,align:'right'">公司email</th>
								  <th data-options="field:'companyAddress',width:100,align:'right'">公司地址</th>
								  <th data-options="field:'lastLoginDate',width:100,align:'right'">上次登录信息</th>
								  <th data-options="field:'creationDate',width:100,align:'right'">创建时间</th>
								  <th data-options="field:'cpy_hot_flag',width:100,align:'right',formatter:formatFlag">是否为热门公司</th>
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
			         <h4 class="modal-title" id="myModalLabel">更新企业信息</h4>
			       </div>
			       <div class="modal-body">
						<script type="text/javascript">
		
						</script>
						<div class="bs-example ">
							<form class="form-horizontal" role="form" action="<%=basePath%>root/rootUser_updateCompany.do" id="companyForm" method="post">
	                           <div class="form-group">
	                                <label class="col-sm-2 control-label">公司登录名:</label>
	                                <div class="col-sm-4">
	                                    <span id="cpy_loginName"></span>
	                                </div>
	                            </div>
	                           <div class="form-group">
	                                <label class="col-sm-2 control-label">公司名:</label>
	                                <div class="col-sm-4">
	                                	<input type="hidden" class="form-control" name="company.id" id="companyId"  placeholder="公司名">
	                                    <input type="text" class="form-control" name="company.companyName" id="companyName"  placeholder="公司名">
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
	                                    <input type="text" class="form-control" name="company.legalPerson" id="legalPerson"  placeholder="法人代表">
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label for="maxim" class="col-sm-2 control-label">公司网址:</label>
	                                <div class="col-sm-4">
	                                    <input type="text" class="form-control" name="company.companyURL" id="companyURL"  placeholder="公司网址">
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label for="maxim" class="col-sm-2 control-label">公司电话:</label>
	                                <div class="col-sm-4">
	                                    <input type="text" class="form-control" name="company.companyTel" id="companyTel"  placeholder="公司电话">
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label for="maxim" class="col-sm-2 control-label">公司email:</label>
	                                <div class="col-sm-4">
	                                    <input type="text" class="form-control" name="company.companyEmail" id="companyEmail"  placeholder="公司email">
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label for="maxim" class="col-sm-2 control-label">公司地址:</label>
	                                <div class="col-sm-4">
	                                    <textarea class="form-control" id="companyAddress" name="company.companyAddress" placeholder="公司地址"></textarea>
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label for="maxim" class="col-sm-2 control-label">公司描述:</label>
	                                <div class="col-sm-4">
	                                    <textarea class="form-control" id="companyDesc" name="company.companyDesc" style="height: 400px;height: 90px;" placeholder="公司描述"></textarea>
	                                </div>
	                            </div>
	                            <input type="hidden" name="company.companyLogo" id="companyLogo">
	                            <div class="form-group">
									<label class="col-sm-2 control-label">头像:</label>
									<div class="col-sm-4">
										<img src="<%=basePath%>images/logo/#" id="userHeadImage" alt="公司Logo">
									</div>
	                            </div>
							</form>
							<form class="form-horizontal" action="<%=basePath%>uploadAction_companyLogoUpload.do" method="post" enctype="multipart/form-data"  id="imgupdateform">
								<input type="file" name="myFile" id="myFile" class="form-control"   onchange="onUploadImgChange(this);">
							</form>
							<span id="Tip" style="display: none"></span>
						</div>
						<div class="highlight text-center">
							<pre>
							     <button type="button" class="btn btn-default" onclick="updateUser()">更新企业信息</button>
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