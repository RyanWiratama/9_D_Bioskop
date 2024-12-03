import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF384357),
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
                borderRadius: BorderRadius.circular(15), // Radius lebih besar untuk sudut lebih halus
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30), // Memberi ruang kecil di atas
                  // Deskripsi Privacy Policy
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '1. Introduction\n\nWelcome to Cineatma! Your privacy is of utmost importance to us. This Privacy Policy outlines the types of information we collect and how we use, store, and protect that information.\n\nWe strive to comply with all relevant privacy regulations and ensure your personal information is handled with care.',
                      style: TextStyle(
                        color: Colors.white, // Warna teks putih
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 20), // Jarak antar deskripsi
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '2. Information We Collect\n\nWe collect personal information such as your name, email address, phone number, payment details, and any other information you provide to us while using our services. This information helps us to provide you with better service and improve your experience with Cineatma.',
                      style: TextStyle(
                        color: Colors.white, // Warna teks putih
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '3. How We Use Your Information\n\nWe use your information to process your bookings, provide customer support, send promotional messages, and improve our services. Your personal information will not be shared with third parties without your consent unless required by law.',
                      style: TextStyle(
                        color: Colors.white, // Warna teks putih
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '4. Data Security\n\nWe take reasonable steps to protect your personal data from unauthorized access, use, or disclosure. However, no security system is 100% secure, and we cannot guarantee the complete security of your data.',
                      style: TextStyle(
                        color: Colors.white, // Warna teks putih
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '5. Changes to This Policy\n\nWe may update this Privacy Policy from time to time. Any changes will be posted on this page, and we encourage you to review this policy periodically to stay informed about how we protect your information.',
                      style: TextStyle(
                        color: Colors.white, // Warna teks putih
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
