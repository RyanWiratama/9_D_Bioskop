import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/entity/film.dart';
import 'package:tubes_pbp_9/entity/studio.dart';
import 'package:tubes_pbp_9/view/Transaksi/transaksi_page.dart';
import 'package:tubes_pbp_9/view/home_view.dart';
import 'package:tubes_pbp_9/view/movie_details.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:tubes_pbp_9/requests/filmReq.dart';
import 'package:tubes_pbp_9/requests/studioReq.dart';
import 'package:tubes_pbp_9/requests/jadwalReq.dart';
import 'package:intl/intl.dart';
import 'package:tubes_pbp_9/entity/jadwal.dart';

class StudioView extends StatefulWidget {
  final int userId;
  final int filmId;

  const StudioView({
    Key? key,
    required this.filmId,
    required this.userId,
  }) : super(key: key);

  @override
  State<StudioView> createState() => _StudioViewState();
}

class _StudioViewState extends State<StudioView> {
  YoutubePlayerController? _youtubeController;
  bool _isError = false;
  bool _isLoading = true;
  Film? _film;
  List<Studio> _studios = [];
  List<Jadwal> _jadwals = [];
  Map<int, List<Jadwal>> _studioJadwals = {};

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await Future.wait([
        _fetchFilmDetails(),
        _fetchStudios(),
        _fetchJadwals(),
      ]);
      _organizeJadwals();
    } catch (e) {
      debugPrint('Error initializing data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchFilmDetails() async {
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

  Future<void> _fetchStudios() async {
    try {
      final studios = await StudioReq.fetchAllStudios();
      setState(() {
        _studios = studios;
      });
    } catch (error) {
      debugPrint('Error fetching studios: $error');
    }
  }

  Future<void> _fetchJadwals() async {
    try {
      final jadwals = await JadwalReq.fetchAllJadwal(widget.filmId);
      setState(() {
        _jadwals = jadwals;
      });
    } catch (error) {
      debugPrint('Error fetching jadwals: $error');
    }
  }

  void _organizeJadwals() {
    _studioJadwals.clear();
    for (var studio in _studios) {
      _studioJadwals[studio.id] =
          _jadwals.where((jadwal) => jadwal.idStudio == studio.id).toList();
    }
  }

  void _initializeYoutubePlayer(String trailerUrl) {
    final videoId = YoutubePlayer.convertUrlToId(trailerUrl);
    if (videoId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
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
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_film == null) {
      return const Scaffold(
        body: Center(child: Text('Error loading film details')),
      );
    }

    String posterPath = '${_film!.poster}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
              if (_film!.trailer.isNotEmpty)
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: _isError
                      ? const Center(
                          child: Text(
                            'Failed to load video',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : _youtubeController == null
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : YoutubePlayer(
                              controller: _youtubeController!,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.blueAccent,
                            ),
                ),
              const SizedBox(height: 16),
              _buildMovieInfo(posterPath),
              const SizedBox(height: 16),
              _buildNavigationButtons(context),
              const SizedBox(height: 16),
              _buildShowtimesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieInfo(String posterPath) {
    return Row(
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
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsView(
                    filmId: widget.filmId, userId: widget.userId),
              ),
            );
          },
          child: const Text(
            'About',
            style: TextStyle(color: Colors.white70),
          ),
        ),
        TextButton(
          onPressed: null,
          child: const Text(
            'Sessions',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildShowtimesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _studios.map((studio) => _buildStudioRow(studio)).toList(),
    );
  }

  Widget _buildStudioRow(Studio studio) {
    final filteredJadwals = _studioJadwals[studio.id] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          studio.nama,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        const SizedBox(height: 8),
        if (filteredJadwals.isEmpty)
          const Text(
            "No sessions available.",
            style: TextStyle(color: Colors.white),
          )
        else
          ...filteredJadwals.map((jadwal) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransaksiPage(
                          jadwalId: jadwal.id,
                          userId: widget
                              .userId), // Ganti dengan halaman tujuan Anda
                    ),
                  );
                },
                splashColor: Colors.blueAccent
                    .withOpacity(0.2), // Efek splash saat ditekan
                hoverColor:
                    Colors.blueGrey.withOpacity(0.2), // Warna saat hover
                borderRadius: BorderRadius.circular(
                    8), // Tambahkan jika ingin efek melingkar
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Untuk mengatur posisi kanan/kiri
                    children: [
                      // Bagian kiri (Tanggal dan Jam)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tanggal: ${jadwal.tanggal}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            "Jam: ${jadwal.jamTayang}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                      // Bagian kanan (Harga)
                      Text(
                        "Price: ${jadwal.harga}",
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              )),
        const Divider(color: Colors.white),
      ],
    );
  }
}
