import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/view/login_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(

          child: Text('Jean-220712030'),
          child: Text('Radit-220711620'),
          child: Text('Ryan - 220711897'),

        ),
      ),
      home: LoginView(),
    );
  }
}
