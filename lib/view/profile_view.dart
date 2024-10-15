// import 'package:flutter/material.dart';

// class ProfileView extends StatelessWidget {
//   const ProfileView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Cinema Profile',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       backgroundColor: const Color.fromARGB(255, 19, 36, 66),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               height: 200,
//               decoration: BoxDecoration(
//                 image: const DecorationImage(
//                   image: NetworkImage(
//                       'https://image.tmdb.org/t/p/w500/6KErczPBROQty7QoIsaa6wJYXZi.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Christophorus Raditya',
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Super Hero Fan and Movie Enthusiast',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 30),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: const [
//                 Column(
//                   children: [
//                     Icon(Icons.movie, size: 30, color: Colors.white),
//                     SizedBox(height: 5),
//                     Text('Watched', style: TextStyle(color: Colors.white)),
//                     Text('50', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Icon(Icons.favorite, size: 30, color: Colors.white),
//                     SizedBox(height: 5),
//                     Text('Favorites', style: TextStyle(color: Colors.white)),
//                     Text('15', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Icon(Icons.star, size: 30, color: Colors.white),
//                     SizedBox(height: 5),
//                     Text('Ratings', style: TextStyle(color: Colors.white)),
//                     Text('90', style: TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }