package com.example.demo.controller;

import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.*;
import com.example.demo.entity.HoaDon;
import com.example.demo.entity.HDCT;
import org.springframework.stereotype.Controller;

import java.awt.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Stream;

@Controller
public class HoaDonPDFExporter {

    public byte[] export(HoaDon hoaDon) throws DocumentException, IOException {
        Document document = new Document(PageSize.A5, 50, 50, 50, 50); // Set margins
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, baos);

        document.open();

        // Load the Vietnamese font
        BaseFont bf = BaseFont.createFont("C:/Users/MY PC/IdeaProjects/java5_1805/src/main/resources/arial.ttf", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        Font titleFont = new Font(bf, 18, Font.BOLD, Color.BLUE);
        Font headerFont = new Font(bf, 14, Font.BOLD);
        Font textFont = new Font(bf, 12);
        Font boldTextFont = new Font(bf, 12, Font.BOLD);

        // Add title
        Paragraph title = new Paragraph("Hóa Đơn Bán Hàng", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(20);
        document.add(title);

        // Format date
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        // Add invoice information
        document.add(new Paragraph("Hóa Đơn ID: " + hoaDon.getId(), textFont));
        document.add(new Paragraph("Ngày Tạo: " + hoaDon.getNgay_tao().format(formatter), textFont));
        document.add(new Paragraph("Khách Hàng: " + hoaDon.getKhachHang().getHo_ten(), textFont));
        document.add(new Paragraph(" ")); // Empty line

        // Add invoice details in a table
        document.add(new Paragraph("Chi Tiết Hóa Đơn:", headerFont));
        document.add(new Paragraph(" ")); // Empty line

        PdfPTable table = new PdfPTable(4); // 4 columns.
        table.setWidthPercentage(100); // Width 100%
        table.setSpacingBefore(10f); // Space before table
        table.setSpacingAfter(10f); // Space after table

        // Set Column widths
        float[] columnWidths = {3f, 1f, 2f, 2f};
        table.setWidths(columnWidths);

        // Add table header
        addTableHeader(table, textFont);

        // Add rows
        List<HDCT> chiTietHoaDonList = hoaDon.getHoaDonChiTiets();
        BigDecimal tongTien = BigDecimal.ZERO;
        for (HDCT ct : chiTietHoaDonList) {
            addTableRow(table, ct, textFont);
            BigDecimal thanhTien = ct.getGia_ban().multiply(BigDecimal.valueOf(ct.getSo_luong_mua()));
            tongTien = tongTien.add(thanhTien);
        }

        // Add the table to the document
        document.add(table);

        // Add total amount
        Paragraph total = new Paragraph("Tổng Tiền: " + tongTien + " $", boldTextFont);
        total.setAlignment(Element.ALIGN_RIGHT);
        document.add(total);

        // Add signature and date
        document.add(new Paragraph(" "));
        document.add(new Paragraph("Người Lập: Trương Nhật Toàn", textFont));
        document.add(new Paragraph("Ngày: " + LocalDateTime.now().format(formatter), textFont));

        document.close();

        return baos.toByteArray();
    }

    private void addTableHeader(PdfPTable table, Font font) {
        Stream.of("Sản Phẩm", "Số Lượng", "Đơn Giá", "Thành Tiền").forEach(columnTitle -> {
            PdfPCell header = new PdfPCell();
            header.setBackgroundColor(Color.LIGHT_GRAY);
            header.setBorderWidth(2);
            header.setPhrase(new Phrase(columnTitle, font));
            header.setHorizontalAlignment(Element.ALIGN_CENTER);
            table.addCell(header);
        });
    }

    private void addTableRow(PdfPTable table, HDCT ct, Font font) {
        table.addCell(new PdfPCell(new Phrase(ct.getCtsp().getSanPham().getTen_san_pham(), font)));
        table.addCell(new PdfPCell(new Phrase(String.valueOf(ct.getSo_luong_mua()), font)));
        table.addCell(new PdfPCell(new Phrase(ct.getGia_ban().toString(), font)));
        BigDecimal thanhTien = ct.getGia_ban().multiply(BigDecimal.valueOf(ct.getSo_luong_mua()));
        table.addCell(new PdfPCell(new Phrase(thanhTien.toString(), font)));
    }
}
