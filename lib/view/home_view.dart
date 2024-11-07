import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/view/list_view.dart';
import 'package:tubes_pbp_9/view/fnb_view.dart';
import 'package:tubes_pbp_9/view/profile_view.dart';
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
      'image': 'https://m.media-amazon.com/images/M/MV5BNWY1NjFmNDItZDhmOC00NjI1LWE0ZDItMTM0MjBjZThiOTQ2XkEyXkFqcGc@.V1.jpg',
      'title': 'Captain America: The Winter Soldier',
    },
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHDuMTc7OO-1HfPZIinsCLxY9rwcQiR-cvVg&s',
      'title': 'Interstellar',
    },
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRD-f-DREjOJg-aJUG4CwOJQlRDNuIpFhiCiA&s',
      'title': 'Dune',
    },
    {
      'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxhs43qHULjieIhZVbT2OmDafk6ke6nf_mvQ&s',
      'title': 'Parasite',
    },
  ];

  static const List<String> topRatedImgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxhs43qHULjieIhZVbT2OmDafk6ke6nf_mvQ&s',
    'https://m.media-amazon.com/images/M/MV5BYTJkNGQyZDgtZDQ0NC00MDM0LWEzZWQtYzUzZDEwMDljZWNjXkEyXkFqcGc@._V1_.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXFdWVZc-JCJibNWStx4DWWAOAN4dBYlF0Ug&s',
  ];

  static const List<String> promoImgList = [
    'https://marketplace.canva.com/EAFkFT3PNBE/1/0/1600w/canva-red-yellow-modern-bold-fast-food-discount-promotion-video-Tihzn5PsC2M.jpg',
    'https://marketplace.canva.com/EAFxfoUeq0M/2/0/900w/canva-red-and-yellow-modern-burger-food-promo-animated-mobile-video-u8oNVV8iiWw.jpg',
    'https://example.com/promo-3.jpg',
  ];

  static const double carouselHeight = 250.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Cineatma',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFF384357),
          child: Column(
            children: [
              _buildNowPlayingSection(),
              _buildImageFlexSection('Top Rated Movies', topRatedImgList),
              _buildImageFlexSection('Promo', promoImgList),
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
                'Now Playing Movies',
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
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Opacity(
                        opacity: 0.8,
                        child: Image.network(
                          item['image']!,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Center(child: Text('Image not available')),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text(
                        item['title']!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildImageFlexSection(String title, List<String> imgList) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
            ],
          ),
        ),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: imgList.map((imgUrl) {
            return SizedBox(
              width: 120,
              height: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Center(child: Text('Image not available')),
                    );
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
