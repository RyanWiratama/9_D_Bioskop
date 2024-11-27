import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/view/home_view.dart';
import 'package:tubes_pbp_9/view/list_view.dart';
import 'package:tubes_pbp_9/view/profile_view.dart';

class FnBPageView extends StatefulWidget {
  const FnBPageView({super.key});

  @override
  State<FnBPageView> createState() => _ListPageState();
}

class _ListPageState extends State<FnBPageView> {
  int _selectedIndex = 0;
  String selectedMenu = "Bites";

  final Map<String, List<Map<String, String>>> menuData = {
    "Combo": [
      {
        "title": "Combo 1",
        "subtitle": "Popcorn + Drink",
        "image": "assets/combo1.jpg"
      },
      {
        "title": "Combo 2",
        "subtitle": "Popcorn + Fries",
        "image": "assets/combo2.jpg"
      },
    ],
    "Drinks": [
      {"title": "Coke", "subtitle": "Cold and Refreshing", "image": "coke.jpg"},
      {
        "title": "Sprite",
        "subtitle": "Lemon Lime",
        "image": "assets/sprite.jpg"
      },
    ],
    "Bites": [
      {
        "title": "Popcorn (R)",
        "subtitle": "Popcorn salt / caramel",
        "image": "assets/popcorn_r.png"
      },
      {
        "title": "Popcorn (M)",
        "subtitle": "Popcorn salt / caramel",
        "image": "assets/popcorn_m.png"
      },
      {
        "title": "Popcorn (L)",
        "subtitle": "Popcorn salt / caramel",
        "image": "assets/popcorn_l.png"
      },
      {"title": "French Fries", "subtitle": "", "image": "assets/fries.jpg"},
    ],
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ListPageView()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FnBPageView()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileView()),
      );
    }
  }

  // upper navbar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            )
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

      // FnB content
      body: Container(
        color: Color(0xFF384357), // Background color for the entire screen
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Menu",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Matches the overall dark theme
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["Combo", "Drinks", "Bites"].map((menu) {
                  bool isSelected = selectedMenu == menu;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMenu = menu;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Color.fromARGB(255, 36, 43, 56)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        menu,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // Menu Items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: menuData[selectedMenu]!.length,
                itemBuilder: (context, index) {
                  final item = menuData[selectedMenu]![index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        item["image"]!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        item["title"]!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      subtitle: Text(
                        item["subtitle"]!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // bottom navbar
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.grey),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie, color: Colors.grey),
              label: 'Movies',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fastfood, color: Colors.grey),
              label: 'FnB',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.grey),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          backgroundColor: Color(0xFF384357),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
