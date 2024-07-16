package com.example.demo.controller;

import com.example.demo.entity.CTSP;
import com.example.demo.entity.HDCT;
import com.example.demo.repositories.CTSPRepository;
import com.example.demo.repositories.HDCTRepository;
import com.example.demo.repositories.HoaDonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Optional;

@Controller
public class HDCTController {
    @Autowired
    HoaDonRepository hoaDonRepository;
    @Autowired
    CTSPRepository ctspRepository;
    @Autowired
    HDCTRepository hdctRepository;

    @GetMapping("/hdct")
    public String hdct(@RequestParam("id_hoa_don") Integer id_hoa_don, @RequestParam(defaultValue = "0") int page, Model model){
        int pageSize = 5;
        // Tạo trang mới với thông số trang hiện tại và số lượng sản phẩm trên mỗi trang
        Pageable pageable = PageRequest.of(page, pageSize);
        // Lấy danh sách sản phẩm dựa trên id_sp và phân trang
        Page<HDCT> hdctPage = hdctRepository.findByIdHD(id_hoa_don, pageable);
        // Tổng số trang
        int totalPages = hdctPage.getTotalPages();
        model.addAttribute("listCTSP", ctspRepository.findAll());
        model.addAttribute("listHDCT", hdctPage.getContent());
        model.addAttribute("id_hoa_don", id_hoa_don);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        return "/hdct/index";
    }

    @PostMapping("/hdct/add")
    public String add(@ModelAttribute("hdct") HDCT hdct, @RequestParam("id_hoa_don") Integer id_hoa_don, @RequestParam("so_luong_mua") Integer so_luong_mua, @RequestParam("gia_ban") BigDecimal gia_ban, Model model){
        hdct.setNgay_sua(LocalDateTime.now());
        hdct.setNgay_tao(LocalDateTime.now());
        hdct.setHoaDon(hoaDonRepository.getById(id_hoa_don));
        hdct.setTong_tien(BigDecimal.valueOf(so_luong_mua).multiply(gia_ban));

        model.addAttribute("id_hoa_don", id_hoa_don);

        hdctRepository.save(hdct);
        return "redirect:/hdct?id_hoa_don=" + id_hoa_don;
    }

    @GetMapping("/hdct/detail")
    public String detail(@RequestParam("id_hoa_don") Integer id_hoa_don, @RequestParam("id") Integer id, Model model){
        Optional<HDCT> hdctOptional = hdctRepository.findById(id);
        if (hdctOptional.isPresent()) {
            model.addAttribute("HDCT", hdctOptional.get());
            model.addAttribute("id_hoa_don", id_hoa_don);
            model.addAttribute("listCTSP", ctspRepository.findAll());
            return "/hdct/edit";
        } else {
            // Xử lý trường hợp không tìm thấy HDCT với id tương ứng
            return "redirect:/hdct?id_hoa_don=" + id_hoa_don;
        }
    }

    @PostMapping("/hdct/update")
    public String update(@ModelAttribute("hdct") HDCT hdct, @RequestParam("id") Integer id, @RequestParam("id_hoa_don") Integer id_hoa_don, @RequestParam("so_luong_mua") Integer so_luong_mua, @RequestParam("gia_ban") BigDecimal gia_ban, Model model){
        hdct.setNgay_tao(hdctRepository.getReferenceById(id).getNgay_tao());
        hdct.setNgay_sua(LocalDateTime.now());
        hdct.setHoaDon(hoaDonRepository.getById(id_hoa_don));
        if (gia_ban != null) {
            hdct.setTong_tien(BigDecimal.valueOf(so_luong_mua).multiply(gia_ban));
        }
        hdct.setTong_tien(BigDecimal.valueOf(so_luong_mua).multiply(gia_ban));

        model.addAttribute("id_hoa_don", id_hoa_don);

        hdctRepository.save(hdct);
        return "redirect:/hdct?id_hoa_don=" + id_hoa_don;
    }
}
