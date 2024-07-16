package com.example.demo.repositories;

import com.example.demo.entity.HDCT;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface HDCTRepository extends JpaRepository<HDCT,Integer> {
    @Query("Select h From HDCT h WHERE h.hoaDon.id =:id_hoa_don")
    Page<HDCT>findByIdHD(@Param("id_hoa_don")Integer id_hoa_don, Pageable pageable);
    @Query("Select h From HDCT h WHERE h.hoaDon.id =:id_hoa_don")
    List<HDCT> findByIdHDBH(@Param("id_hoa_don")Integer id_hoa_don);
}
