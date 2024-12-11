import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/entity/film.dart';
import 'package:tubes_pbp_9/entity/studio.dart';
import 'package:tubes_pbp_9/view/movie_details.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tubes_pbp_9/requests/filmReq.dart';
import 'package:tubes_pbp_9/requests/studioReq.dart';
import 'package:tubes_pbp_9/requests/jadwalReq.dart';
import 'package:intl/intl.dart';
import 'package:tubes_pbp_9/entity/jadwal.dart';

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
  List<Studio> _studios = [];
  List<Jadwal> _jadwals = [];
  String? _selectedDate;

  @override
  void initState() {
    super.initState();
    _fetchFilmDetails();
    _fetchStudios();
    _fetchJadwals();
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

  void _fetchStudios() async {
    try {
      final studios = await StudioReq.fetchAllStudios();
      setState(() {
        _studios = studios;
      });
    } catch (error) {
      debugPrint('Error fetching studios: $error');
    }
  }

  void _fetchJadwals() async {
    try {
      final jadwals = await JadwalReq.fetchShowtimesByFilmId(widget.filmId);
      setState(() {
        _jadwals = jadwals;
        if (_jadwals.isNotEmpty) {
          _selectedDate = _jadwals.first.tanggal; // Default to the first date
        }
      });
    } catch (error) {
      debugPrint('Error fetching jadwals: $error');
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

  @override
  void dispose() {
    if (_youtubeController != null) {
      _youtubeController.dispose();
    }
    super.dispose();
  }

  List<Widget> buildDateButtons() {
    final uniqueDates =
        _jadwals.map((jadwal) => jadwal.tanggal).toSet().toList();

    return uniqueDates.map((date) {
      return _buildDateButton(date, _selectedDate == date);
    }).toList();
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
                  Expanded(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: Image.asset(
                        posterPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.broken_image,
                            color: Colors.white,
                            size: 100,
                          );
                        },
                      ),
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
                    onPressed: () {
                      debugPrint('Already in Sessions');
                    },
                    child: const Text(
                      'Sessions',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: buildDateButtons(),
                ),
              ),
              const SizedBox(height: 16),
              _studios.isEmpty
                  ? const Center(
                      child: Text(
                        'No studios available',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Column(
                      children: _studios.map((studio) {
                        final filteredJadwals = _jadwals
                            .where((jadwal) => jadwal.tanggal == _selectedDate)
                            .toList();
                        return _buildStudioRow(studio, filteredJadwals);
                      }).toList(),
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
        onPressed: () {
          setState(() {
            _selectedDate = date;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.white : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          elevation: isSelected ? 4 : 0,
          shadowColor: isSelected ? Colors.white : Colors.transparent,
        ),
        child: Text(
          DateFormat('dd MMM E', 'id_ID').format(DateTime.parse(date)),
          style: TextStyle(
            color: isSelected ? const Color(0xFF384357) : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildStudioRow(Studio studio, List<Jadwal> jadwals) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: const Color(0xFF2C3E50),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                studio.nama,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Kapasitas: ${studio.kapasitas} seats',
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: jadwals.map((jadwal) {
                  return ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF384357),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(jadwal.jamTayang),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
