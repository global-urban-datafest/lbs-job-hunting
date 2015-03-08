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
<jsp:include page="common.jsp" />
<head>
<title>简历列表</title>

<script type="text/javascript">
	function deleteResume(id){
        var userId=${sessionScope.loginUser.id==null?"":sessionScope.loginUser.id};
        if(notEmpty(userId)){
            if(confirm("您确定要删除此份简历？")){
                $.post('<%=basePath%>user_deleteResume.do',{
                    'id':id
                },function(obj){
                    if(obj)
                    {
                        alert('删除简历成功！');
                        window.location.href="<%=basePath%>/user_findAllResumes.do?id="+userId;
                    }
                });
            }
        }else{
            alert('登录时间过期，请重新登录');
            window.location.href='<%=basePath%>user_loginOut.do';
        }
    }
	 function addRow(tableId){
		     var $tr=$("#"+tableId+" tbody tr");
		     var countNum=$("#"+tableId+" tbody").children("tr").length+1;
		     if($tr.size()==0){
		    	 $("#"+tableId+" tbody").append("<tr><td class='sid'>"+countNum+"</td><td><input type='text' id='resumeName_"+countNum+"' name='resume.name'></td><td><select id='resumePublic_"+countNum+"' name='resume.publicFlag'><option value='1'>是</option><option value='0'>否</option></select></td><td><a href='#' onclick='saveResume("+countNum+",${sessionScope.loginUser.id==null?'':sessionScope.loginUser.id});'><span class='glyphicon glyphicon-floppy-disk'></span></a></td><td><a href='#' onclick=\"deleteRow('addTable',this);\"><span class='glyphicon glyphicon-trash'></span></a></td></tr>");
		     }else{
		    	 $("#"+tableId+" tbody tr:last").after("<tr><td class='sid'>"+countNum+"</td><td><input type='text' id='resumeName_"+countNum+"' name='resume.name'></td><td><select id='resumePublic_"+countNum+"' name='resume.publicFlag'><option value='1'>是</option><option value='0'>否</option></select></td><td><a href='#' onclick='saveResume("+countNum+",${sessionScope.loginUser.id==null?'':sessionScope.loginUser.id});'><span class='glyphicon glyphicon-floppy-disk'></span></a></td><td><a href='#' onclick=\"deleteRow('addTable',this);\"><span class='glyphicon glyphicon-trash'></span></a></td></tr>");
		     }
		  }
	 function deleteRow(tableId,dom){
			 var countNum=$("#"+tableId+" tbody").children("tr").length;
			 if(countNum>=0){
				 var obj= $(dom);
				 obj.parents('tr').remove();
				 var i=0;
				 $('.sid').each(function(index){
					 i++;
					 $(this).html(i);
				 });
				 i=0;
			 }else{
				 alert('么有任何行可删除.');
			 }
		  }
	 function saveResume(row,userId){
		var resumeName=$('#resumeName_'+row).val();
		var resumePulicFlag=$('#resumePublic_'+row).val();
		if(notEmpty(userId)){
			if(notEmpty(resumeName)){
							$.post('<%=basePath%>user_saveResume.do',{'resume.name':resumeName,'resume.public_flag':resumePulicFlag,'user.id':userId},function(data){
								if(data.data.success){
										alert('添加简历成功！');
										window.location.href="<%=basePath%>user_findAllResumes.do?id="+userId; 
								}else{
                                    alert(data.data.msg);
                                }
							});
						}else{
							alert('第'+row+'行的简历名称不能为空');
						}
		}else{
			alert('登录状态已过期，请重新登录');
			window.location.href="<%=basePath%>user_loginOut.do";
		}
	 }
	 function setDefautResume(resumeId){
	        var userId=${sessionScope.loginUser.id==null?"":sessionScope.loginUser.id};
	    	if(notEmpty(userId)){
	     		 if(notEmpty(resumeId)){
	   			 $.post('<%=basePath%>user_setDefautResume.do',{'id':resumeId,'user.id':userId},function(data){
	   				 if(data.success){
	   					 alert('设置为默认成功!');
	   					 window.location.href="<%=basePath%>/user_findAllResumes.do?id="+userId;
	   				 }else{
	   					 alert(data.msg);
	   				 }
	   			 });
	   		 }else{
	   			 alert('未选择任何resume.');
	   		 }
	   	}else{
            alert('登录时间过期，请重新登录');
            window.location.href='<%=basePath%>user_loginOut.do';
	   	}
	 }
	 function unSetDefautResume(resumeId){
	     var userId=${sessionScope.loginUser.id==null?"":sessionScope.loginUser.id};
	     if(notEmpty(userId)){
		 	if(notEmpty(resumeId)){
			 $.post('<%=basePath%>user_unSetDefautResume.do',{'id':resumeId},function(data){
				 if(data.success){
					 alert('取消设置为默认成功!');
					window.location.href="<%=basePath%>user_findAllResumes.do?id="+userId; 
				 }else{
					 alert(data.msg);
				 }
			 });
			 }else{
				 alert('未选择任何resume.');
			 }
		 }else{
	            alert('登录时间过期，请重新登录');
	            window.location.href='<%=basePath%>user_loginOut.do';
		 }
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
                        <c:if test="${requestScope.user.headImage!=null&& '' ne requestScope.user.headImage}">
                            <img src="<%=basePath%>images/userPhoto/${requestScope.user.headImage}" id="userHeadImage" alt="用户头像">
                        </c:if>
                        <c:if test="${requestScope.user.headImage==null || '' eq requestScope.user.headImage}">
                            <img src="<%=basePath%>images/userPhoto/3-13112G33911.jpg" id="userHeadImage" alt="用户头像">
                        </c:if>
                        <div class="caption">
                            <div class="highlight text-center">
                                        <pre>
								                                              用户名:${sessionScope.loginUser.name}<br>
								                                              上次登录时间:<fmt:formatDate value="${sessionScope.loginUser.lastlogindate}" pattern="yyyy-MM-dd"/><br>
								                                              注册时间:<fmt:formatDate value="${sessionScope.loginUser.registerdate}" pattern="yyyy-MM-dd"/><br>
                                        </pre>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
			<div class="col-md-9" role="main">
                <div class="page-header">
                    <h1>简历中心</h1>
                </div>
                <div class="bs-example">
                        <table class="table table-hover">
                            <c:if test="${!empty requestScope.resumes}">
	                            <thead>
	                                <tr>
	                                        <th>编号</th>
	                                        <th>简历名称</th>
	                                        <th>是否公开</th>
	                                        <th>创建时间</th>
	                                        <th>更新时间</th>
	                                        <th>完整程度</th>
	                                        <th>预览</th>
	                                        <th>查看/更新</th>
	                                        <th>删除</th>
	                                        <th>设置为默认</th>
	                                </tr>
	                            </thead>
	                            <tbody>
	                                <c:forEach var="resume" items="${requestScope.resumes}" varStatus="status">
	                                <tr>
	                                            <td>${status.count}</td>
	                                            <td>${resume.name}</td>
	                                            <td>${resume.public_flag==true?'是':'否'}</td>
	                                            <td><fmt:formatDate value="${resume.creationdate}" pattern="yyyy-MM-dd"/></td>
	                                            <td><fmt:formatDate value="${resume.updatedate}" pattern="yyyy-MM-dd" /></td>
	                                            <td>
	                                                <c:if test="${!empty resume.compeletepercent}">
	                                                        ${resume.compeletepercent}%
	                                                 </c:if>
	                                            </td>
	                                            <td><a href="<%=basePath%>user_viewResume.do?id=${resume.id}" target="_blank"><span class="glyphicon-class glyphicon glyphicon-list-alt"></span></a></td>
	                                            <td><a href="<%=basePath%>user_userResumeForward.do?id=${resume.id}"><span class="glyphicon glyphicon-folder-open"></span></a></td>
	                                            <td><a href="#" onclick="deleteResume(${resume.id});"><span class="glyphicon glyphicon-trash"></span></a></td>
	                                            <td>
	                                            	<c:if test="${resume.defaultResumeFlag==true}">
															<a href="#" class="btn btn-default btn-xs" onclick="unSetDefautResume(${resume.id})">取消默认</a>
	                                            	</c:if>
	                                            	<c:if test="${resume.defaultResumeFlag==false}">
															<a href="#" class="btn btn-default btn-xs" onclick="setDefautResume(${resume.id})">设为默认</a>
	                                            	</c:if>
	                                            </td>
	                                </tr>
	                                </c:forEach>
	                            </tbody>
                             </c:if>
	                         <c:if test="${empty requestScope.resumes}">
	                               <tr>
	                               		<td colspan='7'>
	                              		 <span>对不起，你还未添加简历，请先添加</span>
	                              		</td>
	                               </tr>
	                         </c:if>
                         </table>
                  </div>
                  <hr>
                  <div class="bs-example">
	                    <table class="table table-hover" id="addTable">
	                               <thead>
	                                  <tr>
	                                        <th>编号</th>
	                                        <th>简历名称</th>
	                                        <th>是否公开</th>
	                                        <th>保存</th>
	                                        <th>删除(仅删除table行)</th>
	                                  </tr>
	                               </thead>
		                           <tbody>
		                                
		                           </tbody>
		                           <tfoot>
		                           		<tr>
		                           			<td colspan="4"> <a href="#" alt="添加简历" class="btn btn-primary" onclick="addRow('addTable');">添加一行</a></td>
		                           		</tr>
		                           </tfoot>
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
		window.location.href="<%=basePath%>user_loginOut.do";
		</script>
</c:if>