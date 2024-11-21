import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/view/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isAgreed = false;
  bool isAttemptedToSignUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF384357),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header Section
              Container(
                color: const Color(0xFF384357),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // Form Section
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                  ),
                ),
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Text
                      const Padding(
                        padding: EdgeInsets.only(bottom: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "New Here?",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Input Fields
                      inputField("First Name", firstNameController),
                      const SizedBox(height: 16),
                      inputField("Last Name", lastNameController),
                      const SizedBox(height: 16),
                      inputField("Email", emailController, email: true),
                      const SizedBox(height: 16),
                      inputField("Password", passwordController,
                          isPassword: true),
                      const SizedBox(height: 16),
                      inputField("Confirm Password", confirmPasswordController,
                          isConfirmPassword: true),
                      const SizedBox(height: 16),
                      // Terms & Conditions
                      Row(
                        children: [
                          Checkbox(
                            value: isAgreed,
                            onChanged: (value) {
                              setState(() {
                                isAgreed = value!;
                              });
                            },
                          ),
                          const Text('I agree to the terms and conditions'),
                        ],
                      ),
                      if (isAttemptedToSignUp && !isAgreed)
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'You must agree to the terms and conditions',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      const SizedBox(height: 24),
                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isAttemptedToSignUp = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              if (!isAgreed) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'You must agree to the terms and conditions'),
                                  ),
                                );
                              } else {
                                Map<String, dynamic> formData = {
                                  'email': emailController.text,
                                  'password': passwordController.text,
                                };
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LoginView(data: formData),
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF384357),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Sign In Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.black54),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginView()),
                              );
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Input Field Helper
  Widget inputField(String label, TextEditingController controller,
      {bool isPassword = false,
      bool email = false,
      bool isConfirmPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: isPassword || isConfirmPassword,
          keyboardType: email ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: label,
            hintStyle: const TextStyle(color: Colors.black45),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $label';
            }
            if (email && !value.contains('@')) {
              return 'Please enter a valid email address';
            }
            if (isPassword && !RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
              return 'Password must contain at least one uppercase letter';
            }
            if (isPassword && !RegExp(r'(?=.*[!@#\$&*~])').hasMatch(value)) {
              return 'Password must contain at least one special character (!@#\$&*~)';
            }
            if (isConfirmPassword && value != passwordController.text) {
              return 'Confirm Password must match the Password';
            }
            return null;
          },
        ),
      ],
    );
  }
}
