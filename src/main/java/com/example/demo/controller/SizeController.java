package com.example.demo.controller;

import com.example.demo.entity.Size;
import com.example.demo.repositories.SizeRepository;
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
public class SizeController {
    @Autowired
    SizeRepository sizeRepository;

    @GetMapping("/size")
    public String size(@RequestParam(name = "page", defaultValue = "0") int page, Model model) {
        int pageSize = 5; // Số lượng size trên mỗi trang
        Pageable pageable = PageRequest.of(page < 0 ? 0 : page, pageSize);
        Page<Size> sizePage = sizeRepository.findAll(pageable);
        model.addAttribute("listSize", sizePage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", sizePage.getTotalPages());
        return "size/index";
    }
    @PostMapping("/size/search")
    public String search(@RequestParam("search") String search, @RequestParam(name = "page", defaultValue = "0") int page, Model model) {
        int pageSize = 5; // Số lượng size trên mỗi trang
        Pageable pageable = PageRequest.of(page < 0 ? 0 : page, pageSize);
        Page<Size> sizePage = sizeRepository.findByName(search, pageable);
        model.addAttribute("listSize", sizePage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", sizePage.getTotalPages());
        model.addAttribute("search", search); // Add search term to model for redisplay
        return "size/index";
    }

    @GetMapping("/size/delete")
    public String delete(@RequestParam("id") Integer id) {
        sizeRepository.deleteById(id);
        return "redirect:/size";
    }
    @PostMapping("/size/add")
    public String add(@ModelAttribute("size") Size size) {
        size.setNgay_tao(LocalDateTime.now());
        size.setNgay_sua(LocalDateTime.now());
        sizeRepository.save(size);
        return "redirect:/size";
    }
    @GetMapping("/size/detail")
    public String detail(@RequestParam("id") Integer id, Model model) {
        model.addAttribute("size", sizeRepository.findById(id).orElse(null));
        return "size/edit";
    }
    @PostMapping("/size/update")
    public String update(@RequestParam("id") Integer id, @ModelAttribute("size") Size size) {
        Size existingSize = sizeRepository.findById(id).orElse(null);
        if (existingSize != null) {
            size.setNgay_tao(existingSize.getNgay_tao());
            size.setNgay_sua(LocalDateTime.now());
            sizeRepository.save(size);
        }
        return "redirect:/size";
    }
}
