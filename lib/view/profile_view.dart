import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF384357), // Background color
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Cinematma',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Text(
              'Profile',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.search, color: Colors.white), // Search icon
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Hi! Ryan',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildProfileOption(Icons.edit, 'Edit profile'),
            const SizedBox(height: 10),
            _buildProfileOption(Icons.history, 'History'),
            const SizedBox(height: 10),
            _buildProfileOption(Icons.settings, 'Settings'),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white, // White circle background for icon
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.red, size: 18), // Left-arrow icon
              ),
              label: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red button background
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF252B40),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {},
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFB8BCBE), // Background color of navigation bar
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue), // Profile icon with blue color
            label: '',
          ),
        ],
        currentIndex: 3, // Set the selected item (profile)
        onTap: (index) {},
        selectedItemColor: Colors.blue, // Selected color for active icon
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed, // Prevent shifting animation
      ),
    );
  }
}
