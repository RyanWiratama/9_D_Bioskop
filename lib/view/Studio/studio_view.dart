import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/entity/film.dart';
import 'package:tubes_pbp_9/view/movie_details.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tubes_pbp_9/requests/filmReq.dart';
import 'package:intl/intl.dart';

class StudioView extends StatefulWidget {
  final int filmId;

  const StudioView({
    Key? key,
    required this.filmId,
  }) : super(key: key);

  @override
  State<StudioView> createState() => _StudioViewState();
}

class _StudioViewState extends State<StudioView> {
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

  List<Widget> buildDateButtons() {
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(Duration(days: 1));
    DateTime dayAfterTomorrow = today.add(Duration(days: 2));
    DateTime threeDaysAfter = today.add(Duration(days: 3));

    return [
      _buildDateButton(DateFormat('EEEE, d MMM').format(today), true),
      _buildDateButton(DateFormat('EEEE, d MMM').format(tomorrow), false),
      _buildDateButton(
          DateFormat('EEEE, d MMM').format(dayAfterTomorrow), false),
      _buildDateButton(DateFormat('EEEE, d MMM').format(threeDaysAfter), false),
    ];
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
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                            builder: (context) =>
                                MovieDetailsView(filmId: widget.filmId),
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
                  children: buildDateButtons(),
                ),
              ),
              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF384357),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildTheaterRow('AMBARRUKMO XXI', '2.60 km',
                        'Plaza Ambarrukmo Lt. 3', '10:30'),
                    _buildTheaterRow('EMPIRE XXI', '3.40 km',
                        'Jl. Urip Sumoharjo No. 104', '13:30'),
                    _buildTheaterRow('JOGJA CITY MALL XXI', '6.30 km',
                        'Jl. Magelang KM 6', '18:15'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
// throw UnimplementedError();
  }

  Widget _buildDateButton(String date, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.white : const Color(0xFF384357),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.white, width: 2),
          ),
        ),
        child: Text(
          date,
          style: TextStyle(
            color: isSelected ? const Color(0xFF384357) : Colors.white70,
          ),
        ),
      ),
    );
  }

  Widget _buildTheaterRow(
      String name, String distance, String address, String showtimes) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.location_on,
              color: Color.fromARGB(255, 255, 255, 255), size: 25),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      distance,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(
                        width: 8), // Space between distance and address
                    Text(
                      address,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '2D',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp40.000',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // Add your onPressed functionality here
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                  ),
                  child: Text(
                    showtimes,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
