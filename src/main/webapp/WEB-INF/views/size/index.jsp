<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<html>
<head>
    <title>Quản lý size</title>
</head>
<body>
<%@ include file="../nav.jsp" %>
<form action="/size/add" method="post">
    <div class="mb-3">
        <label class="form-label">Mã size:</label>
        <input type="text" class="form-control" name="ma_size">
    </div>
    <div class="mb-3">
        <label class="form-label">Tên size:</label>
        <input type="text" class="form-control" name="ten_size">
    </div>
    <label class="form-label">Trạng thái:</label>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Active" checked>
        <label class="form-check-label">Active</label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Inactive">
        <label class="form-check-label">Inactive</label>
    </div>
    <button type="submit" class="btn btn-outline-success">Add</button>
</form>
<form action="/size/search" method="post">
    <div class="mb-3">
        <label class="form-label">Tìm kiếm:</label>
        <input type="text" class="form-control" name="search" value="${search}">
        <button type="submit" class="btn btn-outline-success">Search</button>
    </div>
</form>
<table class="table table-hover">
    <thead>
    <tr>
        <th>STT</th>
        <th>ID</th>
        <th>Mã size</th>
        <th>Tên size</th>
        <th>Trạng thái</th>
        <th>Ngày tạo</th>
        <th>Ngày sửa</th>
        <th colspan="2">Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${listSize}" var="size" varStatus="i">
        <tr>
            <td>${i.index + 1}</td>
            <td>${size.id}</td>
            <td>${size.ma_size}</td>
            <td>${size.ten_size}</td>
            <td>${size.trang_thai}</td>
            <td>
                <fmt:parseDate value="${size.ngay_tao}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS" var="ngayTaoParsed"/>
                <fmt:formatDate value="${ngayTaoParsed}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
            </td>
            <td>
                <fmt:parseDate value="${size.ngay_sua}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS" var="ngaySuaParsed"/>
                <fmt:formatDate value="${ngaySuaParsed}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
            </td>
            <td>
                <a href="/size/delete?id=${size.id}" class="btn btn-danger">Xóa</a>
                <a href="/size/detail?id=${size.id}" class="btn btn-secondary">Edit</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<!-- Phân trang -->
<div class="card-footer">
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                <a class="page-link" href="/size?page=0">First</a>
            </li>
            <c:forEach var="pageNumber" begin="0" end="${totalPages - 1}">
                <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                    <a class="page-link" href="/size?page=${pageNumber}">${pageNumber + 1}</a>
                </li>
            </c:forEach>
            <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                <a class="page-link" href="/size?page=${totalPages - 1}">Last</a>
            </li>
        </ul>
    </nav>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
