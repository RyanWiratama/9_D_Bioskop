import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/View/view_list.dart';
import 'package:tubes_pbp_9/View/profile_view.dart'; 

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {


  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Image(image: NetworkImage('https://picsum.photos/200/300')),
    ),
    ListNamaView(), 
    ProfileView(),  
      child: Image(image: NetworkImage(''))
    ),
    // PageListView();
    Center(
      child: Text(
        'Index 3: Profile',
      )
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
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
         BottomNavigationBarItem(icon: Icon(Icons.movie,),label: 'List'),
         BottomNavigationBarItem(icon: Icon(Icons.person,),label: 'Profile'),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    ),
    body: _widgetOptions.elementAt(_selectedIndex),

    );
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
