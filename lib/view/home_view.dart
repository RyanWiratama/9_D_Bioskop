import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atmacinema'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 19, 36, 66),
      bottomNavigationBar: BottomNavigationBar(
      items: const[
         BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
         BottomNavigationBarItem(icon: Icon(Icons.movie,),label: 'Ticket'),
         BottomNavigationBarItem(icon: Icon(Icons.restaurant,),label: 'FnB'),
      ],
    ),
    );
  }
}