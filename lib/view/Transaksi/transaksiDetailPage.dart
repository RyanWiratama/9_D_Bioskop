import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/entity/film.dart';
import 'package:tubes_pbp_9/entity/jadwal.dart';
import 'package:tubes_pbp_9/entity/studio.dart';
import 'package:tubes_pbp_9/requests/filmReq.dart';
import 'package:tubes_pbp_9/requests/jadwalReq.dart';
import 'package:tubes_pbp_9/requests/studioReq.dart';
import 'package:tubes_pbp_9/view/transaksi/payment_qris_page.dart';

class TransaksiDetailPage extends StatefulWidget {
  final int jadwalId;
  final int jumlahTiket;

  const TransaksiDetailPage({
    Key? key,
    required this.jadwalId,
    required this.jumlahTiket,
  }) : super(key: key);

  @override
  _TransaksiDetailPageState createState() => _TransaksiDetailPageState();
}

class _TransaksiDetailPageState extends State<TransaksiDetailPage> {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';
  Film? _film;
  Jadwal? _jadwal;
  Studio? _studio;

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

  Future<void> _initializePage() async {
    await _fetchJadwalData();
    await _fetchDataStudio();
  }

  void _navigateToDetailPage() {
    if (_jadwal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data jadwal tidak tersedia!')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GenerateQRPage(),
      ),
    );
  }

  Future<void> _fetchJadwalData() async {
    try {
      setState(() {
        _isLoading = true;
        _isError = false;
      });

      final fetchedJadwal = await JadwalReq.fetchAllJadwal(widget.jadwalId);
      final jadwalDetail = fetchedJadwal.firstWhere(
        (jadwal) => jadwal.id == widget.jadwalId,
        orElse: () => throw Exception('Jadwal tidak ditemukan'),
      );

      setState(() {
        _jadwal = jadwalDetail;
        _studio = _jadwal?.studio;
      });

      await _fetchFilmData();
    } catch (e) {
      setState(() {
        _isError = true;
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchDataStudio() async {
    if (_jadwal == null) return;

    try {
      final fetchedStudio = await StudioReq.fetchStudioById(_jadwal!.idStudio);

      setState(() {
        _studio = fetchedStudio;
      });
    } catch (e) {
      debugPrint('Gagal mengambil data studio: $e');
    }
  }

  Future<void> _fetchFilmData() async {
    if (_jadwal == null) return;

    try {
      final fetchedFilm = await FilmReq.fetchFilmById(_jadwal!.idFilm);

      setState(() {
        _film = fetchedFilm;
      });
    } catch (e) {
      setState(() {
        _isError = true;
        _errorMessage = 'Gagal mengambil data film: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        title: const Text(
          'Transaksi',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _isError
              ? Center(
                  child: Text(
                    'Error: $_errorMessage',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    color: const Color(0xFF384357),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            _film?.poster ?? 'assets/default_poster.png',
                            height: 450,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _jadwalInfo(),
                        const SizedBox(height: 30),
                        _buildContinueButton(), // Tambahkan tombol di sini
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _jadwalInfo() {
    final totalHarga =
        _jadwal != null ? double.parse(_jadwal!.harga) * widget.jumlahTiket : 0;

    return Column(
      children: [
        Text(
          'Film: ${_film?.judul ?? 'Unknown'}',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Tanggal: ${_jadwal?.tanggal ?? 'Unknown'}',
          style: const TextStyle(color: Colors.white70),
        ),
        Text(
          'Studio: ${_studio?.nama ?? 'Studio tidak ditemukan'}',
          style: const TextStyle(color: Colors.white70),
        ),
        Text(
          'Waktu: ${_jadwal?.jamTayang ?? 'Unknown'}',
          style: const TextStyle(color: Colors.white70),
        ),
        Text(
          'Jumlah Tiket: ${widget.jumlahTiket}',
          style: const TextStyle(color: Colors.white70),
        ),
        Text(
          'Total Harga: Rp${totalHarga.toStringAsFixed(0)}.00',
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.confirmation_number, color: Colors.black),
        label: const Text(
          'Lanjutkan',
          style: TextStyle(color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size.fromHeight(56),
        ),
        onPressed: _navigateToDetailPage,
      ),
    );
  }
}
