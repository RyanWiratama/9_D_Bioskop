import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/entity/history.dart';

class ReviewView extends StatefulWidget {
  final History history;

  const ReviewView({Key? key, required this.history}) : super(key: key);

  @override
  _ReviewViewState createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Review',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: const Color(0xFF384357),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      widget.history.film.poster.isNotEmpty
                          ? widget.history.film.poster
                          : 'assets/images/avengers.jpeg',
                      height: 200,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.history.film.judul.isNotEmpty
                          ? widget.history.film.judul
                          : 'Unknown Title',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Cinema', style: TextStyle(color: Colors.white)),
                      Text('Date', style: TextStyle(color: Colors.white)),
                      Text('Time', style: TextStyle(color: Colors.white)),
                      Text('Studio', style: TextStyle(color: Colors.white)),
                      Text('Seats', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //   Text(
                      //     widget.history.cinema,
                      //     style: const TextStyle(color: Colors.white),
                      //   ),
                      Text(
                        widget.history.tanggalNonton,
                        style: const TextStyle(color: Colors.white),
                      ),
                      //   Text(
                      //     widget.history.jamNonton,
                      //     style: const TextStyle(color: Colors.white),
                      //   ),
                      //   Text(
                      //     widget.history.studio,
                      //     style: const TextStyle(color: Colors.white),
                      //   ),
                      //   Text(
                      //     widget.history.seat,
                      //     style: const TextStyle(color: Colors.white),
                      //   ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.white),
              const SizedBox(height: 16),

              // Rating Section
              const Text(
                'Rating',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Row(
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        _rating = index + 1; // Update rating
                      });
                    },
                    icon: Icon(
                      _rating > index ? Icons.star : Icons.star_border,
                      color: Colors.white,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),

              // Review Section
              const Text(
                'Review',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _reviewController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Write your review here...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    String review = _reviewController.text;
                    if (_rating > 0 && review.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Review submitted!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
<<<<<<< Updated upstream
                        SnackBar(
                            content:
                                Text('Please provide a rating and review.')),
=======
                        const SnackBar(content: Text('Please write a review.')),
                      );
                      return;
                    }

                    if (widget.history.id == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Invalid movie history.')),
                      );
                      return;
                    }

                    try {
                      // Assuming you get the logged-in user ID correctly from your auth system
                      // int userId = 123; // Replace with actual logged-in user ID

                      final newReview = Review(
                        id: 19, // ID auto-generated in backend
                        idUser: 7, // User ID from logged-in user
                        idHistory: widget.history.id,
                        rating: _rating,
                        komentar: review,
                        history: widget.history,
                        user: User(
                          id: 7,
                          name:
                              'Diof Tsunami', // Replace with the actual logged-in user's name
                          email: 'tasik@gmail.com', // Replace with actual email
                          password: '',
                          no_telp: BigInt.from(0),
                          foto: '',
                        ),
                      );

                      // Create the review and send to the server
                      final submittedReview =
                          await ReviewReq.createReview(newReview);

                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Review submitted successfully!')),
                      );
                      // Return to the previous screen
                      Navigator.pop(context);
                    } catch (e) {
                      // Handle any errors during submission
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to submit review: $e')),
>>>>>>> Stashed changes
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
