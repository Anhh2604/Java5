<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: aliceblue;
    }
    .navbar {
        margin-bottom: 20px;
    }
    .navbar-brand {
        font-weight: bold;
    }
    .nav-link {
        font-size: 16px;
    }
    footer {
        position: fixed;
        bottom: 0;
        width: 100%;
    }
</style>

<html>
<head>
    <title>Trang chủ</title>
</head>
<body>
<div class="">
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="">
            <a class="navbar-brand" href="trang-chu">Trang chủ</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="san_pham">Sản phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="danh_muc">Danh mục</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="mau_sac">Màu sắc</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="size">Size</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="khach_hang">Khách hàng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="hoa_don">Hóa đơn</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="ban-hang">Bán hàng</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="lich-su">Lịch sử</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>




</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
