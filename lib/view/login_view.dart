import 'package:flutter/material.dart';
import 'package:tubes_pbp_9/view/home_view.dart';
import 'package:tubes_pbp_9/view/register_view.dart';
import 'package:tubes_pbp_9/component/form_component.dart';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D1E3A), Color(0xFF1E375C)], // Background gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  "Sign in to your Account",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Sign in to your Account",
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),
                inputForm(
                  (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email.";
                    }
                    if (!value.contains('@')) {
                      return 'Email must contain @';
                    }
                    return null;
                  },
                  controller: emailController,
                  hintTxt: "Email",
                  helperTxt: "",
                  iconData: Icons.email_outlined,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password.";
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: _obscurePassword
                          ? const Icon(Icons.visibility_outlined)
                          : const Icon(Icons.visibility_off_outlined),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
<<<<<<< Updated upstream
                      if (_formKey.currentState?.validate() ?? false) {
                        if (widget.data == null) {
                          setState(() {
                            _errorMessage = "Email not registered!";
                          });
                        } else {
                          String email = widget.data?['email'];
                          String password = widget.data?['password'];

                          if (emailController.text == email) {
                            if (passwordController.text == password) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const HomeView();
                                  },
                                ),
                              );
                            } else {
                              setState(() {
                                _errorMessage = "Password is incorrect!";
                              });
                            }
                          } else {
                            setState(() {
                              _errorMessage = "Email not registered!";
                            });
                          }
                        }
                      }
                    },
                    child: const Text("Login"),
=======
                      // Forgot password logic goes here
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color(0xFF6FCE4E)),
                    ),
>>>>>>> Stashed changes
                  ),
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6FCE4E),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (widget.data == null) {
                        setState(() {
                          _errorMessage = "Email not registered!";
                        });
                      } else {
                        String email = widget.data?['email'];
                        String password = widget.data?['password'];

                        if (emailController.text == email &&
                            passwordController.text == password) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const HomeView();
                              },
                            ),
                          );
                        } else {
                          setState(() {
                            _errorMessage = "Invalid username or password!";
                          });
                        }
                      }
                    }
                  },
                  child: const Text("Login"),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Or login with",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Google login logic
                      },
                      icon: const Image(
                        image: AssetImage('assets/google_icon.png'),
                        height: 40,
                      ),
                    ),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        // Facebook login logic
                      },
                      icon: const Image(
                        image: AssetImage('assets/facebook_icon.png'),
                        height: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterView(),
                          ),
                        );
                      },
                      child: const Text("Register"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
