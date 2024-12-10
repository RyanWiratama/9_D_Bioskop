import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tubes_pbp_9/requests/userReq.dart';

class EditNamePage extends StatefulWidget {
  final String currentValue;

  const EditNamePage({Key? key, required this.currentValue}) : super(key: key);

  @override
  _EditNamePageState createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    String updatedName = _controller.text;
    if (updatedName.isNotEmpty) {
      try {
        final response = await UserReq.updateUserName(updatedName);

        if (response.statusCode == 200) {
          Navigator.pop(context, updatedName);
          Fluttertoast.showToast(msg: 'Name updated successfully');
        } else {
          throw Exception('Failed to update name');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update name')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name cannot be empty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF384357),
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        title: const Text(
          'Edit Name',
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
          TextButton(
            onPressed: _saveChanges,
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              'FIRST NAME',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Enter First Name',
                hintStyle: TextStyle(color: Colors.white70),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
