package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "ctsp")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class CTSP {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_sp")
    private SanPham sanPham;

    @ManyToOne
    @JoinColumn(name = "id_mau_sac")
    private MauSac mauSac;

    @ManyToOne
    @JoinColumn(name = "id_size")
    private Size size;

    @Column(name = "gia_ban")
    private BigDecimal gia_ban;
    @Column(name = "so_luong_ton")
    private Integer so_luong_ton;
    @Column(name = "trang_thai")
    private String trang_thai;

    @Column(name = "ngay_tao")
    private LocalDateTime ngay_tao;

    @Column(name = "ngay_sua")
    private LocalDateTime ngay_sua;
}
