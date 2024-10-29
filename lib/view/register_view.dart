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

      backgroundColor: const Color(0xFF7B2C27),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: const Color(0xFF7B2C27), // Maroon color for the header
                child: Padding(
                  padding:
                      const EdgeInsets.all(16.0), // Add padding to the header
                  child: Row(
                    children: [
                      // Back button
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          // Navigate to LoginView
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
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFE8D5BE),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),

      backgroundColor: const Color.fromARGB(255, 66, 161, 238),
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          },
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Username',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                inputForm(
                  (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Required Username!';
                    }
                    return null;
                  },
                  controller: usernameController,
                  hintTxt: "Username",
                  helperTxt: "Enter Username",
                  iconData: Icons.person,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                inputForm(
                  (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Required Email!';
                    }
                    if (!p0.contains('@')) {
                      return 'Email Must Contain @';
                    }
                    return null;
                  },
                  controller: emailController,
                  hintTxt: "Email",
                  helperTxt: "Enter Email Adresses",
                  iconData: Icons.email,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Password',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                inputForm(
                  (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Required Password!';
                    }
                    if (p0.length < 8) {
                      return 'Required 8 digits Password!';
                    }
                    if (!RegExp(r'[A-Z]').hasMatch(p0)) {
                      return 'Password must contain at least one uppercase letter!';
                    }
                    if (!RegExp(r'[0-9]').hasMatch(p0)) {
                      return 'Password must contain at least one number!';
                    }
                    return null;
                  },
                  controller: passwordController,
                  hintTxt: "Password",
                  helperTxt: "Enter Password",
                  iconData: Icons.password,
                  password: true,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Phone Number',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                inputForm(
                  (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Required Phone Number!';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(p0)) {
                      return 'Phone Number must contain only digits!';
                    }
                    return null;
                  },
                  controller: notelpController,
                  hintTxt: "Phone Number",
                  helperTxt: "Enter Phone Number",
                  iconData: Icons.phone_android,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> formData = {};
                        formData['email'] = emailController.text;
                        formData['password'] = passwordController.text;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LoginView(
                              data: formData,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 18),
                    ),

                  ),
                ),
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align to start
                    children: [
                      // Header Texts
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, left: 24.0),
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
                      const SizedBox(height: 24),
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

                      // Conditional Error Message
                      if (isAttemptedToSignUp && !isAgreed)
                        const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'You must agree to the terms and conditions',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      const SizedBox(height: 24),
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
                            backgroundColor: const Color(0xFF7B2C27),
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

                      child: Text(
                        'Sign up with',
                        style: TextStyle(
                          color: Colors.black,

                        ),
                      ),
                      const SizedBox(height: 16),
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
                                color: Colors.black,
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
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.g_mobiledata,
                          size: 40, color: Colors.black),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.facebook,
                          size: 40, color: Colors.black),
                      onPressed: () {},
                    ),
                  ],

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function for TextFormField with validations for email and password
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
              borderSide: const BorderSide(color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.black),
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
            if (isPassword) {
              if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                return 'Password must contain at least one uppercase letter';
              }
              if (!RegExp(r'(?=.*[!@#\$&*~])').hasMatch(value)) {
                return 'Password must contain at least one special character (!@#\$&*~)';
              }
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
