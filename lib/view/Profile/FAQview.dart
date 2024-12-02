import 'package:flutter/material.dart';

class FAQView extends StatelessWidget {
  const FAQView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF384357),
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        title: const Text(
          'FAQ',
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
                  // Deskripsi FAQ
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '1. How do I book tickets on Cineatma?\n\nTo book tickets, browse the movie listings, select your desired movie, showtime, and cinema. Choose your seats, proceed to payment, and you will receive an e-ticket in the app.',
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
                      '2. Can I select my preferred seats?\n\nYes, Cineatma allows you to choose your preferred seats during the booking process. You can view the seating layout and pick the seats that suit you best.',
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
                      '3. Are there any booking fees?\n\nA nominal booking fee may be applied per transaction, depending on the cinema\'s policy. The fee details will be shown at checkout.',
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
                      '4. Can I pre-order snacks?\n\nYes, Cineatma allows you to pre-order snacks along with your tickets. Your snacks will be ready for pick-up when you arrive at the cinema.',
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
