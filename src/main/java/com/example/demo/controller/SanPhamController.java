package com.example.demo.controller;

import com.example.demo.entity.DanhMuc;
import com.example.demo.entity.SanPham;
import com.example.demo.repositories.DanhMucRepository;
import com.example.demo.repositories.SanPhamRepository;
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

import java.time.format.DateTimeFormatter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class SanPhamController {
    @Autowired
    SanPhamRepository sanPhamRepository;
    @Autowired
    DanhMucRepository danhMucRepository;
    @GetMapping("/san_pham")
    public String sanPham(Model model, @RequestParam(name = "page", defaultValue = "0") Integer page) {
        int pageSize = 4;
        Pageable pageable = PageRequest.of(page, pageSize);
        Page<SanPham> sanPhamPage = sanPhamRepository.findAll(pageable);
        List<DanhMuc> listDanhMuc = danhMucRepository.findAll();
        model.addAttribute("listSanPham", sanPhamPage.getContent());
        model.addAttribute("sanPhamPage", sanPhamPage);
        model.addAttribute("listDanhMuc", listDanhMuc);
        return "san_pham/index";
    }

    @PostMapping("/san-pham/add")
    public String add(@ModelAttribute("sp")SanPham sanPham){
        sanPham.setNgay_tao(LocalDateTime.now());
        sanPham.setNgay_sua(LocalDateTime.now());
        sanPhamRepository.save(sanPham);
        return "redirect:/san_pham";
    }
    @GetMapping("/san-pham/delete")
    public String delete(@RequestParam("id") Integer id){
        sanPhamRepository.delete(sanPhamRepository.getById(id));
        return "redirect:/san_pham";
    }
    @GetMapping("/san-pham/detail")
    public String detail(@RequestParam("id") Integer id, Model model) {
        SanPham sanPham = sanPhamRepository.findById(id).orElse(null);
        if (sanPham == null) {
            // Xử lý khi không tìm thấy sản phẩm với ID cung cấp
            return "redirect:/san_pham";
        }
        model.addAttribute("sp", sanPham);
        model.addAttribute("listDanhMuc", danhMucRepository.findAll());
        return "san_pham/edit";
    }
    @PostMapping("/san-pham/update")
    public String update(@RequestParam("id") Integer id,@ModelAttribute("sp")SanPham sanPham){
        sanPham.setNgay_tao(sanPhamRepository.getById(id).getNgay_tao());
        sanPham.setNgay_sua(LocalDateTime.now());
        sanPhamRepository.save(sanPham);
        return "redirect:/san_pham";
    }
}
