import 'package:flutter/material.dart';

class TermsAndPoliciesView extends StatelessWidget {
  const TermsAndPoliciesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF384357),
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        title: const Text(
          'Terms & Policies',
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
                  // Deskripsi Terms & Policies
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '1. Terms of Service\n\nBy using Cineatma, you agree to comply with all applicable laws and regulations. You must be at least 18 years old, or have the consent of a parent or guardian, to access and use the services offered by Cineatma.',
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
                      '2. Privacy Policy\n\nWe respect your privacy. All personal data provided will be handled according to our privacy policy. We do not share your personal information with third parties without your consent unless required by law.',
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
                      '3. Cancellation & Refunds\n\nCancellations can be made up to 24 hours before the movie showtime. Refunds will be processed according to the cinema’s refund policy. Please check with the cinema for further details on cancellation and refunds.',
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
                      '4. User Conduct\n\nAs a user of Cineatma, you agree not to misuse the app. You will not engage in any activities that are harmful or illegal, such as attempting to interfere with or disrupt the services provided by Cineatma.',
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
                      '5. Limitation of Liability\n\nCineatma will not be liable for any indirect, incidental, or consequential damages arising from the use or inability to use our services. We are not responsible for any technical failures or disruptions.',
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
