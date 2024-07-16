package com.example.demo.controller;

import com.example.demo.entity.KhachHang;
import com.example.demo.repositories.KhachHangRepository;
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

import java.time.LocalDateTime;

@Controller
public class KhachHangController {
    @Autowired
    KhachHangRepository khachHangRepository;
    @GetMapping("/khach_hang")
    public String khachHang(@RequestParam(name = "page", defaultValue = "0") int page, Model model) {
        int pageSize = 5; // Số lượng khách hàng trên mỗi trang
        Pageable pageable = PageRequest.of(page, pageSize);
        Page<KhachHang> khachHangPage = khachHangRepository.findAll(pageable);

        model.addAttribute("listKhachHang", khachHangPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", khachHangPage.getTotalPages());

        return "khach_hang/index";
    }

    @GetMapping("/khach_hang/delete")
    public String delete(@RequestParam("id") Integer id) {
        khachHangRepository.deleteById(id);
        return "redirect:/khach_hang";
    }

    @PostMapping("/khach_hang/add")
    public String add(@ModelAttribute("khachHang") KhachHang khachHang) {
        khachHang.setNgay_tao(LocalDateTime.now());
        khachHang.setNgay_sua(LocalDateTime.now());
        khachHangRepository.save(khachHang);
        return "redirect:/khach_hang";
    }

    @GetMapping("/khach_hang/detail")
    public String detail(@RequestParam("id") Integer id, Model model) {
        model.addAttribute("khachHang", khachHangRepository.findById(id).orElse(null));
        return "khach_hang/edit";
    }

    @PostMapping("/khach_hang/update")
    public String update(@RequestParam("id") Integer id, @ModelAttribute("khachHang") KhachHang khachHang) {
        KhachHang existingKhachHang = khachHangRepository.findById(id).orElse(null);
        if (existingKhachHang != null) {
            khachHang.setNgay_tao(existingKhachHang.getNgay_tao());
            khachHang.setNgay_sua(LocalDateTime.now());
            khachHangRepository.save(khachHang);
        }
        return "redirect:/khach_hang";
    }
}
