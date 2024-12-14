import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:typed_data';

class PdfPreviewPage extends StatelessWidget {
  const PdfPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pdf Preview"),
        backgroundColor: const Color(0xFF384357),
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 20),
      ),
      body: Container(
        color: const Color(0xFF384357), // Mengatur warna latar belakang
        child: PdfPreview(
          build: (format) => _generatePdf(format),
          canChangePageFormat: false,
          initialPageFormat: PdfPageFormat.a4,
          allowPrinting: true,
          allowSharing: true,
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    try {
      final pdf = pw.Document();

      // Warna utama tema
      final PdfColor primaryColor = PdfColor.fromHex('384357'); // Tema utama
      final PdfColor secondaryColor =
          PdfColor.fromHex('FFD700'); // Warna aksen (kuning)

      // Halaman Tiket Bioskop
      pdf.addPage(
        pw.Page(
          pageFormat: format,
          build: (context) {
            return pw.Container(
              decoration: pw.BoxDecoration(
                color: primaryColor,
                border: pw.Border.all(color: PdfColors.grey),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  // Header Tiket
                  pw.Container(
                    padding: const pw.EdgeInsets.all(15),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.white,
                      borderRadius: const pw.BorderRadius.vertical(
                        bottom: pw.Radius.circular(15),
                      ),
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'AMBARRUKMO XXI',
                          style: pw.TextStyle(
                            fontSize: 24,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.black,
                          ),
                        ),
                        pw.Container(
                          width: 60,
                          height: 60,
                          decoration: pw.BoxDecoration(
                            shape: pw.BoxShape.circle,
                            color: secondaryColor,
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              '🎥',
                              style: pw.TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Pola Artistik (Sobekan)
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 10),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        15,
                        (index) => pw.Container(
                          width: 8,
                          height: 8,
                          decoration: pw.BoxDecoration(
                            shape: pw.BoxShape.circle,
                            color: index % 2 == 0
                                ? PdfColors.grey
                                : PdfColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Konten Utama Tiket
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Center(
                          child: pw.Text(
                            '🎬 CARS 2 🎬',
                            style: pw.TextStyle(
                              fontSize: 22,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white,
                            ),
                          ),
                        ),
                        pw.SizedBox(height: 15),
                        pw.Text(
                          'Showtime: 10:30 WIB | 17 OCT 2024',
                          style: pw.TextStyle(
                              fontSize: 14, color: PdfColors.white),
                        ),
                        pw.Text(
                          'Theater: AMBARRUKMO XXI',
                          style: pw.TextStyle(
                              fontSize: 14, color: PdfColors.white),
                        ),
                        pw.SizedBox(height: 20),
                        pw.Text(
                          'Seats: C2, C3, C4',
                          style: pw.TextStyle(
                              fontSize: 16, color: PdfColors.white),
                        ),
                        pw.Text(
                          'Total Price: Rp 130.500',
                          style: pw.TextStyle(
                              fontSize: 16, color: PdfColors.white),
                        ),
                        pw.SizedBox(height: 20),
                        pw.Text(
                          'Order ID: 46451658679812',
                          style: pw.TextStyle(
                              fontSize: 14, color: PdfColors.white),
                        ),
                        pw.Text(
                          'Payment Method: QRIS',
                          style: pw.TextStyle(
                              fontSize: 14, color: PdfColors.white),
                        ),
                        pw.SizedBox(height: 20),
                        pw.BarcodeWidget(
                          barcode: pw.Barcode.code128(),
                          data: '12PD-DA145-456YG-AG1D2',
                          width: 200,
                          height: 80,
                          color: PdfColors.white,
                        ),
                      ],
                    ),
                  ),

                  // Footer Tiket
                  pw.Container(
                    color: secondaryColor,
                    padding: const pw.EdgeInsets.all(15),
                    child: pw.Center(
                      child: pw.Text(
                        'Selamat Menonton! 🎉',
                        style: pw.TextStyle(
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

      return pdf.save();
    } catch (e) {
      print("Error saat membuat PDF: $e");
      rethrow;
    }
  }
}
