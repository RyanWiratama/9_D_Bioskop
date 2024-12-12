import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/view/Food%20&%20Bev/fnb_view.dart';
import 'package:tubes_pbp_9/view/list_view.dart';
import 'package:tubes_pbp_9/view/movie_details.dart';
import 'package:tubes_pbp_9/view/Profile/profile_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tubes_pbp_9/view/profile/profile_view.dart';
import 'package:tubes_pbp_9/view/home_view.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, String>> notifications = [
    {
      "date": "16 October 2024",
      "content":
          "Promo F&B - Anjing panas has expired. Don't forget to check our other F&B promos!"
    },
    {
      "date": "17 October 2024",
      "content":
          "Now Playing - Kuasa Gelap has arrived to the nearest cinema. Go check it now!"
    },
    {
      "date": "17 October 2024",
      "content":
          "Promo F&B - Burgerrr! has arrived. Don't forget to check our other F&B promos!"
    },
    {
      "date": "18 October 2024",
      "content":
          "Rate it! - How was Joker: folie à deux? Don’t forget to leave a review for the film!"
    },
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ListPageView()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FnBPageView()),
      );
    } else if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF384357),
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Cineatma',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return _buildNotificationCard(
              notifications[index]['date']!,
              notifications[index]['content']!,
            );
          },
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

  Widget _buildNotificationCard(String date, String content) {
    return Card(
      color: const Color(0xFF384357),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          const Divider(color: Colors.white),
        ],
      ),
    );
  }
}
