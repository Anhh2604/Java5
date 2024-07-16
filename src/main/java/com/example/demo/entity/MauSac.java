package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "mau_sac")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class MauSac {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;
    @Column(name = "ma_mau")
    private String ma_mau;
    @Column(name = "ten_mau")
    private String ten_mau;
    @Column(name = "trang_thai")
    private String trang_thai;
    @Column(name = "ngay_tao")
    private LocalDateTime ngay_tao;
    @Column(name = "ngay_sua")
    private LocalDateTime ngay_sua;
}
