import 'package:flutter/material.dart';

class MovieDetailsView extends StatelessWidget {
  final String title;
  final String imageUrl;

  const MovieDetailsView({Key? key, required this.title, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(title, style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF384357), // Background color 
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(imageUrl),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Synopsis',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text(
                'The film follows the Kim family, a poor and cunning South Korean family, who schemes to infiltrate the wealthy Park family by posing as highly qualified tutors and housekeepers. As they cunningly maneuver themselves into the Park family’s lives, a darkly comedic and unsettling power struggle unfolds, exposing the deep-seated class divides and moral compromises that plague contemporary society.',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 24),
              Text(
                'Cast',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(''),
                        ),
                        SizedBox(height: 8),
                        Text( 'Song Kang-ho',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text('Kim Ki-taek', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(''),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Lee Sun-kyun',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text('Park Dong-ik', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundImage: NetworkImage(''),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Cho Yeo-jeong',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text('Park Yeon-kyo', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text('Genre: Drama, Thriller', style: TextStyle(color: Colors.white)),
              Text('Duration: 2 hours 12 minutes', style: TextStyle(color: Colors.white)),
              Text('Director: Bong Joon-ho', style: TextStyle(color: Colors.white)),
              Text('Rating: R', style: TextStyle(color: Colors.white)),
              Text('Release Date: May 30, 2019', style: TextStyle(color: Colors.white)),
              SizedBox(height: 24),
              Text(
                'Reviews',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 8),
              Text('Rating: 8.6/10 (500k)', style: TextStyle(color: Colors.white)),
              SizedBox(height: 8),
              Text(
                'Featured Review:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 4),
              Text(
                'Parasite is a masterful blend of dark comedy and social commentary that keeps you on the edge of your seat. '
                'Bong Joon-ho expertly crafts a narrative that is both entertaining and thought-provoking, making it a must-watch for anyone interested in the complexities of class struggle.',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}