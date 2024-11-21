import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'package:tubes_pbp_9/view/home_view.dart';
>>>>>>> Stashed changes
import 'package:tubes_pbp_9/view/login_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginView(),
    );
  }
}
