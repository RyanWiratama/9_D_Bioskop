import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tubes_pbp_9/requests/userReq.dart';
import 'package:tubes_pbp_9/entity/user.dart';
import 'package:tubes_pbp_9/view/Profile/editNamePage.dart';
import 'package:tubes_pbp_9/view/Profile/editEmailPage.dart';
import 'package:tubes_pbp_9/view/Profile/editPasswordPage.dart';
import 'package:tubes_pbp_9/view/Profile/editNoTelpPage.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  File? _image;
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final userDetails = await UserReq.getUserDetails();
      setState(() {
        user = User.fromJson(userDetails);
        isLoading = false;
      });
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to load user data: $e",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      Fluttertoast.showToast(
        msg: source == ImageSource.camera
            ? "Photo taken"
            : "Photo selected from gallery",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  void _deletePhoto() {
    setState(() {
      _image = null;
    });
    Fluttertoast.showToast(
      msg: "Photo deleted",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take Photo"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text("Delete Photo"),
                onTap: () {
                  Navigator.pop(context);
                  _deletePhoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF384357),
      appBar: AppBar(
        backgroundColor: const Color(0xFF384357),
        elevation: 0,
        title: const Text(
          'Edit Profile',
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildProfilePhoto(context),
              const SizedBox(height: 20),
              _buildEditableField(context, 'Name', user!.name),
              _buildEditableField(context, 'Email', user!.email),
              _buildEditableField(context, 'No Telp', user!.no_telp.toString()),
              _buildEditableField(context, 'Password', '********'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePhoto(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(50),
          ),
          child: _image != null
              ? ClipOval(
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  ),
                )
              : (user?.foto.isEmpty ?? true
                  ? const Icon(Icons.camera_alt,
                      color: Colors.black54, size: 50)
                  : ClipOval(
                      child: Image.network(
                        user!.foto,
                        fit: BoxFit.cover,
                      ),
                    )),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            onTap: _showPhotoOptions,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.edit, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditableField(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                onPressed: () async {
                  if (label == 'Email') {
                    final updatedEmail = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditEmailPage(currentValue: user!.email),
                      ),
                    );

                    if (updatedEmail != null && updatedEmail.isNotEmpty) {
                      setState(() {
                        user!.email = updatedEmail;
                      });
                    }
                  } else if (label == 'Password') {
                    final updatedPassword = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditPasswordPage(),
                      ),
                    );
                    if (updatedPassword != null && updatedPassword.isNotEmpty) {
                      setState(() {
                        // Handle updated password
                      });
                    }
                  } else if (label == 'No Telp') {
                    final updatedNoTelp = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNoTelpPage(
                          currentNoTelp: user!.no_telp.toString(),
                        ),
                      ),
                    );

                    if (updatedNoTelp != null && updatedNoTelp.isNotEmpty) {
                      setState(() {
                        user!.no_telp = updatedNoTelp;
                      });
                    }
                  } else if (label == 'Name') {
                    final updatedName = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditNamePage(currentValue: user!.name),
                      ),
                    );

                    if (updatedName != null && updatedName.isNotEmpty) {
                      setState(() {
                        user!.name = updatedName;
                      });
                    }
                  }
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
