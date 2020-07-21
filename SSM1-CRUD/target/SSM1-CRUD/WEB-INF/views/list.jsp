<%--
  Created by IntelliJ IDEA.
  User: Monster
  Date: 2020/7/15
  Time: 10:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <script src="static/jquery/js/jquery.min.js"></script>
    <script src="static/bootstrap/js/bootstrap.min.js"></script>
    <link href="static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <title>员工列表</title>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h3>SSM-CRUD</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <td>#</td>
                    <td>empName</td>
                    <td>gender</td>
                    <td>email</td>
                    <td>deptName</td>
                    <td>操作</td>
                </tr>
                <c:forEach items="#{pageInfo.list}" var="employee" >
                    <tr>
                        <td>${employee.empId}</td>
                        <td>${employee.empName}</td>
                        <td>${employee.gender=="M"?"男":"女"}</td>
                        <td>${employee.email}</td>
                        <td>${employee.department.deptName}</td>
                        <td>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </td>
                    </tr>
                </c:forEach>

            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6">
            当前第${pageInfo.pageNum}页,总共${pageInfo.pages}页,总共${pageInfo.total}条记录
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="emps">首页</a></li>

                    <c:if test="${!pageInfo.isFirstPage}">
                        <li>
                            <a href="emps?pn=${pageInfo.pageNum - 1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                        <li class=${pageInfo.pageNum==pageNum?"active":""}><a href="emps?pn=${pageNum}">${pageNum}</a></li>
                    </c:forEach>
                    <c:if test="${!pageInfo.isLastPage}">
                        <li>
                            <a href="emps?pn=${pageInfo.pageNum + 1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li><a href="emps?pn=${pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
