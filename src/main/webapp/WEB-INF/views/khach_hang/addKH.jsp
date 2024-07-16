<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<html>
<head>
    <title>Thêm khách hàng</title>
</head>
<body>
<form action="/khach_hang-addKH" method="post">
    <div class="mb-3">
        <label class="form-label">Họ tên:</label>
        <input type="text" class="form-control" name="ho_ten" >
    </div>
    <div class="mb-3">
        <label class="form-label">Địa chỉ:</label>
        <input type="text" class="form-control" name="dia_chi" >
    </div>
    <div class="mb-3">
        <label class="form-label">Số điện thoại:</label>
        <input type="text" class="form-control" name="sdt" >
    </div>

    <button type="submit" class="btn btn-outline-success">ADD</button>
</form>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script
