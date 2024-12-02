import 'package:flutter/material.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF384357),
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        title: const Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5, // Menambahkan jarak antar huruf untuk kesan elegan
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // tinggi garis
          child: Container(
            height: 1.0,
            color: Colors.white70, // warna garis
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white.withOpacity(0.3), const Color(0xFFD9D9D9).withOpacity(0.6)], // Gradasi lembut
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20), // Radius lebih besar untuk sudut lebih halus
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15, // Lebih blur untuk tampilan lebih halus
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30), // Memberi ruang kecil di atas
                  // Ikon kontak
                  const Icon(
                    Icons.mail_outline,
                    size: 50,
                    color: Colors.blueAccent, // Warna ikon yang mencolok
                  ),
                  const SizedBox(height: 20),
                  // Deskripsi Contact Us dengan sedikit pemformatan
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'We would love to hear from you! If you have any questions, concerns, or suggestions, feel free to reach out to us. Our support team is available 24/7 to assist you.\n\n'
                      '📧 Email: support@cineatma.com\n\n'
                      '📞 Phone: +1 800 123 4567\n\n'
                      '🏠 Address: 123 Cinema Street, Movie City, USA\n\n'
                      'Follow us on social media:\n\n'
                      '@cineatma on Instagram, Facebook, and Twitter',
                      style: TextStyle(
                        color: Colors.white, // Warna teks putih
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        height: 1.6, // Menambahkan jarak antar baris agar lebih mudah dibaca
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 30), // Jarak bawah lebih banyak
                  // Tombol untuk menghubungi
                  ElevatedButton(
                    onPressed: () {
                      // Aksi untuk tombol, misalnya membuka email
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Ganti 'primary' dengan 'backgroundColor'
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Send Us a Message',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
