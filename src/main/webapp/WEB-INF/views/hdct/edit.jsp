<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

<html>
<head>
    <title>Sửa chi tiết hóa đơn</title>
</head>
<body>
<%@ include file="../nav.jsp" %>
<form action="/hdct/update?id=${HDCT.id}" method="post">
    <input type="hidden" name="id" value="${HDCT.id}">
    <input type="hidden" name="id_hoa_don" value="${id_hoa_don}">
    <div class="mb-3">
        <label class="form-label">Sản phẩm:</label>
        <select name="ctsp.id" class="form-select" onchange="updatePrice()">
            <c:forEach items="${listCTSP}" var="ctsp">
                <option value="${ctsp.id}" ${HDCT.ctsp.id == ctsp.id ? 'selected' : ''} data-gia-ban="${ctsp.gia_ban}">${ctsp.sanPham.ten_san_pham}-${ctsp.mauSac.ten_mau}-${ctsp.size.ten_size}</option>
            </c:forEach>
        </select>
    </div>
    <div class="mb-3">
        <label class="form-label">Số lượng mua:</label>
        <input type="text" class="form-control" name="so_luong_mua" value="${HDCT.so_luong_mua}">
    </div>
    <div class="mb-3">
        <label class="form-label">Giá bán:</label>
        <input type="text" class="form-control" id="gia_ban_display" name="gia_ban" value="${HDCT.gia_ban}" disabled>
        <input type="hidden" name="gia_ban" id="gia_ban_hidden" value="${HDCT.gia_ban}">
    </div>
    <button type="submit" class="btn btn-outline-success">Cập nhật</button>
</form>
</body>
<script>
    function updatePrice() {
        var selectedOption = document.querySelector('select[name="ctsp.id"] option:checked');
        var giaBan = selectedOption.getAttribute('data-gia-ban');
        document.getElementById('gia_ban_display').value = giaBan;
        document.getElementById('gia_ban_hidden').value = giaBan;
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>
