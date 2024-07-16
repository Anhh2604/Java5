    package com.example.demo.controller;
    import org.springframework.http.HttpHeaders;
    import org.springframework.http.HttpStatus;
    import org.springframework.http.MediaType;
    import org.springframework.http.ResponseEntity;
    import com.example.demo.entity.CTSP;
    import com.example.demo.entity.HDCT;
    import com.example.demo.entity.HoaDon;
    import com.example.demo.entity.KhachHang;
    import com.example.demo.repositories.*;
    import com.lowagie.text.DocumentException;
    import jakarta.servlet.http.HttpServletResponse;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.data.domain.Page;
    import org.springframework.data.domain.PageRequest;
    import org.springframework.data.domain.Pageable;
    import org.springframework.http.HttpStatus;
    import org.springframework.http.MediaType;
    import org.springframework.http.ResponseEntity;
    import org.springframework.stereotype.Controller;
    import org.springframework.ui.Model;
    import org.springframework.web.bind.annotation.GetMapping;
    import org.springframework.web.bind.annotation.ModelAttribute;
    import org.springframework.web.bind.annotation.PostMapping;
    import org.springframework.web.bind.annotation.RequestParam;
    import org.springframework.web.servlet.mvc.support.RedirectAttributes;

    import java.io.IOException;
    import java.math.BigDecimal;

    import java.time.LocalDate;
    import java.time.LocalDateTime;
    import java.time.temporal.WeekFields;
    import java.util.ArrayList;
    import java.util.List;
    import java.util.Optional;

    @Controller
    public class QuanLyController {
        @Autowired
        HoaDonRepository hoaDonRepository;
        @Autowired
        private HoaDonPDFExporter hoaDonPDFExporter;
        @Autowired
        CTSPRepository ctspRepository;
        @Autowired
        HDCTRepository hdctRepository;
        @Autowired
        KhachHangRepository khachHangRepository;
        @Autowired
        SanPhamRepository sanPhamRepository;
        @GetMapping("/trang-chu")
        public String trangChu(Model model){
            LocalDate currentDate = LocalDate.now();

            BigDecimal totalMoneyByDate = hoaDonRepository.getTotalMoneyByDate(LocalDate.now());

            int currentWeek = currentDate.get(WeekFields.ISO.weekOfWeekBasedYear());

            BigDecimal totalMoneyByWeek = hoaDonRepository.getTotalMoneyByWeek(currentDate.getYear(), currentWeek);

            BigDecimal totalMoneyByMonth = hoaDonRepository.getTotalMoneyByMonth(currentDate.getYear(), currentDate.getMonthValue());

            BigDecimal totalMoneyByYear = hoaDonRepository.getTotalMoneyByYear(currentDate.getYear());

            model.addAttribute("totalMoneyByDate", totalMoneyByDate);
            model.addAttribute("totalMoneyByWeek", totalMoneyByWeek);
            model.addAttribute("totalMoneyByMonth", totalMoneyByMonth);
            model.addAttribute("totalMoneyByYear", totalMoneyByYear);
            model.addAttribute("tongSoLuong", sanPhamRepository.countSanPhams());
            model.addAttribute("tongSoLuongCTSP", ctspRepository.sumSoLuong());
            model.addAttribute("tongSoLuongKH", khachHangRepository.countKhachHang());
            return "trangChu";
        }
        @GetMapping("ban-hang")
        public String banHang(@RequestParam(name = "page", defaultValue = "0") int page, Model model){
            model.addAttribute("listCTSP", ctspRepository.findAll());
            model.addAttribute("listKhachHang", khachHangRepository.findByTrangThai());
            int pageSize = 5; // Số lượng hóa đơn trên mỗi trang
            Pageable pageable = PageRequest.of(page, pageSize);
            Page<HoaDon> hoaDonPage = hoaDonRepository.findAllPendingHoaDon(pageable); // Sử dụng phương thức findAllPendingHoaDon

//
            model.addAttribute("listSanPham", sanPhamRepository.findAll());
            model.addAttribute("listHoaDon", hoaDonPage.getContent());
            model.addAttribute("currentPage", page);
            model.addAttribute("totalPages", hoaDonPage.getTotalPages());
            return "banHang";
        }

        @GetMapping("/add-khach-hang")
        public String formAdd(){
            return "khach_hang/addKH";
        }
        @PostMapping("/khach_hang-addKH")
        public String addKH(@ModelAttribute("khachHang") KhachHang khachHang, Model model) {
            khachHang.setNgay_tao(LocalDateTime.now());
            khachHang.setNgay_sua(LocalDateTime.now());
            khachHang.setTrang_thai("Active");
            khachHangRepository.save(khachHang);

            HoaDon hoaDon = new HoaDon();
            hoaDon.setNgay_tao(LocalDateTime.now());
            hoaDon.setNgay_sua(LocalDateTime.now());
            hoaDon.setTrang_thai("Pending");
            hoaDon.setKhachHang(khachHang);
            hoaDon.setDia_chi(khachHang.getDia_chi());
            hoaDon.setSo_dien_thoai(khachHang.getSdt());
            hoaDonRepository.save(hoaDon);

            return "redirect:/ban-hang-detailCT?id_hoa_don=" + hoaDon.getId();
        }
        @PostMapping("/ban-hang-addHD")
        public String addHD(@ModelAttribute("hoaDon") HoaDon hoaDon,RedirectAttributes redirectAttributes, @RequestParam("id_khach_hang") Integer idKH, @RequestParam("page") int page) {
            hoaDon.setNgay_tao(LocalDateTime.now());
            hoaDon.setNgay_sua(LocalDateTime.now());
            hoaDon.setTrang_thai("Pending");
            hoaDon.setKhachHang(khachHangRepository.getById(idKH));
            hoaDon.setDia_chi(khachHangRepository.getById(idKH).getDia_chi());
            hoaDon.setSo_dien_thoai(khachHangRepository.getById(idKH).getSdt());
            hoaDonRepository.save(hoaDon);

            return "redirect:/ban-hang-detailCT?id_hoa_don=" + hoaDon.getId();
        }
        @GetMapping("/add-khach-hang-vl")
        public String addHDVL() {
            KhachHang khachHang = khachHangRepository.getById(16);

            HoaDon hoaDon = new HoaDon();
            hoaDon.setNgay_tao(LocalDateTime.now());
            hoaDon.setNgay_sua(LocalDateTime.now());
            hoaDon.setTrang_thai("Pending");
            hoaDon.setKhachHang(khachHang);
            hoaDon.setDia_chi(khachHang.getDia_chi());
            hoaDon.setSo_dien_thoai(khachHang.getSdt());
            hoaDonRepository.save(hoaDon);

            return "redirect:/ban-hang-detailCT?id_hoa_don=" + hoaDon.getId();
        }
        @GetMapping("/ban-hang-detailCT")
        public String detailCT(@RequestParam("id_hoa_don") Integer id_hoa_don, @RequestParam(name = "page", defaultValue = "0") int page, Model model) {
            int pageSize = 5;
            Pageable pageable = PageRequest.of(page, pageSize);
            List<HDCT> listHDCT = hdctRepository.findByIdHDBH(id_hoa_don);
            BigDecimal totalAmount = listHDCT.stream().map(HDCT::getTong_tien).reduce(BigDecimal.ZERO, BigDecimal::add);
            Page<HoaDon> hoaDonPage = hoaDonRepository.findAllPendingHoaDon(pageable);

            model.addAttribute("listCTSP", ctspRepository.findAll());
            model.addAttribute("listKhachHang", khachHangRepository.findByTrangThai());
            model.addAttribute("listHoaDon", hoaDonPage.getContent());
            model.addAttribute("currentPage", page);
            model.addAttribute("listSanPham", sanPhamRepository.findAll());
            model.addAttribute("totalPages", hoaDonPage.getTotalPages());
            model.addAttribute("listHDCT", hdctRepository.findByIdHDBH(id_hoa_don));
            model.addAttribute("hoaDon", hoaDonRepository.getById(id_hoa_don));
            model.addAttribute("totalAmount", totalAmount);

            return "banHang";
        }

        @GetMapping("/ban-hang-selectProduct")
        public String selectProduct(@RequestParam("id_hoa_don") Integer id_hoa_don,@RequestParam("soLuong") Integer soLuong,
                                    @RequestParam(name = "page", defaultValue = "0") int page, Model model,
                                    @ModelAttribute("hdct")HDCT hdct,@RequestParam("id_ctsp") Integer id_ctsp){
            hdct.setHoaDon(hoaDonRepository.getById(id_hoa_don));
            hdct.setCtsp(ctspRepository.getById(id_ctsp));
            hdct.setNgay_sua(LocalDateTime.now());
            hdct.setNgay_tao(LocalDateTime.now());
            hdct.setTrang_thai("Active");
            hdct.setSo_luong_mua(soLuong);
            CTSP ctsp=ctspRepository.getById(id_ctsp);
            ctsp.setSo_luong_ton(ctsp.getSo_luong_ton()-soLuong);
            ctspRepository.save(ctsp);
            hdct.setGia_ban(ctspRepository.getById(id_ctsp).getGia_ban());
            hdct.setTong_tien(BigDecimal.valueOf(soLuong).multiply(ctspRepository.getById(id_ctsp).getGia_ban()));
            int pageSize = 5; // Số lượng hóa đơn trên mỗi trang
            Pageable pageable = PageRequest.of(page, pageSize);
            List<HDCT> listHDCT = hdctRepository.findByIdHDBH(id_hoa_don);

            // Calculate the total amount using BigDecimal
            BigDecimal totalAmount = listHDCT.stream()
                    .map(HDCT::getTong_tien)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
            Page<HoaDon> hoaDonPage = hoaDonRepository.findAll(pageable);
            model.addAttribute("listCTSP",ctspRepository.findAll());
            model.addAttribute("listKhachHang",khachHangRepository.findByTrangThai());
            model.addAttribute("listHoaDon", hoaDonPage.getContent());
            model.addAttribute("currentPage", page);
            model.addAttribute("listSanPham", sanPhamRepository.findAll());
            model.addAttribute("totalPages", hoaDonPage.getTotalPages());
            model.addAttribute("listHDCT", hdctRepository.findByIdHDBH(id_hoa_don));
            model.addAttribute("hoaDon",hoaDonRepository.getById(id_hoa_don));
            model.addAttribute("totalAmount", totalAmount); // Add total amount to the model

            hdctRepository.save(hdct);
            return "redirect:/ban-hang-detailCT?id_hoa_don="+id_hoa_don;
        }
        @GetMapping("ban-hang-delete")
        public String delete(@RequestParam("id") Integer id, @RequestParam("id_hoa_don") Integer id_hoa_don) {
            hdctRepository.deleteById(id);
            return "redirect:/ban-hang-detailCT?id_hoa_don=" + id_hoa_don;
        }
        @GetMapping("/ban-hang-update")
        public String updateHDCT(@RequestParam("id_hdct") Integer id_hdct, @RequestParam("id_hoa_don") Integer id_hoa_don, @RequestParam("soLuong") Integer soLuong) {
            HDCT hdct = hdctRepository.getById(id_hdct);
            hdct.setSo_luong_mua(soLuong);
            hdct.setNgay_sua(LocalDateTime.now());
            hdct.setTong_tien(hdct.getGia_ban().multiply(BigDecimal.valueOf(soLuong)));

            hdctRepository.save(hdct);

            return "redirect:/ban-hang-detailCT?id_hoa_don=" + id_hoa_don;
        }
        @PostMapping("/ban-hang-thanh-toan")
        public ResponseEntity<byte[]> thanhToan(@RequestParam("id_hoa_don") Integer id_hoa_don, HttpServletResponse response, RedirectAttributes redirectAttributes) {
            if (id_hoa_don == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Vui lòng chọn hóa đơn trước khi thanh toán.");
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
            }

            Optional<HoaDon> hoaDonOptional = hoaDonRepository.findById(id_hoa_don);
            if (hoaDonOptional.isPresent()) {
                HoaDon hoaDon = hoaDonOptional.get();
                hoaDon.setTrang_thai("Completed");
                hoaDon.setNgay_sua(LocalDateTime.now());
                hoaDonRepository.save(hoaDon);

                // Export PDF
                try {
                    byte[] pdfBytes = hoaDonPDFExporter.export(hoaDon);
                    HttpHeaders headers = new HttpHeaders();
                    headers.setContentType(MediaType.APPLICATION_PDF);
                    headers.setContentDispositionFormData("attachment", "hoa-don-" + hoaDon.getId() + ".pdf");
                    ResponseEntity<byte[]> responseEntity = new ResponseEntity<>(pdfBytes, headers, HttpStatus.OK);
                    return responseEntity;
                } catch (IOException | DocumentException e) {
                    e.printStackTrace();
                    redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi xuất hóa đơn.");
                    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
                }
            }

            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy hóa đơn.");
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }


    }
