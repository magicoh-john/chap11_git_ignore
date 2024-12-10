<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 헤더 부분 인클루드 -->
<%@ include file="../include/header.jsp" %>

<!-- 제목 -->
<div class="row">
    <div class="col-lg-12">
        <h2 class="page-header" style="text-align: center;">사원 목록</h2>
    </div>
</div>

<!-- 검색 폼 -->
<div class='row' style="text-align: center; margin-bottom:10px;">
	<div class="col-lg-12">
		<form id='searchForm' action="<c:url value='/emp/list' />" method='get'>
			<div class="form-group">
                <label class="control-label col-md-3"></label>
                <div class="col-md-3">
                    <input type="text" class="form-control" name="searchText" id="searchText" value="${pageMaker.cri.searchText}" />
                </div>
                <div class="col-md-6" style="text-align: left;">
                    <input type="submit" id="btnSearch" class='btn btn-info' value="검색" />
                    <input type="button" class='btn btn-warning' onclick="location.href='<c:url value='/emp/list' />'" value="전체보기" />
                    <input type="button" class='btn btn-success' value="사원등록" onclick="location.href='<c:url value='/emp/register' />'" />
                </div>
            </div>
		</form>
	</div>
</div>

<!-- 테이블 -->
<div class="row">
    <div class="col-lg-12">
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>순서</th>
                    <th>사번</th>
                    <th>성명</th>
                    <th>이메일</th>
                    <th>연락처</th>
                    <th>입사일</th>
                    <th>직위</th>
                    <th>급여</th>
                    <th>부서명</th>
                    <th>근무지역</th>
                    <th>근무도시</th>
                    <th>근무국가</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${empList}" var="emp" varStatus="i">
                    <tr>
                        <td align="center">${i.count}</td>
                        <td>${emp.employeeId}</td>
                        <td>
                            <a href="<c:url value='/emp/read?employeeId=${emp.employeeId}' />">
                                ${emp.firstName} ${emp.lastName}
                            </a>
                        </td>
                        <td>${emp.email}</td>
                        <td>${emp.phoneNumber}</td>
                        <td><fmt:formatDate pattern="yyyy-MM-dd" value="${emp.hireDate}" /></td>
                        <td>${emp.jobTitle}</td>
                        <td>${emp.salary}</td>
                        <td>${emp.departmentName}</td>
                        <td>${emp.stateProvince}</td>
                        <td>${emp.city}</td>
                        <td>${emp.countryName}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- 페이지 네비게이션 -->
<div style="text-align: center;">
    <ul class="pagination">
        <c:if test="${pageMaker.prev}">
            <li><a href="<c:url value='/emp/list?pageNum=${pageMaker.startPage - 1}' />">Previous</a></li>
        </c:if>
        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <li class="${pageMaker.cri.pageNum == num ? 'active' : ''}">
                <a href="<c:url value='/emp/list?pageNum=${num}' />">${num}</a>
            </li>
        </c:forEach>
        <c:if test="${pageMaker.next}">
            <li><a href="<c:url value='/emp/list?pageNum=${pageMaker.endPage + 1}' />">Next</a></li>
        </c:if>
    </ul>
</div>

<!-- 푸터 부분 인클루드 -->
<%@ include file="../include/footer.jsp" %>
