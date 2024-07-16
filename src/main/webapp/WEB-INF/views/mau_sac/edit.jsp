<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<html>
<head>
    <title>Sửa màu sắc</title>
</head>
<body>
<form action="/mau-sac/update?id=${mauSac.id}" method="post">
    <div class="mb-3">
        <label class="form-label">Mã màu:</label>
        <input type="text" class="form-control" name="ma_mau" value="${mauSac.ma_mau}">
    </div>
    <div class="mb-3">
        <label class="form-label">Tên màu:</label>
        <input type="text" class="form-control" name="ten_mau" value="${mauSac.ten_mau}">
    </div>
    <label class="form-label">Trạng thái:</label>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Active" ${mauSac.trang_thai == 'Active' ? 'checked' : ''}>
        <label class="form-check-label">
            Active
        </label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Inactive" ${mauSac.trang_thai == 'Inactive' ? 'checked' : ''}>
        <label class="form-check-label">
            Inactive
        </label>
    </div>
    <button type="submit" class="btn btn-outline-success">Update</button>
</form>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>