package com.example.demo.repositories;

import com.example.demo.entity.HoaDon;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface HoaDonRepository extends JpaRepository<HoaDon,Integer> {
    @Query("UPDATE HoaDon hd SET hd.trang_thai = 'Completed' WHERE hd.id = :id")
    void updateTrangThaiToCompleted(@Param("id") Integer id);
    @Query("SELECT hd FROM HoaDon hd WHERE hd.trang_thai = 'Pending'")
    Page<HoaDon> findAllPendingHoaDon(Pageable pageable);
    @Query("SELECT hd FROM HoaDon hd WHERE hd.trang_thai = 'Completed' AND hd.ngay_sua BETWEEN :startDate AND :endDate")
    Page<HoaDon> findAllCompletedHoaDonByNgaySua(@Param("startDate") LocalDateTime startDate, @Param("endDate") LocalDateTime endDate, Pageable pageable);

    @Query("SELECT hd FROM HoaDon hd WHERE hd.id = :id")
    Optional<HoaDon> findHoaDonById(@Param("id") Integer id);
    @Query("SELECT SUM(hdct.tong_tien) FROM HoaDon hd JOIN hd.hoaDonChiTiets hdct WHERE hd.trang_thai = 'Completed' AND FUNCTION('YEAR', hd.ngay_tao) = FUNCTION('YEAR', :date) AND FUNCTION('MONTH', hd.ngay_tao) = FUNCTION('MONTH', :date) AND FUNCTION('DAY', hd.ngay_tao) = FUNCTION('DAY', :date)")
    BigDecimal getTotalMoneyByDate(@Param("date") LocalDate date);

    @Query("SELECT SUM(hdct.tong_tien) FROM HoaDon hd JOIN hd.hoaDonChiTiets hdct WHERE hd.trang_thai = 'Completed' AND YEAR(hd.ngay_tao) = :year AND DATEPART(week, hd.ngay_tao) = :week")
    BigDecimal getTotalMoneyByWeek(@Param("year") int year, @Param("week") int week);

    @Query("SELECT SUM(hdct.tong_tien) FROM HoaDon hd JOIN hd.hoaDonChiTiets hdct WHERE hd.trang_thai = 'Completed' AND YEAR(hd.ngay_tao) = :year AND MONTH(hd.ngay_tao) = :month")
    BigDecimal getTotalMoneyByMonth(@Param("year") int year, @Param("month") int month);

    @Query("SELECT SUM(hdct.tong_tien) FROM HoaDon hd JOIN hd.hoaDonChiTiets hdct WHERE hd.trang_thai = 'Completed' AND YEAR(hd.ngay_tao) = :year")
    BigDecimal getTotalMoneyByYear(@Param("year") int year);
    @Query("SELECT hd FROM HoaDon hd WHERE hd.trang_thai = 'Completed'")
    Page<HoaDon> findAllCompletedHoaDon(Pageable pageable);
}
