import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tubes_pbp_9/requests/filmReq.dart';
import 'package:tubes_pbp_9/entity/film.dart';
import 'package:tubes_pbp_9/entity/review.dart';
import 'package:tubes_pbp_9/requests/reviewReq.dart';
import 'package:tubes_pbp_9/view/Studio/studio_view.dart';

class MovieDetailsView extends StatefulWidget {
  final int filmId;

  const MovieDetailsView({
    Key? key,
    required this.filmId,
  }) : super(key: key);

  @override
  _MovieDetailsViewState createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  late YoutubePlayerController _youtubeController;
  bool _isError = false;
  Film? _film;
  List<Review> _reviews = [];
  late FlutterTts _flutterTts; // TTS instance

  @override
  void initState() {
    super.initState();
    _flutterTts = FlutterTts();
    _initializeTTS();
    _fetchFilmDetails();
    _fetchReviews();
  }

  void _initializeTTS() {
    _flutterTts.setLanguage("en-US");
    _flutterTts.setPitch(1.0);
    _flutterTts.setSpeechRate(0.5);

    _flutterTts.setStartHandler(() {
      debugPrint("TTS started");
    });

    _flutterTts.setCompletionHandler(() {
      debugPrint("TTS completed");
      // Resume YouTube playback after TTS completes
      if (!_youtubeController.value.isPlaying) {
        _youtubeController.play();
      }
    });

    _flutterTts.setErrorHandler((msg) {
      debugPrint("TTS Error: $msg");
    });
  }

  void _speakSynopsis(String text) async {
    try {
      if (text.isEmpty) {
        debugPrint("Synopsis is empty, cannot speak.");
        return;
      }

      // Pause the YouTube player if it's playing
      if (_youtubeController.value.isPlaying) {
        _youtubeController.pause();
      }

      await _flutterTts.speak(text);
    } catch (e) {
      debugPrint("Error during TTS: $e");
    }
  }

  void _stopSpeaking() async {
    await _flutterTts.stop();
    // Resume the YouTube video after TTS stops
    if (!_youtubeController.value.isPlaying) {
      _youtubeController.play();
    }
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

  void _fetchReviews() async {
    try {
      final reviews = await ReviewReq.fetchAllReviews();
      setState(() {
        _reviews = reviews
            .where((review) => review.history.idFilm == widget.filmId)
            .toList();
      });
    } catch (error) {
      debugPrint('Error fetching reviews: $error');
    }
  }

  void _initializeYoutubePlayer(String trailerUrl) {
    final videoId = YoutubePlayer.convertUrlToId(trailerUrl);
    if (videoId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
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

  Widget _buildPoster(String path) {
    if (path.startsWith('http')) {
      return Image.network(path, fit: BoxFit.cover);
    } else {
      return Image.asset(path, fit: BoxFit.cover);
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    _flutterTts.stop(); // Stop TTS when widget is disposed
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
                  Expanded(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: _buildPoster(posterPath),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      debugPrint('Already in About');
                    },
                    child: const Text(
                      'About',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StudioView(filmId: widget.filmId),
                        ),
                      );
                    },
                    child: const Text(
                      'Sessions',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Synopsis:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _film!.deskripsi,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up, color: Colors.white),
                    onPressed: () async {
                      _speakSynopsis(_film!.deskripsi);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.stop, color: Colors.red),
                    onPressed: () {
                      _stopSpeaking();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Reviews:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              _reviews.isEmpty
                  ? const Text(
                      'No reviews yet.',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _reviews.length,
                      itemBuilder: (context, index) {
                        final review = _reviews[index];
                        return Card(
                          color: Colors.white10,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.user.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Rating: ${review.rating}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  review.komentar,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
