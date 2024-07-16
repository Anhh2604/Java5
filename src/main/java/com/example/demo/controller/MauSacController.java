package com.example.demo.controller;

import com.example.demo.entity.MauSac;
import com.example.demo.repositories.MauSacRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@Controller
public class MauSacController {
    @Autowired
    private MauSacRepository mauSacRepository;

    @GetMapping("/mau_sac")
    public String mau_sac(@RequestParam(name = "page", defaultValue = "0") int page, Model model) {
        int pageSize = 5; // Số lượng màu sắc trên mỗi trang
        Pageable pageable = PageRequest.of(page, pageSize);
        Page<MauSac> mauSacPage = mauSacRepository.findAll(pageable);

        model.addAttribute("listMauSac", mauSacPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", mauSacPage.getTotalPages());

        return "mau_sac/index";
    }

    @GetMapping("/mau-sac/delete")
    public String delete(@RequestParam("id") Integer id) {
        mauSacRepository.deleteById(id);
        return "redirect:/mau_sac";
    }

    @PostMapping("/mau-sac/add")
    public String add(@ModelAttribute("ms") MauSac mauSac) {
        mauSac.setNgay_tao(LocalDateTime.now());
        mauSac.setNgay_sua(LocalDateTime.now());
        mauSacRepository.save(mauSac);
        return "redirect:/mau_sac";
    }

    @GetMapping("/mau-sac/detail")
    public String detail(@RequestParam("id") Integer id, Model model) {
        model.addAttribute("mauSac", mauSacRepository.findById(id).orElse(null));
        return "mau_sac/edit";
    }

    @PostMapping("/mau-sac/update")
    public String update(@RequestParam("id") Integer id, @ModelAttribute("ms") MauSac mauSac) {
        MauSac existingMauSac = mauSacRepository.findById(id).orElse(null);
        if (existingMauSac != null) {
            mauSac.setNgay_tao(existingMauSac.getNgay_tao());
            mauSac.setNgay_sua(LocalDateTime.now());
            mauSacRepository.save(mauSac);
        }
        return "redirect:/mau_sac";
    }
}
