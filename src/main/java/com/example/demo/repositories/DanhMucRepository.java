package com.example.demo.repositories;

import com.example.demo.entity.DanhMuc;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DanhMucRepository extends JpaRepository<DanhMuc,Integer> {
}
