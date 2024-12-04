import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/entity/film.dart';
import 'package:tubes_pbp_9/requests/filmReq.dart';
import 'package:tubes_pbp_9/view/Food%20&%20Bev/fnb_view.dart';
import 'package:tubes_pbp_9/view/Profile/profile_view.dart';
import 'package:tubes_pbp_9/view/home_view.dart';
import 'package:tubes_pbp_9/view/list_viewDetails.dart'; // Import the movie detail page

class ListPageView extends StatefulWidget {
  const ListPageView({super.key});

  @override
  State<ListPageView> createState() => _ListPageState();
}

class _ListPageState extends State<ListPageView> {
  int _selectedIndex = 1;
  TextEditingController _searchController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: const Color(0xFF384357),
      //   title: const Center(
      //     child: Text(
      //       'Cineatma',
      //       style: TextStyle(
      //         fontFamily: 'Poppins',
      //         color: Colors.white,
      //         fontWeight: FontWeight.bold,
      //         fontSize: 24,
      //       ),
      //     ),
      //   ),
      //   leading: IconButton(
      //     icon: const Icon(Icons.search, color: Colors.white),
      //     onPressed: () {},
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.notifications, color: Colors.white),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: Container(
        color: const Color(0xFF384357),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search My Tickets...',
                  hintStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Film>>(
                future: FilmReq.fetchAllFilms(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available.'));
                  } else {
                    final films = snapshot.data!;
                    return ListView.builder(
                      itemCount: films.length,
                      itemBuilder: (context, index) {
                        final film = films[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the movie detail page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailPage(film: film),
                              ),
                            );
                          },
                          child: Card(
                            color: const Color(0xFF495366),
                            margin: const EdgeInsets.symmetric(vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      film.poster, // Ensure film.poster is correct
                                      width: 80,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          film.judul,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          film.deskripsi,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Durasi: ${film.durasi}",
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
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
}
