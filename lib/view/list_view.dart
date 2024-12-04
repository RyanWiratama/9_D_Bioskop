import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'package:tubes_pbp_9/entity/film.dart';
import 'package:tubes_pbp_9/requests/filmReq.dart';
import 'package:tubes_pbp_9/view/Food%20&%20Bev/fnb_view.dart';
import 'package:tubes_pbp_9/view/Profile/profile_view.dart';
import 'package:tubes_pbp_9/view/home_view.dart';
import 'package:tubes_pbp_9/view/list_viewDetails.dart'; // Import the movie detail page
>>>>>>> Stashed changes

class ListPageView extends StatefulWidget {
  const ListPageView({super.key});

  @override
  State<ListPageView> createState() => _ListPageState();
}

class _ListPageState extends State<ListPageView> {
<<<<<<< Updated upstream
  final List<Map<String, String>> movies = [
    {
      'title': 'Avengers: Endgame',
      'description': 'Lorem ipsum dolor sit amet',
      'poster':
          'https://images-cdn.ubuy.co.id/635aa3f5e29f902a352def13-marvel-the-avengers-endgame-movie.jpg',
      'showtime': '12:00 PM, 3:00 PM, 6:00 PM',
    },
    {
      'title': 'Avengers: Infinity War',
      'description': 'Lorem ipsum dolor sit amet',
      'poster':
          'https://images-cdn.ubuy.co.id/668f03f763dc6918441092c0-avengers-infinity-war-movie-poster.jpg',
      'showtime': '1:00 PM, 4:00 PM, 7:00 PM',
    },
    {
      'title': 'Captain America: The Winter Soldier',
      'description': 'Lorem ipsum dolor sit amet',
      'poster':
          'https://m.media-amazon.com/images/M/MV5BNWY1NjFmNDItZDhmOC00NjI1LWE0ZDItMTM0MjBjZThiOTQ2XkEyXkFqcGc@.V1.jpg',
      'showtime': '1:00 PM, 4:00 PM, 7:00 PM',
    },
  ];
=======
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
>>>>>>> Stashed changes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< Updated upstream
      appBar: AppBar(
        title: Text(
          "NOW SHOWING",
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20, // You can adjust the font size as needed
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Container(
        color: const Color(0xFF384357), // Set the background color here
        child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return Card(
              margin: const EdgeInsets.all(10.0),
              elevation: 4,
              child: ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                leading: Image.network(movie['poster']!,
                    width: 100, fit: BoxFit.cover),
                title: Text(
                  movie['title']!,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      movie['description']!,
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Showtimes: ${movie['showtime']!}",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
=======
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
>>>>>>> Stashed changes
              ),
            );
          },
        ),
      ),
    );
  }
}