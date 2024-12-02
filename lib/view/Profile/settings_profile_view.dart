import 'package:flutter/material.dart';
import 'AboutUsView.dart'; // Import the AboutUsView file
import 'FAQView.dart'; // Import the FAQView file
import 'Terms&PoliciesView.dart'; // Import the TermsAndPoliciesView file
import 'PrivacyPolicyView.dart'; // Import the PrivacyPolicyView file
import 'ContactUsView.dart'; // Import the ContactUsView file

class SettingsProfileView extends StatefulWidget {
  const SettingsProfileView({Key? key}) : super(key: key);

  @override
  _SettingsProfileViewState createState() => _SettingsProfileViewState();
}

class _SettingsProfileViewState extends State<SettingsProfileView> {
  // Daftar opsi pengaturan
  List<String> settingsOptions = [
    'About Us',
    'FAQ',
    'Terms & Policies',
    'Privacy Policy',
    'Contact Us',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF384357),
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        title: const Text(
          'Settings',
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan daftar opsi pengaturan tanpa pencarian
            Expanded(
              child: ListView.builder(
                itemCount: settingsOptions.length,
                itemBuilder: (context, index) {
                  return _buildSettingsOption(context, settingsOptions[index]);
                },
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'App Version',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  '1.0.0',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption(BuildContext context, String title) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
          onTap: () {
            // Navigate to AboutUsView if "About Us" is selected
            if (title == 'About Us') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutUsView()),
              );
            }
            // Navigate to FAQView if "FAQ" is selected
            else if (title == 'FAQ') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FAQView()),
              );
            }
            // Navigate to TermsAndPoliciesView if "Terms & Policies" is selected
            else if (title == 'Terms & Policies') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermsAndPoliciesView()),
              );
            }
            // Navigate to PrivacyPolicyView if "Privacy Policy" is selected
            else if (title == 'Privacy Policy') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyPolicyView()),
              );
            }
            // Navigate to ContactUsView if "Contact Us" is selected
            else if (title == 'Contact Us') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactUsView()),
              );
            }
            // Handle other options if needed (e.g., Contact Us, etc.)
          },
        ),
      ],
    );
  }
}
