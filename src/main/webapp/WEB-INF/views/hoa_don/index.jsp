<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<html>
<head>
    <title>Quản lý hóa đơn</title>
</head>
<body>
<%@ include file="../nav.jsp" %>
<a href="/hoa_don-completed" class="btn btn-secondary">Đã hoàn thành</a>

<form action="/hoa_don/add" method="post">
    <div class="mb-3">
        <label class="form-label">Khách hàng:</label>
        <select name="id_khach_hang" class="form-select">
            <c:forEach items="${listKhachHang}" var="kh">
                <option value="${kh.id}">${kh.id}. ${kh.ho_ten}</option>
            </c:forEach>
        </select>
    </div>
    <button type="submit" class="btn btn-outline-success">Add</button>
</form>

<table class="table table-hover">
    <thead>
    <tr>
        <th>STT</th>
        <th>Khách hàng</th>
        <th>Địa chỉ</th>
        <th>Số điện thoại</th>
        <th>Trạng thái</th>
        <th>Ngày tạo</th>
        <th>Ngày sửa</th>
        <th colspan="2">Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${listHoaDon}" var="hoaDon" varStatus="i">
        <tr>
            <td>${i.index + 1}</td>
            <td>${hoaDon.khachHang.ho_ten}</td>
            <td>${hoaDon.khachHang.dia_chi}</td>
            <td>${hoaDon.khachHang.sdt}</td>
            <td>${hoaDon.trang_thai}</td>
            <td>
                <fmt:parseDate value="${hoaDon.ngay_tao}" pattern="yyyy-MM-dd'T'HH:mm" var="ngayTaoParsed"/>
                <fmt:formatDate value="${ngayTaoParsed}" pattern="dd-MM-yyyy HH:mm"/>
            </td>
            <td>
                <fmt:parseDate value="${hoaDon.ngay_sua}" pattern="yyyy-MM-dd'T'HH:mm" var="ngaySuaParsed"/>
                <fmt:formatDate value="${ngaySuaParsed}" pattern="dd-MM-yyyy HH:mm"/>
            </td>
            <td>
                <a href="/hoa_don/delete?id=${hoaDon.id}" class="btn btn-danger">Xóa</a>
                <a href="/hoa_don/detail?id=${hoaDon.id}" class="btn btn-secondary">Edit</a>
                <a href="/hdct?id_hoa_don=${hoaDon.id}" class="btn btn-secondary">Chi tiết</a>
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
