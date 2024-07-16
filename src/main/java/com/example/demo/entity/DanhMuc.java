package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "danh_muc")
@AllArgsConstructor
@NoArgsConstructor
@Data
public class DanhMuc {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;
    @Column(name = "ma_danh_muc")
    private String ma_danh_muc;
    @Column(name = "ten_danh_muc")
    private String ten_danh_muc;
    @Column(name = "trang_thai")
    private String trang_thai;
    @Column(name = "ngay_tao")
    private LocalDateTime ngay_tao;
    @Column(name = "ngay_sua")
    private LocalDateTime ngay_sua;
    public Integer getId() {
        return id;
    }

    // Phương thức setter cho thuộc tính id
    public void setId(Integer id) {
        this.id = id;
    }
}
