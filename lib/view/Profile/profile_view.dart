import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/requests/userReq.dart';
import 'package:tubes_pbp_9/view/home_view.dart';
import 'package:tubes_pbp_9/view/list_view.dart';
import 'package:tubes_pbp_9/view/Auth/login_view.dart';
import 'package:tubes_pbp_9/view/Food & Bev/fnb_view.dart';
import 'package:tubes_pbp_9/view/Profile/edit_profile_view.dart';
import 'package:tubes_pbp_9/view/Profile/history_profile_view.dart';
import 'package:tubes_pbp_9/view/Profile/settings_profile_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int _selectedIndex = 3;
  Map<String, dynamic>? _userData;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final userData = await UserReq.getUserDetails();
      setState(() {
        _userData = userData;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load user data.';
      });
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ListPageView()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FnBPageView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF384357),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cineatma',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi! ${_userData?['name'] ?? 'Guest'}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  'Welcome',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        _buildProfileOption(Icons.edit, 'Edit profile'),
                        const SizedBox(height: 10),
                        _buildProfileOption(Icons.history, 'History'),
                        const SizedBox(height: 10),
                        _buildProfileOption(Icons.settings, 'Settings'),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await UserReq.logout();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()),
                              (route) => false,
                            );
                          },
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          label: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _selectedIndex == 0 ? Colors.black : Colors.grey),
            label: _selectedIndex == 0 ? 'Home' : '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie,
                color: _selectedIndex == 1 ? Colors.black : Colors.grey),
            label: _selectedIndex == 1 ? 'Movies' : '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood,
                color: _selectedIndex == 2 ? Colors.black : Colors.grey),
            label: _selectedIndex == 2 ? 'FnB' : '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: _selectedIndex == 3 ? Colors.black : Colors.grey),
            label: _selectedIndex == 3 ? 'Profile' : '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontFamily: 'Poppins'),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {
          if (title == 'Edit profile') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditProfileView()),
            );
          } else if (title == 'History') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HistoryView()),
            );
          } else if (title == 'Settings') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SettingsProfileView()),
            );
          }
        },
      ),
    );
  }
}
