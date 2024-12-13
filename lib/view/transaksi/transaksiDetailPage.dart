import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/entity/film.dart';
import 'package:tubes_pbp_9/entity/transaksi.dart';
import 'package:tubes_pbp_9/entity/film.dart';
import 'package:tubes_pbp_9/requests/transaksiReq.dart';
import 'package:tubes_pbp_9/requests/filmReq.dart';

class TransaksiDetailPage extends StatefulWidget {
  final int transaksiId;

  const TransaksiDetailPage({Key? key, required this.transaksiId}) : super(key: key);

  @override
  _TransaksiDetailPageState createState() => _TransaksiDetailPageState();
}

class _TransaksiDetailPageState extends State<TransaksiDetailPage> {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';
  Transaksi? _transaksi;
  Film? _film;

  @override
  void initState() {
    super.initState();
    _fetchTransaksiData();
  }

  Future<void> _fetchTransaksiData() async {
    try {
      setState(() {
        _isLoading = true;
        _isError = false;
      });

      final fetchedTransaksi = await TransaksiReq.fetchTransaksiById(widget.transaksiId);

      setState(() {
        _transaksi = fetchedTransaksi;
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        title: const Text(
          'Detail Transaksi',
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
              : _buildContent(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xFF384357),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Transaksi #${_transaksi?.id ?? 'Unknown'}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Film: ${_film?.judul ?? 'Unknown'}',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              'Studio: ${_transaksi?.jadwal?.studio?.nama ?? 'Unknown'}',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              'Jumlah Tiket: ${_transaksi?.totalTiket ?? 0}',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              'Total Harga: Rp${_transaksi?.totalHarga?.toStringAsFixed(2) ?? '0.00'}',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Transaksi selesai!')),
                );
              },
              icon: const Icon(Icons.check),
              label: const Text('Selesai'),
            ),
          ],
        ),
      ),
    );
  }
}
