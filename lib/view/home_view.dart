import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:tubes_pbp_9/view/list_view.dart';
=======
import 'package:tubes_pbp_9/view/view_list.dart';
>>>>>>> Stashed changes

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
<<<<<<< Updated upstream
  late List<Widget> _widgetOptions;
=======

>>>>>>> Stashed changes
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

<<<<<<< Updated upstream
  @override
  Widget build(BuildContext context) {
    _widgetOptions = <Widget>[
      ListPageView(),
    ];
=======
  static const List<Widget> _widgetOptions = <Widget>[
    ListPageView(),
    ListPageView(),
    ListPageView(),
  ];

  @override
  Widget build(BuildContext context) {
>>>>>>> Stashed changes
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atmacinema'),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 19, 36, 66),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.movie,
              ),
              label: 'List'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
<<<<<<< Updated upstream
      body: _widgetOptions.elementAt(_selectedIndex),
=======
      body: _widgetOptions[_selectedIndex],
>>>>>>> Stashed changes
    );
  }
}
