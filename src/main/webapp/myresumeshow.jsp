<%@ page language="java" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<title>简历详情</title>
</head>
<body>
	<jsp:include page="common.jsp" flush="true" />
	<c:if test="${!empty requestScope.resume.resumeDetail}">
		<div class="container">
			<div class="row">
				<div class="col-md-9 col-md-offset-2" role="main">
					<div class="bs-docs-section">
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
			                                        <table class="table table-bordered">
			                                            <tr>
			                                                <td width="12%">真实名</td>
			                                                     <td>
			                                                            <span>${requestScope.resume.resumeDetail.realname}</span>
			                                                     </td>
			                                                	 <td>性别</td>
			                                                     <td>
			                                                     		<span>
			                                                     			<c:if test="${!empty sessionScope.sexs}">
			                                                                 <c:forEach var="c" items="${sessionScope.sexs}">
			                                                                 	<c:if test="${c.id eq requestScope.resume.resumeDetail.sex}">
			                                                                     	${c.tableDesc}
			                                                                    </c:if>
			                                                                 </c:forEach>
			                                                                </c:if>
			                                                     		</span>

			                                                     </td>
			                                                     <td rowspan="4" width="20%">
			                                                         <c:if test="${!empty requestScope.resume.resumeDetail.photo}">
			                                                             <img src="/images/photo/${requestScope.resume.resumeDetail.photo}">
			                                                         </c:if>
			                                                         <c:if test="${empty requestScope.resume.resumeDetail.photo}">
			                                                             <img src="" id="userHeadImage" alt="简历照片">
			                                                         </c:if>
			                                                     </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">出生日期</td>
			                                                <td>
																	<div class="input-append date" data-date="01/01/1900" data-date-format="mm/dd/yyyy">
																		<span><fmt:formatDate value='${requestScope.resume.resumeDetail.birthday}' pattern='MM/dd/yyyy'/></span>
																	</div>
			                                                </td>
			                                                <td>工作年限</td>
			                                                <td>
			                                                   <span>
			                                                         <c:if test="${!empty sessionScope.workyears}">
			                                                                <c:forEach var="c" items="${sessionScope.workyears}">
			                                                                 	<c:if test="${c.id eq requestScope.resume.resumeDetail.workyear}">
			                                                                     	${c.tableDesc}
			                                                                    </c:if>
			                                                                </c:forEach>
			                                                         </c:if>
			                                                   </span>
			                                                </td>
			                                            </tr>
			                                                                             
			                                            
			                                            <tr>
			                                            	<td width="12%">证件类型</td>
			                                                <td>
			                                                    <span>
			                                                         <c:if test="${!empty sessionScope.documenttypes}">
			                                                             <c:forEach var="c" items="${sessionScope.documenttypes}">
			                                                                 	<c:if test="${c.id eq requestScope.resume.resumeDetail.documenttype}">
			                                                                     	${c.tableDesc}
			                                                                    </c:if>
			                                                             </c:forEach>
			                                                         </c:if>
			                                                    </span>
			                                                </td>
			                                                <td>证件号码</td>
			                                                <td>
			                                                    <span>${requestScope.resume.resumeDetail.documentcode}</span>
			                                                </td>
			                                            </tr>
			                                            
			                                            <tr>
			                                                <td width="12%">QQ</td>
			                                                <td>
			                                                        <span>${requestScope.resume.resumeDetail.qq}</span>
			                                                </td>
			                                                <td>Email</td>
			                                                <td>
			                                                        <span>${requestScope.resume.resumeDetail.email}</span>
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td>微信</td>
			                                                <td >
			                                                    <span>${requestScope.resume.resumeDetail.wechat}</span>
			                                                </td>
			                                                <td>手机号码</td>
			                                                <td colspan="2">
			                                                    <span>${requestScope.resume.resumeDetail.mobile}</span>
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">家庭电话</td>
			                                                <td>
			                                                    <span>${requestScope.resume.resumeDetail.hometel}</span>
			                                                </td>
			                                                <td>公司电话</td>
			                                                <td colspan="2">
			                                                    <span>${requestScope.resume.resumeDetail.companytel}</span>
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">求职状态</td>
			                                                <td>
			                                                    <span>
			                                                        <c:if test="${!empty sessionScope.jobstatuses}">
			                                                            <c:forEach var="c" items="${sessionScope.jobstatuses}">
			                                                                 	<c:if test="${c.id eq requestScope.resume.resumeDetail.jobstatus}">
			                                                                     	${c.tableDesc}
			                                                                    </c:if>
			                                                            </c:forEach>
			                                                        </c:if>
			                                                    </span>
			                                                </td>
			                                                <td>政治面貌</td>
			                                                <td colspan="2">
			                                                    <span>
			                                                        <c:if test="${!empty sessionScope.polictictypes}">
			                                                            <c:forEach var="c" items="${sessionScope.polictictypes}">
			                                                                 	<c:if test="${c.id eq requestScope.resume.resumeDetail.politicstatus}">
			                                                                     	${c.tableDesc}
			                                                                    </c:if>
			                                                             </c:forEach>
			                                                        </c:if>
			                                                    </span>
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">婚姻状态</td>
			                                                <td>
			                                                    <span>
			                                                        <c:if test="${!empty sessionScope.marriagestatuses}">
			                                                            <c:forEach var="c" items="${sessionScope.marriagestatuses}">
			                                                                 	<c:if test="${c.id eq requestScope.resume.resumeDetail.marriagestatus}">
			                                                                     	${c.tableDesc}
			                                                                    </c:if>	
			                                                             </c:forEach>
			                                                        </c:if>
			                                                    </span>
			                                                </td>
			                                                <td>邮编</td>
			                                                <td colspan="2">
			                                                    <span>${requestScope.resume.resumeDetail.zip}</span>
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td width="12%">目前年薪</td>
			                                                <td>
			                                                    <span>
			                                                        <c:if test="${!empty sessionScope.salarys}">
			                                                            <c:forEach var="c" items="${sessionScope.salarys}">
			                                                                 	<c:if test="${c.id eq requestScope.resume.resumeDetail.salary}">
			                                                                     	${c.tableDesc}
			                                                                    </c:if>	
			                                                            </c:forEach>
			                                                        </c:if>
			                                                    </span>
			                                                </td>
			                                                <td >身高</td>
			                                                <td  colspan="2">
			                                                    <span>${requestScope.resume.resumeDetail.height}厘米</span>       
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                                <td>家庭地址</td>
			                                                <td colspan="4">
			                                                    <p>${requestScope.resume.resumeDetail.email}</p>
			                                                </td>
			                                            </tr>
			                                            <tr>
			                                            	<td>期望工作类型</td>
			                                            	<td>
			                                            		<span>
			                                                        <c:if test="${!empty sessionScope.worktypes}">
			                                                            <c:forEach var="c" items="${sessionScope.worktypes}">
			                                                                 	<c:if test="${c.id eq requestScope.resume.resumeDetail.worktype}">
			                                                                     	${c.tableDesc}
			                                                                    </c:if>			                                                            
			                                                             </c:forEach>
			                                                        </c:if>
			                                            		</span>
			                                            	</td>
			                                            	<td>期望工作地点</td><td colspan="2">
			                                            		<p>${requestScope.resume.resumeDetail.workspace}</p>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>现居地</td>
			                                            	<td colspan="4">
			                                            			<p>${requestScope.resume.resumeDetail.livingaddress}</p> 
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>期望职业角色</td>
			                                            	<td>
			                                            		<span>
			                                                        <c:if test="${!empty sessionScope.positiontypes}">
			                                                            <c:forEach var="c" items="${sessionScope.positiontypes}">
			                                                                 	<c:if test="${c.id eq requestScope.resume.resumeDetail.positiontype}">
			                                                                     	${c.tableDesc}
			                                                                    </c:if>			                                                            
			                                                            </c:forEach>
			                                                        </c:if>
			                                            		</span>
			                                            	</td>
			                                            	<td>期望薪水</td>
			                                            	<td colspan="2">
			                                            			<span>${requestScope.resume.resumeDetail.exceptsalary}</span> 
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>自我介绍</td>
			                                            	<td>
			                                            		<p>${requestScope.resume.resumeDetail.selfIntrodution}</p>
			                                            	</td>
			                                            	<td>就职日期</td>
			                                            	<td colspan="2">
			                                            		<span>${requestScope.resume.resumeDetail.onboardingdate}</span>
			                                            	</td>
			                                            </tr>
			                                            
			                                            <tr>
			                                            	<td>技能介绍</td>
			                                            	<td colspan="4">
			                                            		<p>${requestScope.resume.resumeDetail.skills}</p>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>工作经历介绍</td>
			                                            	<td colspan="4">
			                                            		<p>${requestScope.resume.resumeDetail.companys}</p>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>项目经验介绍</td>
			                                            	<td colspan="4">
			                                            		<p>${requestScope.resume.resumeDetail.awards}</p>
			                                            	</td>
			                                            </tr>
			                                            <tr>
			                                            	<td>奖惩介绍</td>
			                                            	<td colspan="4">
			                                            		<p>${requestScope.resume.resumeDetail.experiences}</p>
			                                            	</td>
			                                            </tr>
			                                        </table>
		                                    </div>
		                                </div>
		                            </div>
		                    </div>
						</div>
				</div>
			</div>
		</div>
	</c:if>
	<c:if test="${empty requestScope.resume.resumeDetail || empty requestScope.resume}">
					请关闭窗口重试，谢谢.
	</c:if>
</body>
</html>