package com.example.demo.controller;

import com.example.demo.entity.DanhMuc;
import com.example.demo.repositories.DanhMucRepository;
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
public class DanhMucController {
    @Autowired
    DanhMucRepository danhMucRepository;
    @GetMapping("danh_muc")
    public String danh_muc(@RequestParam(name = "page", defaultValue = "0") int page, Model model){
        int pageSize = 5; // Số lượng danh mục trên mỗi trang
        Pageable pageable = PageRequest.of(page, pageSize);
        Page<DanhMuc> danhMucPage = danhMucRepository.findAll(pageable);

        model.addAttribute("listDanhMuc", danhMucPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", danhMucPage.getTotalPages());

        return "danh_muc/index";
    }
    @PostMapping("/danh-muc/add")
    public String add(@ModelAttribute("dm") DanhMuc danhMuc) {
        danhMuc.setNgay_tao(LocalDateTime.now());
        danhMuc.setNgay_sua(LocalDateTime.now());
        danhMucRepository.save(danhMuc);
        return "redirect:/danh_muc";
    }

    @GetMapping("/danh-muc/delete")
    public String delete(@RequestParam("id") Integer id) {
        danhMucRepository.delete(danhMucRepository.getById(id));
        return "redirect:/danh_muc";
    }

    @GetMapping("/danh-muc/detail")
    public String detail(@RequestParam("id") Integer id, Model model) {
        model.addAttribute("dm", danhMucRepository.getById(id));
        return "danh_muc/edit";
    }

    @PostMapping("/danh-muc/update")
    public String update(@RequestParam("id") Integer id, @ModelAttribute("dm") DanhMuc danhMuc) {
        DanhMuc existingDanhMuc = danhMucRepository.getById(id);
        danhMuc.setNgay_tao(existingDanhMuc.getNgay_tao());
        danhMuc.setNgay_sua(LocalDateTime.now());
        danhMucRepository.save(danhMuc);
        return "redirect:/danh_muc";
    }
}
