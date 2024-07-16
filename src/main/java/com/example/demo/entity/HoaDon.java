package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "hoa_don")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class HoaDon {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "id_khach_hang")
    private KhachHang khachHang;
    @Column(name = "trang_thai")
    private String trang_thai;
    @Column(name = "ngay_tao")
    private LocalDateTime ngay_tao;
    @Column(name = "ngay_sua")
    private LocalDateTime ngay_sua;
    @Column(name = "dia_chi")
    private String dia_chi;
    @Column(name = "so_dien_thoai")
    private String so_dien_thoai;
    @OneToMany(mappedBy = "hoaDon", cascade = CascadeType.ALL)
    private List<HDCT> hoaDonChiTiets;
    public BigDecimal getTotalAmount() {
        BigDecimal totalAmount = BigDecimal.ZERO;
        if (hoaDonChiTiets != null) {
            for (HDCT hdct : hoaDonChiTiets) {
                totalAmount = totalAmount.add(hdct.getTong_tien());
            }
        }
        return totalAmount;
    }
}

