import 'package:flutter/material.dart';

class SettingsProfileView extends StatelessWidget {
  const SettingsProfileView({Key? key}) : super(key: key);

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
            _buildSettingsOption(context, 'About Us'),
            _buildSettingsOption(context, 'FAQ'),
            _buildSettingsOption(context, 'Terms & Policies'),
            _buildSettingsOption(context, 'Privacy Policy'),
            _buildSettingsOption(context, 'Contact Us'),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'App Version',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600, // Semi-bold
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
              fontWeight: FontWeight.w600, // Semi-bold
              fontFamily: 'Poppins',
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
          onTap: () {
            // Handle navigation or action here
          },
        ),
      ],
    );
  }
}
