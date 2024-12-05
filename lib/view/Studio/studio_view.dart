import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/view/movie_details.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tubes_pbp_9/requests/filmReq.dart';
import 'package:tubes_pbp_9/entity/film.dart';

class StudioView extends StatefulWidget {
  final int filmId;

  const StudioView({
    Key? key,
    required this.filmId,
  }) : super(key: key);

  _StudioViewState createState() => _StudioViewState();
}

class _StudioViewState extends State<StudioView>{
  late YoutubePlayerController _youtubeController;
  bool _isError = false;
  Film? _film;

  @override
  void initState() {
    super.initState();
    _fetchFilmDetails();
  }

  void _fetchFilmDetails() async {
    try {
      final film = await FilmReq.fetchFilmById(widget.filmId);
      setState(() {
        _film = film;
      });
      if (film.trailer.isNotEmpty) {
        _initializeYoutubePlayer(film.trailer);
      }
    } catch (error) {
      setState(() {
        _isError = true;
      });
      debugPrint('Error fetching film details: $error');
    }
  }

  void _initializeYoutubePlayer(String trailerUrl) {
    final videoId = YoutubePlayer.convertUrlToId(trailerUrl);
    if (videoId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    } else {
      setState(() {
        _isError = true;
      });
    }
  }

  @override
  void dispose() {
    if (_youtubeController != null) {
      _youtubeController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_film == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    String posterPath = '${_film!.poster}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(_film!.judul, style: const TextStyle(color: Colors.white)),
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
              Stack(
                alignment: Alignment.center,
                children: [
                  _isError || _film!.trailer.isEmpty
                      ? const Center(
                          child: Text(
                            'Failed to load video',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        )
                      : YoutubePlayer(
                          controller: _youtubeController,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.blueAccent,
                        ),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poster
                  Expanded(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: Image.asset(posterPath, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _film!.judul,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Genre: ${_film!.genre}',
                            style: const TextStyle(color: Colors.white)),
                        Text('Durasi: ${_film!.durasi}',
                            style: const TextStyle(color: Colors.white)),
                        Text('Sutradara: ${_film!.sutradara}',
                            style: const TextStyle(color: Colors.white)),
                        Text('Rating Usia: ${_film!.ratingUsia}',
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // about & sessions
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsView(filmId: widget.filmId),
                          ),
                        );
                      },
                      child: const Text(
                        'About',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Sessions',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildDateButton('18 Okt Jumat', true),
                    _buildDateButton('19 Okt Sabtu', false),
                    _buildDateButton('20 Okt Minggu', false),
                    _buildDateButton('21 Okt Senin', false),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildTheaterRow('AMBARRUKMO XXI', '2.60 km', '10:30, 12:30, 13:45, 15:20, 18:30'),
                    _buildTheaterRow('EMPIRE XXI', '3.40 km', '10:15, 11:45, 13:30, 14:45'),
                    _buildTheaterRow('JOGJA CITY MALL XXI', '6.30 km', '11:30, 13:45, 14:30, 18:15, 20:30'),
                    _buildTheaterRow('SLEMAN CITY HALL XXI', '11.3 km', '10:45, 13:00, 16:30, 20:30'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateButton(String date, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.red : Colors.grey[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          date,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget _buildTheaterRow(String name, String distance, String showtimes) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.location_on, color: Colors.red, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  distance,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  showtimes,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            'Rp40.000',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}