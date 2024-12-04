import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import FlutterToast

class EditLastNamePage extends StatefulWidget {
  final String currentValue;

  const EditLastNamePage({Key? key, required this.currentValue})
      : super(key: key);

  @override
  EditLastNamePageState createState() => EditLastNamePageState();
}

class EditLastNamePageState extends State<EditLastNamePage> {
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _lastNameController = TextEditingController(text: widget.currentValue);
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    super.dispose();
  }

  // Function to save changes and show the toast message
  void _saveChanges() {
    String updatedLastName = _lastNameController.text;
    Navigator.pop(context,
        updatedLastName); // Return the updated name to the previous screen

    // Show toast message
    Fluttertoast.showToast(
      msg: "Last Name successfully updated!",
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
          'Edit Last Name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          // Button "Change Password" on the right side
          TextButton(
            onPressed: _saveChanges,
            child: const Text(
              'Change Password', // Change the button text as required
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
            // Last Name TextField with underline style
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent background
                border: Border(
                    bottom:
                        BorderSide(color: Colors.white)), // Underlined border
              ),
              child: TextField(
                controller: _lastNameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  labelText: 'Last Name',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintText: 'Enter your last name',
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
