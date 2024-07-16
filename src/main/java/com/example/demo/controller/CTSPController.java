package com.example.demo.controller;

import com.example.demo.entity.CTSP;
import com.example.demo.repositories.CTSPRepository;
import com.example.demo.repositories.MauSacRepository;
import com.example.demo.repositories.SanPhamRepository;
import com.example.demo.repositories.SizeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;

@Controller
public class CTSPController {
    @Autowired
    CTSPRepository ctspRepository;
    @Autowired
    SizeRepository sizeRepository;
    @Autowired
    SanPhamRepository sanPhamRepository;
    @Autowired
    MauSacRepository mauSacRepository;
    @GetMapping("/ctsp")
    public String ctsp(@RequestParam("id_sp")Integer id_sp, @RequestParam(defaultValue = "0") int page, Model model){
        // Số lượng sản phẩm trên mỗi trang
        int pageSize = 5;
        // Tạo trang mới với thông số trang hiện tại và số lượng sản phẩm trên mỗi trang
        Pageable pageable = PageRequest.of(page, pageSize);
        // Lấy danh sách sản phẩm dựa trên id_sp và phân trang
        Page<CTSP> ctspPage = ctspRepository.findByIdSp(id_sp, pageable);
        // Tổng số trang
        int totalPages = ctspPage.getTotalPages();
        // Danh sách sản phẩm
        model.addAttribute("listCTSP", ctspPage.getContent());
        model.addAttribute("listMauSac", mauSacRepository.findAll());
        model.addAttribute("listSize", sizeRepository.findAll());
        // Số trang hiện tại
        model.addAttribute("currentPage", page);
        // Tổng số trang
        model.addAttribute("totalPages", totalPages);
        // Id sản phẩm
        model.addAttribute("id_sp", id_sp);
        return "ctsp/index";
    }
    @PostMapping("/ctsp/add")
    public String add(@ModelAttribute("ctsp") CTSP ctsp, @RequestParam("id_sp") Integer id_sp, Model model) {
        ctsp.setNgay_sua(LocalDateTime.now());
        ctsp.setNgay_tao(LocalDateTime.now());

        // Thiết lập SanPham cho CTSP
        ctsp.setSanPham(sanPhamRepository.findById(id_sp).orElse(null));
        model.addAttribute("id_sp", id_sp);

        ctspRepository.save(ctsp);

        return "redirect:/ctsp?id_sp=" + id_sp;
    }

    @GetMapping("/ctsp/delete")
    public String delete(@RequestParam("id") Integer id, @RequestParam("id_sp") Integer id_sp) {
        ctspRepository.deleteById(id);
        return "redirect:/ctsp?id_sp=" + id_sp;
    }

    @GetMapping("/ctsp/detail")
    public String detail(@RequestParam("id_sp") Integer id_sp, @RequestParam("id") Integer id, Model model) {
        model.addAttribute("ctsp", ctspRepository.findById(id).orElse(null));
        model.addAttribute("listSize", sizeRepository.findAll());
        model.addAttribute("listSanPham", sanPhamRepository.findAll());
        model.addAttribute("listMauSac", mauSacRepository.findAll());
        model.addAttribute("id_sp", id_sp);
        return "ctsp/edit";
    }

    @PostMapping("/ctsp/update")
    public String update(@ModelAttribute("ctsp") CTSP ctsp, @RequestParam("id") Integer id, @RequestParam("id_sp") Integer id_sp) {
        CTSP existingCTSP = ctspRepository.findById(id).orElse(null);
        if (existingCTSP != null) {
            ctsp.setNgay_sua(LocalDateTime.now());
            ctsp.setNgay_tao(existingCTSP.getNgay_tao());
            ctsp.setSanPham(existingCTSP.getSanPham()); // Giữ nguyên thông tin sản phẩm
            ctspRepository.save(ctsp);
        }
        return "redirect:/ctsp?id_sp=" + id_sp;
    }
}
