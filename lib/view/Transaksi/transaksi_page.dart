import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/entity/jadwal.dart';
import 'package:tubes_pbp_9/entity/user.dart';
import 'package:tubes_pbp_9/requests/jadwalReq.dart';
import 'package:tubes_pbp_9/requests/userReq.dart';

class TransaksiPage extends StatefulWidget {
  final int idUser;

  const TransaksiPage({Key? key, required this.idUser}) : super(key: key);

  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  bool _isLoading = true;
  bool _isError = false;
  User? _user;
  List<Jadwal> _jadwals = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final userFuture = UserReq.getUserDetails();
      final jadwalsFuture = JadwalReq.fetchAllJadwal();

      final results = await Future.wait([userFuture, jadwalsFuture]);

      setState(() {
        _user = results[0] as User;
        _jadwals = results[1] as List<Jadwal>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isError = true;
        _isLoading = false;
      });
      print('Error fetching data: $e');
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
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color(0xFF384357),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _isError
                ? const Center(
                    child: Text(
                      'Failed to load data',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: _jadwals.length,
                    itemBuilder: (context, index) {
                      final jadwal = _jadwals[index];
                      return Card(
                        color: const Color(0xFF404E5A),
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/posterFilm/${jadwal.idFilm}_poster.jpg',
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.broken_image,
                                      size: 100,
                                      color: Colors.white70,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Film: ${jadwal.idFilm}', // Replace with actual film name
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Studio: ${jadwal.idStudio}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Tanggal: ${jadwal.tanggal}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Jam: ${jadwal.jamTayang}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 20),
                              if (_user != null)
                                Text(
                                  'User: ${_user!.name}',
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => TransaksiDetailPage(
                                  //       jadwal: jadwal,
                                  //       user: _user!,
                                  //     ),
                                  //   ),
                                  // );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 246, 246, 246),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Lanjutkan Transaksi',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
