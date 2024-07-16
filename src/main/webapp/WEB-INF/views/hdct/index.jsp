<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<html>
<head>
    <title>Quản lý hóa đơn chi tiết</title>
</head>
<body>
<%@ include file="../nav.jsp" %>
<form action="/hdct/add" method="post">
    <label class="form-label">Id:</label>
    <input class="form-control" name="id_hoa_don" value="${id_hoa_don}" readonly>
    <div class="mb-3">
        <label class="form-label">Sản phẩm:</label>
        <select name="ctsp.id" class="form-select" onchange="updatePrice()">
            <c:forEach items="${listCTSP}" var="ctsp">
                <option value="${ctsp.id}" data-gia-ban="${ctsp.gia_ban}">${ctsp.sanPham.ten_san_pham}-${ctsp.mauSac.ten_mau}-${ctsp.size.ten_size}</option>
            </c:forEach>
        </select>
    </div>
    <div class="mb-3">
        <label class="form-label">Số lượng mua:</label>
        <input type="text" class="form-control" name="so_luong_mua">
    </div>
    <div class="mb-3">
        <label class="form-label">Giá bán:</label>
        <input type="text" class="form-control" id="gia_ban_display" disabled>
        <input type="hidden" id="gia_ban_hidden" name="gia_ban">
    </div>
    <button type="submit" class="btn btn-outline-success">Thêm HDCT</button>
</form>


<table class="table table-hover">
    <thead>
    <tr>
        <th>STT</th>
        <th>Sản phẩm</th>
        <th>Số lượng mua</th>
        <th>Giá bán</th>
        <th>Tổng tiền</th>
        <th>Ngày tạo</th>
        <th>Ngày sửa</th>
        <th>Hành động</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${listHDCT}" var="hdct" varStatus="i">
        <tr>
            <td>${i.index + 1}</td>
            <td>${hdct.ctsp.sanPham.ten_san_pham} - ${hdct.ctsp.mauSac.ten_mau} - ${hdct.ctsp.size.ten_size}</td>
            <td>${hdct.so_luong_mua}</td>
            <td>${hdct.gia_ban}</td>
            <td>${hdct.tong_tien}</td>
            <td>
                <fmt:parseDate value="${hdct.ngay_tao}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS" var="ngayTaoParsed"/>
                <fmt:formatDate value="${ngayTaoParsed}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
            </td>
            <td>
                <fmt:parseDate value="${hdct.ngay_sua}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS" var="ngaySuaParsed"/>
                <fmt:formatDate value="${ngaySuaParsed}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
            </td>
            <td>
                <a href="/hdct/delete?id=${hdct.id}" class="btn btn-danger">Xóa</a>
                <a href="/hdct/detail?id=${hdct.id}&id_hoa_don=${hdct.hoaDon.id}" class="btn btn-secondary">Chi tiết</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table><div class="card-footer">
    <ul class="pagination">
        <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
            <a class="page-link" href="?page=0">First</a>
        </li>
        <c:forEach var="pageNumber" begin="0" end="${totalPages > 0 ? totalPages - 1 : 0}">
            <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                <a class="page-link" href="?page=${pageNumber}&id_hoa_don=${id_hoa_don}">${pageNumber + 1}</a>
            </li>
        </c:forEach>
        <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
            <a class="page-link" href="?page=${totalPages - 1}">Last</a>
        </li>
    </ul>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script>
    function updatePrice() {
        var selectedOption = document.querySelector('select[name="ctsp.id"] option:checked');
        var giaBan = selectedOption.getAttribute('data-gia-ban');
        document.getElementById('gia_ban_display').value = giaBan;
        document.getElementById('gia_ban_hidden').value = giaBan;
    }
</script>
</body>
</html>
