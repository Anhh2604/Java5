package com.example.demo.controller;

import com.example.demo.entity.HoaDon;
import com.example.demo.entity.KhachHang;
import com.example.demo.repositories.HoaDonRepository;
import com.example.demo.repositories.KhachHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class HoaDonController {
    @Autowired
    HoaDonRepository hoaDonRepository;

    @Autowired
    KhachHangRepository khachHangRepository;

    @GetMapping("/hoa_don")
    public String hoaDon(@RequestParam(name = "page", defaultValue = "0") int page, Model model) {
        int pageSize = 5; // Số lượng hóa đơn trên mỗi trang
        Pageable pageable = PageRequest.of(page, pageSize);
        Page<HoaDon> hoaDonPage = hoaDonRepository.findAll(pageable);

        model.addAttribute("listHoaDon", hoaDonPage.getContent());
        model.addAttribute("listKhachHang", khachHangRepository.findAll());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", hoaDonPage.getTotalPages());

        return "hoa_don/index";
    }

    @PostMapping("/hoa_don/add")
    public String add(@ModelAttribute("hoaDon") HoaDon hoaDon, @RequestParam("id_khach_hang") Integer idKhachHang) {
        hoaDon.setNgay_tao(LocalDateTime.now());
        hoaDon.setNgay_sua(LocalDateTime.now());
        hoaDon.setKhachHang(khachHangRepository.getById(idKhachHang));
        hoaDon.setDia_chi(khachHangRepository.getById(idKhachHang).getDia_chi());
        hoaDon.setTrang_thai("Pending");
        hoaDon.setSo_dien_thoai(khachHangRepository.getById(idKhachHang).getSdt());
        hoaDonRepository.save(hoaDon);
        return "redirect:/hoa_don";
    }

    @GetMapping("/hoa_don/delete")
    public String delete(@RequestParam("id") Integer id) {
        hoaDonRepository.deleteById(id);
        return "redirect:/hoa_don";
    }
    @GetMapping("/hoa_don-completed")
    public String completed(@RequestParam(name = "page", defaultValue = "0") int page, Model model){
        int pageSize = 5; // Số lượng hóa đơn trên mỗi trang
        Pageable pageable = PageRequest.of(page, pageSize);
        Page<HoaDon> hoaDonPage = hoaDonRepository.findAllCompletedHoaDon(pageable);

        model.addAttribute("listHoaDon", hoaDonPage.getContent());
        model.addAttribute("listKhachHang", khachHangRepository.findAll());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", hoaDonPage.getTotalPages());

        return "hoa_don/index";
    }
    @GetMapping("/hoa_don/detail")
    public String detail(@RequestParam("id") Integer id, Model model) {
        HoaDon hoaDon = hoaDonRepository.findById(id).orElse(null);
        model.addAttribute("hoaDon", hoaDon);
        model.addAttribute("listKhachHang", khachHangRepository.findAll());
        return "hoa_don/edit";
    }

    @PostMapping("/hoa_don/update")
    public String update(@ModelAttribute("hoaDon") HoaDon hoaDon,@RequestParam("id_khach_hang") Integer idKhachHang) {
        hoaDon.setNgay_sua(LocalDateTime.now());
        hoaDon.setNgay_sua(LocalDateTime.now());
        hoaDon.setKhachHang(khachHangRepository.getById(idKhachHang));
        hoaDon.setDia_chi(khachHangRepository.getById(idKhachHang).getDia_chi());
        hoaDon.setSo_dien_thoai(khachHangRepository.getById(idKhachHang).getSdt());
        hoaDonRepository.save(hoaDon);
        return "redirect:/hoa_don";
    }
    @GetMapping("/lich-su-pending")
    public String pendingHoaDonByDate(
            @RequestParam(name = "daysAgo", defaultValue = "30") int daysAgo,
            Model model) {

        Pageable pageable = Pageable.unpaged();
        Page<HoaDon> hoaDonPage;

        if (daysAgo > 0) {
            // Nếu daysAgo là một giá trị hợp lệ, tính toán khoảng thời gian
            LocalDateTime endDate = LocalDateTime.now(); // Ngày hiện tại
            LocalDateTime startDate = endDate.minusDays(daysAgo); // daysAgo ngày trước
            hoaDonPage = hoaDonRepository.findAllCompletedHoaDonByNgaySua(startDate, endDate, pageable);

            // Sắp xếp danh sách theo ngày sửa giảm dần (tức là ngày gần đây nhất lên trước)
            List<HoaDon> sortedList = hoaDonPage.getContent()
                    .stream()
                    .sorted(Comparator.comparing(HoaDon::getNgay_sua).reversed())
                    .collect(Collectors.toList());

            // Đặt lại nội dung của trang hoá đơn đã sắp xếp
            hoaDonPage = new PageImpl<>(sortedList, pageable, sortedList.size());
        } else {
            // Ngược lại, hiển thị tất cả các hóa đơn và sắp xếp theo ngày sửa giảm dần
            hoaDonPage = hoaDonRepository.findAllCompletedHoaDon(pageable);

            // Sắp xếp danh sách theo ngày sửa giảm dần (tức là ngày gần đây nhất lên trước)
            List<HoaDon> sortedList = hoaDonPage.getContent()
                    .stream()
                    .sorted(Comparator.comparing(HoaDon::getNgay_sua).reversed())
                    .collect(Collectors.toList());

            // Đặt lại nội dung của trang hoá đơn đã sắp xếp
            hoaDonPage = new PageImpl<>(sortedList, pageable, sortedList.size());
        }

        model.addAttribute("listHoaDon", hoaDonPage.getContent());

        return "lichSu";
    }

    @GetMapping("/lich-su")
    public String pendingHoaDon(
            Model model) {

        Pageable pageable = Pageable.unpaged();
        Page<HoaDon> hoaDonPage = hoaDonRepository.findAllCompletedHoaDon(pageable);

        // Sắp xếp danh sách theo ngày sửa giảm dần (tức là ngày gần đây nhất lên trước)
        List<HoaDon> sortedList = hoaDonPage.getContent()
                .stream()
                .sorted(Comparator.comparing(HoaDon::getNgay_sua).reversed())
                .collect(Collectors.toList());

        // Đặt lại nội dung của trang hoá đơn đã sắp xếp
        hoaDonPage = new PageImpl<>(sortedList, pageable, sortedList.size());

        model.addAttribute("listHoaDon", hoaDonPage.getContent());

        return "lichSu";
    }
}
