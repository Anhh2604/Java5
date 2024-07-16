<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<html>
<head>
    <title>Sửa khách hàng</title>
</head>
<body>
<form action="/khach_hang/update?id=${khachHang.id}" method="post">
    <div class="mb-3">
        <label class="form-label">Họ tên:</label>
        <input type="text" class="form-control" name="ho_ten" value="${khachHang.ho_ten}">
    </div>
    <div class="mb-3">
        <label class="form-label">Địa chỉ:</label>
        <input type="text" class="form-control" name="dia_chi" value="${khachHang.dia_chi}">
    </div>
    <div class="mb-3">
        <label class="form-label">Số điện thoại:</label>
        <input type="text" class="form-control" name="sdt" value="${khachHang.sdt}">
    </div>
    <label class="form-label">Trạng thái:</label>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Active" ${khachHang.trang_thai == 'Active' ? 'checked' : ''}>
        <label class="form-check-label">
            Active
        </label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Inactive" ${khachHang.trang_thai == 'Inactive' ? 'checked' : ''}>
        <label class="form-check-label">
            Inactive
        </label>
    </div>
    <button type="submit" class="btn btn-outline-success">Update</button>
</form>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script
