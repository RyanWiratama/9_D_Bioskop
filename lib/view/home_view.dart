import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/view/list_view.dart';
import 'package:tubes_pbp_9/view/Food%20&%20Bev/fnb_view.dart';
import 'package:tubes_pbp_9/view/movie_details.dart';
import 'package:tubes_pbp_9/view/Profile/profile_view.dart';
import 'package:tubes_pbp_9/view/notification.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tubes_pbp_9/requests/filmReq.dart';
import 'package:tubes_pbp_9/entity/film.dart';

class HomeView extends StatefulWidget {
  final int userId;

  const HomeView({Key? key, required this.userId}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ListPageView(userId: widget.userId), // Passing userId
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              FnBPageView(userId: widget.userId), // Passing userId
        ),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProfileView(userId: widget.userId), // Passing userId
        ),
      );
    }
  }

  static const List<String> topRatedImgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxhs43qHULjieIhZVbT2OmDafk6ke6nf_mvQ&s',
    'https://m.media-amazon.com/images/M/MV5BYTJkNGQyZDgtZDQ0NC00MDM0LWEzZWQtYzUzZDEwMDljZWNjXkEyXkFqcGc@._V1_.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXFdWVZc-JCJibNWStx4DWWAOAN4dBYlF0Ug&s',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxhs43qHULjieIhZVbT2OmDafk6ke6nf_mvQ&s',
    'https://m.media-amazon.com/images/M/MV5BYTJkNGQyZDgtZDQ0NC00MDM0LWEzZWQtYzUzZDEwMDljZWNjXkEyXkFqcGc@._V1_.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXFdWVZc-JCJibNWStx4DWWAOAN4dBYlF0Ug&s',
  ];

  static const List<String> promoImgList = [
    'https://marketplace.canva.com/EAFkFT3PNBE/1/0/1600w/canva-red-yellow-modern-bold-fast-food-discount-promotion-video-Tihzn5PsC2M.jpg',
    'https://marketplace.canva.com/EAFxfoUeq0M/2/0/900w/canva-red-and-yellow-modern-burger-food-promo-animated-mobile-video-u8oNVV8iiWw.jpg',
    'https://marketplace.canva.com/EAFkFT3PNBE/1/0/1600w/canva-red-yellow-modern-bold-fast-food-discount-promotion-video-Tihzn5PsC2M.jpg',
    'https://marketplace.canva.com/EAFxfoUeq0M/2/0/900w/canva-red-and-yellow-modern-burger-food-promo-animated-mobile-video-u8oNVV8iiWw.jpg',
  ];

  static const double carouselHeight = 250.0;

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
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NotificationPage(userId: widget.userId)),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFF384357),
          child: Column(
            children: [
              _buildNowPlayingSection(),
              _buildHorizontalScrollSection(
                  'Top Rated Movies', topRatedImgList),
              _buildHorizontalScrollSection('Promo', promoImgList),
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

  Widget _buildNowPlayingSection() {
    return FutureBuilder<List<Film>>(
      future: FilmReq.fetchAllFilms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No movies available'));
        } else {
          final films = snapshot.data!;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Discover Movies',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                height: carouselHeight,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: carouselHeight,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    pauseAutoPlayOnTouch: true,
                  ),
                  items: films.map((film) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsView(
                              filmId: film.id,
                              userId: widget.userId,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Opacity(
                                opacity: 0.5,
                                child: Image.asset(
                                  '${film.poster}',
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: carouselHeight,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: const Center(
                                          child: Text('Image not available')),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 120,
                                    margin: const EdgeInsets.only(bottom: 8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: AssetImage('${film.poster}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    film.judul,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        film.ratingUsia.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildHorizontalScrollSection(String title, List<String> imgList) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 225.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imgList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        imgList[index],
                        width: 150,
                        height: 225,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Text('Image not available')),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
