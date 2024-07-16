<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<html>
<head>
    <title>Bán hàng</title>
</head>
<body>
<%@ include file="nav.jsp" %>
<c:if test="${not empty successMessage}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${successMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>
<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${errorMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>
<div class="row">
    <div class="col-md-8">
        <h2>Danh sách hóa đơn</h2>
        <table class="table table-hover">
            <thead>
            <tr>
                <th>STT</th>
                <th>ID</th>
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
                    <td>${hoaDon.id}</td>
                    <td>${hoaDon.khachHang.ho_ten}</td>
                    <td>${hoaDon.dia_chi}</td>
                    <td>${hoaDon.so_dien_thoai}</td>
                    <td>${hoaDon.trang_thai}</td>
                    <td>
                        <fmt:parseDate value="${hoaDon.ngay_tao}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS" var="ngayTaoParsed"/>
                        <fmt:formatDate value="${ngayTaoParsed}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
                    </td>
                    <td>
                        <fmt:parseDate value="${hoaDon.ngay_sua}" pattern="yyyy-MM-dd'T'HH:mm:ss.SSS" var="ngaySuaParsed"/>
                        <fmt:formatDate value="${ngaySuaParsed}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
                    </td>
                    <td>
                        <a href="/ban-hang-detailCT?id_hoa_don=${hoaDon.id}&page=${currentPage}" class="btn btn-primary">Chọn</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div class="card-footer">
            <ul class="pagination">
                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                    <a class="page-link" href="?page=0&id_hoa_don=${hoaDon.id}">First</a>
                </li>
                <c:forEach var="pageNumber" begin="0" end="${totalPages - 1}">
                    <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?page=${pageNumber}&id_hoa_don=${hoaDon.id}">${pageNumber + 1}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages - 1 ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${totalPages - 1}&id_hoa_don=${hoaDon.id}">Last</a>
                </li>
            </ul>
        </div>
    </div>
    <div class="col-md-3">
        <h2>Hóa đơn</h2>
        <form action="/ban-hang-addHD" method="post">
            <input type="hidden" name="page" value="${currentPage}">
            <div class="mb-3">
                <label class="form-label">Id:</label>
                <input type="text" class="form-control" name="id_hoa_don" value="${hoaDon.id}" readonly>
            </div>
            <div class="mb-3">
                <label class="form-label">Khách hàng:</label>
                <select name="id_khach_hang" class="form-select">
                    <c:forEach items="${listKhachHang}" var="kh">
                        <option value="${kh.id}" ${kh.id==khachHang.id? 'selected' : (kh.id == hoaDon.khachHang.id?'selected':'')}>${kh.id}. ${kh.ho_ten}</option>
                    </c:forEach>
                </select>
                <a href="/add-khach-hang" class="btn btn-primary">Thêm khách hàng mới</a>
                <a href="/add-khach-hang-vl" class="btn btn-primary">Vãng lai</a>
            </div>
            <div class="mb-3">
                <h4>Tổng tiền: <fmt:formatNumber value="${totalAmount}"/>$</h4> <!-- Display total amount here -->
            </div>
            <button type="submit" class="btn btn-outline-success mt-3">Tạo hóa đơn</button>
        </form>
        <form action="/ban-hang-thanh-toan" method="post" id="paymentForm" onsubmit="return validateThanhToan()">
            <input type="hidden" id="id_hoa_don" name="id_hoa_don" value="${hoaDon.id}">
            <button type="submit" class="btn btn-outline-primary">Thanh toán</button>
        </form>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <h2>Chi tiết hóa đơn</h2>
        <table class="table table-hover">
            <thead>
            <tr>
                <th>STT</th>
                <th>ID</th>
                <th>Sản phẩm</th>
                <th>Số lượng mua</th>
                <th>Giá bán</th>
                <th>Tổng tiền</th>
                <th>Chức năng</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listHDCT}" var="hdct" varStatus="i">
                <tr class="product-row">
                    <td>${i.index + 1}</td>
                    <td>${hdct.id}</td>
                    <td>${hdct.ctsp.sanPham.ten_san_pham} - ${hdct.ctsp.mauSac.ten_mau} - ${hdct.ctsp.size.ten_size}</td>
                    <td>${hdct.so_luong_mua}</td>
                    <td>${hdct.gia_ban}</td>
                    <td>${hdct.tong_tien}</td>
                    <td>
                        <a href="/ban-hang-delete?id=${hdct.id}&id_hoa_don=${hoaDon.id}" class="btn btn-danger">Xóa</a>
                        <a href="#" class="btn btn-primary" onclick="updateProductWithDefaultQuantity(${hdct.id}, ${hoaDon.id}, ${hdct.so_luong_mua})">Cập nhật</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<h2>Danh sách chi tiết sản phẩm</h2>
<table class="table table-hover">
    <thead>
    <tr>
        <th>STT</th>
        <th>Màu sắc</th>
        <th>Size</th>
        <th>Giá bán</th>
        <th>Số lượng tồn</th>
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
            <td>${ctsp.sanPham.ten_san_pham} (${ctsp.sanPham.ma_san_pham})</td>
            <td>
                <a href="#" class="btn btn-primary" onclick="chooseProduct(${ctsp.id}, ${hoaDon.id})">Chọn</a>
                <input type="hidden" id="soLuongTon_${ctsp.id}" value="${ctsp.so_luong_ton}">
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<script>
    document.getElementById('paymentForm').addEventListener('submit', function(event) {
        if (!validateThanhToan()) {
            event.preventDefault();
        } else {
            event.preventDefault(); // Ngăn chặn hành động mặc định của form
            var id_hoa_don = "${hoaDon.id}";

            fetch('/ban-hang-thanh-toan?id_hoa_don=' + id_hoa_don, { method: 'POST' })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Lỗi khi tải tệp PDF');
                    }
                    return response.blob();
                })
                .then(blob => {
                    const url = window.URL.createObjectURL(blob);
                    const a = document.createElement('a');
                    a.style.display = 'none';
                    a.href = url;
                    a.download = 'hoa-don.pdf';
                    document.body.appendChild(a);
                    a.click();
                    window.URL.revokeObjectURL(url);
                    window.location.href = '/ban-hang';
                })
                .catch(error => {
                    console.error('Lỗi:', error);
                    alert('Đã xảy ra lỗi khi tải tệp PDF.');
                    window.location.href = '/ban-hang';
                });
        }
    });

    function validateThanhToan() {
        var selectedHoaDon = document.getElementById("id_hoa_don").value;
        var numberOfProducts = document.getElementsByClassName("product-row").length;

        if (!selectedHoaDon) {
            alert("Vui lòng chọn hóa đơn trước khi thanh toán.");
            return false; // Ngăn form được submit
        } else if (numberOfProducts === 0) {
            alert("Vui lòng chọn sản phẩm cho hóa đơn trước khi thanh toán.");
            return false; // Ngăn form được submit
        }

        return true; // Cho phép form được submit
    }

    function chooseProduct(id_ctsp, id_hoa_don) {
        if (id_hoa_don == null || id_hoa_don === "") {
            alert("Vui lòng chọn hóa đơn trước khi chọn sản phẩm.");
            return;
        }

        var soLuongTon = document.getElementById("soLuongTon_" + id_ctsp).value;
        var soLuong = prompt("Nhập số lượng mua:", "1");
        if (soLuong !== null && !isNaN(soLuong) && parseInt(soLuong) > 0) {
            if (parseInt(soLuong) <= parseInt(soLuongTon)) {
                window.location.href = "/ban-hang-selectProduct?id_ctsp=" + id_ctsp + "&id_hoa_don=" + id_hoa_don + "&soLuong=" + soLuong + "&page=${currentPage}";
            } else {
                alert("Số lượng mua vượt quá số lượng tồn kho. Vui lòng nhập lại.");
            }
        } else if (soLuong !== null) {
            alert("Vui lòng nhập một số nguyên dương hợp lệ.");
        }
    }

    function updateProductWithDefaultQuantity(id_hdct, id_hoa_don, currentQuantity) {
        var soLuong = prompt("Nhập số lượng mới:", currentQuantity);
        if (soLuong !== null && !isNaN(soLuong) && parseInt(soLuong) > 0) {
            window.location.href = "/ban-hang-update?id_hdct=" + id_hdct + "&id_hoa_don=" + id_hoa_don + "&soLuong=" + soLuong;
        } else if (soLuong !== null) {
            alert("Vui lòng nhập một số nguyên dương hợp lệ.");
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
