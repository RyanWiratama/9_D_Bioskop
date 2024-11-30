import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import FlutterToast
import 'editFirstNamePage.dart'; // Import halaman edit untuk First Name
import 'editLastNamePage.dart'; // Import halaman edit untuk Last Name
import 'editEmailPage.dart'; // Import halaman edit untuk Email
import 'editPasswordPage.dart'; // Import halaman edit untuk Password
import 'package:image_picker/image_picker.dart'; // Import image_picker package
import 'dart:io'; // To use File for selected images

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  // Define a variable to store the selected image
  File? _image;

  // Function to handle photo picking
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _image = File(image.path); // Store the picked image
      });
      Fluttertoast.showToast(
        msg: source == ImageSource.camera ? "Photo taken" : "Photo selected from gallery",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  // Function to handle deleting the photo
  void _deletePhoto() {
    setState(() {
      _image = null; // Clear the selected image
    });
    Fluttertoast.showToast(
      msg: "Photo deleted",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  // Function to display the photo options modal
  void _showPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2C3E50),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 160,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context); // Close modal
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Camera icon
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.black),
                      onPressed: () {
                        _pickImage(ImageSource.camera); // Pick from camera
                        Navigator.pop(context); // Close modal
                      },
                    ),
                  ),
                  // Gallery icon
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                      icon: const Icon(Icons.photo_library, color: Colors.black),
                      onPressed: () {
                        _pickImage(ImageSource.gallery); // Pick from gallery
                        Navigator.pop(context); // Close modal
                      },
                    ),
                  ),
                  // Delete icon
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.black),
                      onPressed: () {
                        _deletePhoto(); // Delete the selected photo
                        Navigator.pop(context); // Close modal
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C3E50),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C3E50),
        elevation: 0,
        title: const Text(
          'Edit profile',
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(Icons.camera_alt, color: Colors.black54, size: 50),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    _showPhotoOptions(context);
                  },
                  child: const Text(
                    'Edit photo',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 20),
                // Edit First Name
                _buildEditableField(context, 'First Name', 'Ryan', EditFirstNamePage(currentValue: 'Ryan')),
                // Edit Last Name
                _buildEditableField(context, 'Last Name', 'Wiratama', EditLastNamePage(currentValue: 'Wiratama')),
                // Edit Email (diganti ke EditEmailPage)
                _buildEditableField(context, 'Email', 'RyanWirawiri@gmail.com', EditEmailPage(currentValue: 'RyanWirawiri@gmail.com')),
                // Edit Password
                _buildEditableField(context, 'Password', '**********', EditPasswordPage(currentValue: '**********')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membangun field yang dapat diedit
  Widget _buildEditableField(BuildContext context, String label, String value, Widget pageToNavigate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => pageToNavigate),
                  ).then((_) {
                    Fluttertoast.showToast(
                      msg: "$label berhasil diubah!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'EDIT',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white),
        ],
      ),
    );
  }
}
