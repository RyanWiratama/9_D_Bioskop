import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Details',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MovieDetailsView(
        title: 'Joker: Folie à Deux',
        imageUrl: 'https://via.placeholder.com/200x300',
        trailerUrl: 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
        rating: '5.3/10 (74K)',
        releaseDate: 'October 4, 2024',
      ),
    );
  }
}

class MovieDetailsView extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String trailerUrl;
  final String rating;
  final String releaseDate;

  const MovieDetailsView({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.trailerUrl,
    required this.rating,
    required this.releaseDate,
  }) : super(key: key);

  @override
  _MovieDetailsViewState createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  late VideoPlayerController _controller;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _controller = VideoPlayerController.network(widget.trailerUrl)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      }).catchError((error) {
        setState(() {
          _isError = true;
        });
        debugPrint('Error initializing video player: $error');
      });
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF384357),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF384357),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie Trailer with Play Button
              Stack(
                alignment: Alignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: _isError
                        ? const Center(
                            child: Text(
                              'Failed to load video',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          )
                        : _controller.value.isInitialized
                            ? VideoPlayer(_controller)
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.play_circle_fill, color: Colors.white, size: 80),
                    onPressed: () {
                      _controller.play();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Movie Poster and Details Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poster
                  Expanded(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 2 / 3, // Adjust aspect ratio for poster
                      child: Image.network(widget.imageUrl, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Film Details (with title, genre, duration, director, and age rating)
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Genre: Crime, Thriller, Musical', style: const TextStyle(color: Colors.white)),
                        Text('Duration: 2 hours 18 minutes', style: const TextStyle(color: Colors.white)),
                        Text('Director: Todd Phillips', style: const TextStyle(color: Colors.white)),
                        Text('Rating: 17+', style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Rating and Release Date Section with white background and opacity
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Rating with white background
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          widget.rating,
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  // Release Date with white background
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.black, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Release date: ${widget.releaseDate}',
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Synopsis Section with white background
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Synopsis',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '“Joker: Folie à Deux” finds Arthur Fleck institutionalized at Arkham awaiting trial for his crimes as Joker. While struggling with his dual identity, Arthur not only stumbles upon true love, but also finds the music that has always been inside him.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Cast Section
              const Text(
                'Cast',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildCastMember(
                    name: 'Joaquin Phoenix',
                    role: 'Arthur Fleck / Joker',
                    imageUrl: 'https://via.placeholder.com/100',
                  ),
                  _buildCastMember(
                    name: 'Lady Gaga',
                    role: 'Harley Quinn',
                    imageUrl: 'https://via.placeholder.com/100',
                  ),
                  _buildCastMember(
                    name: 'Zazie Beetz',
                    role: 'Sophie Dumond',
                    imageUrl: 'https://via.placeholder.com/100',
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Photos Section
              const Text(
                'Photos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildPhoto('https://via.placeholder.com/200x300'),
                  const SizedBox(width: 8),
                  _buildPhoto('https://via.placeholder.com/200x300'),
                  const SizedBox(width: 8),
                  _buildPhoto('https://via.placeholder.com/200x300'),
                ],
              ),
              const SizedBox(height: 24),

              // Review Section
              const Text(
                'Reviews',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '“An intense, musical, and heart-wrenching journey that continues to delve into the psyche of one of the most iconic characters of modern cinema.”',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCastMember({
    required String name,
    required String role,
    required String imageUrl,
  }) {
    return Expanded(
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(role, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildPhoto(String imageUrl) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}
