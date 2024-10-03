import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

<<<<<<< Updated upstream
=======
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Image(image: NetworkImage(''))
    ),
    // PageListView();
    Center(
      child: Text(
        'Index 3: Profile',
      )
    )
  ];

>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atmacinema'),
        centerTitle: true,
<<<<<<< Updated upstream
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ],
=======
>>>>>>> Stashed changes
      ),
      backgroundColor: const Color.fromARGB(255, 19, 36, 66),
      bottomNavigationBar: BottomNavigationBar(
      items: const[
         BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
<<<<<<< Updated upstream
         BottomNavigationBarItem(icon: Icon(Icons.movie,),label: 'Ticket'),
         BottomNavigationBarItem(icon: Icon(Icons.restaurant,),label: 'FnB'),
      ],
    ),
=======
         BottomNavigationBarItem(icon: Icon(Icons.movie,),label: 'List'),
         BottomNavigationBarItem(icon: Icon(Icons.person,),label: 'Profile'),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    ),
    body: _widgetOptions.elementAt(_selectedIndex),
>>>>>>> Stashed changes
    );
  }
}