<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<html>
<head>
    <title>Quản lý khách hàng</title>
</head>
<body>
<%@ include file="../nav.jsp" %>

<form action="/khach_hang/add" method="post">
    <div class="mb-3">
        <label class="form-label">Họ tên:</label>
        <input type="text" class="form-control" name="ho_ten">
    </div>
    <div class="mb-3">
        <label class="form-label">Địa chỉ:</label>
        <input type="text" class="form-control" name="dia_chi">
    </div>
    <div class="mb-3">
        <label class="form-label">Số điện thoại:</label>
        <input type="text" class="form-control" name="sdt">
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

<table class="table table-hover">
    <thead>
    <tr>
        <th>STT</th>
        <th>ID</th>
        <th>Họ tên</th>
        <th>Địa chỉ</th>
        <th>Số điện thoại</th>
        <th>Trạng thái</th>
        <th>Ngày tạo</th>
        <th>Ngày sửa</th>
        <th colspan="2">Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${listKhachHang}" var="khachHang" varStatus="i">
        <tr>
            <td>${i.index + 1}</td>
            <td>${khachHang.id}</td>
            <td>${khachHang.ho_ten}</td>
            <td>${khachHang.dia_chi}</td>
            <td>${khachHang.sdt}</td>
            <td>${khachHang.trang_thai}</td>
            <td>
                <fmt:parseDate value="${khachHang.ngay_tao}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS" var="ngayTaoParsed"/>
                <fmt:formatDate value="${ngayTaoParsed}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
            </td>
            <td>
                <fmt:parseDate value="${khachHang.ngay_sua}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS" var="ngaySuaParsed"/>
                <fmt:formatDate value="${ngaySuaParsed}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
            </td>
            <td>
                <a href="/khach_hang/delete?id=${khachHang.id}" class="btn btn-danger">Xóa</a>
                <a href="/khach_hang/detail?id=${khachHang.id}" class="btn btn-secondary">Edit</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="card-footer">
    <ul class="pagination">
        <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
            <a class="page-link" href="?page=0">First</a>
        </li>
        <c:forEach var="pageNumber" begin="0" end="${totalPages - 1}">
            <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                <a class="page-link" href="?page=${pageNumber}">${pageNumber + 1}</a>
            </li>
        </c:forEach>
        <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
            <a class="page-link" href="?page=${totalPages - 1}">Last</a>
        </li>
    </ul>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
