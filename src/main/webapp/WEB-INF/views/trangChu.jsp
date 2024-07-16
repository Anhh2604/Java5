<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            background-image: url('https://hoanghamobile.com/tin-tuc/wp-content/webp-express/webp-images/uploads/2024/03/hinh-nen-desktop.jpg.webp');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            margin-bottom: 80px; /* Adjust margin to make space for footer */
        }
        .footer {
            position: fixed;
            bottom: 0;
            width: 100%;
            background-color: #343a40;
            color: white;
            padding: 20px 0;
        }
        .scrollable-content {
            max-height: calc(100vh - 100px); /* Adjust height for scrolling */
            overflow-y: auto;
            padding-bottom: 20px; /* Add space at the bottom for better readability */
        }
    </style>
    <style>
        @keyframes blink {
            0% { opacity: 1; }
            50% { opacity: 0; }
            100% { opacity: 1; }
        }
        .blink {
            animation: blink 1s infinite;
        }
    </style>
</head>
<body>

<%@ include file="nav.jsp" %>

<div class="container mt-5">
    <div class="row">
        <div class="col-md-12 blink">
            <h1 style="color: white;">Xin chào!</h1>
            <p style="color: white;">Chào mừng bạn đến với website bán hàng tại quầy của tôi.</p>
        </div>

        <div class="col-md-12 scrollable-content"> <!-- Make this div scrollable -->
            <div class="card" style="background-color: #212529;"> <!-- Change background color of the card -->
                <div class="card-body">
                    <h1 style="color: white;">Thống kê:</h1>
                    <p style="color: white;">Số lượng sản phẩm: ${tongSoLuong}</p>
                    <p style="color: white;">Số lượng chi tiết sản phẩm: ${tongSoLuongCTSP}</p>
                    <p style="color: white;">Số lượng khách hàng: ${tongSoLuongKH}</p>
                    <p style="color: white;">Tổng số tiền trong ngày: ${totalMoneyByDate}$</p>
                    <p style="color: white;">Tổng số tiền trong tuần: ${totalMoneyByWeek}$</p>
                    <p style="color: white;">Tổng số tiền tháng: ${totalMoneyByMonth}$</p>
                    <p style="color: white;">Tổng số tiền trong năm: ${totalMoneyByYear}$</p>
                </div>
            </div>
        </div>

    </div>
</div>
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5>Thông tin liên hệ</h5>
                <p>Địa chỉ: Tây Tựu, Bắc Từ Liêm, Hà Nội</p>
                <p>Email: Toantnph32021@fpt.edu.vn</p>
                <p>Điện thoại: 0392565937</p>
            </div>
            <div class="col-md-6">
                <h5>Theo dõi chúng tôi trên mạng xã hội</h5>
                <ul class="list-inline">
                    <li class="list-inline-item">
                        <a href="https://www.facebook.com/profile.php?id=100004361595533&locale=vi_VN" target="_blank">
                            <img src="https://cdn.iconscout.com/icon/free/png-512/free-facebook-social-media-fb-logo-square-44659.png?f=webp&w=256" alt="Facebook" style="width: 30px; height: 30px;">
                        </a>
                    </li>
                    <li class="list-inline-item">
                        <a href="https://www.instagram.com/toen._.yang?igsh=cTRqcjdvbnVrc2Zh" target="_blank">
                            <img src="https://cdn.iconscout.com/icon/free/png-512/instagram-233-896451.png" alt="Instagram" style="width: 30px; height: 30px;">
                        </a>
                    </li>
                    <li class="list-inline-item">
                        <a href="https://zalo.me/01692565937" target="_blank">
                            <img src="https://e7.pngegg.com/pngimages/851/579/png-clipart-zalo-laptop-login-mobile-phones-qr-code-laptop-electronics-text-thumbnail.png" alt="Zalo" style="width: 30px; height: 30px;">
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</footer>
<script>
    var element = document.querySelector('.col-md-12');
    var colors = ['#ffffff', '#ff0000', '#00ff00', '#0000ff'];
    var currentColorIndex = 0;
    var childElements = element.querySelectorAll('*'); // Lấy tất cả các phần tử con

    setInterval(function() {
        // Đặt màu sắc mới cho tất cả các phần tử con
        childElements.forEach(function(child) {
            child.style.color = colors[currentColorIndex];
        });
        currentColorIndex = (currentColorIndex + 1) % colors.length;
    }, 1000); // Thay đổi màu mỗi giây
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
