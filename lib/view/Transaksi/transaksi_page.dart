import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/entity/studio.dart';
import 'package:tubes_pbp_9/entity/transaksi.dart';
import 'package:tubes_pbp_9/entity/jadwal.dart';
import 'package:tubes_pbp_9/entity/film.dart';
import 'package:tubes_pbp_9/requests/studioReq.dart';
import 'package:tubes_pbp_9/requests/transaksiReq.dart';
import 'package:tubes_pbp_9/requests/jadwalReq.dart';
import 'package:tubes_pbp_9/requests/filmReq.dart';
import 'package:tubes_pbp_9/view/transaksi/transaksiDetailPage.dart';

class TransaksiPage extends StatefulWidget {
  final int jadwalId;

  const TransaksiPage({Key? key, required this.jadwalId}) : super(key: key);

  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';

  Jadwal? _jadwal;
  Studio? _studio;
  Film? _film;
  int _jumlahKursi = 1;

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
        _studio = _jadwal?.studio; // Ambil studio langsung dari jadwal
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

  Future<void> _fetchFilmData() async {
    if (_jadwal == null) return;

    try {
      final fetchedFilm = await FilmReq.fetchFilmById(_jadwal!.idFilm);
      setState(() {
        _film = fetchedFilm;
      });
    } catch (e) {
      debugPrint('Gagal mengambil data film: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _initializePage();
  }

  Future<void> _initializePage() async {
    await _fetchJadwalData();
    await _fetchDataStudio();
  }

  Future<void> _fetchDataStudio() async {
    debugPrint('test');
    if (_jadwal == null) return;

    try {
      debugPrint('Fetching studio with ID: ${_jadwal!.idStudio}');
      final fetchedStudio = await StudioReq.fetchStudioById(_jadwal!.idStudio);

      debugPrint('Studio fetched: ${fetchedStudio.nama}');

      setState(() {
        _studio = fetchedStudio;
      });
    } catch (e) {
      debugPrint('Gagal mengambil data studio: $e');
    }
  }

  // Future<void> _createInitialTransaksi() async {
  //   try {
  //     Transaksi newTransaksi = Transaksi(
  //       id: 0,
  //       idUser: 1,
  //       idJadwal: widget.jadwalId,
  //       totalTiket: _jumlahKursi,
  //       totalHarga: double.parse(_jadwal!.harga) * _jumlahKursi,
  //     );

  //     final transaksiResponse =
  //         await TransaksiReq.createTransaksi(newTransaksi);

  //     setState(() {
  //       _transaksi = transaksiResponse;
  //     });
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Gagal membuat transaksi: $e')),
  //     );
  //   }
  // }

  // Future<void> _updateTransaksi() async {
  //   try {
  //     Transaksi updatedTransaksi = Transaksi(
  //       id: _transaksi!.id,
  //       idUser: _transaksi!.idUser,
  //       idJadwal: _transaksi!.idJadwal,
  //       totalTiket: _jumlahKursi,
  //       totalHarga: double.parse(_jadwal!.harga) * _jumlahKursi,
  //     );

  //     final updatedResponse =
  //         await TransaksiReq.updateTransaksi(_transaksi!.id, updatedTransaksi);

  //     setState(() {
  //       _transaksi = updatedResponse;
  //     });
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Gagal memperbarui transaksi: $e')),
  //     );
  //   }
  // }

  void _incrementKursi() {
    setState(() {
      _jumlahKursi++;
    });
  }

  void _decrementKursi() {
    if (_jumlahKursi > 1) {
      setState(() {
        _jumlahKursi--;
      });
    }
  }

  void _navigateToDetailPage() {
    if (_jadwal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data jadwal tidak tersedia!')),
      );
      return; // Exit early if `_jadwal` is not loaded
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransaksiDetailPage(
          jadwalId: widget.jadwalId, // Pass `jadwalId` as a fallback
          jumlahTiket: _jumlahKursi, // Pass the number of tickets
        ),
      ),
    );
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
                            _film!.poster,
                            height: 450,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _jadwalInfo(),
                        const SizedBox(height: 20),
                        _jumlahKursiControl(),
                        const SizedBox(height: 30),
                        _buildContinueButton(),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _jadwalInfo() {
    return Column(
      children: [
        Text(
          'Film: ${_jadwal?.film?.judul ?? 'Unknown'}',
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
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        Text(
          'Studio: ${_studio?.nama ?? 'Studio tidak ditemukan'}',
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        Text(
          'Waktu: ${_jadwal?.jamTayang ?? 'Unknown'}',
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        Text(
          'Harga: ${_jadwal?.harga ?? 'Unknown'}',
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }

  Widget _jumlahKursiControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove, color: Colors.white),
          onPressed: _decrementKursi,
        ),
        Text(
          '$_jumlahKursi',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: _incrementKursi,
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
        onPressed: _navigateToDetailPage,
      ),
    );
  }
}
