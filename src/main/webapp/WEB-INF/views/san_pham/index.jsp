<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quản lý sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<%@ include file="../nav.jsp" %>
<form action="/san-pham/add" method="post">
    <div class="mb-3">
        <label class="form-label">Mã sản phẩm:</label>
        <input type="text" class="form-control" name="ma_san_pham">
    </div>
    <div class="mb-3">
        <label  class="form-label">Tên sản phẩm:</label>
        <input type="text" class="form-control" name="ten_san_pham">
    </div>
    <label class="form-label">Trạng thái:</label>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai"  value="Active" checked>
        <label class="form-check-label">
            Active
        </label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Inactive" >
        <label class="form-check-label" >
            Inactive
        </label>
    </div>
    <div class="mb-3">
        <label  class="form-label">Danh mục:</label>
        <select name="danhMuc.id" class="form-select">
            <c:forEach items="${listDanhMuc}" var="dm">
                <option value="${dm.id}">${dm.ten_danh_muc}</option>
            </c:forEach>
        </select>
    </div>
    <button type="submit" class="btn btn-outline-success">Add</button>
</form>
<table class="table table-hover">
    <thead>
    <tr>
        <th>STT</th>
        <th>ID</th>
        <th>Mã sản phẩm</th>
        <th>Tên sản phẩm</th>
        <th>Trạng thái</th>
        <th>Ngày tạo</th>
        <th>Ngày sửa</th>
        <th>Danh mục</th>
        <th colspan="2">Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${listSanPham}" var="sp" varStatus="i">
        <tr>
            <td>${i.index+1}</td>
            <td>${sp.id}</td>
            <td>${sp.ma_san_pham}</td>
            <td>${sp.ten_san_pham}</td>
            <td>${sp.trang_thai}</td>
            <td>
                <fmt:parseDate value="${sp.ngay_tao}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS" var="ngayTaoParsed"/>
                <fmt:formatDate value="${ngayTaoParsed}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
            </td>
            <td>
                <fmt:parseDate value="${sp.ngay_sua}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS" var="ngaySuaParsed"/>
                <fmt:formatDate value="${ngaySuaParsed}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
            </td>
            <td>${sp.danhMuc.ten_danh_muc}</td>
            <td>
                <a href="/san-pham/delete?id=${sp.id}" class="btn btn-danger">Xóa</a>
                <a href="/san-pham/detail?id=${sp.id}" class="btn btn-secondary">Edit</a>
                <a href="/ctsp?id_sp=${sp.id}" class="btn btn-secondary">Chi tiết</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<ul class="pagination">
    <li class="page-item ${sanPhamPage.first ? 'disabled' : ''}">
        <a class="page-link" href="?page=0">First</a>
    </li>
    <c:forEach begin="0" end="${sanPhamPage.totalPages - 1}" var="i">
        <li class="page-item ${i == sanPhamPage.number ? 'active' : ''}">
            <a class="page-link" href="?page=${i}">${i + 1}</a>
        </li>
    </c:forEach>
    <li class="page-item ${sanPhamPage.last ? 'disabled' : ''}">
        <a class="page-link" href="?page=${sanPhamPage.totalPages - 1}">Last</a>
    </li>
</ul>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
