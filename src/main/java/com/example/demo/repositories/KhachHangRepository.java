package com.example.demo.repositories;

import com.example.demo.entity.KhachHang;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface KhachHangRepository extends JpaRepository<KhachHang, Integer> {
    @Query("SELECT k FROM KhachHang k WHERE COALESCE(k.trang_thai, 'Active') = 'Active'")
    List<KhachHang>findByTrangThai();
    @Query("SELECT COUNT(kh) FROM KhachHang kh")
    long countKhachHang();
}
