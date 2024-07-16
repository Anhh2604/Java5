<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<html>
<head>
    <title>Lịch sử</title>
</head>
<body>
<%@ include file="nav.jsp" %>
<select name="khoang_thoi_gian" class="form form-select" onchange="changeTimeRange(this.value)">
    <option value="10000">Tất cả</option>
    <option value="90">90 ngày trước</option>
    <option value="60">60 ngày trước</option>
    <option value="30">30 ngày trước</option>
    <option value="14">14 ngày trước</option>
    <option value="7">7 ngày trước</option>
    <option value="3">3 ngày trước</option>
    <option value="1">1 ngày trước</option>

</select>
<table class="table table-hover">
    <thead>
    <tr>
        <th>STT</th>
        <th>Khách hàng</th>
        <th>Địa chỉ</th>
        <th>Số điện thoại</th>
        <th>Ngày tháng</th>
        <th>Tổng tiền</th>
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

            <td>
                <fmt:parseDate value="${hoaDon.ngay_sua}" pattern="yyyy-MM-dd'T'HH:mm" var="ngaySuaParsed"/>
                <fmt:formatDate value="${ngaySuaParsed}" pattern="dd-MM-yyyy HH:mm"/>
            </td>
            <td>
                    <%-- Tính tổng tiền từ chi tiết hóa đơn --%>
                <c:set var="total" value="0" />
                <c:forEach items="${hoaDon.hoaDonChiTiets}" var="hdct">
                    <c:set var="total" value="${total + hdct.tong_tien}" />
                </c:forEach>
                    ${total} $
            </td>
            <td>
                    <%--                <a href="/hoa_don/delete?id=${hoaDon.id}" class="btn btn-danger">Xóa</a>--%>
                    <%--                <a href="/hoa_don/detail?id=${hoaDon.id}" class="btn btn-secondary">Edit</a>--%>
                <a href="/hdct?id_hoa_don=${hoaDon.id}" class="btn btn-secondary">Chi tiết</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<script>
    window.onload = function() {
        // Lấy giá trị đã chọn từ URL
        var selectedValue = getSelectedValueFromURL();

        // Tìm option có giá trị tương ứng và đặt thuộc tính selected
        var selectElement = document.querySelector('select[name="khoang_thoi_gian"]');
        var options = selectElement.options;
        for (var i = 0; i < options.length; i++) {
            if (options[i].value === selectedValue) {
                options[i].selected = true;
                break;
            }
        }
    }

    // Hàm này để lấy giá trị được chọn từ URL
    function getSelectedValueFromURL() {
        var urlParams = new URLSearchParams(window.location.search);
        var daysAgo = urlParams.get('daysAgo');
        if (daysAgo) {
            return daysAgo;
        }
        return "10000"; // Giá trị mặc định nếu không có tham số daysAgo trong URL
    }
    function changeTimeRange(value) {
        switch (value) {
            case "10000":
                window.location.href = "/lich-su";
                break;
            case "1":
                window.location.href = "/lich-su-pending?daysAgo=1";
                break;
            case "3":
                window.location.href = "/lich-su-pending?daysAgo=3";
                break;
            case "7":
                window.location.href = "/lich-su-pending?daysAgo=7";
                break;
            case "14":
                window.location.href = "/lich-su-pending?daysAgo=14";
                break;
            case "30":
                window.location.href = "/lich-su-pending?daysAgo=30";
                break;
            case "60":
                window.location.href = "/lich-su-pending?daysAgo=60";
                break;
            case "90":
                window.location.href = "/lich-su-pending?daysAgo=90";
                break;
            default:
                break;
        }

    }

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
