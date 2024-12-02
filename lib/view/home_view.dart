import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/view/list_view.dart';
import 'package:tubes_pbp_9/view/Food%20&%20Bev/fnb_view.dart';
import 'package:tubes_pbp_9/view/movie_details.dart';
import 'package:tubes_pbp_9/view/Profile/profile_view.dart';
import 'package:tubes_pbp_9/view/notification.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

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

  static const List<Map<String, String>> nowPlayingMovies = [
    {
      'image':
          'https://m.media-amazon.com/images/M/MV5BNWY1NjFmNDItZDhmOC00NjI1LWE0ZDItMTM0MjBjZThiOTQ2XkEyXkFqcGc@.V1.jpg',
      'title': 'Captain America: The Winter Soldier',
      'trailer': 'https://www.youtube.com/watch?v=dKrVegVI0Us',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHDuMTc7OO-1HfPZIinsCLxY9rwcQiR-cvVg&s',
      'title': 'Interstellar',
      'trailer': 'https://www.youtube.com/watch?v=zSWdZVtXT7E',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRD-f-DREjOJg-aJUG4CwOJQlRDNuIpFhiCiA&s',
      'title': 'Dune',
      'trailer': 'https://www.youtube.com/watch?v=n9xhJrPXop4',
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxhs43qHULjieIhZVbT2OmDafk6ke6nf_mvQ&s',
      'title': 'Parasite',
      'trailer': 'https://www.youtube.com/watch?v=SEUXfv87Wpk',
    },
  ];

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
                    builder: (context) => const NotificationPage()),
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
          backgroundColor: Colors.transparent,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildNowPlayingSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: true,
            ),
            items: nowPlayingMovies.map((item) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailsView(
                        title: item['title']!,
                        imageUrl: item['image']!,
                        trailerUrl: item['trailer']!,
                        rating: 'N/A',
                        releaseDate: 'N/A',
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Stack(
                    children: [
                      // Background Poster Image with lower opacity
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Opacity(
                          opacity: 0.5, // Set opacity of the background poster
                          child: Image.network(
                            item['image']!,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            height: carouselHeight,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Center(
                                    child: Text('Image not available')),
                              );
                            },
                          ),
                        ),
                      ),
                      // Overlay Details
                      Positioned(
                        bottom: 10,
                        left: 10,
                        right: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Small Poster Image above the title
                            Container(
                              width: 90,
                              height: 120,
                              margin: const EdgeInsets.only(
                                  bottom:
                                      8.0), // Spacing between image and title
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(item['image']!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Title of the movie
                            Text(
                              item['title']!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Rating
                            Row(
                              children: const [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '7.7', // Rating bisa dimodifikasi
                                  style: TextStyle(
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsView(
                          title: 'Title Placeholder',
                          imageUrl: imgList[index],
                          trailerUrl: 'Trailer Placeholder',
                          rating: 'N/A',
                          releaseDate: 'N/A',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        imgList[index],
                        width: 150,
                        height: 225,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Center(
                                child: Text('Image not available')),
                          );
                        },
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
