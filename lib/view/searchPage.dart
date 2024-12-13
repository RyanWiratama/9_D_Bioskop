import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/entity/film.dart';
import 'package:tubes_pbp_9/view/Food%20&%20Bev/fnb_view.dart';
import 'package:tubes_pbp_9/view/list_view.dart';
import 'package:tubes_pbp_9/view/Profile/profile_view.dart';
import 'package:tubes_pbp_9/view/home_view.dart';
import 'package:tubes_pbp_9/view/movie_details.dart';
import 'package:tubes_pbp_9/view/notification.dart';
import 'package:tubes_pbp_9/requests/filmReq.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 0;
  String query = "";
  List<Film> movies = [];
  List<Film> filteredMovies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  void fetchMovies() async {
    try {
      setState(() {
        isLoading = true;
      });

      final films = await FilmReq.fetchAllFilms();
      setState(() {
        movies = films;
        filteredMovies = films;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        filteredMovies = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error loading films: $e',
            style: const TextStyle(fontFamily: 'Poppins'),
          ),
        ),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ListPageView()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FnBPageView()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileView()),
        );
        break;
    }
  }

  void _filterMovies(String searchQuery) {
    setState(() {
      query = searchQuery;
      filteredMovies = movies
          .where((movie) => 
            movie.judul.toLowerCase().contains(searchQuery.toLowerCase()) ||
            movie.genre.toLowerCase().contains(searchQuery.toLowerCase())
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF384357),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 8.0, right: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search, color: Colors.white),
                            hintText: "Search for movies...",
                            hintStyle: const TextStyle(
                              color: Colors.white70, 
                              fontFamily: 'Poppins'
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white, 
                            fontFamily: 'Poppins'
                          ),
                          onChanged: _filterMovies,
                        ),
                      ),
                      const SizedBox(width: 3.0),
                      IconButton(
                        icon: const Icon(Icons.notifications, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NotificationPage()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: filteredMovies.isEmpty
                      ? Center(
                          child: Text(
                            'No movies found',
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 18,
                              fontFamily: 'Poppins'
                            ),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: filteredMovies.length,
                          itemBuilder: (context, index) {
                            final movie = filteredMovies[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailsView(
                                      filmId: movie.id,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        '${movie.poster}',
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.grey,
                                            child: Icon(
                                              Icons.movie,
                                              color: Colors.white,
                                              size: 50,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    movie.judul,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                      fontFamily: 'Poppins'
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
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