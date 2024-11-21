import 'package:flutter/material.dart';

class FnBPageView extends StatefulWidget {
  const FnBPageView({super.key});

  @override
  State<FnBPageView> createState() => _ListPageState();
}

class _ListPageState extends State<FnBPageView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ),
            );
          },
        ),
      ),
    );
  }
}