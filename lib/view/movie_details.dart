import 'package:flutter/material.dart';

class MovieDetailsView extends StatelessWidget {
  final String title;
  final String imageUrl;

  const MovieDetailsView(
      {Key? key, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(title,
            style: TextStyle(color: Colors.black, fontFamily: 'Poppins')),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(height: 16),
              Text(
                'Synopsis',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(height: 8),
              Text(
                'The film follows the Kim family, a poor and cunning South Korean family, who schemes to infiltrate the wealthy Park family by posing as highly qualified tutors and housekeepers. As they cunningly maneuver themselves into the Park family’s lives, a darkly comedic and unsettling power struggle unfolds, exposing the deep-seated class divides and moral compromises that plague contemporary society.',
                style: TextStyle(
                    fontSize: 16, color: Colors.white, fontFamily: 'Poppins'),
              ),
              SizedBox(height: 24),
              Text(
                'Cast',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCastMember('Song Kang-ho', 'Kim Ki-taek', ''),
                  _buildCastMember('Lee Sun-kyun', 'Park Dong-ik', ''),
                  _buildCastMember('Cho Yeo-jeong', 'Park Yeon-kyo', ''),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Details',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(height: 8),
              _buildDetailText('Genre: Drama, Thriller'),
              _buildDetailText('Duration: 2 hours 12 minutes'),
              _buildDetailText('Director: Bong Joon-ho'),
              _buildDetailText('Rating: R'),
              _buildDetailText('Release Date: May 30, 2019'),
              SizedBox(height: 24),
              Text(
                'Reviews',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(height: 8),
              Text('Rating: 8.6/10 (500k)',
                  style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
              SizedBox(height: 8),
              Text(
                'Featured Review:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(height: 4),
              Text(
                'Parasite is a masterful blend of dark comedy and social commentary that keeps you on the edge of your seat. '
                'Bong Joon-ho expertly crafts a narrative that is both entertaining and thought-provoking, making it a must-watch for anyone interested in the complexities of class struggle.',
                style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCastMember(String name, String role, String imageUrl) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(imageUrl.isNotEmpty
                ? imageUrl
                : 'https://via.placeholder.com/64'),
          ),
          SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins'),
          ),
          Text(role,
              style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
        ],
      ),
    );
  }

  Widget _buildDetailText(String detail) {
    return Text(detail,
        style: TextStyle(color: Colors.white, fontFamily: 'Poppins'));
  }
}
