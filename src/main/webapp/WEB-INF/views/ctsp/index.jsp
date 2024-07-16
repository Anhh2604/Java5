<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<html>
<head>
    <title>Quản lý chi tiết sản phẩm</title>
</head>
<body>
<%@ include file="../nav.jsp" %>

<form action="/ctsp/add" method="post">
    <div class="mb-3">
        <label class="form-label">ID sản phẩm:</label>
        <input type="text" class="form-control" name="id_sp" value="${id_sp}" readonly>
    </div>
    <div class="mb-3">
        <label class="form-label">Màu sắc:</label>
        <select name="mauSac.id" class="form-select">
            <c:forEach items="${listMauSac}" var="ms">
                <option value="${ms.id}">${ms.ten_mau}</option>
            </c:forEach>
        </select>
    </div>
    <div class="mb-3">
        <label class="form-label">Size:</label>
        <select name="size.id" class="form-select">
            <c:forEach items="${listSize}" var="s">
                <option value="${s.id}">${s.ten_size}</option>
            </c:forEach>
        </select>
    </div>
    <div class="mb-3">
        <label class="form-label">Giá bán:</label>
        <input type="text" class="form-control" name="gia_ban">
    </div>
    <div class="mb-3">
        <label class="form-label">Số lượng tồn:</label>
        <input type="number" class="form-control" name="so_luong_ton">
    </div>
    <label class="form-label">Trạng thái:</label>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Active" checked>
        <label class="form-check-label">
            Active
        </label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Inactive">
        <label class="form-check-label">
            Inactive
        </label>
    </div>

    <button type="submit" class="btn btn-outline-success">Add</button>
</form>

<table class="table table-hover">
    <thead>
    <tr>
        <th>STT</th>
        <th>Màu sắc</th>
        <th>Size</th>
        <th>Giá bán</th>
        <th>Số lượng tồn</th>
        <th>Trạng thái</th>
        <th>Ngày tạo</th>
        <th>Ngày sửa</th>
        <th>Sản phẩm</th>
        <th colspan="2">Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${listCTSP}" var="ctsp" varStatus="i">
        <tr>
            <td>${i.index + 1}</td>
            <td>${ctsp.mauSac.ten_mau}</td>
            <td>${ctsp.size.ten_size}</td>
            <td>${ctsp.gia_ban}</td>
            <td>${ctsp.so_luong_ton}</td>
            <td>${ctsp.trang_thai}</td>
            <td>
                <fmt:parseDate value="${ctsp.ngay_tao}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="ngayTaoParsed"/>
                <fmt:formatDate value="${ngayTaoParsed}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <td>
                <fmt:parseDate value="${ctsp.ngay_sua}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="ngaySuaParsed"/>
                <fmt:formatDate value="${ngaySuaParsed}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <td>${ctsp.sanPham.ten_san_pham} (${ctsp.sanPham.ma_san_pham})</td>
            <td>
                <a href="/ctsp/delete?id=${ctsp.id}&id_sp=${id_sp}" class="btn btn-danger">Xóa</a>
                <a href="/ctsp/detail?id=${ctsp.id}&id_sp=${id_sp}" class="btn btn-secondary">Edit</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="card-footer">
    <ul class="pagination">
        <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
            <a class="page-link" href="?id_sp=${id_sp}&page=0">First</a>
        </li>
        <c:forEach var="pageNumber" begin="0" end="${totalPages > 0 ? totalPages - 1 : 0}">
            <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                <a class="page-link" href="?id_sp=${id_sp}&page=${pageNumber}">${pageNumber + 1}</a>
            </li>
        </c:forEach>
        <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
            <a class="page-link" href="?id_sp=${id_sp}&page=${totalPages - 1}">Last</a>
        </li>
    </ul>
</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>
