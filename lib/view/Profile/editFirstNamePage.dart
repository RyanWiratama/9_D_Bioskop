import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import FlutterToast

class EditFirstNamePage extends StatefulWidget {
  final String currentValue; // This is the current first name

  const EditFirstNamePage({Key? key, required this.currentValue})
      : super(key: key);

  @override
  _EditFirstNamePageState createState() => _EditFirstNamePageState();
}

class _EditFirstNamePageState extends State<EditFirstNamePage> {
  late TextEditingController _controller; // Controller to manage text field

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text:
            widget.currentValue); // Set initial value to the current first name
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose controller when widget is disposed
    super.dispose();
  }

  // Function to save changes and show the toast message
  void _saveChanges() {
    String updatedFirstName = _controller.text; // Get the updated value
    Navigator.pop(context,
        updatedFirstName); // Return the updated name to the previous screen

    // Show toast message
    Fluttertoast.showToast(
      msg: "First Name successfully updated!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF384357),
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        title: const Text(
          'Edit First Name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(
                context); // Close the page when back button is pressed
          },
        ),
        actions: [
          // Replace IconButton with a TextButton for 'Save'
          TextButton(
            onPressed: _saveChanges, // Save changes when button is pressed
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // First Name TextField with underline style
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent background
                border: Border(
                    bottom:
                        BorderSide(color: Colors.white)), // Underlined border
              ),
              child: TextField(
                controller: _controller, // Use the controller to bind the text
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  labelText: 'First Name',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'Enter your first name',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
