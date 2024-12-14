import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:tubes_pbp_9/view/Transaksi/PdfPreviewPage.dart';

class PaymentDetails {
  final String orderNumber;
  final String paymentId;
  final String paymentMethod;
  final String paymentDate;
  final String movieTitle;
  final String movieSchedule;
  final List<String> seats;
  final String totalPayment;

  PaymentDetails({
    required this.orderNumber,
    required this.paymentId,
    required this.paymentMethod,
    required this.paymentDate,
    required this.movieTitle,
    required this.movieSchedule,
    required this.seats,
    required this.totalPayment,
  });
}

class PaymentDetailsPage extends StatelessWidget {
  const PaymentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for payment details
    final paymentDetails = PaymentDetails(
      orderNumber: '46451658679812',
      paymentId: 'PBP123',
      paymentMethod: 'QRIS',
      paymentDate: '17 OCT 2024',
      movieTitle: 'Joker : folie à deux',
      movieSchedule: '10:30 WIB | 18 OCT 2024\nAMBARRUKMO XXI\nC2, C3, C4',
      seats: ['C2', 'C3', 'C4'],
      totalPayment: 'Rp 130.500',
    );

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
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          paymentDetails.movieTitle,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          paymentDetails.movieSchedule,
                          style: const TextStyle(
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
                    buildPaymentDetailRow(
                        'Nomor Order', paymentDetails.orderNumber),
                    buildPaymentDetailRow(
                        'ID Pembayaran', paymentDetails.paymentId),
                    buildPaymentDetailRow(
                        'Metode Pembayaran', paymentDetails.paymentMethod),
                    buildPaymentDetailRow(
                        'Tanggal Pembayaran', paymentDetails.paymentDate),
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
                      'Kursi Regular\n${paymentDetails.seats.join(', ')}',
                      'Rp 40.000 x 3',
                    ),
                    const Divider(color: Colors.white24),
                    buildPaymentDetailRow('Biaya Layanan', 'Rp 3.500 x 3'),
                    const Divider(color: Colors.white24),
                    buildPaymentDetailRow(
                      'Total Bayar',
                      paymentDetails.totalPayment,
                      isBold: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Barcode dengan Desain Menarik
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD0D5DB),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: '12PD-DA145-456YG-AG1D2',
                      width: 250,
                      height: 80,
                      color: Colors.black,
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
                padding: const EdgeInsets.only(bottom: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PdfPreviewPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: const Color(0xFF4A5568),
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
