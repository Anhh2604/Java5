package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "hdct")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class HDCT {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "id_hoa_don")
    private HoaDon hoaDon;
    @ManyToOne
    @JoinColumn(name = "id_ctsp")
    private CTSP ctsp;
    @Column(name = "so_luong_mua")
    private int so_luong_mua;
    @Column(name = "gia_ban")
    private BigDecimal gia_ban;
    @Column(name = "tong_tien")
    private BigDecimal tong_tien;
    @Column(name = "trang_thai")
    private  String trang_thai;
    @Column(name = "ngay_tao")
    private LocalDateTime ngay_tao;
    @Column(name = "ngay_sua")
    private LocalDateTime ngay_sua;
}
