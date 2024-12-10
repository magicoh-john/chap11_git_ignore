<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 헤더 부분 인클루드 -->
<%@ include file="../include/header.jsp" %>

<!-- 제목 -->
<div class="row">
    <div class="col-lg-12">
        <h2 class="page-header" style="text-align: center;">사원 상세 정보</h2>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<!-- 바디(내용) -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                Employee Details
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">
                <!-- start table contents -->
                <div>
                    <table class="table table-bordered table-hover table-striped" >
	                    <colgroup>
							<col width = "20%">						
							<col width = "80%">						
						</colgroup>
                        <tr>
                            <th>Employee ID</th>
                            <td>${employee.employeeId}</td>
                        </tr>
                        <tr>
                            <th>First Name</th>
                            <td>${employee.firstName}</td>
                        </tr>
                        <tr>
                            <th>Last Name</th>
                            <td>${employee.lastName}</td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td>${employee.email}</td>
                        </tr>
                        <tr>
                            <th>Phone Number</th>
                            <td>${employee.phoneNumber}</td>
                        </tr>
                        <tr>
                            <th>Hire Date</th>
                            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${employee.hireDate}" /></td>
                        </tr>
                        <tr>
                            <th>Job ID</th>
                            <td>${employee.jobId}</td>
                        </tr>
                        <tr>
                            <th>Salary</th>
                            <td>${employee.salary}</td>
                        </tr>
                        <tr>
                            <th>Commission Pct</th>
                            <td>${employee.commissionPct}</td>
                        </tr>
                        <tr>
                            <th>Manager ID</th>
                            <td>${employee.managerId}</td>
                        </tr>
                        <tr>
                            <th>Department ID</th>
                            <td>${employee.departmentId}</td>
                        </tr>
                        <tr>
                        	<td colspan="2" style="text-align:center">
							<input type="button" id="btnModify" class='btn btn-info' onclick="location.href='<c:url value="/emp/modify" />'" value="수정" />
	                        <input type="button" id="btnList" class='btn btn-info' onclick="location.href='<c:url value="/emp/list" />'" value="목록" />							
							<input type="button" id="btnDelete" class='btn btn-info' onclick="location.href='<c:url value="/emp/delete" />'" value="삭제" />
							</td>

                        </tr>
                    </table>
                </div>
                <!-- end table contents -->
            </div>
            <!-- panel-body -->
        </div>
        <!-- panel -->
    </div>
    <!-- col-lg-12 -->
</div>

<!-- 푸터 부분 인클루드 -->
<%@ include file="../include/footer.jsp" %>
