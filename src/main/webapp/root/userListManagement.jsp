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
	$("#userList").datagrid({
		url:'<%=basePath%>root/rootUser_findAllUser.do',
		pageNumber:1
 	});
	$('#updateUser').on('hidden.bs.modal', function (e) {
		$("#userList").datagrid("reload");
	});
});
function formatFlag(val ,row){
	if(val==true)
		return "是";
	else
		return "否";
}

function updateUserForward(){
	var row=$("#userList").datagrid("getSelected");
	if(notEmpty(row)){
		var userId=row.id;
		if(notEmpty(userId)){
			$('#updateid').val("");
			$('#updateNameSpan').html("");
			$('#updateregisteremailspan').html("");
			$('#updatemaxim').html("");
			$('#updateImage').attr('src','');
			$.post("<%=basePath%>root/rootUser_updateUserForward.do?id="+userId,function(data){
				if(notEmpty(data)){
					$('#updateid').val(data.id);
					$('#updateNameSpan').html(data.name);
					$('#updateregisteremailspan').html(data.registeremail);
					$('#updatemaxim').html(data.maxim);
					$('#updateImage').attr('src','<%=basePath%>images/userPhoto/'+data.headImage);
				}
			});
			$('#updateUser').modal('show');
		}else{
			alert("你选择的行的id不能为空!");
		}
	}else{
		alert("你未选择任何行");
	}
}
function uploadUserImage(){
    var options = {
        target:'#Tip', //后台将把传递过来的值赋给该元素
        type:'POST',
        success: function(){
            filename=$('#Tip').text();
            $('#updateImage').attr('src','<%=basePath%>images/userPhoto/'+filename);
        } //显示操作提示
    };
    $('#imgupdateform').ajaxSubmit(options);
    return false; //为了不刷新页面,返回false，反正都已经在后台执行完了，没事！
}
function updateUser(){
    var userId=$('#updateid').val();
    var headImage=$('#updateImage').attr('src');
    if(notEmpty(headImage)){
    	if(headImage.lastIndexOf('\/')>0){
        	headImage=headImage.substring(headImage.lastIndexOf('\/')+1,headImage.length);
    	}else{
    		headImage="3-13112G33911.jpg";
    	}
    }
    var maxim= $('#updatemaxim').val();
    if(notEmpty(userId)){
        $.post('<%=basePath%>root/rootUser_updateUser.do',{
            'user.id':userId,
            'user.headImage':headImage,
            'user.Maxim':maxim
        },function(obj){
            if(obj.success)
            {
                alert('基本信息更新成功！')
                $('#updateUser').modal('hide');
            }
        });
    }else{
        alert('你要更新的用户的id不能为空');
    }
}
function deleteUser(){
	var row=$("#userList").datagrid("getSelected");
	if(notEmpty(row)){
		var userId=row.id;
		if(notEmpty(userId)){
			$.post("<%=basePath%>root/rootUser_deleteUser.do?id="+userId,function(data){
	            if(data.success)
	            {
	                alert('删除用户信息成功！')
	                $("#userList").datagrid("reload");
	            }else{
	            	alert(data.msg);
	            }
			});
		}else{
			alert("你选择的行的id不能为空!");
		}
	}else{
		alert("你未选择任何行");
	}
}
</script>
</head>
<body style="background: none">
	<div class="container" style="background: none;">
		<div class="row">
			<div class="col-md-12" role="main">
					<div class="page-header">
					  <h1>用户列表</h1>
					</div>
                	<div  id="toolbar">
						    <div style="padding:5px;">
						        <a href="#" class="easyui-linkbutton" data-options="iconCls:'glyphicon glyphicon-floppy-disk'" onclick="updateUserForward();">更新用户</a>
						        <a href="#" class="easyui-linkbutton" data-options="iconCls:'glyphicon glyphicon-trash'" onclick="deleteUser()">删除用户</a>
						    </div>
					</div>
                    <table  data-options="rownumbers:true,pagination:true,singleSelect:true,method:'post',toolbar:'#toolbar',height:450" id="userList">
					        <thead>
					            <tr>
					            	<th hidden="hidden" data-options="field:'id'"></th>
					                <th data-options="field:'name',width:100">登录名</th>
					                <th data-options="field:'registeremail',width:120">注册Email</th>
					                <th data-options="field:'maxim',width:120">名言</th>
									<th data-options="field:'checkflag',width:100,formatter:formatFlag">资料是否完整</th>
					                <th data-options="field:'registerdate',width:100,align:'right'">注册日期</th>
					                <th data-options="field:'lastlogindate',width:100,align:'right'">上次登录日期</th>
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
			         <h4 class="modal-title" id="myModalLabel">更新用户信息</h4>
			       </div>
			       <div class="modal-body">
						<script type="text/javascript">
		
						</script>
						<div class="bs-example ">
	                        <div class="form-horizontal" role="form">
	                        	<div class="form-group">
									<label class="col-sm-2 control-label">头像:</label>
									<div class="col-sm-4">
										<img src="" id="updateImage" ></img>
									</div>
								</div>
	                            <div class="form-group">
	                                <label class="col-sm-2 control-label">用户名:</label>
	                                <div class="col-sm-4">
	                                    <span class="text-muted" style="position: relative;top:6px;" id="updateNameSpan"></span>
	                                    <input type="hidden" name="user.id" id="updateid">
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label for="registeremail" class="col-sm-2 control-label">Email:</label>
	                                <div class="col-sm-4">
	                                    <span class="text-muted" id="updateregisteremailspan" style="position: relative;top:6px;"></span>
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label for="maxim" class="col-sm-2 control-label">格言</label>
	                                <div class="col-sm-4">
	                                    <textarea id="updatemaxim" name="user.maxim" class="form-control" placeholder="格言">${requestScope.user.maxim}</textarea>
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label class="col-sm-2 control-label" for="userHeadImage">头像:</label>
	                                <div class="col-sm-4">
	                                    <form class="form-horizontal" action="<%=basePath%>uploadAction_userHeadUpload.do"
	                                          method="post" enctype="multipart/form-data"  id="imgupdateform" onsubmit="return uploadUserImage()">
	                                        <input type="file" id="upload" name="myFile" class="form-control"/>
	                                        <br>
	                                        <input type="submit" id="updateimg" value="上传头像" class="text-center"/>
	                                    </form>
	                                </div>
	                            </div>
	                        </div>
						</div>
						<div class="highlight text-center">
							<pre>
							     <button type="button" class="btn btn-default" onclick="updateUser()">更新基本信息</button>
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