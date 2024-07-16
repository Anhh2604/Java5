package com.example.demo.repositories;

import com.example.demo.entity.CTSP;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CTSPRepository extends JpaRepository<CTSP, Integer> {
    @Query("SELECT c FROM CTSP c WHERE c.sanPham.id = :idSp")
    Page<CTSP> findByIdSp(Integer idSp, Pageable pageable);
    @Query("SELECT SUM(c.so_luong_ton) FROM CTSP c")
    Long sumSoLuong();
}
