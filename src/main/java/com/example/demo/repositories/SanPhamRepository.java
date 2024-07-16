package com.example.demo.repositories;

import com.example.demo.entity.SanPham;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface SanPhamRepository extends JpaRepository<SanPham,Integer> {
    @Query("SELECT COUNT(sp) FROM SanPham sp")
    long countSanPhams();
}
