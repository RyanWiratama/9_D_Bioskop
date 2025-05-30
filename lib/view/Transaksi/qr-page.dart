import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tubes_pbp_9/entity/transaksi.dart';
import 'package:tubes_pbp_9/view/Transaksi/payment_details_page.dart';
import 'package:tubes_pbp_9/view/home_view.dart';
import 'package:http/http.dart' as http;

class QrPage extends StatefulWidget {
  final double? totalHarga;
  final int idUser;
  final int idJadwal;
  final int totalTiket;

  const QrPage({
    Key? key,
    required this.totalHarga,
    required this.idUser,
    required this.idJadwal,
    required this.totalTiket,
  }) : super(key: key);

  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  int _alert = 0;
  // Future<void> createTransaksi() async {
  //   try {
  //     // Create the Transaksi object
  //     final transaksi = Transaksi(
  //       id: 0,
  //       idUser: widget.idUser,
  //       idJadwal: widget.idJadwal,
  //       totalTiket: widget.totalTiket,
  //       totalHarga: widget.totalHarga,
  //     );

  //     debugPrint('test belumsukses created');

  //     // Call the createTransaksi method from TransaksiReq
  //     final createdTransaksi = await TransaksiReq.createTransaksi(transaksi);

  //     debugPrint('test sukses created');
  //     // Show the payment success dialog
  //     showPaymentSuccessDialog(context);
  //   } catch (e) {
  //     print('Error in createTransaksi: $e');
  //     showErrorDialog(context, 'Failed to create transaction');
  //   }
  // }

  static final String baseUrl =
      '10.0.2.2:8000'; // Use the local development server for Android emulator
  static final String endpoint = '/api/transaksi/create';
  final FlutterSecureStorage storage = FlutterSecureStorage();

  // Method to create transaksi
  Future<Transaksi> createTransaksi(Transaksi transaksi) async {
    final Uri url =
        Uri.http(baseUrl, endpoint); // Full URL combining baseUrl and endpoint

    try {
      final String? token = await FlutterSecureStorage().read(key: 'token');

      if (token == null) {
        throw Exception('User is not authenticated');
      }
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id_user': transaksi.idUser,
          'id_jadwal': transaksi.idJadwal,
          'total_tiket': transaksi.totalTiket,
          'total_harga': transaksi.totalHarga,
        }),
      );
      debugPrint(transaksi.idUser.toString());
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 201) {
        // Transaction created successfully

        final responseBody = json.decode(response.body);

        return Transaksi.fromJson(responseBody['post']);

        _alert = 1;
      } else {
        debugPrint('test after post');
        throw Exception(
            'Failed to create transaksi ALILUELEO: ${response.body}');
        _alert - 0;
      }
    } catch (e) {
      debugPrint('test after post');
      throw Exception('Error in createTransaksi CUYYYY: $e');
    }
  }

  void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 350,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      size: 100,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Pembayaran Berhasil!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.totalHarga ?? 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFF384357),
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text(
          'Cinematma',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Pembayaran\nQRIS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Text(
              'Klik untuk membayar',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () async {
                try {
                  await createTransaksi(Transaksi(
                    id: 0,
                    idUser: widget.idUser,
                    idJadwal: widget.idJadwal,
                    totalTiket: widget.totalTiket,
                    totalHarga: widget.totalHarga,
                  ));
                } catch (e) {
                  // Handle any error if necessary
                  print('Error: $e');
                }
                showPaymentSuccessDialog(context);
              },
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B2B38),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: QrImageView(
                  data: 'https://pub.dev/packages/qr_flutter',
                  version: 6,
                  padding: const EdgeInsets.all(20),
                  size: 320,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/qris.png',
                        height: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          color: Color(0xFFB0B0B0),
                        ),
                      ),
                      Text(
                        'Rp ${widget.totalHarga.toString()}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFEFEF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.info_outline,
                                size: 16, color: Colors.blue),
                            SizedBox(width: 6),
                            Text(
                              'Use any supported e-wallet or mobile banking apps',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentDetailsPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2B2B38),
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Download Receipt',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomeView(userId: widget.idUser),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2B2B38),
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
