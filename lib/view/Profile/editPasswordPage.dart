import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tubes_pbp_9/requests/userReq.dart';

class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage({Key? key}) : super(key: key);

  @override
  _EditPasswordPageState createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  bool _isCurrentPasswordHidden = true;
  bool _isNewPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      String currentPassword = _currentPasswordController.text;
      String newPassword = _newPasswordController.text;
      String confirmPassword = _confirmPasswordController.text;

      if (newPassword != confirmPassword) {
        Fluttertoast.showToast(
          msg: "New password and confirmation do not match.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }

      if (currentPassword == newPassword) {
        Fluttertoast.showToast(
          msg: "New password cannot be the same as the current password.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }

      try {
        final response =
            await UserReq.updateUserPassword(currentPassword, newPassword);

        if (response.statusCode == 200) {
          Fluttertoast.showToast(
            msg: "Password updated successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

          Navigator.pop(context, true);
        } else {
          Fluttertoast.showToast(
            msg: "Failed to update password: ${response.reasonPhrase}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Error occurred: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
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
          'Edit password',
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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Change the password regularly for account security',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 30),
              _buildPasswordField(
                'CURRENT PASSWORD',
                _currentPasswordController,
                _isCurrentPasswordHidden,
                () => setState(() {
                  _isCurrentPasswordHidden = !_isCurrentPasswordHidden;
                }),
              ),
              const SizedBox(height: 20),
              _buildPasswordField(
                'NEW PASSWORD',
                _newPasswordController,
                _isNewPasswordHidden,
                () => setState(() {
                  _isNewPasswordHidden = !_isNewPasswordHidden;
                }),
              ),
              const SizedBox(height: 20),
              _buildPasswordField(
                'CONFIRM PASSWORD',
                _confirmPasswordController,
                _isConfirmPasswordHidden,
                () => setState(() {
                  _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                }),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B2B38),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    'Change Password',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(height: 16), // Spacing di bawah tombol
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    String label,
    TextEditingController controller,
    bool isHidden,
    VoidCallback toggleVisibility,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          obscureText: isHidden,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: label == 'CONFIRM PASSWORD'
                ? 'Retype the password'
                : 'Enter your ${label.toLowerCase()}',
            hintStyle: const TextStyle(color: Colors.white70),
            suffixIcon: IconButton(
              icon: Icon(
                isHidden ? Icons.visibility_off : Icons.visibility,
                color: Colors.white70,
              ),
              onPressed: toggleVisibility,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label cannot be empty';
            }
            return null;
          },
        ),
      ],
    );
  }
}
