<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<html>
<head>
    <title>Sửa chi tiết sản phẩm</title>
</head>
<body>
<form action="/ctsp/update" method="post">
    <input type="hidden" name="id" value="${ctsp.id}">
    <input type="hidden" name="id_sp" value="${id_sp}">
    <div class="mb-3">
        <label class="form-label">Màu sắc:</label>
        <select name="mauSac.id" class="form-select">
            <c:forEach items="${listMauSac}" var="ms">
                <option value="${ms.id}" ${ms.id == ctsp.mauSac.id ? 'selected' : ''}>${ms.ten_mau}</option>
            </c:forEach>
        </select>
    </div>
    <div class="mb-3">
        <label class="form-label">Size:</label>
        <select name="size.id" class="form-select">
            <c:forEach items="${listSize}" var="s">
                <option value="${s.id}" ${s.id == ctsp.size.id ? 'selected' : ''}>${s.ten_size}</option>
            </c:forEach>
        </select>
    </div>
    <div class="mb-3">
        <label class="form-label">Giá bán:</label>
        <input type="text" class="form-control" name="gia_ban" value="${ctsp.gia_ban}">
    </div>
    <div class="mb-3">
        <label class="form-label">Số lượng tồn:</label>
        <input type="number" class="form-control" name="so_luong_ton" value="${ctsp.so_luong_ton}">
    </div>
    <label class="form-label">Trạng thái:</label>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Active" ${ctsp.trang_thai == 'Active' ? 'checked' : ''}>
        <label class="form-check-label">
            Active
        </label>
    </div>
    <div class="form-check">
        <input class="form-check-input" type="radio" name="trang_thai" value="Inactive" ${ctsp.trang_thai == 'Inactive' ? 'checked' : ''}>
        <label class="form-check-label">
            Inactive
        </label>
    </div>

    <button type="submit" class="btn btn-outline-success">Update</button>
</form>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>
