package com.example.demo.repositories;

import com.example.demo.entity.Size;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface SizeRepository extends JpaRepository<Size,Integer> {

    @Query("SELECT s FROM Size s WHERE s.ten_size LIKE %:ten_size%")
    Page<Size> findByName(@Param("ten_size") String ten_size, Pageable pageable);

}
