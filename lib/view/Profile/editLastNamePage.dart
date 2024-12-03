import 'package:flutter/material.dart';

class EditLastNamePage extends StatefulWidget {
  final String currentValue;

  const EditLastNamePage({Key? key, required this.currentValue}) : super(key: key);

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

  void _saveChanges() {
    String updatedLastName = _lastNameController.text;
    Navigator.pop(context, updatedLastName); // Kembali ke halaman sebelumnya dengan data baru
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
            TextField(
              controller: _lastNameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Last Name',
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Menggunakan backgroundColor, bukan primary
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Save Changes',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
