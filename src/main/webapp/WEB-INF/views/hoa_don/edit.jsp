<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<html>
<head>
    <title>Sửa hóa đơn</title>
</head>
<body>
<form action="/hoa_don/update?id=${hoaDon.id}" method="post">
    <div class="mb-3">
        <label class="form-label">Khách hàng:</label>
        <select name="id_khach_hang" class="form-select">
            <c:forEach items="${listKhachHang}" var="kh">
                <option value="${kh.id}" ${kh.id == hoaDon.khachHang.id? 'selected' : ''}>${kh.id}.${kh.ho_ten}</option>
            </c:forEach>
        </select>
    </div>
    <div class="mb-3">
        <label class="form-label">Địa chỉ:</label>
        <input type="text" class="form-control" name="dia_chi" value="${hoaDon.dia_chi}" readonly>
    </div>
    <div class="mb-3">
        <label class="form-label">Số điện thoại:</label>
        <input type="text" class="form-control" name="so_dien_thoai" value="${hoaDon.so_dien_thoai}" readonly>
    </div>
    <label class="form-label">Trạng thái:</label>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Active" ${hoaDon.trang_thai == 'Active' ? 'checked' : ''}>
        <label class="form-check-label">
            Active
        </label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Inactive" ${hoaDon.trang_thai == 'Inactive' ? 'checked' : ''}>
        <label class="form-check-label">
            Inactive
        </label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Completed" ${hoaDon.trang_thai == 'Completed' ? 'checked' : ''}>
        <label class="form-check-label">
            Completed
        </label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Pending" ${hoaDon.trang_thai == 'Pending' ? 'checked' : ''}>
        <label class="form-check-label">
            Pending
        </label>
    </div>
    <button type="submit" class="btn btn-outline-success">Update</button>
</form>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>
