import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class PaymentDetailsPage extends StatelessWidget {
  const PaymentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF384357),
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Cinematma',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Judul
              const SizedBox(height: 20),
              const Text(
                'Rincian Pembayaran',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 25),

              // Row dengan Poster dan Deskripsi Film
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    height: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                        image: AssetImage('assets/posterFilm/gotg2Poster.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(height: 20),
                        Text(
                          'Joker : folie à deux',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '10:30 WIB | 18 OCT 2024\nAMBARRUKMO XXI\nC2, C3, C4',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 15,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const Divider(color: Colors.white24),
              const SizedBox(height: 10),

              // Bukti Pembayaran
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B2B38),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bukti Pembayaran',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    buildPaymentDetailRow('Nomor Order', '46451658679812'),
                    buildPaymentDetailRow('ID Pembayaran', 'PBP123'),
                    buildPaymentDetailRow('Metode Pembayaran', 'QRIS'),
                    buildPaymentDetailRow('Tanggal Pembayaran', '17 OCT 2024'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Total Pembayaran
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B2B38),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '3 Tiket',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    buildPaymentDetailRow(
                        'Kursi Regular\nC2, C3, C4', 'Rp 40.000 x 3'),
                    const Divider(color: Colors.white24),
                    buildPaymentDetailRow('Biaya Layanan', 'Rp 3.500 x 3'),
                    const Divider(color: Colors.white24),
                    buildPaymentDetailRow(
                      'Total Bayar',
                      'Rp 130.500',
                      isBold: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Barcode dengan Desain Menarik
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD0D5DB), // Warna abu-abu terang
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    BarcodeWidget(
                      barcode: Barcode.code128(), // Barcode Code128
                      data: '12PD-DA145-456YG-AG1D2', // Data barcode
                      width: 250,
                      height: 80,
                      color: Colors.black, // Warna hitam
                      drawText: false,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '12PD - DA145 - 456YG - AG1D2',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Tombol Download PDF
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0), // Jarak tombol dari bawah
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Logika untuk mengunduh PDF
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor:
                          const Color(0xFF4A5568), // Warna abu-abu gelap
                    ),
                    child: const Text(
                      'Download PDF',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildPaymentDetailRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.white70,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.white,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
